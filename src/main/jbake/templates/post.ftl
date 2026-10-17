<!doctype html>
<html lang="zh-Hant">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="description" content="${(content.summary)!config.site_description}">
  <title>${content.title} — ${config.site_title}</title>
  <link rel="stylesheet" href="${content.rootpath}css/site.css">
  <#include "includes/seo-head.ftl">
  <@renderSeo
    pageUri=(content.uri!"")
    pageTitle=(content.title!config.site_title)
    pageDescription=(content.summary!config.site_description)
    pageKind=(content.type!"page")
    doc=content
  />
</head>
<body>
  <#assign rootPath = content.rootpath>
  <#assign currentSection = "logs">
  <#include "includes/header.ftl">
  <#include "includes/tag-ui.ftl">

  <main class="shell article-shell">
    <article class="article">
      <header class="article-header">
        <a class="back-link" href="${content.rootpath}index.html">← 回到日誌</a>
        <div class="post-meta">
          <time datetime="${content.date?string('yyyy-MM-dd')}">發布 ${content.date?string('yyyy.MM.dd')}</time>
          <#-- Modified date is displayed only when it differs from the publication date.
               The shared SEO helper also falls back to publication date for older posts. -->
          <#assign modifiedDate = effectiveModifiedDate(content)>
          <#if modifiedDate?has_content && modifiedDate != content.date?string('yyyy-MM-dd')>
            <span>·</span>
            <time datetime="${modifiedDate?html}">更新 ${modifiedDate?replace('-', '.')?html}</time>
          </#if>
          <#if content.category??><span>${content.category}</span></#if>
        </div>
        <h1>${content.title}</h1>
        <#if content.summary??><p class="article-lead">${content.summary}</p></#if>
      </header>
      <div class="article-body">
        ${content.body}
      </div>
      <@renderPostTags
	    tagNames=(content.tags![])
	    rootPath=(content.rootpath!"")
      />
    </article>
  </main>

  <#include "includes/footer.ftl">
</body>
</html>
