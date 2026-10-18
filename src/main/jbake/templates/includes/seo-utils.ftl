<#--
  Shared helpers for canonical and JSON-LD.
  site.host is the single source of truth for absolute URLs.
-->
<#function siteBase>
  <#return (config.site_host!"https://dev.howqpon.com")?replace("/+$", "", "r")>
</#function>

<#function canonicalUrl relativePath="">
  <#local path = (relativePath!"")?string?replace("^/+", "", "r")>
  <#if path == "index.html">
    <#local path = "">
  <#elseif path?ends_with("/index.html")>
    <#local path = path?remove_ending("index.html")>
  </#if>
  <#return siteBase() + "/" + path>
</#function>

<#function absoluteAssetUrl rawPath="">
  <#local path = (rawPath!"")?string?trim>
  <#if path?starts_with("https://") || path?starts_with("http://")>
    <#return path>
  <#elseif path?starts_with("//")>
    <#return "https:" + path>
  </#if>
  <#return siteBase() + "/" + path?replace("^/+", "", "r")>
</#function>

<#-- JSON-LD inside an HTML script: encode < so content cannot close the script tag. -->
<#function jsonEscape value="">
  <#return (value!"")?string?json_string?replace("<", r"\u003C")>
</#function>

<#--
  Explicit, user-selected images only; never guess from Markdown body.
  Logs use cover; news uses cover when set, otherwise its existing image field.
  This is the single source for both BlogPosting.image and og:image.
-->
<#function articleImageUrl doc kind="">
  <#local pageKind = (kind!"")?string>
  <#if pageKind != "post" && pageKind != "news">
    <#return "">
  </#if>
  <#local cover = (doc.cover!"")?string?trim>
  <#if cover?has_content>
    <#return absoluteAssetUrl(cover)>
  </#if>
  <#if pageKind == "news">
    <#local newsImage = (doc.image!"")?string?trim>
    <#if newsImage?has_content>
      <#return absoluteAssetUrl(newsImage)>
    </#if>
  </#if>
  <#return "">
</#function>

<#-- For older Markdown without dateModified, use the original publication date.
     This does not modify any Markdown source file. -->
<#function effectiveModifiedDate doc>
  <#if doc.dateModified??>
    <#if doc.dateModified?is_date>
      <#return doc.dateModified?string("yyyy-MM-dd")>
    <#elseif doc.dateModified?string?trim?has_content>
      <#return doc.dateModified?string?trim>
    </#if>
  </#if>
  <#if doc.date??>
    <#return doc.date?string("yyyy-MM-dd")>
  </#if>
  <#return "">
</#function>

<#--
  The metadata format is single-line key=value, so use faq1Question/faq1Answer,
  faq2Question/faq2Answer, etc. Up to ten pairs are supported.
  Incomplete or whitespace-only pairs are ignored.
  No changes are required in existing Markdown files.
-->
<#function faqPairs doc>
  <#local pairs = []>
  <#list 1..10 as i>
    <#local qKey = "faq" + i + "Question">
    <#local aKey = "faq" + i + "Answer">
    <#local question = (doc[qKey]!"")?string?trim>
    <#local answer = (doc[aKey]!"")?string?trim>
    <#if question?has_content && answer?has_content>
      <#local pairs = pairs + [{"question": question, "answer": answer}]>
    </#if>
  </#list>
  <#return pairs>
</#function>

<#--
  An ordered TL;DR is independent of summary. New drafts use tldr1...tldr3,
  up to tldr10. Empty entries are skipped and renumbered at render time.
  Backward compatibility: a single pre-existing tldr= line becomes one point
  only if no numbered tldr fields have content.
-->
<#function tldrPoints doc>
  <#local points = []>
  <#list 1..10 as i>
    <#local key = "tldr" + i>
    <#local point = (doc[key]!"")?string?trim>
    <#if point?has_content>
      <#local points = points + [point]>
    </#if>
  </#list>
  <#if points?size == 0>
    <#local legacy = (doc.tldr!"")?string?trim>
    <#if legacy?has_content>
      <#local points = [legacy]>
    </#if>
  </#if>
  <#return points>
</#function>
