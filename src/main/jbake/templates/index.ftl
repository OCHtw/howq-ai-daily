<!doctype html>
<html lang="zh-Hant">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="description" content="${config.site_description}">
  <title>${config.site_title} — ${config.site_subtitle}</title>
  <link rel="stylesheet" href="css/site.css">
  <link rel="stylesheet" href="css/post-cover.css">
</head>
<body>
  <#assign rootPath = "">
  <#assign currentSection = "logs">
  <#include "includes/header.ftl">
  <#include "includes/tag-ui.ftl">
  <#include "includes/content-sort.ftl">
  <#assign sortedPosts = sortByDateAndFilename(published_posts)>
  <main>
    <section class="hero">
      <div class="shell hero-grid">
        <div>
          <p class="eyebrow">BUILD IN OPEN</p>
          <h1>把 AI 帶進<br>餐飲微小店家的挑戰日記。</h1>
          <p class="hero-copy">寫下產品想法、紀錄ＡＩ探索、模擬ＥＳＧ實驗、思考ＯPEN ＤATA運用，也許是開發瑣事或是那些真正做下去之後才會碰到的問題。</p>
          <div class="hero-actions">
            <a class="button button-primary" href="#latest">看最新進度</a>
            <a class="button button-quiet" href="about.html">這個專案在做什麼</a>
          </div>
        </div>
        <aside class="hero-note" aria-label="專案原則">
          <span class="status-dot"></span>
          <p>現在正在做</p>
          <strong>小步公開、持續累積，透過分享與交流促進更多可能，讓成果有「完成那天」。</strong>
        </aside>
      </div>
    </section>

    <section class="shell content-section" id="latest">
      <div class="section-heading">
        <div>
          <p class="eyebrow">LATEST LOGS</p>
          <h2>最近的腳步</h2>
        </div>
        <p>日誌採 Markdown 格式，JBake 產生靜態 HTML。</p>
      </div>

      <div class="post-list">
        <#if sortedPosts?has_content>
          <#list sortedPosts as post>
            <#assign hasCover = (post.cover!"")?trim?has_content>
            <article class="post-card">
              <div class="post-meta">
                <time datetime="${post.date?string('yyyy-MM-dd')}">${post.date?string('yyyy.MM.dd')}</time>
                <#if post.category??><span>${post.category}</span></#if>
              </div>
              <div class="post-card-layout<#if hasCover> has-cover</#if>">
                <div class="post-card-copy">
                  <h3><a href="${post.uri?html}">${post.title?html}</a></h3>
                  <#if post.summary??><p>${post.summary?html}</p></#if>
                  <a class="text-link" href="${post.uri?html}">閱讀紀錄 →</a>
                </div>
                <#-- Only an explicitly specified cover is shown. Never scan the article body. -->
                <#if hasCover>
                  <a class="post-list-cover post-card-cover"
                     href="${post.uri?html}"
                     aria-label="閱讀：${post.title?html}">
                    <img src="${post.cover?trim?html}"
                         alt=""
                         loading="lazy"
                         decoding="async">
                  </a>
                </#if>
              </div>
            </article>
          </#list>
        <#else>
          <div class="empty-state">第一篇日誌準備中。</div>
        </#if>
      </div>
    </section>
    <div class="shell">
      <@renderTagCloud
        rootPath=""
        scope="logs"
        title="日誌標籤"
      />
    </div>
   <br/>
   <br/>
  </main>

  <#include "includes/footer.ftl">
</body>
</html>
