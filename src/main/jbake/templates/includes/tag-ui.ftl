<#--
    共用 Tag UI
    - renderPostTags：文章下面的 hashtag
    - renderTagCloud：標籤雲
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



<#macro renderTagCloud rootPath="">

    <#if tags?? && tags?size gt 0>

        <section class="tag-cloud-section">

            <div class="section-heading">
                <h2>Topics</h2>

                <a
                    class="section-more"
                    href="${rootPath}tags/"
                >
                    全部標籤
                </a>
            </div>


            <div class="tag-cloud">

                <#list tags?sort_by("name") as t>

                    <#local count = (t.tagged_posts![])?size>
                    <#local sizeClass = "tag-cloud-s">

                    <#if count gt 20>

                        <#local sizeClass = "tag-cloud-xl">

                    <#elseif count gt 10>

                        <#local sizeClass = "tag-cloud-l">

                    <#elseif count gt 4>

                        <#local sizeClass = "tag-cloud-m">

                    </#if>


                    <a
                        class="tag-cloud-item ${sizeClass}"
                        href="${rootPath}${t.uri?html}"
                        title="${count} 篇文章"
                    >
                        #${t.name?html}

                        <span class="tag-cloud-count">
                            ${count}
                        </span>
                    </a>

                </#list>

            </div>

        </section>

    </#if>

</#macro>