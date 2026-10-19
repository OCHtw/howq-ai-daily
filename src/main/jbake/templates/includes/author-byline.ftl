<#--
  Single author identity for posts and original news commentary.
  All parameters come from jbake.properties; old Markdown files need no edits.
  site.author       -> visible name
  site.author.display.url -> clickable author link (independent of Person.url)
  Person @id and sameAs are generated separately by schema.ftl.
-->
<#macro renderAuthorByline rootPath="" role="post">
  <#-- The byline uses its own URL; never fall back to the Schema Person.url. -->
  <#local authorDisplayUrl = (config.site_author_display_url!(rootPath + "about.html"))?string?trim>
  <#if !authorDisplayUrl?has_content>
    <#local authorDisplayUrl = rootPath + "about.html">
  </#if>
  <p class="author-byline">
    <span class="author-byline-label"><#if role == "news">整理／短評<#else>作者</#if>：</span>
    <a href="${authorDisplayUrl?html}" rel="author">${(config.site_author!"OCHtw")?html}</a>
  </p>
</#macro>
