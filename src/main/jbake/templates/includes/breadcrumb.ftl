<#--
  BreadcrumbList JSON-LD for the site's real navigation hierarchy.
  Generated at build time, without new Markdown front-matter fields.

  The homepage is also the log index: a post is "日誌 > 文章", NOT
  "首頁 > 日誌 > 文章" (there is no separate /posts/ landing page).
  Each intermediate item points to an actual canonical URL.
-->

<#function breadcrumbTrail pageUrl pageTitle pageKind>
  <#local kind = (pageKind!"")?string>
  <#local homeUrl = canonicalUrl("")>

  <#-- A single-item trail adds no useful hierarchy to the homepage. -->
  <#if kind == "index" || pageUrl == homeUrl>
    <#return []>
  </#if>

  <#local items = [{"name": "首頁", "url": homeUrl}]>
  <#local label = (pageTitle!"")?string?trim>

  <#if kind == "post">
    <#-- The homepage is the actual log index. -->
    <#local items = [{"name": "日誌", "url": homeUrl}]>
  <#elseif kind == "news">
    <#local items = items + [{"name": "新聞", "url": canonicalUrl("news/")}]>
  <#elseif kind == "tag">
    <#local items = items + [{"name": "主題", "url": canonicalUrl("tags/")}]>
    <#-- Remove the site name suffix from the existing tag page title. -->
    <#local suffix = " — " + (config.site_title!"")>
    <#if label?ends_with(suffix)>
      <#local label = label?remove_ending(suffix)>
    </#if>
  <#elseif kind == "newsindex">
    <#local label = "新聞">
  <#elseif kind == "tagsindex">
    <#local label = "主題">
  </#if>

  <#if !label?has_content>
    <#return []>
  </#if>

  <#return items + [{"name": label, "url": pageUrl}]>
</#function>

<#macro renderBreadcrumb pageUrl pageTitle pageKind>
  <#local items = breadcrumbTrail(pageUrl, pageTitle, pageKind)>
  <#if items?size gte 2>
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "BreadcrumbList",
  "@id": "${jsonEscape(pageUrl + "#breadcrumb")}",
  "itemListElement": [
    <#list items as item>
    {
      "@type": "ListItem",
      "position": ${item?index + 1},
      "name": "${jsonEscape(item.name)}",
      "item": "${jsonEscape(item.url)}"
    }<#sep>,</#sep>
    </#list>
  ]
}
</script>
  </#if>
</#macro>
