<!doctype html>
<html lang="zh-Hant">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="description" content="依主題瀏覽 ${config.site_title} 的日誌與新聞。">
  <title>主題 — ${config.site_title}</title>
  <link rel="stylesheet" href="../css/site.css">
</head>
<body>
  <#assign rootPath = "../">
  <#assign currentSection = "topics">

  <#include "includes/header.ftl">
  <#include "includes/tag-ui.ftl">

  <main class="shell article-shell">
    <section class="tags-index-page">
      <header class="article-header compact">
        <p class="eyebrow">TOPICS</p>
        <h1>主題</h1>
        <p class="article-lead">可以一起看，也可以只看日誌或新聞裡出現過的標籤。</p>
      </header>

      <div class="topic-cloud-groups">
        <@renderTagCloud
          rootPath="../"
          scope="all"
          title="日誌＋新聞"
          description="整個 howq AI Daily 出現過的主題。"
        />

        <@renderTagCloud
          rootPath="../"
          scope="logs"
          title="日誌"
          description="只計算 Build in Open 日誌使用的標籤。"
        />

        <@renderTagCloud
          rootPath="../"
          scope="news"
          title="新聞"
          description="只計算新聞短評使用的標籤。"
        />
      </div>
    </section>
  </main>

  <#include "includes/footer.ftl">
</body>
</html>
