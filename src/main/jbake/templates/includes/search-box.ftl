<#macro searchBox rootPath="">

    <div
        class="site-search"
        data-search-root="${rootPath?html}"
    >

        <label
            class="sr-only"
            for="site-search-input"
        >
            搜尋文章
        </label>


        <input
            id="site-search-input"
            class="site-search-input"
            type="search"
            placeholder="搜尋文章…"
            autocomplete="off"
            spellcheck="false"
        >


        <div
            id="site-search-results"
            class="site-search-results"
            hidden
            aria-live="polite"
        ></div>

    </div>


    <script
        defer
        src="${rootPath}js/search.js"
    ></script>

</#macro>