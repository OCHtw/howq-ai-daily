<!doctype html>
<html lang="zh-Hant">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="description" content="${config.site_description}">
  <title>#${tag?html} — ${config.site_title}</title>
  <link rel="stylesheet" href="../css/site.css">
</head>
<body>
  <#assign rootPath = "../">
  <#assign currentSection = "topics">
  <#include "includes/header.ftl">
  <#include "includes/tag-ui.ftl">

  <main class="shell article-shell">
    <section class="tag-page">
      <header class="tag-page-header">
        <p class="eyebrow">HASHTAG</p>
        <h1>#${tag?html}</h1>
        <p class="tag-page-count">${tag_posts?size} 篇文章</p>
      </header>

      <div class="post-list">
        <#list tag_posts as post>
          <article class="post-card">
            <div class="post-meta">
              <#if post.date??>
                <time datetime="${post.date?string('yyyy-MM-dd')}">${post.date?string('yyyy.MM.dd')}</time>
              </#if>
              <#if post.category??><span>${post.category?html}</span></#if>
            </div>

            <h2><a href="../${post.uri?html}">${post.title?html}</a></h2>
            <#if post.summary??><p>${post.summary?html}</p></#if>

            <@renderPostTags
              tagNames=(post.tags![])
              rootPath="../"
            />
          </article>
        <#else>
          <div class="empty-state">目前沒有文章。</div>
        </#list>
      </div>
    </section>
  </main>

  <#include "includes/footer.ftl">
</body>
</html>
