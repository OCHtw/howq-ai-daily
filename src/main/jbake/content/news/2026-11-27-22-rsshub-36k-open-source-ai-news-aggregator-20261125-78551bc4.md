title=RSSHub 破 3.6 萬星「萬物皆可 RSS」開源神器教學：自動抓取 X、YouTube、GitHub 動態再餵給 AI 生成每日早報
date=2026-11-27
dateModified=2026-11-27
source_date=2026-11-25
type=news
status=published
category=系統開發
tags=Tip,AI摘要
source_name=AI郵報
source_url=https://www.aiposthub.com/rsshub-36k-open-source-ai-news-aggregator-20261125/
image=https://storage.ghost.io/c/5e/61/5e6189f0-c5e0-49a0-97b4-5eddd3f43c77/content/images/2026/11/strategy30-b3-cover-27.png
summary=RSSHub 破 3.6 萬星開源教學！透過 Docker 自架把 X、YouTube、GitHub Releases、Telegram 與 PTT 通通轉成標準 RSS，再串接 Python 與 LLM 每天早上 8 點自動生成個人與團隊 AI 科技早報。
tldr1=
tldr2=
tldr3=
faq1Question=想追蹤的台灣本地網站或公司公告不在 RSSHub 支援清單裡怎麼辦？
faq1Answer=有兩個選擇：第一，RSSHub 支援社群開源貢獻，熟悉 JavaScript／TypeScript 的開發者通常只需寫 30 至 50 行 Cheerio 解析程式就能新增一條自訂路由；第二，如果你的需求只是單純盯某個公告網頁有沒有新文字出現，反而更適合搭配 Changedetection.io 直接做網頁異動偵測。
faq2Question=能推播到 LINE 或 Email 嗎？
faq2Answer=完全可以。腳本中最後的 push_telegram() 函式只有短短幾行，你可以輕鬆換成 Discord Incoming Webhook（只要一行 HTTP POST）、Slack Webhook、LINE Messaging API 的 Push 端點，或是透過 Gmail SMTP／Resend API 每天早上寄出一封排版精美的 HTML 電子報給全團隊。
faq3Question=
faq3Answer=
preview=RSSHub 破 3.6 萬星開源教學！透過 Docker 自架把 X、YouTube、GitHub Releases、Telegram 與 PTT 通通轉成標準 RSS，再串接 Python 與 LLM 每天早上 8 點自動生成個人與團隊 AI 科技早報。
~~~~~~

萬物皆可 RSS

<div class="video-container">
  <iframe
    src="https://www.youtube-nocookie.com/embed/ItLI_uUW5rU"
    title="Self-host your own RSS Feed Reader and Aggregator"
    loading="lazy"
    allowfullscreen>
  </iframe>
</div>

在 2026 年的 AI Agent 與自動化浪潮下，RSS 反而迎來了最強勢的文藝復興——因為 LLM 與自動化管線最需要的就是標準化、輕量、按時間排序且無廣告干擾的純文字結構，而這正是 RSS 協議的天生強項。


> 小編想用來幫店家收集情報 ＾＾


<a href="https://github.com/diygod/rsshub?utm_source=howqpon.com" target="_blank" rel="noopener noreferrer">Rsshub Github ↗</a>

