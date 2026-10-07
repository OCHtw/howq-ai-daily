[
<#list published_posts as post>
{
    "title": "${(post.title!"")?json_string}",
    "uri": "${(post.uri!"")?json_string}",
    "date": "<#if post.date??>${post.date?string("yyyy-MM-dd")}</#if>",

    "tags": [
        <#if post.tags??>
            <#list post.tags as tag>
                "${tag?json_string}"<#sep>,</#sep>
            </#list>
        </#if>
    ],

    "body": "${(post.body!"")?json_string}"
}<#sep>,</#sep>
</#list>
]