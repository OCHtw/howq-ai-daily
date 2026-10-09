package tw.howq.daily.tools;

import java.io.IOException;
import java.net.URI;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.Locale;
import java.util.Scanner;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;

/** Imports public article metadata as a JBake news draft; it does not copy article bodies. */
public final class NewsImporter {
    private static final ZoneId TAIPEI = ZoneId.of("Asia/Taipei");
    private static final Pattern DATE = Pattern.compile("(\\d{4}-\\d{2}-\\d{2})");
    private static final Pattern SLUG = Pattern.compile("[^a-z0-9]+", Pattern.CASE_INSENSITIVE);
    private static final int TIMEOUT_MILLIS = 15_000;

    private NewsImporter() { }

    public static void main(String[] args) throws Exception {
        String url;
        if (args.length > 0 && !args[0].isBlank()) {
            url = args[0].trim();
        } else {
            System.out.print("請貼上新聞網址：https://...");
            System.out.flush();
            Scanner scanner = new Scanner(System.in, StandardCharsets.UTF_8);
            if (!scanner.hasNextLine()) {
                System.err.println("缺少新聞網址。可於 Program arguments 指定網址。");
                return;
            }
            url = scanner.nextLine().trim();
        }

        URI input = validateUrl(url);
        System.out.println("正在擷取公開新聞資訊：" + input);
        Document doc = Jsoup.connect(input.toString())
                .userAgent("Mozilla/5.0 (compatible; HowqNewsImporter/1.0; metadata-only)")
                .timeout(TIMEOUT_MILLIS)
                .maxBodySize(2_000_000)
                .followRedirects(true)
                .get();
        String canonical = firstNotBlank(
                link(doc, "link[rel=canonical]"),
                meta(doc, "meta[property=og:url]"),
                doc.location(), input.toString());
        URI source = validateUrl(canonical);

        String title = firstNotBlank(meta(doc, "meta[property=og:title]"),
                meta(doc, "meta[name=twitter:title]"), doc.title());
        if (title.isBlank()) {
            throw new IOException("網站未提供標題，請手動建立新聞 Markdown。");
        }
        String description = firstNotBlank(
                meta(doc, "meta[property=og:description]"),
                meta(doc, "meta[name=description]"),
                meta(doc, "meta[name=twitter:description]"));
        String image = firstNotBlank(
                metaUrl(doc, "meta[property=og:image]"),
                metaUrl(doc, "meta[name=twitter:image]"));
        String published = firstNotBlank(
                meta(doc, "meta[property=article:published_time]"),
                meta(doc, "meta[name=pubdate]"),
                meta(doc, "meta[name=date]"),
                meta(doc, "meta[itemprop=datePublished]"),
                timeValue(doc));
        LocalDate date = LocalDate.now(TAIPEI);
        LocalDate sourceDate = parseDate(published);
        String host = source.getHost();
        String sourceName = firstNotBlank(meta(doc, "meta[property=og:site_name]"), host);

        // This is intentionally a manually maintained category, not a guessed classification.
        String category = args.length >= 2 && !args[1].isBlank() ? args[1].trim() : "未分類";
        Path outDir = Path.of("src", "main", "jbake", "content", "news");
        Files.createDirectories(outDir);
        String basename = date + "-" + slug(source);
        Path target = outDir.resolve(basename + ".md");
        int number = 2;
        while (Files.exists(target)) {
            target = outDir.resolve(basename + "-" + number++ + ".md");
        }

        StringBuilder markdown = new StringBuilder();
        header(markdown, "title", title);
        header(markdown, "date", date.toString());
        header(markdown, "source_date", sourceDate == null ? "" : sourceDate.toString());
        header(markdown, "type", "news");
        header(markdown, "status", "draft");
        header(markdown, "category", category);
        header(markdown, "tags", "");
        header(markdown, "source_name", sourceName);
        header(markdown, "source_url", source.toString());
        header(markdown, "image", image);
        header(markdown, "summary", description);
        header(markdown, "preview", description);
        markdown.append("~~~~~~\n\n");
        markdown.append("<!-- TODO: 這裡寫你的小編短評。檢查標題、摘要、分類、圖片授權後，改 status=published。 -->\n\n");
        Files.writeString(target, markdown.toString(), StandardCharsets.UTF_8);
        System.out.println("已建立草稿：" + target.toAbsolutePath());
        System.out.println("標題：" + title);
        System.out.println("分享日期（date）：" + date);
        System.out.println("原始發布日期（source_date）：" + (sourceDate == null ? "未找到，請手動查證" : sourceDate));
        System.out.println("請先編輯短評、category、tags；審查完成再將 status=draft 改成 published。");
    }

    static URI validateUrl(String value) {
        URI uri = URI.create(value);
        if (!("http".equalsIgnoreCase(uri.getScheme()) || "https".equalsIgnoreCase(uri.getScheme()))
                || uri.getHost() == null) {
            throw new IllegalArgumentException("只接受完整的 http:// 或 https:// 新聞網址。");
        }
        return uri;
    }

    static String meta(Document doc, String selector) {
        Element element = doc.selectFirst(selector);
        return element == null ? "" : element.attr("content").trim();
    }

    static String metaUrl(Document doc, String selector) {
        Element element = doc.selectFirst(selector);
        if (element == null) return "";
        String value = element.attr("content").trim();
        if (value.isBlank()) return "";
        try {
            URI url = URI.create(doc.baseUri()).resolve(value);
            return validateUrl(url.toString()).toString();
        } catch (IllegalArgumentException ex) {
            return "";
        }
    }

    static String link(Document doc, String selector) {
        Element element = doc.selectFirst(selector);
        if (element == null) return "";
        return element.absUrl("href");
    }

    static String timeValue(Document doc) {
        Element time = doc.selectFirst("time[datetime]");
        return time == null ? "" : time.attr("datetime");
    }

    static LocalDate parseDate(String value) {
        Matcher matcher = DATE.matcher(value);
        if (matcher.find()) {
            try {
                return LocalDate.parse(matcher.group(1), DateTimeFormatter.ISO_LOCAL_DATE);
            } catch (DateTimeParseException ignored) {
                // Metadata can be malformed.
            }
        }
        return null;
    }

    static String slug(URI url) {
        String path = url.getPath();
        String last = path == null ? "" : path.replaceAll("/+$", "");
        last = last.substring(last.lastIndexOf('/') + 1).replaceFirst("\\.[A-Za-z0-9]+$", "");
        last = SLUG.matcher(last.toLowerCase(Locale.ROOT)).replaceAll("-").replaceAll("^-|-$", "");
        if (last.length() > 55) last = last.substring(0, 55).replaceAll("-+$", "");
        if (last.isBlank()) last = "article";
        return last + "-" + Integer.toHexString(url.toString().hashCode());
    }

    static String firstNotBlank(String... values) {
        for (String value : values) {
            if (value != null && !value.isBlank()) return value.trim();
        }
        return "";
    }

    static void header(StringBuilder result, String key, String value) {
        // JBake metadata is single-line key=value. Avoid newlines or separator injection.
        String safe = (value == null ? "" : value)
                .replaceAll("[\\p{Cntrl}\\s]+", " ")
                .replace("~~~~~~", "------").trim();
        result.append(key).append('=').append(safe).append('\n');
    }
}
