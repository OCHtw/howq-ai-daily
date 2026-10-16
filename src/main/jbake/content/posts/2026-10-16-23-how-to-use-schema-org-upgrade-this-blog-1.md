title=將Schema.org 結構化資料更新到blog
date=2026-10-16
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