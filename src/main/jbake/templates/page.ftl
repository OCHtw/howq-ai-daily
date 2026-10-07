<!doctype html>
<html lang="zh-Hant">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="description" content="${(content.summary)!config.site_description}">
  <title>${content.title} — ${config.site_title}</title>
  <link rel="stylesheet" href="${content.rootpath}css/site.css">
</head>
<body>
  <#assign rootPath = content.rootpath>
  <#assign currentSection = "about">
  <#include "includes/header.ftl">

  <main class="shell article-shell">
    <article class="article">
      <header class="article-header compact">
        <p class="eyebrow">ABOUT</p>
        <h1>${content.title}</h1>
        <#if content.summary??><p class="article-lead">${content.summary}</p></#if>
      </header>
      <div class="article-body">
        ${content.body}
      </div>
    </article>
  </main>

  <#include "includes/footer.ftl">
</body>
</html>
