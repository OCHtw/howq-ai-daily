title=將Schema.org 結構化資料更新到blog
date=2026-10-16
dateModified=2026-10-17
type=post
status=published
category=內建小程式
tags=GEO,Blog改版
summary=先把 SEO 基礎與 Schema.org 一起做好。統一正式網域、canonical、Sitemap，並導入 WebSite、WebPage、BlogPosting、AboutPage。新聞頁則額外利用 isBasedOn 建立來源關係。
~~~~~~

> 小編請AI大大先牛刀小試，先將blog加上最基礎的部分

## 本次完成的修改

| 項目 | 處理結果 |
| --- | --- |
| 正式網域 | [https://dev.howqpon.com/](<https://dev.howqpon.com/?utm_source=chatgpt.com>) |
| Sitemap | 開啟並新增 XML 模板 |
| Canonical | 所有 HTML 頁面統一自動產生 |
| Schema.org | 依 `type` 自動選擇類型 |
| 日誌 | `BlogPosting` |
| 新聞短評 | `BlogPosting` \+ `isBasedOn` |
| 關於頁 | `AboutPage` |
| 分類、標籤頁 | `CollectionPage` |
| `dateModified` | 選填，不使用建置時間 |
| `robots.txt` | 新增 Sitemap 宣告 |


><a href="https://dev.howqpon.com/robots.txt"
   target="_blank"
   rel="noopener noreferrer">
   看完整robots.txt ↗
</a>


## 增加的修改 10/17

  - 未來新增的貼文都預設發文日為 dateModified
  - 若有dateModified又和發文日不同就顯示在頁面
  
快照於2026-10-17

**Before**
![網站內文顯示修改日期 2026-10-17 快照](/images/2026-10-17/2026-10-17-show-modified-date-on-page.jpg)
