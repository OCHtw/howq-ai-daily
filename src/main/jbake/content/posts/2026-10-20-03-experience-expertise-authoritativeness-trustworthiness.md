title=E-E-A-T是什麼？目前這個Blog還缺什麼？增加小編資訊
date=2026-10-20
dateModified=2026-10-20
type=post
status=published
category=內建小程式
cover=
tags=GEO,Blog改版
summary=E-E-A-T 是 Google 用來評估內容品質與可信度的四個面向。對正在經營的Blog而言，它不只涉及 SEO，也關係到你希望 AI 搜尋系統能否理解你的文章、作者身分及內容來源。
tldr1=
tldr2=
tldr3=
faq1Question=
faq1Answer=
faq2Question=
faq2Answer=
faq3Question=
faq3Answer=
~~~~~~


## E-E-A-T 的四個面向

### 1. Experience｜實際經驗

你是否真正做過這件事？

例如，親自用 Java、JBake 建立網站、測試 Schema，並留下操作結果與踩坑紀錄。

### 2. Expertise｜專業知識

你是否理解技術原理，能解釋為何選擇某個解決方案，而不只是重述官方文件？

### 3. Authoritativeness｜權威性

其他人是否認識、引用或推薦你在特定領域的內容？

例如，技術社群引用你的研究成果。

### 4. Trustworthiness｜可信度

讀者能否確認作者是誰、資訊從哪裡來、何時更新，以及內容有沒有可靠證據？

Google 特別強調：**Trust（可信度）是四者中最重要的。**

## 兩個常見的 E-E-A-T 誤解

但有兩件事很容易被誤解：

- **E-E-A-T 本身不是一個可以直接計算的 Google 排名分數。**
- **增加 Schema 不會自動提升 E-E-A-T。** Schema 能幫助搜尋系統理解資訊，但無法代替真實經驗、專業內容和可信的外部佐證。


## 健檢目前Blog

| 項目 | 現況 | 我的判斷 |
|---|---|---|
| Canonical | 已實作 | 保留 |
| Sitemap | 已啟用 | 保留 |
| BlogPosting | 已實作 | 保留 |
| Organization | 已實作 | 保留 |
| Person | OCHtw、GitHub sameAs | 基礎已具備 |
| datePublished / dateModified | 已實作 | 保留 |
| 新聞來源 isBasedOn | 已實作 | 很適合新聞短評 |
| TL;DR、FAQ | 已支援 | 不必額外擴充 |
| **作者在文章中的署名** | **尚無** | **優先補強** |
| **作者經歷、專長** | **說明不足** | **優先補強** |
| **新聞編輯與更正原則** | **未看到明確說明** | **建議補強** |
| 外部引用與業界認可 | 尚未評估到證據 | 長期累積 |


## 進行改善工程

**強化Person schema.org設定：**


```
{
  "@type": "Person",
  "@id": "https://ochtw.com/#person",
  "name": "OCHtw",
  "url": "https://www.linkedin.com/in/hsinwei-chen-tw",
  "sameAs": [
    "https://github.com/OCHtw"
  ]
}
```

  - 統一@id到已購入的個人網址：OCHtw 是創作者，howqpon 是內容品牌，因為從長期來看，小編打算經營多個Blog。提供更清楚、一致的身分線索。



**在文章中的署名：**

快照於2026-10-20

![在文章中的署名前 2026-10-20 快照](/images/2026-10-20/2026-10-20-before-add-author-on-page.jpg)

![在文章中的署名後 2026-10-20 快照](/images/2026-10-20/2026-10-20-after-add-author-on-page.jpg)


**增加關於作者、新聞編輯與更正原則：**

快照於2026-10-20

![about.html 2026-10-20 快照](/images/2026-10-20/2026-10-20-about-html-snapshot.png)
