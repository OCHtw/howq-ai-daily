title=Howqpon雲端架構(2)：零公開入口（Zero Public Ingress）
date=2026-11-01
dateModified=2026-11-03
type=post
status=published
category=Project Actions
cover=
tags=專案產出,系統設計
summary=評估後選擇Cloudflare 提供一站式防護與加速服務：DNS實現極速解析，CDN透過全球節點快取加速，WAF自動攔截惡意攻擊，LB智慧分流確保服務高可用性，Tunnel則能安全隱藏源站並實現內網穿透，全面提升網站效能與安全性。但最重要的是Cloudflare費用固定，即使入門版也提供無限頻寬。
tldr1=核心理念：所有外部流量必須經過 Cloudflare，後端 EC2 不提供公開入口，避免攻擊者繞過防護直接攻擊主機。
tldr2=把「公開網站」與「公開主機」分離。網站仍然對全球使用者開放，但真正執行服務的 EC2 隱藏在私有網路中。
tldr3=透過 Cloudflare 集中處理安全防護、快取與流量調度，讓後端專注於業務運算，同時兼顧安全性、效能、可擴充性及營運成本。
faq1Question=為何是 Cloudflare 而非其他廠商？
faq1Answer=Cloudflare 的絕對優勢在於一體化 Anycast 邊緣網路。它在單一控制台無縫整合極速 DNS、CDN、免計費 DDoS/WAF 防護 與 Tunnel 穿透，免除多重組件拼湊，大幅降低架構複雜度與維運成本。
faq2Question=什麼是一體化 Anycast 邊緣網路？
faq2Answer=Cloudflare透過BGP協定打造Anycast網路(擁有超過200Tbps的龐大總容量)。它與全球上萬家 ISP 及交換中心深度互連 (Peering)，讓全球95%的網路使用者能在50毫秒內抵達最近節點，這種「物理距離的絕對壓縮」在遇到DDoS(分散式阻斷服務)攻擊時，讓它能在惡意流量抵達我的AWS伺服器之前，就利用全球各地的邊緣節點將其就近分散並吸收，徹底化解巨量頻寬耗盡的危機，確保Howqpon的服務穩定上線。造就了其無可匹敵的解析速度與海量抗攻擊頻寬。
faq3Question=這麼優會很貴吧！？
faq3Answer=Cloudflare 在業界普遍被認為是成本控管最佳、最容易入門的選擇，特別是在成本上主打可預測性與無限頻寬。提供非常慷慨的Free 方案，付費版也採固定月費能。有效防止「流量暴增導致帳單爆炸」的風險。不過由於目前網站架在AWS，所以還會有AWS EC2傳輸到Cloudflare的流量費要在未來進行評估。
~~~~~~

![howqpon雲端網頁服務新架構規劃2-零公開入口](/images/2026-10-31/howqpon-web-application-architecture-designs-2-zero-public-ingress.jpg)


**核心理念：所有外部流量必須經過 Cloudflare，後端 AWS EC2 不提供公開入口，避免攻擊者繞過防護直接攻擊主機。**

> 選擇站在 Cloudflare ＆ AWS兩大巨人之後，讓他們來加快服務並抵禦惡意攻擊。


### 架構概念

```text
使用者 / Internet
       ↓
Cloudflare（DNS / CDN / WAF）
       ↓
Cloudflare LB（負載平衡）
       ↓
Cloudflare Tunnel（安全通道）
       ↓
Private AWS EC2（無公開 IP）
```

### 設計特色

1. **主機完全私有化**：EC2 不配置 Public IP，不開放 Internet Inbound Port。
2. **統一安全入口**：外部請求經 Cloudflare 防護，降低 DDoS 與惡意流量風險。
3. **主動建立通道**：由 EC2 內的 `cloudflared` 主動連接 Cloudflare，不必開放對外監聽埠。
4. **避免繞過防護**：外部無法直接透過公開網路連入 EC2，降低源站暴露風險。
5. **支援高可用性**：透過 LB 健康檢查與多台 EC2，實現流量分配及故障切換。

### Cloudflare 各元件優勢

| 元件 | 核心功能 | 主要優勢 |
|---|---|---|
| **DNS** | 網域解析與 Proxy | 隱藏源站 IP，統一流量入口 |
| **CDN** | 全球邊緣快取 | 加速靜態資源、降低 EC2 負載與頻寬成本 |
| **WAF** | Web 應用防火牆 | 防範 SQL Injection、XSS、惡意請求及部分應用層攻擊 |
| **LB** | 負載平衡與健康檢查 | 分散流量、偵測主機異常、自動切換健康節點 |
| **Tunnel** | 主動式加密連線 | 無須公開 IP 或開放 Inbound Port，防止直接攻擊源站 |

### 技術補充

- **DNS**：網站使用 Proxied（橘雲）模式，讓流量經過 Cloudflare。
- **CDN**：圖片、CSS、JS 等靜態資源預設可快取；動態 HTML 須另外設定 Cache Rules。
- **WAF**：可結合 Managed Rules、Custom Rules、Rate Limiting，加強應用層防護。
- **LB**：需要配置健康檢查與多個可用後端，才能達成真正的故障切換。
- **Tunnel**：透過 `cloudflared` 建立 Outbound-only 連線，Security Group 不必開放 Internet Inbound。

### 核心價值

**把「公開網站」與「公開主機」分離。**

網站仍然對全球使用者開放，但真正執行服務的 EC2 隱藏在私有網路中。

以 Cloudflare 集中處理安全防護、快取與流量調度，讓後端專注於業務運算，同時兼顧安全性、效能、可擴充性及營運成本。


### 附註：最重要的價格實惠

> 0元起跳也太佛心了。

| 方案 | 價格 | 核心功能 | 適用情境 |
|---|---|---|---|
| Free | $0 | 基礎 DNS、CDN、DDoS 防護、Tunnel | 開發初期與小型網站 |
| Pro | $20 / 月 | 託管 WAF、圖片最佳化、快取分析 | 初期商業服務 |
| Business | $200 / 月 | 100% SLA、自訂 WAF、進階防機器人 | 高穩定 B2B 企業營運 |
| Enterprise | 客製報價 | 專屬路由、SSO 整合、24/7 原廠支援 | 大型企業與客製化需求 |

  * Load Balancing 為附加服務，將依據實際流量與端點數量額外計費（基礎起價為 $5/月）。


> 小編覺得唯一的缺點是會在使用者連網頁時，跳出來問你是不是機器人。這體驗差了些，不過辨識率有越來越好，對同一個可識別的連線不會一直問。


### 進一步說明

  * 回到全架構預覽 **<a href="https://dev.howqpon.com/posts/2026-10-31-22-implementing-secure-cloud-web-application-architecture-designs-1.html?utm_source=howqpon.com" target="_blank" rel="noopener noreferrer">全架構 ↗</a>**

  * 前往服務門面 **<a href="https://dev.howqpon.com/posts/2026-11-02-00-implementing-secure-cloud-web-application-architecture-designs-3-lightweight-application-layer.html?utm_source=howqpon.com" target="_blank" rel="noopener noreferrer">輕量化應用層 ↗</a>**

  * 前往高併發低耗能核心 **<a href="https://dev.howqpon.com/posts/2026-11-03-22-implementing-secure-cloud-web-application-architecture-designs-4-cache-and-buffer-layer.html?utm_source=howqpon.com" target="_blank" rel="noopener noreferrer">快取緩存事件層 ↗</a>**