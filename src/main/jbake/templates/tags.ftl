<!doctype html>
<html lang="zh-Hant">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="description" content="${config.site_description}">
  <title>#${tag?html} — ${config.site_title}</title>
  <link rel="stylesheet" href="../css/site.css">
  <link rel="stylesheet" href="../css/post-cover.css">
</head>
<body>
  <#assign rootPath = "../">
  <#assign currentSection = "topics">

  <#include "includes/header.ftl">
  <#include "includes/tag-ui.ftl">

  <#assign displayDocuments = []>

  <#list (tagged_documents![]) as doc>
    <#if (doc.type!"") == "post" || (doc.type!"") == "news">
      <#assign displayDocuments = displayDocuments + [doc]>
    </#if>
  </#list>

  <main class="shell article-shell">
    <section class="tag-page">
      <header class="tag-page-header">
        <p class="eyebrow">HASHTAG</p>
        <h1>#${tag?html}</h1>

        <p class="tag-page-count">
          <span id="tag-scope-label">日誌＋新聞</span>
          ·
          <span id="tag-result-count">${displayDocuments?size}</span> 篇
        </p>
      </header>

      <div class="tag-result-list" id="tag-result-list">
        <#list displayDocuments as doc>
          <#assign hasCover = (doc.type!"") == "post" && (doc.cover!"")?trim?has_content>
          <article
            class="tag-result-item"
            data-content-type="${(doc.type!"")?html}"
          >
            <div class="post-meta">
              <#if doc.date??>
                <time datetime="${doc.date?string('yyyy-MM-dd')}">${doc.date?string('yyyy.MM.dd')}</time>
              </#if>

              <#if (doc.type!"") == "news">
                <span>新聞</span>
              <#else>
                <span>日誌</span>
              </#if>

              <#if doc.category??>
                <span>${doc.category?html}</span>
              </#if>
            </div>

            <div class="tag-result-layout<#if hasCover> has-cover</#if>">
              <div class="tag-result-copy">
                <h2>
                  <a href="../${doc.uri?html}">${doc.title?html}</a>
                </h2>

                <#if doc.summary??>
                  <p>${doc.summary?html}</p>
                </#if>

                <@renderPostTags
                  tagNames=(doc.tags![])
                  rootPath="../"
                />
              </div>

              <#-- News list stays unchanged. Posts show a thumbnail only if cover is set. -->
              <#if hasCover>
                <a class="post-list-cover tag-result-cover"
                   href="../${doc.uri?html}"
                   aria-label="閱讀：${doc.title?html}">
                  <img src="${doc.cover?trim?html}"
                       alt=""
                       loading="lazy"
                       decoding="async">
                </a>
              </#if>
            </div>
          </article>
        <#else>
          <div class="empty-state">目前沒有內容。</div>
        </#list>
      </div>
    </section>
  </main>

  <script>
  (() => {
    const params = new URLSearchParams(window.location.search);
    const scope = params.get("scope");

    if (scope !== "logs" && scope !== "news") {
      return;
    }

    const wantedType = scope === "logs" ? "post" : "news";
    const label = scope === "logs" ? "日誌" : "新聞";
    let visibleCount = 0;

    document.querySelectorAll("[data-content-type]").forEach(item => {
      const visible = item.dataset.contentType === wantedType;
      item.hidden = !visible;
      if (visible) {
        visibleCount += 1;
      }
    });

    const labelNode = document.getElementById("tag-scope-label");
    const countNode = document.getElementById("tag-result-count");

    if (labelNode) {
      labelNode.textContent = label;
    }

    if (countNode) {
      countNode.textContent = String(visibleCount);
    }
  })();
  </script>

  <#include "includes/footer.ftl">
</body>
</html>
