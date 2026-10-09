(() => {

    "use strict";

    const search = document.querySelector(".site-search");

    if (!search) {
        return;
    }

    const input = search.querySelector(".site-search-input");
    const results = search.querySelector(".site-search-results");

    const rootPath = search.dataset.searchRoot || "";

    let index = null;
    let loadingPromise = null;

    function normalize(value) {

        return (value || "")
            .toString()
            .toLowerCase()
            .trim();

    }

    function stripHtml(html) {

        const template = document.createElement("template");

        template.innerHTML = html || "";

        return (
            template.content.textContent ||
            template.content.innerText ||
            ""
        )
            .replace(/\s+/g, " ")
            .trim();

    }

    async function loadIndex() {

        if (index) {
            return index;
        }

        if (loadingPromise) {
            return loadingPromise;
        }

        loadingPromise = fetch(rootPath + "search.json")
            .then(response => {

                if (!response.ok) {
                    throw new Error(
                        "Cannot load search.json"
                    );
                }

                return response.json();

            })
            .then(items => {

                index = items.map(item => {

                    const bodyText =
                        stripHtml(item.body);

                    const tags =
                        Array.isArray(item.tags)
                            ? item.tags
                            : [];

                    return {
                        ...item,

                        bodyText,

                        searchTitle:
                            normalize(item.title),

                        searchTags:
                            tags.map(normalize),

                        searchBody:
                            normalize(bodyText),

                        searchAll:
                            normalize(
                                [
                                    item.title,
                                    item.category,
                                    tags.join(" "),
                                    bodyText
                                ].join(" ")
                            )
                    };

                });

                return index;

            })
            .catch(error => {

                console.error(
                    "Search index load failed:",
                    error
                );

                index = [];

                return index;

            });

        return loadingPromise;

    }

    function score(item, tokens, wholeQuery) {

        const matchesAll =
            tokens.every(token =>
                item.searchAll.includes(token)
            );

        if (!matchesAll) {
            return -1;
        }

        let result = 0;

        if (
            wholeQuery &&
            item.searchTitle.includes(wholeQuery)
        ) {
            result += 100;
        }

        for (const token of tokens) {

            if (
                item.searchTags.some(
                    tag => tag === token
                )
            ) {
                result += 80;
            }

            if (
                item.searchTags.some(
                    tag => tag.includes(token)
                )
            ) {
                result += 40;
            }

            if (
                item.searchTitle.includes(token)
            ) {
                result += 30;
            }

            if (
                normalize(item.category).includes(token)
            ) {
                result += 20;
            }

            if (
                item.searchBody.includes(token)
            ) {
                result += 5;
            }

        }

        return result;

    }

    function createResult(item) {

        const link =
            document.createElement("a");

        link.className =
            "search-result-item";

        link.href =
            rootPath + item.uri;

        const title =
            document.createElement("div");

        title.className =
            "search-result-title";

        title.textContent =
            item.title;

        const meta =
            document.createElement("div");

        meta.className =
            "search-result-meta";

        const parts = [];

        if (item.type === "news") {
            parts.push("新聞");
        } else if (item.type === "post") {
            parts.push("日誌");
        }

        if (item.date) {
            parts.push(item.date);
        }

        if (item.category) {
            parts.push(item.category);
        }

        if (
            item.tags &&
            item.tags.length > 0
        ) {
            parts.push(
                item.tags
                    .map(tag => "#" + tag)
                    .join(" ")
            );
        }

        meta.textContent =
            parts.join(" · ");

        const excerpt =
            document.createElement("div");

        excerpt.className =
            "search-result-excerpt";

        let text = item.bodyText || "";

        if (text.length > 140) {

            text =
                text.substring(0, 140) +
                "…";

        }

        excerpt.textContent =
            text;

        link.appendChild(title);
        link.appendChild(meta);
        link.appendChild(excerpt);

        return link;

    }

    function render(items) {

        results.replaceChildren();

        if (items.length === 0) {

            const empty =
                document.createElement("div");

            empty.className =
                "search-empty";

            empty.textContent =
                "找不到符合的內容";

            results.appendChild(empty);

            results.hidden = false;

            return;
        }

        items
            .slice(0, 8)
            .forEach(item => {

                results.appendChild(
                    createResult(item)
                );

            });

        results.hidden = false;

    }

    async function searchArticles() {

        let query =
            normalize(input.value);

        query =
            query.replace(/^#+/, "");

        if (!query) {

            results.hidden = true;

            results.replaceChildren();

            return;

        }

        const articles =
            await loadIndex();

        const tokens =
            query
                .split(/\s+/)
                .filter(Boolean);

        const matches =
            articles
                .map(item => ({
                    item,
                    score: score(
                        item,
                        tokens,
                        query
                    )
                }))
                .filter(
                    result =>
                        result.score >= 0
                )
                .sort(
                    (a, b) =>
                        b.score - a.score
                )
                .map(
                    result =>
                        result.item
                );

        render(matches);

    }

    let timer = null;

    input.addEventListener(
        "input",
        () => {

            clearTimeout(timer);

            timer =
                setTimeout(
                    searchArticles,
                    120
                );

        }
    );

    input.addEventListener(
        "focus",
        () => {

            loadIndex();

            if (
                input.value.trim()
            ) {
                searchArticles();
            }

        }
    );

    document.addEventListener(
        "keydown",
        event => {

            if (
                event.key === "Escape"
            ) {

                results.hidden = true;

                input.blur();

            }

        }
    );

    document.addEventListener(
        "click",
        event => {

            if (
                !search.contains(
                    event.target
                )
            ) {

                results.hidden = true;

            }

        }
    );

})();
