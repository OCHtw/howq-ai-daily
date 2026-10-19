<#-- Add configured UTM tracking to news source links only. Original source_url stays unchanged. -->
<#function newsSourceUrl original>
  <#local url = original?trim>
  <#if !url?has_content || (config.news_utm_enabled!"true")?lower_case != "true"
      || !(url?starts_with("https://") || url?starts_with("http://"))>
    <#return url>
  </#if>
  <#local fragment = "">
  <#if url?contains("#")>
    <#local fragment = "#" + url?keep_after("#")>
    <#local url = url?keep_before("#")>
  </#if>
  <#-- Optional host exclusions: exact domain or its subdomains, never a substring match. -->
  <#local excludedDomains = (config.news_utm_exclude_domains!"")?trim>
  <#if excludedDomains?has_content>
    <#-- Extract the hostname, ignoring port, username, query and URL fragment. -->
    <#local authority = url?keep_after("://")?keep_before("/")?keep_before("?")>
    <#local hostname = authority?split("@")?last?split(":")?first?lower_case>
    <#list excludedDomains?split(";") as excludedEntry>
      <#local excludedHost = excludedEntry?trim?lower_case>
      <#if excludedHost?has_content
          && (hostname == excludedHost || hostname?ends_with("." + excludedHost))>
        <#return url + fragment>
      </#if>
    </#list>
  </#if>
  <#local params = []>
  <#if !url?matches("(?s).*[?&]utm_source(?:=|&|$).*")>
    <#local params = params + ["utm_source=" + (config.news_utm_source!"howqpon.com")?url("UTF-8")]>
  </#if>
  <#if !url?matches("(?s).*[?&]utm_medium(?:=|&|$).*")>
    <#local params = params + ["utm_medium=" + (config.news_utm_medium!"referral")?url("UTF-8")]>
  </#if>
  <#if !url?matches("(?s).*[?&]utm_campaign(?:=|&|$).*")>
    <#local params = params + ["utm_campaign=" + (config.news_utm_campaign!"blog_news")?url("UTF-8")]>
  </#if>
  <#if params?has_content>
    <#local sep = "?">
    <#if url?contains("?")>
      <#local sep = "&">
      <#if url?ends_with("?") || url?ends_with("&")>
        <#local sep = "">
      </#if>
    </#if>
    <#local url = url + sep + params?join("&")>
  </#if>
  <#return url + fragment>
</#function>
