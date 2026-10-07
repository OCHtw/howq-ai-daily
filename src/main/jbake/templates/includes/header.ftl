<#include "/includes/search-box.ftl">
<header class="site-header">
  <div class="shell header-inner">
    <a class="brand" href="${rootPath}index.html" aria-label="${config.site_title} 首頁">
      <span class="brand-mark" aria-hidden="true">H</span>
      <span>
        <strong>${config.site_title}</strong>
        <small>好客萌團 · build in open</small>
      </span>
    </a>
    <nav class="site-nav" aria-label="主要導覽">
      <a href="${rootPath}index.html"<#if currentSection == "logs"> aria-current="page"</#if>>日誌</a>
      <a href="${rootPath}tags/"<#if currentSection == "topics"> aria-current="page"</#if>>主題</a>
      <a href="${rootPath}about.html"<#if currentSection == "about"> aria-current="page"</#if>>關於</a>
    </nav>
    <@searchBox rootPath=rootPath />
  </div>
</header>
