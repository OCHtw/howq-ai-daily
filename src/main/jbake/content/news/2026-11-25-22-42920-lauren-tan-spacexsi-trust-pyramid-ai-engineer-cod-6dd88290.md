title=一個月出 1.1 萬個 PR 如何不出包？Grok Bot 負責人分享 AI 協作的信任金字塔
date=2026-11-25
dateModified=2026-11-25
source_date=2026-11-16
type=news
status=published
category=系統開發
tags=AI,Tip,AI架構
source_name=INSIDE
source_url=https://www.inside.com.tw/article/42920-lauren-tan-spacexsi-trust-pyramid-ai-engineer-code-2026
image=https://bucket-image.inkmaginecms.com/version/social/9dde7c0f-a597-445c-80dd-9a93db8a4006/image/2026/11/55099ecc-89f0-499e-9904-693851b5fc66.webp
summary=SpaceXSI 首席工程師 Lauren Tan 在 AI Engineer CODE 2026 分享團隊一個月出 1.1 萬個 AI 代理生成的 pull request、回退率僅 0.5% 的做法，核心是把約束放進程式碼庫本身，而非只靠人工審查。
tldr1=核心概念：除錯時應優先修改程式庫與 lint 規則而非修改提示詞；唯有內層穩定，才能推行外層的自動開 PR 與自動合併。
tldr2=
tldr3=
faq1Question=
faq1Answer=
faq2Question=
faq2Answer=
faq3Question=
faq3Answer=
preview=SpaceXSI 首席工程師 Lauren Tan 在 AI Engineer CODE 2026 分享團隊一個月出 1.1 萬個 AI 代理生成的 pull request、回退率僅 0.5% 的做法，核心是把約束放進程式碼庫本身，而非只靠人工審查。
~~~~~~

> 小編也遇到系統越來越大時，AI大大常有時人來瘋亂寫的問題，這個信任金字塔好像可以解決一部分問題。

## 信任金字塔的架構：核心邏輯是以程式碼庫設計與自動化約束取代人工逐行審查


| 層級（由強約束至弱約束） | 核心目標 | 具體執行細節與團隊案例 |
| :--- | :--- | :--- |
| **1. 程式碼庫本身** (Codebase) | **讓錯誤根本寫不出來** | 程式碼是 AI 最大宗的模仿來源。團隊禁用容易出錯的 API（如 React 的 `useEffect`）、刪除 99% 的註解（避免過時註解誤導 AI），並維持清晰的模組邊界。 |
| **2. 靜態檢查** (Static Analysis) | **在合併前自動攔截** | 透過嚴格的型別系統、Lint 規則、編譯器與 CI 自動擋下問題。例如：為避免桌面端渲染超過 16ms 造成卡頓，團隊直接寫了「相依圖檢查器」，從架構層面禁止主執行緒執行重型任務，而非靠人工提醒。 |
| **3. 驗證機制** (Verification) | **交出「執行證據」才算數** | 團隊將 **約 70% 的 Token 預算花在驗證上**。包含**執行期驗證**（讓 Agent 實際啟動程式、截圖、錄製 UI 操作影片證明功能正常），以及**形式驗證**（使用 TLA+ 或 Lean 證明系統不變量成立）。 |
| **4. 文字規則** (Prose / Rules) | **僅保留需要判斷力的指引** | 包含 `AGENTS.md`、Skills 與提示詞。原則是「文字要一直刪」—當模型變強或錯誤已轉化為 Lint 規則後，就將對應的文字說明刪除，避免規則過長導致 AI 忽略。 |
| **5. 人工審查** (Human Review) | **最後一道防線** | 專案早期由人密切審查，但隨信任度提升，最終交由「交叉找碴 Agent」先挑錯，人類僅需確認最終成果或架構方向。 |


由內而外推動：除錯時應優先修改程式庫與 lint 規則而非修改提示詞；唯有內層穩定，才能推行外層的自動開 PR 與自動合併。


<div class="video-container">
  <iframe
    src="https://www.youtube-nocookie.com/embed/O_zcc6Xl12g"
    title="All Code Is Slop (Except Mine) — Lauren Tan, SpaceXSI"
    loading="lazy"
    allowfullscreen>
  </iframe>
</div>

<a href="https://www.youtube.com/watch?v=dP3ntiRf7YI?utm_source=howqpon.com" target="_blank" rel="noopener noreferrer">中文翻譯字幕版 ↗</a>

---

## Lint（程式碼靜態檢查工具）

一種在不實際執行程式的情況下，自動掃描程式碼並抓出潛在錯誤、不良寫法或風格不一致的工具（執行這個檢查的過程就叫 Linting）。你可以把它想像成 Word 的「拼字與文法檢查」，只是檢查的對象換成了程式碼。


### Java 經典三大 Lint 工具

| 工具名稱 | 檢查對象 | 核心強項 | 常見攔截問題 |
| :--- | :--- | :--- | :--- |
| **Checkstyle** | 原始碼（`.java`） | **排版與風格規範** | 縮排不一致、變數命名不符合駝峰式、缺少註解、單行過長 |
| **PMD** | 原始碼（`.java`） | **程式碼品質與壞味道** | 宣告卻未使用的變數、空的 `try-catch` 區塊、邏輯過於複雜、重複程式碼 |
| **SpotBugs** | 位元組碼（`.class`） | **潛在 Bug 與執行期風險** | 空指標異常（`NullPointerException`）、資料庫連線未關閉、多執行緒死鎖 |


在 Maven 或 Gradle 專案中，通常會將 Checkstyle + PMD + SpotBugs 同時整合進建置流程（Build Pipeline），確保「格式統一、寫法乾淨、沒有低級 Bug」三件事一次到位。


