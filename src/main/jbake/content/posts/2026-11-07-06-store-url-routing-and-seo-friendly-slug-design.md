title=進一步設計店家url增加slug強化SEO/GEO效果
date=2026-11-07
dateModified=2026-11-07
type=post
status=published
category=Project Actions
cover=
tags=專案產出,系統設計
summary=採用「識別碼定位店家、slug 描述店家、Canonical 固定主網址」的方式。店家改名或搬遷時，保留原識別碼，讓既有連結持續有效。依Google 建議使用容易理解的描述性網址；本方案將無 slug 網址作為 Canonical，因此 slug 的主要收益是分享可讀性。
tldr1=網址包含「招牌與店名」「地區位址」，比單純編號更能表達頁面內容。幫助使用者決定是否點選，分享連結時接收方更容易理解。
tldr2=
tldr3=
faq1Question=
faq1Answer=
faq2Question=
faq2Answer=
faq3Question=
faq3Answer=
~~~~~~

延伸原url設計(<a href="https://dev.howqpon.com/posts/2026-11-04-22-global-unique-id-regional-routing-seo-geo-url-planning.html?utm_source=howqpon.com" target="_blank" rel="noopener noreferrer">Howqpon地區路由與SEO/GEO網址規劃 ↗</a>)，透過slug的加入，讓店家網址不在是冷冰冰的數字，而是有店家特徵的描述。


## 店家 /s URL 與 slug 設計

採用「識別碼定位店家、slug 描述店家、Canonical 固定主網址」的方式。店家改名或搬遷時，保留原識別碼，讓既有連結持續有效。

### 1. 方法與定義

網址格式：

```text
固定主網址：https://howqpon.com/tw/s/{識別碼}
分享網址：  https://howqpon.com/tw/s/{識別碼}/{slug}
```

| 項目 | 定義 | 範例 |
|---|---|---|
| `/s` | 表示店家頁面 | `/tw/s/` |
| 內部 ID | 全球唯一的資源編號 | `1234` |
| 對外識別碼 | 用來定位店家，不隨 slug 變更 | `123401s` |
| slug | 可選的描述後綴，使用店名、地區等文字 | `全聯行天宮店-台北市中山區` |
| Canonical | 指定給搜尋引擎的代表網址，固定不含 slug | `https://howqpon.com/tw/s/123401s` |
| Schema `@id` | 店家實體的固定識別，與 Canonical 分開設定 | `https://howqpon.com/id/1234#store` |

### 2. 網址範例

下列網址皆顯示同一家店：

```text
https://howqpon.com/tw/s/123401s

https://howqpon.com/tw/s/123401s/全聯行天宮店-台北市中山區

https://howqpon.com/tw/s/123401s/pxmart-xingtian-temple-zhongshan-taipei
```

此處中英文 slug 是同一份內容的網址別名，不代表另建英文內容頁。

### 3. 請求處理規則

1. 後端以 `123401s` 查找店家；slug 不參與店家識別。
2. 主網址與帶 slug 的網址皆直接回傳完整頁面及 HTTP `200`，保留訪客輸入的網址。
3. 店名、地址、頁面標題及 Schema，皆由最新店家資料產生，不從 slug 推算。
4. 所有版本在 HTML `<head>` 宣告同一個 Canonical；主網址本身也宣告相同值。
5. Sitemap 與站內主要連結統一使用主網址；分享功能可產生帶有最新 slug 的網址。
6. 識別碼不存在時回傳 HTTP `404`；單純 slug 寫錯不影響查找。

Canonical 範例：

```html
<link rel="canonical" href="https://howqpon.com/tw/s/123401s">
```

Canonical 不會改變瀏覽器地址列。本方案讓帶 slug 的網址直接顯示內容，無須為 slug 差異逐一設定轉址。

### 4. SEO 與連結維護優勢

#### 加上 slug 的 SEO 與使用者價值

加上 slug，讓網址本身就能說明「哪間店、哪個分店、位於哪裡」。Google 也建議網址使用容易理解、具有描述性的文字。

例如：

```text
https://howqpon.com/tw/s/123401s/全聯行天宮店-台北市中山區
```

| 好處 | 對店家頁的價值 |
|---|---|
| 補充搜尋主題線索 | 網址包含「全聯」「行天宮店」「台北市中山區」，比單純編號更能表達頁面內容。 |
| 清楚區分同品牌分店 | 使用者容易辨認這是行天宮附近的分店，減少點錯其他分店。 |
| 幫助使用者決定是否點選 | 當網址文字被顯示時，使用者能先確認店名與地區是否符合需求。這是合理的預期效益，實際點擊改善仍需觀察。 |
| 分享連結更容易理解 | 在文章、論壇或社群直接貼上網址時，連結本身就帶有店家資訊，接收者更容易辨識內容。 |

其中，主題線索是 SEO 的輔助價值；辨識與分享則是使用者體驗的價值。加入 slug 不代表保證提高排名，也不代表增加多個獨立搜尋入口。

#### 主網址與舊連結的延續性

| 優勢 | 說明 |
|---|---|
| 集中搜尋訊號 | 使用 Canonical 表明各版本屬於同一頁，有助於將連結等訊號集中到代表網址。 |
| 主網址穩定 | 店名或地址變更時，Canonical 維持不變，減少因描述文字更新而遷移主網址的需要。 |
| 舊連結持續有效 | 外部文章、社群貼文、QR Code 即使使用舊 slug，仍可透過識別碼顯示最新店家資料。 |

本方案將無 slug 網址作為 Canonical，因此 slug 的主要收益是分享可讀性。Canonical 是偏好訊號，最終代表網址仍由搜尋引擎判定。

### 5. slug 寫錯或縮短的範例

以下網址共用 `https://howqpon.com/tw/s/123401s` 前綴：

| 後綴 | 狀況 | 結果 |
|---|---|---|
| 無後綴 | 直接使用主網址 | 顯示店家最新資料 |
| `/全聯行天宮店` | 省略地區 | 顯示同一家店 |
| `/pxmart-xingtian-temple-zhongshan-tainan` | 將 Taipei 誤寫為 Tainan | 顯示同一家店及資料庫中的正確地址 |

slug 錯字不會改變頁面內容；所有版本仍宣告相同 Canonical。

### 6. 店家換地址與改名案例

以下為假設案例：同一家店由台北市中山區搬到大同區，並更改店名。

| 項目 | 搬遷前 | 搬遷後 |
|---|---|---|
| 店名 | 全聯行天宮店 | 全聯寧夏夜市店 |
| 所在地 | 台北市中山區 | 台北市大同區 |
| 內部 ID | `1234` | `1234` |
| 對外識別碼 | `123401s` | `123401s` |
| Canonical | `https://howqpon.com/tw/s/123401s` | `https://howqpon.com/tw/s/123401s` |
| Schema `@id` | `https://howqpon.com/id/1234#store` | `https://howqpon.com/id/1234#store` |

搬遷前分享網址：

```text
https://howqpon.com/tw/s/123401s/全聯行天宮店-台北市中山區
```

搬遷後新產生的分享網址：

```text
https://howqpon.com/tw/s/123401s/全聯寧夏夜市店-台北市大同區
```

新舊網址皆以 `123401s` 找到同一家店，顯示搬遷後的店名與完整地址。更新資料時，同步更新頁面標題、地址及 Schema；頁面可註記「已搬遷至大同區」，方便從舊連結進入的訪客辨識。

保留網址有助於維持連結延續性；搬遷仍會改變地區相關性，搜尋表現可能隨之變動。本例以同一店家延續為前提；不同分店各自使用不同 ID。

### 參考資料

- [Google：指定 Canonical 與整合重複網址](https://developers.google.com/search/docs/crawling-indexing/consolidate-duplicate-urls)
- [Google：網址結構最佳做法](https://developers.google.com/search/docs/crawling-indexing/url-structure)
- [Google：SEO 入門指南](https://developers.google.com/search/docs/fundamentals/seo-starter-guide)

