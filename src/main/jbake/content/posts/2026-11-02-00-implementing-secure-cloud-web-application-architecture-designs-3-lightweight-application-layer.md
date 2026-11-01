title=Howqpon雲端架構(3)：輕量化應用層
date=2026-11-02
dateModified=2026-11-02
type=post
status=published
category=Project Actions
cover=
tags=專案產出,系統設計
summary=專注Thin Client後端框架，採htmx配合Alpine.js來驅動互動，透過 Thymeleaf渲染局部HTML片段 (Fragments) 來動態更新畫面，免去JSON API轉換層，也不需所有權限驗證。將狀態與業務邏輯的重擔交還給後端伺服器（採用Spring Boot），讓瀏覽器端的應用層保持極度輕量化與低延遲。再加上採用分層資料快取，不直接存取核心關聯式資料庫。除了地端快取，最新資料與交易結果都僅能透過Redis非同步取回。將系統吞吐量推向極致，解除應用層對傳統關聯式資料庫效能的依賴，提升併發性。
tldr1=核心理念：輕量化 SSR（Server-Side Rendering 伺服器端渲染）架構降低資源消耗與安全風險。且Web 主機不對外公開，透過 Cloudflare Tunnel安全進入。
tldr2=採用分層資料快取，不直接存取核心關聯式資料庫。除了地端快取，最新資料與交易結果都僅能透過Redis非同步取回。將系統吞吐量推向極致，解除應用層對傳統關聯式資料庫效能的依賴，提升併發性。
tldr3=不是追求華麗與操作酷炫的前後端框架，而是在安全隔離的基礎上，以最少的資源提供足夠的互動能力。
faq1Question=Thin Client × 分層快取非同步驅動的優勢是什麼？
faq1Answer=可以讓瀏覽器端的應用層保持極度輕量化，進而提供極致的讀取低延遲與高吞吐量，單台主機可以服務的連線數也能大增，提升併發性。更重要的是由於和前端與資料端都低耦合，且分散式資料庫具高擴充力。可輕鬆單純橫向擴展應用程式實例與Redis叢集。理論上耗能相對低，且效能瓶頸較容易透過擴充輕量資源克服。
faq2Question=但專案主流架構都是單頁應用程式(SPA)配合關聯式資料庫(RDS)，表示一定比較正確吧？
faq2Answer=主流代表的是「泛用性」與「企業分工標準」，而非架構上的絕對「正確性」。SPA 加上直接存取關聯式資料庫（RDS）雖然是業界預設的萬用板手，在系統開發確實SPA+RDS較為直觀，同步處理的寫法容易處理且測試。但當系統越大型其複雜度也會高速加深，處理前端與後端維護兩套狀態與驗證邏輯，並撰寫大量僅用於搬運 JSON 的 API，大幅增加了開發與維護的摩擦力。另外最致命的缺點就是面對高併發下的RDS瓶頸。當面臨突發性高流量（例如中午時段大量使用者同時瀏覽菜單與送出訂單），RDS 的連線池數量與資料表鎖定機制，往往會成為系統最先卡死並拖垮效能的節點。
faq3Question=那為何用Thin Client(SSR + htmx) × 快取非同步驅動專案比率少？
faq3Answer=儘管「SSR + htmx + 非同步快取」在特定場景下效能與開發體驗極佳，但未能成為業界主流，主要受制於企業組織結構、行動端策略與技術生態系的歷史慣性。首先若該應用未來有行動端App需求，那必然需要為手機端再寫一套專屬的 JSON API，引發企業對雙重維護成本的疑慮。另外在「前端工程師（React/Vue）」與「後端工程師（Java/Go/Node）」的職涯與技能樹完全切開，全端思維工程師反而難以輕易招募。最後則是UI元件庫落差，面對需要極度複雜離線交互或重量級儀表板的場景時，開發者需要自行處理更多 DOM 細節，且效果不彰。
~~~~~~

![howqpon雲端網頁服務新架構規劃3-輕量化應用層](/images/2026-10-31/howqpon-web-application-architecture-designs-3-lightweight-application-layer.jpg)


**核心理念：輕量化 SSR（Server-Side Rendering 伺服器端渲染）架構降低資源消耗與安全風險。且Web 主機不對外公開，透過 Cloudflare Tunnel 安全進入。**

> 選擇SSR另一個考量是開發單純，不需要前端工程師與後端工程師間，大量的溝通協調與互推責任的會議跟文件地獄。雖說未來都是AI大大自己寫，但還是讓開發簡單些，避免AI代理們也吵起來 哈。

### 架構概念

```text
使用者 / Internet
        ↓
Cloudflare（DNS / CDN / WAF / LB）
        ↓
Cloudflare Tunnel
        ↓
Private EC2（Security Group A）
        │
        ├─ Spring Boot / Spring Security
        │    └─ 認證、授權、Session 安全
        │
        ├─ Spring MVC + Thymeleaf
        │    └─ Server-Side HTML Rendering
        │
        ├─ HTMX + Alpine.js + SortableJS
        │    └─ 輕量前端互動
        │
        └─ 分層快取
             ├─ L0：Cloudflare CDN
             └─ L1：Caffeine
             └─ L2：Redis
```


### 設計特色

1. **私有化應用主機**：EC2 無公開 IP，僅透過 Cloudflare Tunnel 提供 Web 服務。
2. **強化身分與權限控管**：Spring Security 實作 Authentication、Authorization、Scoped / Risk-based Authorization。
3. **輕量化網頁架構**：Spring MVC + Thymeleaf 進行 Server-Side Rendering，HTMX 處理局部更新，避免大型 SPA 的額外負擔。
4. **漸進式前端強化**：透過 Alpine.js、SortableJS 提供複雜互動，維持低前端依賴與開發成本。
5. **多層安全防護**：CSRF、Session Security、Security Headers、CSP 與 HTML Output Encoding，降低 XSS、注入等風險。
6. **分層資料快取加速**：CDN（L0）快取靜態資源，Caffeine（L1）快取低敏感度、低變動性資料，減少後端查詢。最新變更放在Redis（L2），供caffine讀取。
7. **限制快取內容**：不在應用層快取機敏資料，避免快取成為資料外洩來源。


### 關鍵技術優勢

| 技術 | 主要優勢 |
|---|---|
| **Spring Security** | 集中管理認證、授權與 Web 安全機制 |
| **Spring MVC + Thymeleaf** | 後端直接產生 HTML，降低前端架構複雜度 |
| **HTMX** | 局部更新網頁，減少 JavaScript 與 API 開發成本 |
| **Alpine.js / SortableJS** | 小型函式庫提供動態互動與拖曳排序 |
| **CSP / HTML Encoding** | 限制腳本來源、降低 XSS 風險 |
| **Cloudflare CDN（L0）** | 邊緣快取靜態資源，減少主機流量 |
| **Caffeine（L1）** | JVM 本地高速快取，降低遠端資料讀取次數 |
| **Redis（L2）** | 供caffine讀取；當有變更時即更新，部分機敏資料為加密，需用 (OpenBao) 解讀 |


### 核心價值

**不是追求華麗與操作酷炫的前後端框架，而是在安全隔離的基礎上，以最少的資源提供足夠的互動能力。**

透過 **Private EC2 + Spring Security + SSR + HTMX + 分層快取**，兼顧安全性、效能、低營運成本與未來水平擴充能力。

  * 極致的讀取低延遲與高吞吐量
  * 核心資料庫的絕對隔離與保護
  * 突破連線池與鎖定瓶頸
  * 釋放 Web 執行緒以提升併發性


### 明顯缺點

> 需要透過更複雜的網頁佈局，減少渲染區塊與頻率。且要設計出簡潔有力的網頁排版，讓使用者減少操作。
> 另外強化預測下一步需要資料，規劃提前準備，拉滿快取命中率。


#### SSR的操作畫面與使用者體驗缺點:

  * 頻繁的全頁刷新與狀態流失造成畫面閃爍（白屏）
  * 互動延遲感較重（高度依賴網路速度）
  * 難以實現複雜的高頻互動

#### 分層資料快取加速的致命陷阱:

此設計強制放棄了「強一致性 (Strong Consistency)」，架構師必須在系統中妥善處理「最終一致性 (Eventual Consistency)」。所以讀取請求皆命中記憶體層率非100%的情況時，會陷入等待回應與髒資料海嘯，UIUX使用者體驗極差。若讓前端應用過多輪詢或WebSocket，非同步獲取最新的交易結果，也會造成倍數成長的效能壓力。




