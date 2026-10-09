(() => {
  "use strict";

  const tabs = Array.from(
    document.querySelectorAll("[data-news-category]")
  );

  const items = Array.from(
    document.querySelectorAll("[data-news-item]")
  );

  const empty = document.getElementById("news-filter-empty");

  if (tabs.length === 0 || items.length === 0) {
    return;
  }

  const knownCategories = new Set(
    tabs.map(tab => tab.dataset.newsCategory)
  );

  function applyCategory(category, updateUrl) {
    const selected = knownCategories.has(category)
      ? category
      : "all";

    let visibleCount = 0;

    tabs.forEach(tab => {
      const active = tab.dataset.newsCategory === selected;

      tab.classList.toggle("is-active", active);
      tab.setAttribute(
        "aria-pressed",
        active ? "true" : "false"
      );
    });

    items.forEach(item => {
      const visible =
        selected === "all"
        || item.dataset.category === selected;

      item.hidden = !visible;

      if (visible) {
        visibleCount += 1;
      }
    });

    if (empty) {
      empty.hidden = visibleCount > 0;
    }

    if (updateUrl) {
      const url = new URL(window.location.href);

      if (selected === "all") {
        url.searchParams.delete("category");
      } else {
        url.searchParams.set("category", selected);
      }

      window.history.replaceState(
        null,
        "",
        url.pathname + url.search + url.hash
      );
    }
  }

  tabs.forEach(tab => {
    tab.addEventListener("click", () => {
      applyCategory(
        tab.dataset.newsCategory,
        true
      );
    });
  });

  const params = new URLSearchParams(
    window.location.search
  );

  applyCategory(
    params.get("category") || "all",
    false
  );
})();
