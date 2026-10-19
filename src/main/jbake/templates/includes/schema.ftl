<#--
  Auto-detect post/news/page/newsindex/index/tag/tagsindex.
  Expects functions from includes/seo-utils.ftl to be loaded first.
  Numbered TL;DR fields create an independent WebPageElement with an ItemList
  (there is no Schema.org TLDR type); FAQ pairs create an FAQPage node.
  Empty values create neither visible elements nor JSON-LD nodes.
-->
<#--
  Date-only metadata is interpreted as midnight in Taiwan for JSON-LD only.
  Do not change visible date labels, Markdown files, or already complete
  date-time values. +08:00 is Asia/Taipei's offset.
-->
<#function schemaDateTime rawDate="">
  <#local value = (rawDate!"")?string?trim>
  <#if value?matches(r"^[0-9]{4}-[0-9]{2}-[0-9]{2}$")>
    <#return value + "T00:00:00+08:00">
  </#if>
  <#return value>
</#function>

<#macro renderSchema pageUrl pageTitle pageDescription="" pageKind="" doc={}>
  <#local homeUrl = canonicalUrl("")>
  <#-- Global author identity. Name remains site.author for backward compatibility. -->
  <#local authorId = (config.site_author_id!(homeUrl + "#author"))?string?trim>
  <#if !authorId?has_content>
    <#local authorId = homeUrl + "#author">
  </#if>
  <#local authorUrl = (config.site_author_url!canonicalUrl("about.html"))?string?trim>
  <#if !authorUrl?has_content>
    <#local authorUrl = canonicalUrl("about.html")>
  </#if>
  <#local authorSameAs = []>
  <#list (config.site_author_sameas!"")?string?split(";") as rawUrl>
    <#local sameAsUrl = rawUrl?trim>
    <#if sameAsUrl?has_content>
      <#local authorSameAs = authorSameAs + [sameAsUrl]>
    </#if>
  </#list>
  <#local kind = (pageKind!"")?string>
  <#local isArticle = (kind == "post" || kind == "news")>
  <#local imageUrl = articleImageUrl(doc, kind)>
  <#local tldrItems = tldrPoints(doc)>
  <#local faqList = faqPairs(doc)>
  <#local hasTldr = isArticle && tldrItems?has_content>
  <#local hasFaq = isArticle && faqList?size gt 0>
  <#local webPageType = "WebPage">
  <#if kind == "newsindex" || kind == "tagsindex" || kind == "tag">
    <#local webPageType = "CollectionPage">
  <#elseif kind == "page" && pageUrl?ends_with("/about.html")>
    <#local webPageType = "AboutPage">
  </#if>
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@graph": [
    {
      "@type": "WebSite",
      "@id": "${jsonEscape(homeUrl + "#website")}",
      "url": "${jsonEscape(homeUrl)}",
      "name": "${jsonEscape(config.site_title!"howq AI Daily")}",
      "description": "${jsonEscape(config.site_description!"")}",
      "inLanguage": "zh-TW",
      "publisher": {"@id": "${jsonEscape(homeUrl + "#publisher")}"}
    },
    {
      "@type": "Organization",
      "@id": "${jsonEscape(homeUrl + "#publisher")}",
      "name": "${jsonEscape(config.site_publisher!"howq AI Daily")}",
      "url": "${jsonEscape(homeUrl)}"
    },
    {
      "@type": "Person",
      "@id": "${jsonEscape(authorId)}",
      "name": "${jsonEscape(config.site_author!"OCHtw")}",
      "url": "${jsonEscape(authorUrl)}"<#if authorSameAs?has_content>,
      "sameAs": [<#list authorSameAs as sameAsUrl>"${jsonEscape(sameAsUrl)}"<#sep>, </#list>]</#if>
    },
    {
      "@type": "${webPageType}",
      "@id": "${jsonEscape(pageUrl + "#webpage")}",
      "url": "${jsonEscape(pageUrl)}",
      "name": "${jsonEscape(pageTitle)}",
      "description": "${jsonEscape(pageDescription)}",
      "inLanguage": "zh-TW",
      "isPartOf": {"@id": "${jsonEscape(homeUrl + "#website")}"}<#if isArticle>,
      "mainEntity": {"@id": "${jsonEscape(pageUrl + "#article")}"}</#if><#if hasTldr || hasFaq>,
      "hasPart": [<#if hasTldr>{"@id": "${jsonEscape(pageUrl + "#tldr")}"}</#if><#if hasTldr && hasFaq>, </#if><#if hasFaq>{"@id": "${jsonEscape(pageUrl + "#article-faq")}"}</#if>]</#if>
    }<#if isArticle>,
    {
      "@type": "BlogPosting",
      "@id": "${jsonEscape(pageUrl + "#article")}",
      "url": "${jsonEscape(pageUrl)}",
      "headline": "${jsonEscape(doc.title!pageTitle)}",
      "description": "${jsonEscape(doc.summary!pageDescription)}",
      "inLanguage": "zh-TW",
      "mainEntityOfPage": {"@id": "${jsonEscape(pageUrl + "#webpage")}"},
      "author": {"@id": "${jsonEscape(authorId)}"},
      "publisher": {"@id": "${jsonEscape(homeUrl + "#publisher")}"}<#if doc.date??>,
      "datePublished": "${jsonEscape(schemaDateTime(doc.date?string('yyyy-MM-dd')))}"</#if><#if effectiveModifiedDate(doc)?has_content>,
      "dateModified": "${jsonEscape(schemaDateTime(effectiveModifiedDate(doc)))}"</#if><#if (doc.category!"")?has_content>,
      "articleSection": "${jsonEscape(doc.category)}"</#if><#if doc.tags?? && doc.tags?has_content>,
      "keywords": [<#list doc.tags as topic>"${jsonEscape(topic)}"<#sep>, </#sep></#list>]</#if><#if imageUrl?has_content>,
      "image": "${jsonEscape(imageUrl)}"</#if><#if kind == "news" && (doc.source_url!"")?string?trim?has_content>,
      "isBasedOn": {
        "@type": "CreativeWork",
        "url": "${jsonEscape(doc.source_url)}"<#if (doc.source_name!"")?string?trim?has_content>,
        "publisher": {
          "@type": "Organization",
          "name": "${jsonEscape(doc.source_name)}"
        }</#if><#if (doc.source_date!"")?string?trim?has_content>,
        "datePublished": "${jsonEscape(doc.source_date)}"</#if>
      }</#if>
    }</#if><#if hasTldr>,
    {
      "@type": "WebPageElement",
      "@id": "${jsonEscape(pageUrl + "#tldr")}",
      "name": "TL;DR · 重點摘要",
      "cssSelector": "#article-tldr",
      "isPartOf": {"@id": "${jsonEscape(pageUrl + "#webpage")}"},
      "mainEntity": {"@id": "${jsonEscape(pageUrl + "#tldr-list")}"}
    },
    {
      "@type": "ItemList",
      "@id": "${jsonEscape(pageUrl + "#tldr-list")}",
      "name": "文章重點摘要",
      "itemListOrder": "https://schema.org/ItemListOrderAscending",
      "numberOfItems": ${tldrItems?size},
      "itemListElement": [
        <#list tldrItems as point>
        {
          "@type": "ListItem",
          "position": ${point?index + 1},
          "name": "${jsonEscape(point)}"
        }<#sep>,</#sep>
        </#list>
      ]
    }</#if><#if hasFaq>,
    {
      "@type": "FAQPage",
      "@id": "${jsonEscape(pageUrl + "#article-faq")}",
      "url": "${jsonEscape(pageUrl + "#article-faq")}",
      "name": "常見問題",
      "inLanguage": "zh-TW",
      "isPartOf": {"@id": "${jsonEscape(pageUrl + "#webpage")}"},
      "mainEntity": [
        <#list faqList as faq>
        {
          "@type": "Question",
          "name": "${jsonEscape(faq.question)}",
          "acceptedAnswer": {
            "@type": "Answer",
            "text": "${jsonEscape(faq.answer)}"
          }
        }<#sep>,</#sep>
        </#list>
      ]
    }</#if>
  ]
}
</script>
</#macro>
