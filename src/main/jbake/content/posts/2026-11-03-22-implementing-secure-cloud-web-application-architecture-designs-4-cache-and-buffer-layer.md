title=Howqpon雲端架構(4)：快取與緩存事件層（Cache & Buffer）
date=2026-11-03
dateModified=2026-11-03
type=post
status=published
category=Project Actions
cover=
tags=專案產出,系統設計
summary=滿足低成本、低耗能，但在高併發情境下要高效能條件下，採用快取(Cache)在技術架構中，將高頻存取放於靠近需求端。而傳統同步寫入資料庫會受限於磁碟I/O與DB連接池瓶頸，搭配Redis作為In-Memory快取與訊息佇列作為寫入 Buffer的Write-Behind架構。將「即時線上響應」與「慢速資料持久化」徹底解耦。
tldr1=核心理念：應用層不直接存取核心資料庫，而是透過Redis快取讀取與RabbitMQ事件佇列緩寫資料庫，隔離資料讀寫權限，降低資料庫負載與入侵風險。
tldr2=採讀寫分離架構(Command and Query Responsibility Segregation)，讀取時極大幅度降低響應延遲，寫入資料時流量削峰與速率匹配，在高併發時維持平滑拉取數據，防止資料庫崩潰。
tldr3=透過本地快取直接回應，擋掉重複性讀取請求。經由拉取MQ訊息透過批量更新SQL，將多次昂貴的Disk I/O攤平為單次操作。防止DB連接池耗盡、CPU飆升或IOPS瓶頸，提速卻大幅降低耗能。
faq1Question=採用快取架構時的隱患？
faq1Answer=導入快取並非沒有代價，主要是必須克服資料一致性(Consistency)，快取與資料庫數據同步存在時間差。另外長期運作會遭遇快取異常，包括快取穿透(Penetration，用戶查詢的資料在快取和資料庫中根本不存在，而迴圈式直接穿透到資料庫去查詢)、快取擊穿(Breakdown，某一個非常熱門的特定資料突然過期，就在這個熱門資料失效的瞬間，成千上萬個針對該資料的併發請求同時穿透快取，直接衝擊資料庫)與快取雪崩(Avalane，大量不同的快取資料在同一時間集體過期Expire)。
faq2Question=採用緩取架構時的挑戰？
faq2Answer=資料可靠性降低，或是訊息亂序與併發競爭網路波動導致舊資料在Consumer端晚於新資料寫入 DB。甚至MQ 網路重試或 Consumer 重啟造成重複投遞，也可能是特定熱點 Key 寫入量極大，單一佇列消費不及。造成無法判別的髒資料。
faq3Question=
faq3Answer=
~~~~~~

![howqpon雲端網頁服務新架構規劃4-快取與緩存事件層](/images/2026-10-31/howqpon-web-application-architecture-designs-4-cache-and-buffer-layer.jpg)


**核心理念：應用層不直接存取核心資料庫，而是透過Redis快取讀取與RabbitMQ事件佇列緩寫資料庫，隔離資料讀寫權限，降低資料庫負載與入侵風險。**

### 架構概念

```text
第 2 區：輕量化應用層（SG-A）
              │
       ┌──────┴──────┐
       ↓             ↓
    Redis         RabbitMQ
   L2 Read         事件佇列
       │             │
       │             ↓
       │        非同步資料緩存處理
       │             │
       ↑             ↓
    快取更新 ← 第 4 區：核心資料庫
  Reload /          （SG-C）
  Invalidate       AWS RDS
```

快取（Cache）在技術架構中的核心作用，是將高頻存取或計算成本昂貴的資料暫存於高速介質（如記憶體），利用時間與空間局部性（Locality of Reference）短路慢速儲存介質（如磁碟或資料庫）與網路 I/O 的存取路徑。

在高併發寫入情境下，傳統同步寫入資料庫（Write-Through）會受限於磁碟 I/O 與 DB 連接池瓶頸。搭配 Redis 作為 In-Memory 快取 與 訊息佇列（Message Queue, 簡稱 MQ）作為寫入 Buffer 的 Write-Behind（Write-Back）架構，核心在於將「即時線上響應」與「慢速資料持久化」徹底解耦。

### 設計特色

1. **CQRS (讀寫分離架構, Command and Query Responsibility Segregation)**：查詢優先透過 Redis，資料異動透過 RabbitMQ 發送命令，由後端資料服務統一處理。
2. **最小權限隔離**：SG-B 僅開放指定 EC2 存取，Redis 採唯讀帳號，RabbitMQ 限制 Exchange、Routing Key 與發布權限。
3. **防止橫向入侵**：即使應用層 EC2 遭入侵，也不能直接連接核心資料庫或任意修改快取。
4. **非同步事件處理**：資料寫入透過佇列交由授權的 Consumer 處理，降低前端與資料庫的直接耦合。
5. **快取狀態管理**：以 `LOADED / UNLOADED` 標記快取狀態，結合 TTL、Reload / Invalidate 與 Redis Keyspace Notifications 管理更新。
6. **防止偽造與重放攻擊**：透過 HMAC 簽章、timestamp、nonce、message-id 驗證事件合法性及避免重複執行。
7. **資料保護**：敏感資料不直接放入快取，必要時透過 OpenBao 管理加密與解密所需金鑰。

### 關鍵技術優勢

| 技術 | 主要優勢 |
|---|---|
| **Redis（L2）** | 高速讀取共享快取，減少資料庫查詢 |
| **RabbitMQ** | 非同步處理、訊息緩衝與工作分流 |
| **CQRS** | 分離查詢與異動責任，降低權限暴露 |
| **Redis ACL** | 限制帳號可操作的命令與 Key 範圍 |
| **HMAC / Nonce** | 驗證命令來源及完整性，降低偽造與重放風險 |
| **TTL / Keyspace Notifications** | 管理快取生命週期並輔助資料更新 |
| **AWS Security Group B** | 限制跨服務網路存取，縮小攻擊面 |

### 與核心資料庫的關係

**第 3 區（SG-B）負責快取與訊息傳遞，第 4 區（SG-C）負責真正的資料查詢、寫入與稽核。**

- **讀取流程**：應用層 → Redis；快取未命中時，由授權資料服務回源取得資料並更新快取。
- **寫入流程**：應用層 → RabbitMQ → 授權 Consumer → 核心資料庫。
- **更新流程**：資料庫交易成功提交後，透過可靠事件通知更新或失效快取。
- **權限原則**：應用層不持有資料庫存取權，資料異動由獨立服務控管。

### 核心價值

**不是單純為了加速而增加 Redis，也不是單純為了非同步而增加 RabbitMQ，而是利用兩者建立應用層與核心資料之間的安全隔離帶。**

即使 Web 主機遭入侵，攻擊者也只能接觸受限的讀取與訊息發布介面，無法直接取得資料庫操作權限。

同時保留未來透過 Redis Replica、RabbitMQ Consumer 與不同業務節點進行水平擴充的能力。

> **實作關鍵**：Redis ACL、RabbitMQ 權限與 HMAC 驗證必須真正落實；資料庫交易與快取更新也需要可靠事件機制，才能避免訊息遺失或資料不一致。
