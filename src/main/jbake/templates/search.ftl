<#include "includes/content-sort.ftl">
<#assign searchable = []>

<#list published_content as item>
  <#if (item.type!"") == "post" || (item.type!"") == "news">
    <#assign searchable = searchable + [item]>
  </#if>
</#list>

<#assign searchable = sortByDateAndFilename(searchable)>

[
<#list searchable as item>
{
    "title": "${(item.title!"")?json_string}",
    "uri": "${(item.uri!"")?json_string}",
    "date": "<#if item.date??>${item.date?string("yyyy-MM-dd")}</#if>",
    "type": "${(item.type!"")?json_string}",
    "category": "${(item.category!"")?json_string}",

    "tags": [
        <#if item.tags??>
            <#list item.tags as tag>
                "${tag?json_string}"<#sep>,</#sep>
            </#list>
        </#if>
    ],

    "body": "${(((item.summary!"") + " " + (item.body!"")))?json_string}"
}<#sep>,</#sep>
</#list>
]
