title=熱門AI模型評分系統Arena完成B輪融資，估值在10個月內近乎翻倍，達到31億美元
date=2026-10-14
source_date=2026-10-08
type=news
status=published
category=AI應用
tags=AI,評分系統
source_name=TechCrunch
source_url=https://techcrunch.com/2026/10/08/popular-ai-leaderboard-arena-nearly-doubles-valuation-to-3-1b-valuation-in-10-months/
image=https://techcrunch.com/wp-content/uploads/2026/06/ARENA_3Founders.jpg?resize=1200,801
summary=Arena宣布完成2億美元B輪融資，估值達31億美元。平台讓使用者比較不同AI模型的回答，再利用群眾評價形成模型排名。除了免費的公開評測，也向企業及模型開發公司提供付費評估分析。公司表示，2026年6月的年化營收已達1億美元。
preview=The company behind the popular LMArena leaderboard has raised $200 million led by Lightspeed and Khosla, and is now measuring AI models on alignment issues such as lying.
~~~~~~

小編除了羨慕可以融資這麼多錢外，也好奇這件任務有這麼重要嗎？就問AI大大：

## Arena 產品評價

在現今評估大型語言模型（LLM）的盲測中，LMSYS Chatbot Arena（模型競技場） 所採用的「AI模型盲測對決 + 群眾評分（Crowdsourced Elo Rating）」被公認為最重要且最具公信力的行業標準之一。


## Chatbot Arena 的運作機制

Chatbot Arena 的 Elo 評分系統採用了類似棋藝或電競的 **Elo 評分系統**，其運作流程非常直覺：

- **盲測對決（Blind Test）**：使用者輸入任意提示詞（Prompt），系統隨機指派兩個匿名模型（例如模型 A 與模型 B），並同時生成回答。

- **群眾評價（Crowdsourcing）**：使用者在不知道模型名稱的情況下，根據回答的品質、準確度與邏輯，投票選出「A 較好」、「B 較好」、「平手」或「都很差」。

- **動態排名（Elo Rating）**：系統收集數十萬次真實投票後，透過統計學演算法計算每個模型的 Elo 分數，並即時更新全球公開的排行榜（Leaderboard）。


## 為什麼群眾評價的排名如此重要？


- **破解「基準測試刷榜」的集體作弊（Goodhart's Law）**

傳統的 AI 評測（如 MMLU、GSM8K 等靜態資料庫）近年面臨巨大挑戰。許多廠商在訓練模型時，會不小心（或刻意）將測試題目納入訓練資料中（資料污染），導致模型在考試中拿到滿分，但實際對話時卻很難用。

Arena 的題目完全來自使用者的隨機真實提問，模型無法提前「背考古題」，能真正反映其實戰能力。

- **貼近人類真實的「偏好」（Human Preference）**

AI 好不好用，很難單靠客觀數據測量。一個回答可能語法完全正確，但語氣太官腔、排版太亂，或者沒有抓到使用者的幽默感。

Chatbot Arena 捕捉的是人類最直觀的偏好（RLHF 的核心觀念）。群眾投票出來的第一名，代表它最符合大多數人類的閱讀與思考習慣。

- **動態應對「提示詞漂移」與技術迭代**

AI 領域的技術更新以「週」為單位計算。傳統的學術論文評測需要數個月的時間準備和同儕審查，等結果公布時，該模型可能早就過時了。

Arena 透過全球網友 24 小時不間斷的盲測，可以在新模型發布後的 24 到 48 小時內，快速定位出該模型在全世界的真實排名。


## 總結

利用群眾評價形成的 AI 排行榜，其核心重要性在於「它把 AI 的評價權，從實驗室數據交回給了真正的使用者」。它不僅是各大科技巨頭（OpenAI、Google、Anthropic）證明自己技術實力的最高舞台，也是工程師和企業在挑選要使用哪款 AI 模型時，最安全、最不容易踩雷的參考指標。


