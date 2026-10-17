<?xml version="1.0" encoding="UTF-8"?>
<#-- Only published HTML pages appear here. No fake lastmod from build time. -->
<#include "includes/seo-utils.ftl">
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <url><loc>${canonicalUrl("")?xml}</loc></url>
  <url><loc>${canonicalUrl("news/")?xml}</loc></url>
  <url><loc>${canonicalUrl("tags/")?xml}</loc></url>
  <#list published_content as doc>
    <#if doc.uri?? && ((doc.type!"") == "post" || (doc.type!"") == "news" || (doc.type!"") == "page")>
  <url>
    <loc>${canonicalUrl(doc.uri)?xml}</loc>
    <#if effectiveModifiedDate(doc)?has_content>
    <lastmod>${effectiveModifiedDate(doc)?xml}</lastmod>
    </#if>
  </url>
    </#if>
  </#list>
  <#list (tags![]) as t>
  <url><loc>${canonicalUrl(t.uri)?xml}</loc></url>
  </#list>
</urlset>
