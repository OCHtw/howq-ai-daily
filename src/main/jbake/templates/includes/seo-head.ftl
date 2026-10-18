<#--
  Single entrypoint for per-page canonical and structured data.
  Keep existing title/meta/style elements in their original templates.
-->

<#include "/includes/seo-utils.ftl">
<#include "/includes/schema.ftl">
<#include "/includes/analytics.ftl">


<#macro renderSeo pageUri="" pageTitle="" pageDescription="" pageKind="" doc={}>
  <#local absoluteUrl = canonicalUrl(pageUri)>
  <link rel="canonical" href="${absoluteUrl?html}">
  <@renderSchema
    pageUrl=absoluteUrl
    pageTitle=pageTitle
    pageDescription=pageDescription
    pageKind=pageKind
    doc=doc
  />
</#macro>
