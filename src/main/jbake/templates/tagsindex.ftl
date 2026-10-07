<!doctype html>
<html lang="zh-Hant">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="description" content="依主題瀏覽 ${config.site_title} 的 Build in Open 日誌。">
  <title>所有標籤 — ${config.site_title}</title>
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
        <h1>所有標籤</h1>
        <p class="article-lead">依主題瀏覽 howq AI Daily 的 Build in Open 日誌。</p>
      </header>

      <@renderTagCloud rootPath="../" />
    </section>
  </main>

  <#include "includes/footer.ftl">
</body>
</html>
