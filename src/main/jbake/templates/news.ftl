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
  <link rel="stylesheet" href="${content.rootpath}css/news-layout.css">
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

  <#-- Compare text, rather than requiring exact equality.
       The ratio is the proportion of two-character snippets not shared with the other text,
       using the longer snippet count as denominator. It works for Chinese without word splitting.
       Punctuation/spacing/case differences are ignored; repeated snippets are matched once. -->
  <#function comparableNewsText value>
    <#return (value!"")?string?lower_case?replace(r"[\s\p{P}\p{S}]+", "", "r")>
  </#function>
  <#function previewDifferenceRatio summary preview>
    <#local a = comparableNewsText(summary)>
    <#local b = comparableNewsText(preview)>
    <#if !b?has_content || a == b><#return 0></#if>
    <#if !a?has_content><#return 1></#if>
    <#-- Short texts cannot form a 2-character snippet. -->
    <#if a?length lt 2 || b?length lt 2><#return 1></#if>

    <#-- | is safe as a delimiter because normalization removes punctuation. -->
    <#local remainingBigrams = "">
    <#list 0..(b?length - 2) as i>
      <#local remainingBigrams = remainingBigrams + "|" + b?substring(i, i + 2) + "|">
    </#list>

    <#local common = 0>
    <#list 0..(a?length - 2) as i>
      <#local token = "|" + a?substring(i, i + 2) + "|">
      <#local pos = remainingBigrams?index_of(token)>
      <#if pos gte 0>
        <#local common = common + 1>
        <#local remainingBigrams = remainingBigrams?substring(0, pos)
          + remainingBigrams?substring(pos + token?length)>
      </#if>
    </#list>
    <#local maxCount = a?length - 1>
    <#if b?length - 1 gt maxCount><#local maxCount = b?length - 1></#if>
    <#return 1 - common / maxCount>
  </#function>
  <#assign summaryText = (content.summary!"")?string?trim>
  <#assign previewText = (content.preview!"")?string?trim>
  <#-- Strictly more than 50% different shows both texts; otherwise summary only. -->
  <#assign showSourcePreview = previewText?has_content
      && (!summaryText?has_content || previewDifferenceRatio(summaryText, previewText) gt 0.5)>

  <#include "includes/header.ftl">
  <#include "includes/tag-ui.ftl">

  <main class="shell article-shell">
    <article class="article news-article">
      <header class="news-review-header">
        <a class="back-link" href="${content.rootpath}news/">← 回到新聞</a>
        <div class="post-meta">
          <#if content.date??>
            <time datetime="${content.date?string('yyyy-MM-dd')}">分享 ${content.date?string('yyyy.MM.dd')}</time>
            <#-- This is the publication date of the commentary, not the source news. -->
            <#assign modifiedDate = effectiveModifiedDate(content)>
            <#if modifiedDate?has_content && modifiedDate != content.date?string('yyyy-MM-dd')>
              <span>·</span>
              <time datetime="${modifiedDate?html}">更新 ${modifiedDate?replace('-', '.')?html}</time>
            </#if>
          </#if>
          <#if content.category?? && content.category?has_content>
            <span>${content.category?html}</span>
          </#if>
        </div>

        <p class="eyebrow">NEWS · MY NOTE</p>
        <h1>${content.title?html}</h1>
        <#if (content.source_name!"")?string?trim?has_content
             || (content.source_date!"")?string?trim?has_content>
          <p class="news-origin-info">
            <#if (content.source_name!"")?string?trim?has_content>
              來源：${content.source_name?html}
            </#if>
            <#if (content.source_date!"")?string?trim?has_content>
              <span>原文 ${content.source_date?html}</span>
            </#if>
          </p>
        </#if>
        <@renderAuthorByline rootPath=(content.rootpath!"") role="news" />
        <#if summaryText?has_content>
          <p class="news-summary">${summaryText?html}</p>
        </#if>
      </header>

      <section class="news-commentary" aria-labelledby="news-commentary-heading">
        <h2 id="news-commentary-heading" class="news-commentary-title">小編短評</h2>
        <div class="article-body news-review-body">
          ${content.body}
        </div>
      </section>

      <@renderTldr doc=content />

      <section class="news-source-preview" aria-labelledby="news-source-heading">
        <h2 id="news-source-heading" class="news-source-heading">原始新聞</h2>
        <#if (content.source_name!"")?string?trim?has_content
             || (content.source_date!"")?string?trim?has_content>
          <div class="news-source-meta">
            <#if (content.source_name!"")?string?trim?has_content>
              <span>${content.source_name?html}</span>
            </#if>
            <#if (content.source_date!"")?string?trim?has_content>
              <span>發布 ${content.source_date?html}</span>
            </#if>
          </div>
        </#if>

        <h3 class="news-source-title">
          <#if trackedSourceUrl?has_content>
            <a href="${trackedSourceUrl?html}" target="_blank" rel="noopener noreferrer">${content.title?html}</a>
          <#else>
            ${content.title?html}
          </#if>
        </h3>

        <#-- Summary already appears in the lead; only display preview when >50% different. -->
        <#if showSourcePreview>
          <p class="news-source-excerpt">${previewText?html}</p>
        </#if>

        <#if (content.image!"")?string?trim?has_content>
          <#if trackedSourceUrl?has_content>
            <a class="news-preview-image-link" href="${trackedSourceUrl?html}"
               target="_blank" rel="noopener noreferrer" aria-label="開啟完整新聞">
              <img class="news-preview-image" src="${content.image?html}"
                   alt="" loading="lazy">
            </a>
          <#else>
            <img class="news-preview-image" src="${content.image?html}"
                 alt="" loading="lazy">
          </#if>
        </#if>

        <#if trackedSourceUrl?has_content>
          <a class="text-link news-source-link" href="${trackedSourceUrl?html}"
             target="_blank" rel="noopener noreferrer">閱讀完整新聞 →</a>
        </#if>
      </section>

      <@renderFaq doc=content />
      <@renderPostTags tagNames=(content.tags![]) rootPath=(content.rootpath!"") />
    </article>
  </main>

  <#include "includes/footer.ftl">
</body>
</html>
