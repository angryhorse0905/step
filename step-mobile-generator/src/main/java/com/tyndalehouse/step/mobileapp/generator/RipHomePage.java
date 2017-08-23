package com.tyndalehouse.step.mobileapp.generator;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.nodes.Node;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URL;
import java.nio.channels.Channels;
import java.nio.channels.ReadableByteChannel;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Downloads the home page and amends it to suit the purposes of the mobile app
 */
public class RipHomePage {
    public static final String BASE_STEP = "http://localhost:80/";
    public static final Pattern CSS_URL = Pattern.compile("url\\('?([^')]+)'?\\)");
    public static final Pattern JS_URL = Pattern.compile("\"(js/.*min\")");

    public static void main(String[] args) throws IOException {
        new RipHomePage().process(BASE_STEP, "?mobile=online", "C:\\dev\\projects\\temp\\my-test-app\\www");
    }

    /**
     * Downloads the STEP home page and processes it.
     */
    private void process(final String url, final String args, final String directory) throws IOException {
        Document doc = download(url + args);
        applyRules(doc);
        outputDocument(doc);

        List<String> relativeLinks = scanLinks(doc);
        writeApp(directory, doc, relativeLinks);
    }

    private void writeApp(final String directory, final Document doc, final List<String> relativeLinks) throws IOException {
        final File root = new File(directory);
        FileUtils.forceMkdir(root);

        //write the main app, as index.html
        FileUtils.write(new File(root, "index.html"), doc.html());

        //download files and move to relevant directories
        for (final String relativeLink : relativeLinks) {
            File f = downloadFileToDisk(root, relativeLink);
            downloadCSSReferencedResources(root, f);
//            downloadJSReferences(root, f);
        }

        downloadInternationalFiles(root);
    }

    private void downloadJSReferencedResources(final File root, final File relativeLink) throws IOException {

    }

    private void downloadCSSReferencedResources(final File root, final File relativeLink) throws IOException {
        final String suffix = ".css";
        final Pattern urlMatcher = CSS_URL;

        if(!relativeLink.getName().endsWith(suffix)) {
            return;
        }

        //we're dealing with a CSS file, so scan the content for url()
        List<String> resources = new ArrayList<>(32);
        final String fileContents = FileUtils.readFileToString(relativeLink);

        //now match the url(....)
        final Matcher cssURLMatcher = urlMatcher.matcher(fileContents);
        while(cssURLMatcher.find()) {
            //extract first group, to download later
            final String group = cssURLMatcher.group(1);
            resources.add(group);
        }

        //calculate real root
        for(String resource : resources) {
            if(resource.contains("#")) {
                continue;
            }

            File relativeRoot = resource.startsWith("../") || resource.startsWith("/") ? relativeLink.getParentFile().getParentFile() : relativeLink.getParentFile();

            String finalName = resource.replace("../", "");
            if(finalName.startsWith("/")) {
                finalName = finalName.substring(1);
            }

            downloadFileToDisk(root, (relativeRoot.getAbsolutePath() + "/" + finalName).replace(root.getAbsolutePath(), "").replace('\\', '/'));
        }
    }

    private void downloadInternationalFiles(final File root) throws IOException {
        Properties prop = new Properties();
        prop.load(getClass().getClassLoader().getResourceAsStream("step.core.properties"));

        String languages = prop.getProperty("app.languages.available");
        final String[] langs = StringUtils.split(languages, ",");
        for(String lang : langs) {
            downloadFileToDisk(root, "international/interactive.js?lang=" + lang, lang);
        }
    }

    private File downloadFileToDisk(final File root, final String filePath) throws IOException {
        return downloadFileToDisk(root, filePath, null);
    }

    private File downloadFileToDisk(final File root, final String filePath, final String infix) throws IOException {
        final URL website = new URL(BASE_STEP + filePath);
        final ReadableByteChannel rbc = Channels.newChannel(website.openStream());

        final int directoryEnd = filePath.lastIndexOf('/');
        final File fileDirectory;
        String fileName;
        if (directoryEnd != -1) {
            fileDirectory = new File(root, filePath.substring(0, directoryEnd));
            FileUtils.forceMkdir(fileDirectory);
            fileName = filePath.substring(directoryEnd + 1);
        } else {
            fileName = filePath;
            fileDirectory = root;
        }

        //remove any arguments
        if(fileName.contains("?")) {
            fileName = fileName.substring(0, fileName.indexOf('?'));
        }

        if(infix != null) {
            //add the infix just before the file extension
            fileName = fileName.substring(0, fileName.indexOf('.')) + '-' + infix + fileName.substring(fileName.indexOf("."));
        }

        final File outputFile = new File(fileDirectory, fileName);
        final FileOutputStream fos = new FileOutputStream(outputFile);
        fos.getChannel().transferFrom(rbc, 0, Long.MAX_VALUE);
        return outputFile;
    }

    private List<String> scanLinks(final Document doc) {
        Iterator<Element> iterator = doc.select("[src], [rel]:not([rel=canonical])").iterator();
        List<String> links = new ArrayList<>();
        while (iterator.hasNext()) {
            final Element next = iterator.next();
            final String src = next.attr("src");
            if (StringUtils.isNotBlank(src)) {
                addRelativeURL(links, src);
            } else {
                addRelativeURL(links, next.attr("href"));
            }
        }
        return links;
    }

    private void addRelativeURL(final List<String> links, final String src) {
        if (!src.startsWith("international")) {
            links.add(src);
        }
    }

    private void outputDocument(final Document doc) {
        String html = doc.html();
        System.out.println(html);
    }

    private void applyRules(final Document doc) {
        removeExtras(doc);
    }


    private void removeComments(Node node) {
        // as we are removing child nodes while iterating, we cannot use a normal foreach over children,
        // or will get a concurrent list modification error.
        int i = 0;
        while (i < node.childNodes().size()) {
            Node child = node.childNode(i);
            if (child.nodeName().equals("#comment"))
                child.remove();
            else {
                removeComments(child);
                i++;
            }
        }
    }

    private void removeExtras(final Document doc) {
        doc.select(".passageContent").empty();
        doc.select(".examplesColumn").remove();
        doc.select("#raiseSupportTrigger").remove();
        removeComments(doc);
        doc.select("#languageMenu li").removeAttr("title");
    }

    private Document download(final String url) throws IOException {
        return Jsoup.connect(url).get();
    }
}
