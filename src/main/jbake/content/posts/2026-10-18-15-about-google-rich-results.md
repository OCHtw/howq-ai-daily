title=認識複合式搜尋結果（Rich Results）
date=2026-10-18
dateModified=2026-10-18
type=post
status=published
category=內建小程式
tags=GEO,Blog改版
summary=Schema.org 還提供了數百種結構化資料類型。不同的網站性質，會對應到不同的標記策略。實作正確的結構化資料，最大的好處是能解鎖 Google 搜尋結果上各種吸睛的複合式搜尋結果（Rich Results）。
faq1Question=Google官方支援的搜尋結果類型總共有哪些？
faq1Answer=可以到<a href="https://developers.google.com/search/docs/appearance/structured-data/search-gallery?utm_source=howqpon.com" target="_blank" rel="noopener noreferrer">Rich Results Gallery ↗</a>來了解目前開放的規格。
faq2Question=如何檢查是否符合Google要求的JSON-LD格式？
faq2Answer=可以進行<a href="https://search.google.com/test/rich-results?utm_source=howqpon.com" target="_blank" rel="noopener noreferrer">Google Rich Results Test ↗</a>來了解是否符合規格。
faq3Question=JSON-LD寫得100%正確且通過測試，就會呈現Rich Results嗎？
faq3Answer=不一定。Google會透過演算法來決定是否要顯示複合式搜尋結果。這取決於使用者的搜尋意圖，以及你網站本身的權重與品質。
~~~~~~

小編因為有啥看到google搜尋出來的結果列，有些人的會多些東西，所以就問AI大大那是啥。原來是Google Rich Results。而這是實作正確Schema.org的結構化資料後，Google給的額外紅利：解鎖 Google 搜尋結果上各種吸睛的**複合式搜尋結果（Rich Results）**。常見的如下：

## 1\. 電商與產品銷售（E-commerce）

### Product（產品）

- **視覺效果：** 在搜尋結果直接顯示產品的價格、庫存狀態（例如：有現貨）、特價資訊等。
- **對 SEO 的幫助：** 讓消費者在點擊進入網站前就看到價格與庫存，能大幅過濾掉無效點擊，並提高精準轉換率。

### Review 與 AggregateRating（評論與總體評分）

- **視覺效果：** 顯示吸睛的黃金星級評分（⭐⭐⭐⭐⭐）及評論數量。
- **對 SEO 的幫助：** 帶有星星的搜尋結果在視覺上非常突出，通常能顯著提升點擊率。這通常會與 `Product`、`LocalBusiness` 或 `Recipe` 搭配使用。

## 2\. 內容發布與部落格（Content & Publishing）

### Article / NewsArticle / BlogPosting（文章）

- **視覺效果：** 有機會被收錄到手機版搜尋結果頂部的「焦點新聞（Top Stories）」輪播中，或是顯示較大的預覽圖片。
- **對 SEO 的幫助：** 對於新聞媒體或高流量部落格來說，這是搶佔搜尋結果最上方黃金版面的關鍵。需要提供標題、發布時間、作者、首圖等資訊。

### FAQPage（常見問題）

- **視覺效果：** 在搜尋結果下方，直接以手風琴（Accordion）的折疊形式顯示一問一答。
- **對 SEO 的幫助：** 佔用極大的搜尋結果版面，把競爭對手往下擠。
- **注意事項：** Google 近期已縮減 FAQ 的顯示頻率，目前主要保留給具高權威性的健康或政府網站，但一般網站實作仍有助於爬蟲理解網頁內容。

## 3\. 網站結構與導覽（Site Structure）

### BreadcrumbList（麵包屑導覽）

- **視覺效果：** 將搜尋結果原本顯示的複雜網址（URL），轉換成清楚的路徑階層，例如：`example.com > 電腦 > 筆記型電腦`。
- **對 SEO 的幫助：** 幫助搜尋引擎理解網站的層級架構，同時讓使用者清楚知道這個網頁在網站中的位置。

## 4\. 特殊產業與領域（Specialized）

### Recipe（食譜）

- **視覺效果：** 專為美食網站設計，可以在搜尋結果顯示料理時間、卡路里、評分，並以精美的圖文輪播呈現。

### Event（活動）

- **視覺效果：** 如果你舉辦演唱會、線上研討會（Webinar）或課程，標記後可以在搜尋結果列出未來的活動日期、時間與地點。

### SoftwareApplication（軟體應用程式）

- **視覺效果：** 適合軟體公司或 App 介紹頁面，可以標記作業系統（OS）、價格、類別等資訊。

### VideoObject（影片）

- **視覺效果：** 讓影片不僅能出現在一般搜尋結果，還能出現在「影片」搜尋分頁中，甚至可以標記 `hasPart` 來顯示影片的「關鍵片段（Key Moments）」時間軸。


## 目前小編可以先設計進哪些？

### 1\. 文章代表圖片（最值得投入）

你已經有 Markdown Cover 設計，可以延伸成文章 `image` Schema，再搭配 `og:image` 和 `max-image-preview:large`。

Google 建議 `Article` 提供以下比例的高解析度圖片：

- **1:1**（正方形）
- **4:3**（標準橫式）
- **16:9**（寬螢幕）

若想爭取 Google Discover 大圖曝光，圖片寬度建議至少 **1200px**。

### 2\. 自動產生 BreadcrumbList

依據網站的日誌、新聞、主題分類，自動生成階層式的 `BreadcrumbList`，不必每篇 Markdown 文章都手動設定。

![通過Google Rich Results Test 的 2026-10-18 快照](/images/2026-10-18/2026-10-18-rich-result-test-pass.jpg)


### 3\. 網站識別與作者資訊

首頁設定適當的 `Organization` 或 `Person` Schema，搭配 Logo、作者連結和網站名稱，有利於 Google 辨認網站身分。


## 後續的調整

修改檢測問題：已將日期格式自動生成為加上台灣時間預設零點零分。




