title=往外連的url後方加上UTM
date=2026-10-19
dateModified=2026-10-19
type=post
status=published
category=內建小程式
cover=
tags=GEO,Blog改版
summary=往外連的url後方加上UTM，如果對方查看 GA4 流量來源，就有機會看到 howqpon。未來若有一定導流量，新聞媒體或作者可能注意到你的網站。
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


## 往外連的url後方加上UTM有什麼好處?
- 品牌曝光：如果對方查看 GA4 流量來源，就有機會看到 howqpon。
- 建立關係：未來若有一定導流量，新聞媒體或作者可能注意到你的網站。
- 來源識別：比只依靠 HTTP Referer 更容易讓對方識別你的品牌。
- 不影響你自己的 SEO：正常對外連結附加 UTM，不會直接造成你網站的 SEO 扣分。

> 一點一點建立聲譽。就算微不足道。廣結善緣拉

## 格式

| 參數 | 用途 |
| :--- | :--- |
| `utm_source=howqpon.com` | 告訴對方流量來自 howqpon |
| `utm_medium=referral` | 表示是其他網站的推薦連結 |
| `utm_campaign=blog_news` | 區分是 Blog 的新聞引用 |
| `news.utm.exclude_domains=example.com;another-news.org` | 不加 UTM 的新聞網站，多個網域以 ; 分隔 |
