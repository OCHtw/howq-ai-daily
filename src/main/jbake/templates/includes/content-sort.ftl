<#--
  共用文章排序：
  1. date 日期新到舊（同一天只比較 yyyy-MM-dd）
  2. 來源檔名小到大（不是文章標題、也不是發布先後）

  JBake 在 document.file 提供來源檔案完整路徑；
  把路徑分隔符統一後，只取最後的檔名。
-->
<#function sortByDateAndFilename documents>
  <#local rows = []>
  <#local days = []>

  <#list documents as doc>
    <#local day = "0000-00-00">
    <#if doc.date??>
      <#local day = doc.date?string("yyyy-MM-dd")>
    </#if>

    <#local sourcePath = (doc.file!"")?string>
    <#if !sourcePath?has_content>
      <#local sourcePath = (doc.uri!"")?string>
    </#if>
    <#local filename = sourcePath?replace("\\", "/")?keep_after_last("/")>

    <#local rows = rows + [{
      "day": day,
      "filename": filename,
      "document": doc
    }]>

    <#if !days?seq_contains(day)>
      <#local days = days + [day]>
    </#if>
  </#list>

  <#-- 日期降冪，日期相同時先按檔名升冪。 -->
  <#local byFilename = rows?sort_by("filename")>
  <#local result = []>
  <#list days?sort?reverse as day>
    <#list byFilename as row>
      <#if row.day == day>
        <#local result = result + [row.document]>
      </#if>
    </#list>
  </#list>

  <#return result>
</#function>
