<!doctype html>
<html lang="zh-Hant">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="description" content="${(content.summary)!config.site_description}">
  <title>${content.title} — ${config.site_title}</title>
  <link rel="stylesheet" href="${content.rootpath}css/site.css">
  <link rel="stylesheet" href="${content.rootpath}css/article-extras.css">
  <link rel="stylesheet" href="${content.rootpath}css/author-byline.css">
  <#include "includes/seo-head.ftl">
  <#include "includes/article-extras.ftl">
  <#include "includes/author-byline.ftl">
  <#include "includes/news-source-url.ftl">
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
  <#assign currentSection = "news">
  <#assign trackedSourceUrl = newsSourceUrl(content.source_url!"")>

  <#include "includes/header.ftl">
  <#include "includes/tag-ui.ftl">

  <main class="shell article-shell">
    <article class="article news-article">

      <header class="news-review-header">
        <a class="back-link" href="${content.rootpath}news/">← 回到新聞</a>

        <div class="post-meta">
          <#if content.date??>
            <time datetime="${content.date?string('yyyy-MM-dd')}">分享 ${content.date?string('yyyy.MM.dd')}</time>
            <#-- Publication date of this commentary, not the source news article. -->
            <#assign modifiedDate = effectiveModifiedDate(content)>
            <#if modifiedDate?has_content && modifiedDate != content.date?string('yyyy-MM-dd')>
              <span>·</span>
              <time datetime="${modifiedDate?html}">更新 ${modifiedDate?replace('-', '.')?html}</time>
            </#if>
          </#if>

          <#if content.category??>
            <span>${content.category?html}</span>
          </#if>
        </div>

        <p class="eyebrow">MY NOTE</p>
        <h1>小編短評</h1>
        <@renderAuthorByline rootPath=(content.rootpath!"") role="news" />
      </header>

      <div class="article-body news-review-body">
        <#-- Display summary directly above the editor's own review, using the same blockquote style as Markdown. -->
        <#if content.summary?? && content.summary?has_content>
          <blockquote>
            <p>${content.summary?html}</p>
          </blockquote>
        </#if>

        ${content.body}
      </div>

      <#-- Preserve the existing summary/commentary order. New TL;DR is separate. -->
      <@renderTldr doc=content />

      <section class="news-source-preview">
        <div class="news-source-meta">
          <span>原始新聞</span>
          <#if content.source_name??>
            <span>${content.source_name?html}</span>
          </#if>
          <#if content.source_date?? && content.source_date?has_content>
            <span>發布 ${content.source_date?html}</span>
          </#if>
        </div>

        <h2>
          <#if content.source_url??>
            <a
              href="${trackedSourceUrl?html}"
              target="_blank"
              rel="noopener noreferrer"
            >${content.title?html}</a>
          <#else>
            ${content.title?html}
          </#if>
        </h2>

        <#if content.preview??>
          <p class="news-source-excerpt">${content.preview?html}</p>
        <#elseif content.summary??>
          <p class="news-source-excerpt">${content.summary?html}</p>
        </#if>

        <#if content.image??>
          <#if content.source_url??>
            <a
              class="news-preview-image-link"
              href="${trackedSourceUrl?html}"
              target="_blank"
              rel="noopener noreferrer"
              aria-label="開啟完整新聞"
            >
              <img
                class="news-preview-image"
                src="${content.image?html}"
                alt=""
                loading="lazy"
              >
            </a>
          <#else>
            <img
              class="news-preview-image"
              src="${content.image?html}"
              alt=""
              loading="lazy"
            >
          </#if>
        </#if>

        <#if content.source_url??>
          <a
            class="text-link news-source-link"
            href="${trackedSourceUrl?html}"
            target="_blank"
            rel="noopener noreferrer"
          >閱讀完整新聞 →</a>
        </#if>
      </section>

      <@renderFaq doc=content />
      <@renderPostTags
        tagNames=(content.tags![])
        rootPath=(content.rootpath!"")
      />

    </article>
  </main>

  <#include "includes/footer.ftl">
</body>
</html>
