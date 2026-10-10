# howq-ai-daily

**把 AI 帶進餐飲微小店家的工程日誌**  
*Engineering log for bringing AI into tiny local eateries.*

這是一個 Build in Public 專案，記錄 AI、軟體工程、開放資料（Open Data）與ESG導向的餐飲科技的結合研究、實驗及開發過程。

不只記錄成功的成果，也公開技術選擇、實作經驗與遇到的問題。

## Website

**[dev.howqpon.com](https://dev.howqpon.com/)**

網站主要包含：

- **日誌（Posts）**：開發過程、技術實驗與實作心得。
- **新聞（News）**：相關技術與產業動態整理。
- **主題（Topics）**：依照主題、分類與標籤探索內容。

## Technology Stack

| Technology | Purpose |
|---|---|
| Java 25 | 開發工具與內容處理 |
| Maven | 專案建置與依賴管理 |
| JBake | 靜態網站產生 |
| FreeMarker | HTML 模板引擎 |
| HTML / CSS / JavaScript | 網站呈現與互動 |
| GitHub Actions | 自動化建置與部署 |
| GitHub Pages | 靜態網站託管 |

## Getting Started

### Prerequisites

- JDK 25
- Apache Maven
- Git

### Clone

```bash
git clone https://github.com/OCHtw/howq-ai-daily.git
cd howq-ai-daily
```

### Build

```bash
mvn clean package
```

產生的靜態網站位於：

```text
target/website/
```

### Local Preview

```bash
mvn package -Pserve
```

可依專案的 JBake 設定，在本機瀏覽產生的網站。

## Project Structure

主要內容：

- `src/main/jbake/` — JBake 網站來源與模板
- `content/posts/` — 開發日誌內容
- `content/news/` — 新聞內容
- `pom.xml` — Maven 專案設定
- `.github/workflows/` — GitHub Actions 自動化流程

實際目錄配置依專案版本為準。

## License

This project is licensed under the **GNU General Public License v3.0 (GPL-3.0)**.

Copyright © 2026 OCHtw.

You may use, study, modify, and distribute this software under the terms of GPL v3. Redistributed copies must preserve applicable copyright and license notices.

See [LICENSE](LICENSE) for the full license text.

本專案程式碼依 GPL v3 授權。重新散布時須遵守授權條款並保留適用的著作權及授權聲明。

網站原創文章、圖片及品牌素材不因程式碼採用 GPL v3 而自動適用相同授權。

## Author

**OCHtw**

GitHub: https://github.com/OCHtw