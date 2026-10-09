# 新聞內容格式

新增新聞時，放在：

`src/main/jbake/content/news/`

例如：

`src/main/jbake/content/news/2026-10-09-openai-example.md`

建議格式：

```text
title=原始新聞標題
date=2026-10-09
type=news
status=published
category=AI
tags=AI,OpenAI,餐飲科技
source_name=新聞來源名稱
source_url=https://example.com/full-news
image=https://example.com/preview.jpg
summary=新聞清單頁顯示的短摘要，建議約 60～120 字。
preview=進入新聞短評頁後，原始新聞標題下面顯示的較長預覽文字，建議約 150～300 字。
~~~~~~

這裡寫你自己的小短評。

可以是 1～3 段 Markdown，也可以有粗體、清單或連結。
```

欄位用途：

- `title`：新聞原始標題。新聞清單會顯示；短評頁裡也會作為「前往完整新聞」的連結文字。
- `category`：新聞頁上方動態頁籤來源。
- `tags`：新聞標籤雲來源，也會出現在主題頁。
- `summary`：新聞清單的短摘要。
- `preview`：短評頁裡較長的原始新聞預覽。
- `source_name`：來源媒體名稱。
- `source_url`：完整新聞網址。
- `image`：預覽圖片網址，亦可改成網站內相對網址，例如 `../images/news/example.jpg`。
- Markdown 內文：你的「小編短評」。

注意：`content/news/index.md` 是新聞清單入口，不要刪除。
