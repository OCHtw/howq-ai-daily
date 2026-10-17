<#--
  Stage 1 JSON-LD. Auto-detect post/news/page/newsindex/index/tag/tagsindex.
  Expects functions from includes/seo-utils.ftl to be loaded first.
  This does not claim that a commentary about someone else's news is original reporting.
-->
<#macro renderSchema pageUrl pageTitle pageDescription="" pageKind="" doc={}>
  <#local homeUrl = canonicalUrl("")>
  <#local kind = (pageKind!"")?string>
  <#local isArticle = (kind == "post" || kind == "news")>
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
      "@id": "${jsonEscape(homeUrl + "#author")}",
      "name": "${jsonEscape(config.site_author!"OCHtw")}",
      "sameAs": ["https://github.com/OCHtw"]
    },
    {
      "@type": "${webPageType}",
      "@id": "${jsonEscape(pageUrl + "#webpage")}",
      "url": "${jsonEscape(pageUrl)}",
      "name": "${jsonEscape(pageTitle)}",
      "description": "${jsonEscape(pageDescription)}",
      "inLanguage": "zh-TW",
      "isPartOf": {"@id": "${jsonEscape(homeUrl + "#website")}"}<#if isArticle>,
      "mainEntity": {"@id": "${jsonEscape(pageUrl + "#article")}"}</#if>
    }<#if isArticle>,
    {
      "@type": "BlogPosting",
      "@id": "${jsonEscape(pageUrl + "#article")}",
      "url": "${jsonEscape(pageUrl)}",
      "headline": "${jsonEscape(doc.title!pageTitle)}",
      "description": "${jsonEscape(doc.summary!pageDescription)}",
      "inLanguage": "zh-TW",
      "mainEntityOfPage": {"@id": "${jsonEscape(pageUrl + "#webpage")}"},
      "author": {"@id": "${jsonEscape(homeUrl + "#author")}"},
      "publisher": {"@id": "${jsonEscape(homeUrl + "#publisher")}"}<#if doc.date??>,
      "datePublished": "${doc.date?string('yyyy-MM-dd')}"</#if><#if effectiveModifiedDate(doc)?has_content>,
      "dateModified": "${jsonEscape(effectiveModifiedDate(doc))}"</#if><#if (doc.category!"")?has_content>,
      "articleSection": "${jsonEscape(doc.category)}"</#if><#if doc.tags?? && doc.tags?has_content>,
      "keywords": [<#list doc.tags as topic>"${jsonEscape(topic)}"<#sep>, </#sep></#list>]</#if><#if kind == "post" && (doc.cover!"")?string?trim?has_content>,
      "image": "${jsonEscape(absoluteAssetUrl(doc.cover))}"</#if><#if kind == "news" && (doc.source_url!"")?string?trim?has_content>,
      "isBasedOn": {
        "@type": "CreativeWork",
        "url": "${jsonEscape(doc.source_url)}"<#if (doc.source_name!"")?string?trim?has_content>,
        "publisher": {
          "@type": "Organization",
          "name": "${jsonEscape(doc.source_name)}"
        }</#if><#if (doc.source_date!"")?string?trim?has_content>,
        "datePublished": "${jsonEscape(doc.source_date)}"</#if>
      }</#if>
    }</#if>
  ]
}
</script>
</#macro>
