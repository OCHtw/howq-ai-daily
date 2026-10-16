title=AI SEO／GEO：Schema.org 結構化資料通用指南
date=2026-10-16
type=post
status=published
category=Project Actions
tags=GEO,Insight
summary=Schema.org 是描述**實體（Entity）、內容（Content）、關係（Relationship）與來源（Provenance）**的結構化語意詞彙，目前常被用來寫給AI搜尋的格式。
~~~~~~

> 小編請AI大大整理啥是 Schema.org

# AI SEO／GEO：Schema.org 結構化資料通用指南

## 1. 核心觀念

Schema.org 是描述**實體（Entity）、內容（Content）、關係（Relationship）與來源（Provenance）**的結構化語意詞彙，目前常被用來寫給AI搜尋的格式。
- **SEO**：協助搜尋引擎理解內容；在符合搜尋服務規範時，有機會獲得特定搜尋呈現方式。
- **GEO（Generative Engine Optimization）**：讓內容的主題、實體、相互關係、時效與來源更清楚，便於機器理解與整合。
- **重要限制**：加入 Schema.org 標記**不保證**搜尋排名、AI 摘要露出或生成式 AI 引用。標記必須與使用者能實際看到的內容一致。

建議使用 **JSON-LD**，並以穩定的 `@id` 串連同一頁面的多個實體。

## 2. 常用 Schema.org 類型（`@type`）

| 類別 | 類型 | 主要用途 |
|---|---|---|
| 網站結構 | `WebSite` | 網站名稱、網址、發布者 |
| 網站結構 | `WebPage` | 單一網頁 |
| 網站結構 | `AboutPage` | 關於某組織或某主題的頁面 |
| 網站結構 | `CollectionPage` | 分類、集合、彙整頁 |
| 網站結構 | `BreadcrumbList` | 麵包屑與網站階層 |
| 網站結構 | `ItemList` | 條目清單與順序 |
| 身分與實體 | `Organization` | 公司或組織 |
| 身分與實體 | `Person` | 人物、作者或專家 |
| 身分與實體 | `Place` | 地點 |
| 身分與實體 | `LocalBusiness` | 實體商家及其細分類型 |
| 身分與實體 | `Brand` | 品牌 |
| 知識與內容 | `Article` | 一般文章 |
| 知識與內容 | `NewsArticle` | 新聞報導 |
| 知識與內容 | `BlogPosting` | 部落格文章 |
| 知識與內容 | `TechArticle` | 技術文章 |
| 知識與內容 | `FAQPage` | 站方提供的常見問題及答案 |
| 知識與內容 | `QAPage` | 單一問題及其答案的問答頁 |
| 知識與內容 | `HowTo` | 步驟型說明 |
| 知識與內容 | `DefinedTerm` | 術語或概念定義 |
| 商品與服務 | `Product` | 商品 |
| 商品與服務 | `Service` | 服務 |
| 商品與服務 | `Offer` | 提供條件、價格、供應資訊 |
| 商品與服務 | `Review` | 個別評論 |
| 商品與服務 | `AggregateRating` | 匯總評分 |
| 專業資料 | `Dataset` | 資料集 |
| 專業資料 | `DataCatalog` | 資料集目錄 |
| 專業資料 | `Event` | 活動 |
| 專業資料 | `SoftwareApplication` | 軟體應用 |
| 多媒體 | `ImageObject` | 圖片 |
| 多媒體 | `VideoObject` | 影片 |
| 多媒體 | `AudioObject` | 音訊 |

**選擇原則：** 每個網頁只標記其真實存在的主體與內容，不需要把所有 `@type` 都塞進同一頁。

## 3. GEO 值得重視的四組欄位

### 3.1 實體識別（Entity Identity）

目標：清楚回答「這個內容說的是哪一個人、組織、地點或事物？」

| 欄位 | 說明 |
|---|---|
| `@id` | 實體的穩定 URI 識別碼 |
| `@type` | 實體類型 |
| `name` | 名稱 |
| `alternateName` | 別名、其他名稱 |
| `description` | 描述 |
| `disambiguatingDescription` | 用於區別相似名稱的補充描述 |
| `url` | 正式網頁網址 |
| `sameAs` | 指向其他能識別**同一實體**的網頁 URL |
| `identifier` | 正式編號或識別資料 |

### 3.2 語意關係（Semantic Relationships）

目標：表達「誰和誰有什麼關係？」

| 欄位 | 說明 |
|---|---|
| `mainEntity` | 頁面的主要描述對象 |
| `mainEntityOfPage` | 某實體主要由哪個頁面描述 |
| `about` | 內容主要討論的主題 |
| `mentions` | 內容中提及的其他實體 |
| `isPartOf` | 屬於哪個網站或較大內容單位 |
| `hasPart` | 包含哪些子內容 |
| `relatedLink` | 網頁的相關連結（適用 `WebPage`） |

### 3.3 內容與時效性（Content & Freshness）

目標：讓內容的題目、形式、語言與更新狀態更明確。

| 欄位 | 說明 |
|---|---|
| `headline` | 標題（常用於文章） |
| `abstract` | 摘要 |
| `articleBody` | 文章正文（適用文章類型） |
| `inLanguage` | 語言，例如 `zh-TW` |
| `datePublished` | 首次發布日期 |
| `dateModified` | 真正的內容修改日期 |
| `lastReviewed` | 最後內容審核日期（適用部分內容類型） |
| `author` | 作者 |
| `publisher` | 發布者 |
| `keywords` | 主題關鍵詞 |

> 不應只是為了製造「最新」印象而更新 `dateModified`；日期應與實際內容維護一致。

### 3.4 來源與可驗證性（Provenance）

目標：交代資訊是誰提供的，以及依據是什麼。

| 欄位 | 說明 |
|---|---|
| `citation` | 引用的資料、文章或文獻 |
| `isBasedOn` | 內容衍生或參考的來源 |
| `author` | 內容作者 |
| `publisher` | 發布單位 |
| `license` | 授權條件 |
| `sdPublisher` | 結構化資料的發布者 |

其中 `citation` 與 `isBasedOn` 很適合研究、知識整理及資料型網站，但不代表 AI 一定會信任或引用內容。

## 4. 推薦的 JSON-LD 結構

常見做法是用 `@graph` 連結**網站 → 網頁 → 內容實體 → 發布組織**，而不是把所有資訊寫在一個沒有關係的平面物件裡。

```text
WebSite
  └── WebPage
        └── mainEntity → Article
                            └── publisher → Organization
```

以下為通用示例，網址與名稱需換成真實資料：

```json
{
  "@context": "https://schema.org",
  "@graph": [
    {
      "@type": "WebSite",
      "@id": "https://example.com/#website",
      "name": "Example",
      "url": "https://example.com/"
    },
    {
      "@type": "Organization",
      "@id": "https://example.com/#organization",
      "name": "Example Publisher",
      "url": "https://example.com/"
    },
    {
      "@type": "WebPage",
      "@id": "https://example.com/guide#webpage",
      "url": "https://example.com/guide",
      "name": "知識指南",
      "inLanguage": "zh-TW",
      "isPartOf": {
        "@id": "https://example.com/#website"
      },
      "mainEntity": {
        "@id": "https://example.com/guide#article"
      }
    },
    {
      "@type": "Article",
      "@id": "https://example.com/guide#article",
      "headline": "知識指南",
      "mainEntityOfPage": {
        "@id": "https://example.com/guide#webpage"
      },
      "publisher": {
        "@id": "https://example.com/#organization"
      }
    }
  ]
}
```

這是**語意關聯的最小示例**，不是完整的搜尋複合式結果範本。實務上需依頁面內容補充作者、圖片、發布日期、來源等資訊。

## 5. FAQ、AI 搜尋與常見誤解

1. **`FAQPage` 不是 GEO 的捷徑。** 它可以描述 FAQ 內容，但各搜尋服務是否把它呈現為特別的搜尋功能，會依政策改變；不應把取得 FAQ 複合式結果當成必然回報。
2. **`QAPage` 不等於一般 FAQ。** 它適合以單一問題及答案為主的問答頁；使用時應檢查搜尋服務對該類型的具體規範。
3. **更多欄位不等於更好的排名或更多 AI 引用。** 真實性、清楚的內容組織、網站可存取性、可驗證來源與內容品質同樣重要。
4. **`sameAs` 不應濫用。** 它代表「同一實體」，不是任意相關的網站、新聞、供應商或社群貼文。
5. **Schema.org 支援 ≠ Google 支援特定 rich result。** 詞彙有效，不代表所有搜尋引擎都提供對應的特殊顯示。

## 6. 一般網站的實作優先順序

| 優先級 | 建議實作 | 理由 |
|---|---|---|
| P0 | `WebSite`、`WebPage`、核心實體 `@id` | 建立穩定識別與基礎結構 |
| P0 | `name`、`description`、`url`、`mainEntity` | 明確說明頁面及主要對象 |
| P1 | `Organization`／`Person`、`author`、`publisher` | 表達內容責任與發布者 |
| P1 | `about`、`sameAs`、`isPartOf` | 建立主題與實體間的關係 |
| P1 | 依內容選 `Article`、`Product`、`Service` 等 | 使用符合真實內容的語意模型 |
| P2 | `dateModified`、`lastReviewed`、`citation` | 補足時效與來源脈絡 |
| P2 | `BreadcrumbList`、`ItemList` 等 | 補充導航、清單及階層 |
| 按需求 | `Dataset`、`Event`、`VideoObject` 等 | 支援特定內容類型 |

> P0／P1／P2 是工程建議的實作順序，**不是搜尋引擎官方的排名權重**。

## 7. 發布前檢查清單

- [ ] 選用的 `@type` 與頁面真實內容相符。
- [ ] 相同實體跨頁使用一致且穩定的 `@id`。
- [ ] `mainEntity`、`about`、`mentions` 沒有混用。
- [ ] `sameAs` 只連向真正的同一實體。
- [ ] 作者、日期、評分、價格等資訊有對應的可見內容與事實依據。
- [ ] JSON-LD 語法正確，沒有錯誤的關聯或無效連結。
- [ ] 檢查 Schema.org 語意與目標搜尋引擎的額外規定。
- [ ] 網頁仍可正常供爬蟲存取，且正文對使用者可讀。

## 8. 總結

對一般 AI SEO／GEO 網站，應優先把以下四個問題描述清楚：

1. **Entity：** 這是誰、什麼事物？
2. **Relationship：** 它與其他人、事、物有什麼關係？
3. **Content：** 這頁到底提供了什麼資訊，何時建立、何時更新？
4. **Provenance：** 誰提供資訊，根據什麼來源？

**核心原則：先把真實內容與實體關係建好，再用 Schema.org 清楚表達；不要為了 SEO／GEO 填寫不真實或不相干的標記。**

## 9. 官方參考資源

- [Schema.org 官方詞彙表](https://schema.org/docs/full.html)
- [Schema.org 入門](https://schema.org/docs/gs.html)
- [Google Search Central：結構化資料總覽](https://developers.google.com/search/docs/appearance/structured-data/intro-structured-data)
- [Google Search Central：Article 結構化資料](https://developers.google.com/search/docs/appearance/structured-data/article)
- [Google Search Central：FAQ 結構化資料](https://developers.google.com/search/docs/appearance/structured-data/faqpage)
- [Google Rich Results Test](https://search.google.com/test/rich-results)
- [Schema Markup Validator](https://validator.schema.org/)








