title=OpenAI 前技術長新創開源小模型：筆電離線跑，飛機上寫出飛行模擬器
date=2026-11-25
dateModified=2026-11-25
source_date=2026-11-21
type=news
status=published
category=AI模型
tags=Open-Weights,Tip
source_name=鏈新聞 ABMedia
source_url=https://abmedia.io/thinking-machines-inkling-2-mini
image=https://i0.wp.com/abmedia.io/wp-content/uploads/2026/11/thinking-machines-inkling-2-mini-cover.jpg?fit=1536%2C1024&quality=99&ssl=1
summary=Thinking Machines 開源 Inkling 2 Mini：264 億參數、約 20GB 記憶體可在筆電離線執行，DeepSWE 48.2% 為同級開源模型第一，採中間層重複運算的迴圈架構。根據 Thinking Machines 官方發表文，Inkling 2 Mini 在總參數 1,000 億以下的開源權重模型中，寫程式測試 DeepSWE v1.1 拿下 48.2%、綜合測試 Vals Index v2.2 拿下 46.5%，兩項都是同級第一。
tldr1=是「混合專家」架構：模型裡有很多組各有專長的子網路，每次只叫用其中幾組。Inkling 2 Mini 總參數 264 億，每個字實際用到的只有 34 億。最特別的是迴圈架構。模型共 24 層、分成 4 段，每處理一個字，頭尾兩段各跑一次，中間兩段重複跑三次，等於用 24 層的參數做了 48 層的運算。
tldr2=官方的說法是，中間層負責比較抽象的推理，多跑幾遍能讓模型想得更深，用更少的字就得出正確答案，對需要推理品質的 AI 代理寫程式任務特別有幫助。官方實驗中，迴圈放在中間 12 層，28 項評測裡有 27 項比放在最後 12 層進步更多。
tldr3=
faq1Question=
faq1Answer=
faq2Question=
faq2Answer=
faq3Question=
faq3Answer=
preview=Thinking Machines 開源 Inkling 2 Mini：264 億參數、約 20GB 記憶體可在筆電離線執行，DeepSWE 48.2% 為同級開源模型第一，採中間層重複運算的迴圈架構。
~~~~~~

## 寫程式領先，背知識沒有變強

官方拿 Gemma 4 31B、Qwen3.8-27B 等同級開源模型比較。DeepSWE v1.1 這項寫程式測試，Inkling 2 Mini 拿 48.2%，Qwen3.8-27B 是 42.2%；Hugging Face 部落格整理，跟這 4 個模型比，48 項測試裡它有 32 項領先。官方也列出弱點：多輪對話與條件很多的指令，分數落後 Qwen3.8-27B；在 HLE-Diamond 等高難度推理測試，也比不上更大的模型。


