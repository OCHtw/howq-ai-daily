<#-- Optional content fields; empty or missing fields render no HTML. -->
<#macro renderTldr doc>
  <#local points = tldrPoints(doc)>
  <#if points?has_content>
    <aside id="article-tldr" class="article-tldr" aria-labelledby="article-tldr-heading">
      <h2 id="article-tldr-heading">TL;DR · 重點摘要</h2>
      <ol>
        <#list points as point>
          <li>${point?html}</li>
        </#list>
      </ol>
    </aside>
  </#if>
</#macro>

<#macro renderFaq doc>
  <#local items = faqPairs(doc)>
  <#if items?size gt 0>
    <section id="article-faq" class="article-faq" aria-labelledby="article-faq-heading">
      <h2 id="article-faq-heading">常見問題</h2>
      <#list items as item>
        <section class="article-faq-item">
          <h3>${item.question?html}</h3>
          <#-- FAQ answers are trusted author-maintained metadata; preserve inline HTML links and emphasis.
               Do not render content from untrusted users here without server-side HTML sanitization. -->
          <div class="article-faq-answer">${item.answer}</div>
        </section>
      </#list>
    </section>
  </#if>
</#macro>
