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
