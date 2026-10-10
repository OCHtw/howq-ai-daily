<!doctype html>
<html lang="zh-Hant">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="description" content="howq AI Daily 新聞短評與資訊整理。">
  <title>新聞 — ${config.site_title}</title>
  <link rel="stylesheet" href="${content.rootpath}css/site.css">
</head>
<body>
  <#assign rootPath = content.rootpath>
  <#assign currentSection = "news">

  <#include "includes/header.ftl">
  <#include "includes/tag-ui.ftl">
  <#include "includes/content-sort.ftl">

  <#assign newsItems = []>

  <#list published_content as item>
    <#if (item.type!"") == "news">
      <#assign newsItems = newsItems + [item]>
    </#if>
  </#list>

  <#assign newsItems = sortByDateAndFilename(newsItems)>
  <#assign newsCategories = []>

  <#list newsItems as item>
    <#if
      item.category??
      && item.category?has_content
      && !newsCategories?seq_contains(item.category)
    >
      <#assign newsCategories = newsCategories + [item.category]>
    </#if>
  </#list>

  <main class="shell news-index-shell">
    <header class="news-index-header">
      <p class="eyebrow">NEWS</p>
      <h1>新聞</h1>
      <p>留下值得追的消息，以及我為什麼覺得它值得注意。</p>
    </header>

    <div class="news-tabs" aria-label="新聞分類">
      <button
        class="news-tab is-active"
        type="button"
        data-news-category="all"
        aria-pressed="true"
      >
        全部
        <span>${newsItems?size}</span>
      </button>

      <#list newsCategories as category>
        <#assign categoryCount = 0>

        <#list newsItems as item>
          <#if (item.category!"") == category>
            <#assign categoryCount = categoryCount + 1>
          </#if>
        </#list>

        <button
          class="news-tab"
          type="button"
          data-news-category="${category?html}"
          aria-pressed="false"
        >
          ${category?html}
          <span>${categoryCount}</span>
        </button>
      </#list>
    </div>

    <section class="news-list" id="news-list" aria-live="polite">
      <#list newsItems as news>
        <article
          class="news-list-item"
          data-news-item
          data-category="${(news.category!"未分類")?html}"
        >
          <div class="news-list-meta">
            <#if news.date??>
              <time datetime="${news.date?string('yyyy-MM-dd')}">分享 ${news.date?string('yyyy.MM.dd')}</time>
            </#if>

            <#if news.category??>
              <span>${news.category?html}</span>
            </#if>

            <#if news.source_name??>
              <span>${news.source_name?html}</span>
            </#if>
            <#if news.source_date?? && news.source_date?has_content>
              <span>原文 ${news.source_date?html}</span>
            </#if>
          </div>

          <h2>
            <a href="${content.rootpath}${news.uri?html}">${news.title?html}</a>
          </h2>

          <#if news.summary??>
            <p class="news-list-excerpt">${news.summary?html}</p>
          </#if>
        </article>
      <#else>
        <div class="empty-state">第一則新聞準備中。</div>
      </#list>

      <div class="empty-state" id="news-filter-empty" hidden>
        這個分類目前沒有新聞。
      </div>
    </section>

    <div class="news-tag-cloud-wrap">
      <@renderTagCloud
        rootPath=content.rootpath
        scope="news"
        title="新聞標籤"
        description="從新聞短評裡出現過的 hashtag 繼續往下找。"
      />
    </div>
  </main>

  <script defer src="${content.rootpath}js/news.js"></script>

  <#include "includes/footer.ftl">
</body>
</html>
