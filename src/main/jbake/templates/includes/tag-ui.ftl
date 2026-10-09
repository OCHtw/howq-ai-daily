<#--
    共用 Tag UI
    - renderPostTags：內容下方 hashtag
    - renderTagCloud：標籤雲，可切 all / logs / news
-->

<#macro renderPostTags tagNames rootPath="">
    <#if tagNames?? && tagNames?size gt 0>

        <div class="post-tags">

            <#list tagNames as tagName>

                <#local tagUri = "">

                <#if tags??>
                    <#list tags as t>

                        <#if t.name == tagName>
                            <#local tagUri = t.uri>
                            <#break>
                        </#if>

                    </#list>
                </#if>

                <#if tagUri?has_content>

                    <a
                        class="post-tag"
                        href="${rootPath}${tagUri?html}"
                    >#${tagName?html}</a>

                <#else>

                    <span class="post-tag">
                        #${tagName?html}
                    </span>

                </#if>

            </#list>

        </div>

    </#if>
</#macro>


<#macro renderTagCloud
    rootPath=""
    scope="all"
    title="Topics"
    description=""
    showAllLink=false
>

    <#if tags?? && tags?size gt 0>

        <section class="tag-cloud-section tag-cloud-section-${scope?html}">

            <div class="section-heading tag-cloud-heading">
                <div>
                    <h2>${title?html}</h2>

                    <#if description?has_content>
                        <p class="tag-cloud-description">${description?html}</p>
                    </#if>
                </div>

                <#if showAllLink>
                    <a
                        class="section-more"
                        href="${rootPath}tags/"
                    >
                        全部標籤
                    </a>
                </#if>
            </div>

            <div class="tag-cloud">

                <#list tags?sort_by("name") as t>

                    <#local count = 0>

                    <#list (t.tagged_documents![]) as doc>
                        <#local docType = (doc.type!"")>

                        <#if
                            (scope == "all" && (docType == "post" || docType == "news"))
                            || (scope == "logs" && docType == "post")
                            || (scope == "news" && docType == "news")
                        >
                            <#local count = count + 1>
                        </#if>
                    </#list>

                    <#if count gt 0>

                        <#local sizeClass = "tag-cloud-s">

                        <#if count gt 20>
                            <#local sizeClass = "tag-cloud-xl">
                        <#elseif count gt 10>
                            <#local sizeClass = "tag-cloud-l">
                        <#elseif count gt 4>
                            <#local sizeClass = "tag-cloud-m">
                        </#if>

                        <#local tagHref = rootPath + t.uri>

                        <#if scope == "logs">
                            <#local tagHref = tagHref + "?scope=logs">
                        <#elseif scope == "news">
                            <#local tagHref = tagHref + "?scope=news">
                        </#if>

                        <a
                            class="tag-cloud-item ${sizeClass}"
                            href="${tagHref?html}"
                            title="${count} 篇內容"
                        >
                            #${t.name?html}

                            <span class="tag-cloud-count">
                                ${count}
                            </span>
                        </a>

                    </#if>

                </#list>

            </div>

        </section>

    </#if>

</#macro>
