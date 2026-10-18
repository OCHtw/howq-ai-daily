<#--
  Single entrypoint for per-page canonical and structured data.
  Keep existing title/meta/style elements in their original templates.
-->

<#include "/includes/seo-utils.ftl">
<#include "/includes/schema.ftl">
<#include "/includes/breadcrumb.ftl">
<#include "/includes/analytics.ftl">


<#macro renderSeo pageUri="" pageTitle="" pageDescription="" pageKind="" doc={}>
  <#local absoluteUrl = canonicalUrl(pageUri)>
  <#local kind = (pageKind!"")?string>
  <#local isArticle = (kind == "post" || kind == "news")>
  <#local imageUrl = articleImageUrl(doc, kind)>
  <link rel="canonical" href="${absoluteUrl?html}">
  <#if isArticle>
  <#-- Allow Google to use a large image preview when a suitable image exists. -->
  <meta name="robots" content="max-image-preview:large">
  <meta property="og:type" content="article">
  <meta property="og:locale" content="zh_TW">
  <meta property="og:site_name" content="${(config.site_title!"howq AI Daily")?html}">
  <meta property="og:url" content="${absoluteUrl?html}">
  <meta property="og:title" content="${pageTitle?html}">
  <meta property="og:description" content="${pageDescription?html}">
  <#if imageUrl?has_content>
  <meta property="og:image" content="${imageUrl?html}">
  </#if>
  </#if>
  <@renderSchema
    pageUrl=absoluteUrl
    pageTitle=pageTitle
    pageDescription=pageDescription
    pageKind=pageKind
    doc=doc
  />
  <@renderBreadcrumb
    pageUrl=absoluteUrl
    pageTitle=pageTitle
    pageKind=pageKind
  />
</#macro>
