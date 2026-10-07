# bio-howq-ai-daily

Local Maven project for the **HOWQ AI Daily** build-in-open static site.

- Local project: `bio-howq-ai-daily`
- GitHub repository: `OCHtw/howq-ai-daily`
- Generator: JBake 2.7.0
- Content: Markdown
- Templates: FreeMarker
- Output: `target/website`

## Import into Spring STS 4

1. `File` → `Import...`
2. `Maven` → `Existing Maven Projects`
3. Select this project directory.
4. Make sure `pom.xml` is checked.
5. Finish.

## Build once

Run as Maven build with goals:

```bash
clean package
```

Generated files are written to:

```text
target/website/
```

## Live preview

Run as Maven build with goals:

```bash
package -Pserve
```

Then open:

```text
http://localhost:8820/
```

The `serve` profile uses JBake inline mode, so content/template/assets changes are watched and rebaked while the server is running.

## Add a new log

Create a Markdown file under:

```text
src/main/jbake/content/posts/
```

Example header:

```text
title=My new log
date=2026-10-08
type=post
status=published
category=AI
summary=One-line summary shown on the home page.
~~~~~~

Write Markdown here.
```

## GitHub Pages

The included workflow builds `target/website` and deploys it with GitHub Pages Actions.

After pushing the repository to `OCHtw/howq-ai-daily`, open repository **Settings → Pages** and set **Source** to **GitHub Actions**.
