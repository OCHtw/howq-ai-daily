title=changedetection.io 完整教學 2026：3.4 萬星開源網頁變更監控，降價／補貨／公告自動通知（Docker 安裝、CSS／XPath／jq 選擇器、Browser Steps、Apprise 通知、價格追蹤與 REST API 一次學會）
date=2026-11-27
dateModified=2026-11-27
source_date=2026-10-04
type=news
status=published
category=系統開發
tags=Tip,AI摘要
source_name=Dennis 技術視野洞察 | AI 工具・Python 教學・系統架構開發實戰
source_url=https://most.tw/posts/blog/changedetection-io-complete-guide-2026/
image=https://most.tw/images/2026-10-04-changedetection-io-guide.webp
summary=changedetection.io 是 GitHub 上 34,000+ stars、Apache-2.0 授權的開源網頁變更監控工具（Python 撰寫，最新版 0.60.8，2021 年至今持續維護）。它幫你盯住任何網頁——商品降價、補貨、政府公告、職缺釋出、PDF 改版——只要內容變了就透過 Apprise 推播到 ntfy、Telegram、Discord、Email 或 Webhook。本文從 Docker Compose 安裝、第一個 watch、CSS／XPath／JSONPath／jq 選擇器、條件觸發、JavaScript 網站的 Browser Steps 與 Playwright 設定，一路到價格追蹤模式、REST API 自動化（含可直接複製的 Python 範例）、與 Distill.io／Visualping／自己寫 cron 的完整比較表，以及 7 個新手一定會踩的陷阱。
tldr1=
tldr2=
tldr3=
faq1Question=
faq1Answer=
faq2Question=
faq2Answer=
faq3Question=
faq3Answer=
preview=changedetection.io 是 GitHub 上 34,000+ stars、Apache-2.0 授權的開源網頁變更監控工具（Python 撰寫，最新版 0.60.8，2021 年至今持續維護）。它幫你盯住任何網頁——商品降價、補貨、政府公告、職缺釋出、PDF 改版——只要內容變了就透過 Apprise 推播到 ntfy、Telegram、Discord、Email 或 Webhook。本文從 Docker Compose 安裝、第一個 watch、CSS／XPath／JSONPath／jq 選擇器、條件觸發、JavaScript 網站的 Browser Steps 與 Playwright 設定，一路到價格追蹤模式、REST API 自動化（含可直接複製的 Python 範例）、與 Distill.io／Visualping／自己寫 cron 的完整比較表，以及 7 個新手一定會踩的陷阱。
~~~~~~

全天候替你盯著指定網址的內容變動，並在偵測到更新時第一時間發送通知給你。

### 精準內容過濾

支援 CSS 選擇器、XPath、JSONPath 與 jq，能鎖定網頁中的特定區塊進行監控，並自動忽略時間戳記或廣告等無關雜訊。

### 動態網頁與互動模擬

內建 Playwright 與瀏覽器步驟（Browser Steps）功能，能處理需要載入 JavaScript 的現代網頁，甚至模擬點擊或輸入動作後再抓取內容。

### 價格與補貨追蹤

內建專門的電商價格追蹤模式，可設定「價格低於特定金額」或「出現補貨字樣」等條件式觸發通知。

### AI 摘要與 MCP 支援

支援串接 OpenAI、Google Gemini、Anthropic 或本地 Ollama 等模型，能用白話文設定觸發條件或自動總結變更重點，並支援透過 MCP（Model Context Protocol）讓 AI 助理直接查詢監控歷史。

### 多元推播管道

透過整合 Apprise，支援超過 85 種通知方式，包含 Telegram、LINE、Discord、Slack、Email 與自訂 Webhook。

### 視覺化差異比對

每次偵測到變動都會保留歷史快照，並提供並排或行內的文字與視覺差異（Diff）比對介面，讓你一眼看出哪裡被修改。



> 小編想用來幫店家收集情報 ＾＾ 搭配RssHub


<a href="https://github.com/dgtlmoon/changedetection.io?utm_source=howqpon.com" target="_blank" rel="noopener noreferrer">Changedetection.io Github ↗</a>

