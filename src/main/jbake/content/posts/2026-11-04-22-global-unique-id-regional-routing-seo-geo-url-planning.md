title=Howqpon地區路由與SEO/GEO網址規劃
date=2026-11-04
dateModified=2026-11-04
type=post
status=published
category=Project Actions
cover=
tags=專案產出,系統設計
summary=採用「全球唯一資源ID + 地區路由碼」架構。全球每家店擁有永久且唯一的 Entity ID。公開網址包含地區路由碼，方便快速判斷所屬國家。使用 /tw/、/jp/ 等路徑區分地區服務。Cloudflare 負責跨國請求分流，各國主機獨立運作。SEO Canonical 使用正式地區網址。Schema.org @id 使用不包含地區路由碼的永久 Entity ID。實體身分、公開網址、語言及實際主機位置彼此獨立。
tldr1=Entity ID 決定「這是哪一家店」。Schema.org @id 決定「如何長期識別同一個實體」。
tldr2=Region Code 決定「優先從哪個地區路由」。Cloudflare 決定「請求實際送往哪個國家的主機」。
tldr3=正式地區 URL 決定「使用者與搜尋引擎應使用哪個網頁」。避免把資料身分、URL、SEO 與主機部署位置綁死。
faq1Question=為什麼 @id 不必包含最後加上的隱性地區碼？
faq1Answer=這是因為在設計上將ID分為兩層Entity ID：永久不變，例如 1234，用於資料庫的邏輯身分、跨國同步、Schema @id。Public Routing ID：例如 123401，用於 Cloudflare 快速分流和公開網址。這個設計讓將來無論增加國家、搬遷主機或調整路由方式，都不必改變店家的核心身分。
faq2Question=
faq2Answer=
faq3Question=
faq3Answer=
~~~~~~


![Howqpon地區路由與SEO/GEO網址規劃](/images/2026-11-04/howqpon-global-unique-id-regional-routing-seo-geo-url-planning.jpg)

howqpon-global-unique-id-regional-routing-seo-geo-url-planning.jpg


## 一、ID 與 URL 設計

採用 **全球唯一 Entity ID + 兩碼 Region Code**。

| 項目 | 台灣 | 日本 |
|---|---|---|
| Entity ID | `1234` | `1235` |
| Region Code | `01` | `02` |
| Public ID | `123401` | `123502` |
| 正式 URL | `/tw/123401` | `/jp/123502` |
| 全球查找 | `/123401` | `/123502` |
| Schema `@id` | `/id/1234#store` | `/id/1235#store` |

地區碼：`01=tw`、`02=jp`、`03=kr`、`04=us`。

Entity ID 永久不變；Public ID 包含路由資訊，不得重複分配。

## 二、URL 分流規則

由 Cloudflare Workers 負責判斷與分流。

```text
/123401     → 301 → /tw/123401
/123502     → 301 → /jp/123502

/tw/123401  → 台灣 EC2
/jp/123502  → 日本 EC2

/tw/123502  → 301 → /jp/123502
```

- 無地區路徑：解析 Public ID 最後兩碼，轉到正式 URL。
- 地區錯誤：轉到正確國家。
- ID 不存在：404。
- 店家遷移：保留歷史轉址紀錄，避免舊網址失效。
- API 寫入請求不採 301 轉址，直接由正式路徑分流。

## 三、Cloudflare 與主機架構

```text
使用者
   │
   ▼
howqpon.com
   │
   ▼
Cloudflare Workers
   │
   ├── /tw/* → tw-origin.howqpon.com
   │              └── 台灣 Caddy → Spring Boot
   │
   ├── /jp/* → jp-origin.howqpon.com
   │              └── 日本 Caddy → Spring Boot
   │
   └── /kr/* → kr-origin.howqpon.com
                  └── 韓國 Caddy → Spring Boot
```

分工：

- **Cloudflare**：全球入口、地區判斷、301 轉址、反向代理。
- **Caddy**：各國 HTTPS 與反向代理。
- **Spring Boot**：店家頁面、API、業務邏輯。
- **各國資料庫**：獨立管理或依需求同步。

來源子網域需要正確的 TLS、DNS 與來源主機保護，不應讓外部繞過 Cloudflare 的安全規則。

## 四、跨站請求與 API 設計

### 1. 瀏覽器對各國主機：同源代理（推薦）

```text
瀏覽器
  │
  └── https://howqpon.com/jp/api/store/123502
                    │
                    ▼
              Cloudflare
                    │
                    ▼
             日本 Spring Boot
```

瀏覽器只使用 `https://howqpon.com`，不直接呼叫 `jp-origin.howqpon.com`。

優點：

- 瀏覽器保持 Same-Origin。
- 一般情況不需要額外設定 CORS。
- Cookie 可統一使用公開網域。
- 各國 Spring Boot 獨立運作。
- 可避免公開內部主機網址。

注意：登入 Session、授權和 CSRF 仍需妥善設計；同網域不代表不同地區自動共用登入狀態。

### 2. 各國主機互相請求：Server-to-Server

```text
台灣 Spring Boot
       │
       ├── HTTPS / mTLS / 簽章驗證
       │
       ▼
日本 Spring Boot API
```

- 伺服器對伺服器請求不受瀏覽器 CORS 限制。
- 建議 HTTPS，必要時採用 mTLS 或短效簽章 Token。
- 內部 API 必須驗證身分與授權。
- 優先讓各國服務本地查詢，避免每次跨國同步請求。

### 3. 必須由瀏覽器直接跨網域時

例如：

```text
https://howqpon.com
        │
        ▼
https://jp-origin.howqpon.com/api/...
```

此時屬於 Cross-Origin，需要 CORS 設定。

- 限定允許的 Origin。
- 正確處理 OPTIONS Preflight。
- 使用 Cookie 時必須正確設定 Credentials。
- 有憑證的 CORS 不可使用 `Access-Control-Allow-Origin: *`。
- 不建議將內部 Origin 當作公開 API 入口。

**原則：優先同網域路徑代理，避免不必要的 CORS。**

## 五、SEO / GEO 設定

正式地區 URL 同時用於分享、Canonical、Sitemap。

```html
<link rel="canonical"
      href="https://howqpon.com/tw/123401">
```

Schema.org：

```json
{
  "@context": "https://schema.org",
  "@type": "Restaurant",
  "@id": "https://howqpon.com/id/1234#store",
  "name": "範例餐廳",
  "url": "https://howqpon.com/tw/123401"
}
```

- `@id`：永久識別店家。
- `url`：正式公開網頁。
- Canonical：正式地區 URL。
- Sitemap：只收錄正式地區 URL。
- 多語言頁面：另外規劃 `hreflang`。

## 六、最終原則

1. **Entity ID**：全球唯一且永久不變。
2. **Public ID**：附加地區碼，快速路由。
3. **正式 URL**：`/{country}/{publicId}`。
4. **Cloudflare**：依 URL 分流至各國主機。
5. **瀏覽器 API**：維持 `howqpon.com` 同源請求。
6. **跨國服務 API**：HTTPS + 身分驗證，必要時 mTLS／簽章。
7. **Canonical**：正式地區網址。
8. **Schema `@id`**：獨立、穩定，不包含地區碼。
9. **國家、語言、主機位置**：各自獨立管理。

**核心方向：統一網域入口、全球唯一身分、地區獨立部署、同源 API 代理。**