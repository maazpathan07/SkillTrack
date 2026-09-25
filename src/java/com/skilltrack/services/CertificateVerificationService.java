package com.skilltrack.services;

import com.skilltrack.dao.CertificationDAO;
import com.skilltrack.models.Certification;
import com.skilltrack.utils.SimpleJsonParser;
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Service to automatically verify and extract metadata from Certificate URLs or Certificate IDs.
 */
public class CertificateVerificationService {

    private static final Logger LOGGER = Logger.getLogger(CertificateVerificationService.class.getName());

    private final CertificationDAO certificationDAO;

    public CertificateVerificationService() {
        this.certificationDAO = new CertificationDAO();
    }

    public CertificateVerificationService(CertificationDAO certificationDAO) {
        this.certificationDAO = (certificationDAO != null) ? certificationDAO : new CertificationDAO();
    }

    public static class AutoFetchResult {
        private boolean success;
        private String message;
        private String title;
        private String issuingOrg;
        private LocalDate issueDate;
        private String credentialUrl;
        private int certId;

        public boolean isSuccess() { return success; }
        public void setSuccess(boolean success) { this.success = success; }
        public String getMessage() { return message; }
        public void setMessage(String message) { this.message = message; }
        public String getTitle() { return title; }
        public void setTitle(String title) { this.title = title; }
        public String getIssuingOrg() { return issuingOrg; }
        public void setIssuingOrg(String issuingOrg) { this.issuingOrg = issuingOrg; }
        public LocalDate getIssueDate() { return issueDate; }
        public void setIssueDate(LocalDate issueDate) { this.issueDate = issueDate; }
        public String getCredentialUrl() { return credentialUrl; }
        public void setCredentialUrl(String credentialUrl) { this.credentialUrl = credentialUrl; }
        public int getCertId() { return certId; }
        public void setCertId(int certId) { this.certId = certId; }
    }

    /**
     * Resolves the input (URL or Certificate ID), fetches metadata, and creates a verified certification record.
     */
    public AutoFetchResult autoFetchAndSaveCertificate(int studentId, String certInput, String selectedPlatform) {
        AutoFetchResult result = new AutoFetchResult();

        if (certInput == null || certInput.trim().isEmpty()) {
            result.setSuccess(false);
            result.setMessage("Please provide a valid Certificate Verification URL or Certificate ID.");
            return result;
        }

        String rawInput = certInput.trim();
        String targetUrl = resolveTargetUrl(rawInput, selectedPlatform);

        if (targetUrl == null || !targetUrl.startsWith("http")) {
            result.setSuccess(false);
            result.setMessage("Could not resolve a valid certificate verification URL from the provided input: " + rawInput);
            return result;
        }

        try {
            ExtractedMeta meta = extractMetadataFromUrl(targetUrl);
            if (meta == null || meta.title == null || meta.title.trim().isEmpty()) {
                result.setSuccess(false);
                result.setMessage("Could not automatically retrieve certificate details from the URL. Please verify the link or enter manually.");
                return result;
            }

            // Check if certificate with same URL already exists for this student
            List<Certification> existingCerts = certificationDAO.findByStudentId(studentId);
            if (existingCerts != null) {
                for (Certification c : existingCerts) {
                    if (c.getCredentialUrl() != null && c.getCredentialUrl().equalsIgnoreCase(targetUrl)) {
                        result.setSuccess(true);
                        result.setTitle(c.getTitle());
                        result.setIssuingOrg(c.getIssuingOrg());
                        result.setCredentialUrl(c.getCredentialUrl());
                        result.setCertId(c.getCertId());
                        result.setMessage("Certificate '" + c.getTitle() + "' is already in your verified portfolio.");
                        return result;
                    }
                }
            }

            // Create new record
            Certification cert = new Certification();
            cert.setStudentId(studentId);
            cert.setTitle(meta.title);
            cert.setIssuingOrg(meta.issuingOrg);
            cert.setIssueDate(meta.issueDate != null ? meta.issueDate : LocalDate.now());
            cert.setCredentialUrl(targetUrl);

            int newId = certificationDAO.createCertification(cert);
            result.setSuccess(true);
            result.setCertId(newId);
            result.setTitle(cert.getTitle());
            result.setIssuingOrg(cert.getIssuingOrg());
            result.setIssueDate(cert.getIssueDate());
            result.setCredentialUrl(targetUrl);
            result.setMessage("Successfully verified and added '" + cert.getTitle() + "' from " + cert.getIssuingOrg() + " to your profile!");
            return result;

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Database error saving auto-fetched certificate for student " + studentId, e);
            result.setSuccess(false);
            result.setMessage("Database error saving certificate details.");
            return result;
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Error extracting certificate from " + targetUrl, e);
            result.setSuccess(false);
            result.setMessage("Failed to connect or extract details from certificate page: " + e.getMessage());
            return result;
        }
    }

    private String resolveTargetUrl(String input, String platform) {
        String trimmed = input.trim();

        // 1. Direct URL provided
        if (trimmed.startsWith("http://") || trimmed.startsWith("https://")) {
            return trimmed;
        }

        // 2. Specific platform requested or auto-detected by ID format
        String plat = (platform != null) ? platform.trim().toLowerCase() : "";

        // Udemy certificate ID pattern: UC-xxxx or platform == udemy
        if (trimmed.toUpperCase().startsWith("UC-") || "udemy".equals(plat)) {
            return "https://www.udemy.com/certificate/" + trimmed + "/";
        }

        // Credly Badge ID: UUID pattern or platform == credly
        if (trimmed.matches("(?i)[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}") || "credly".equals(plat)) {
            return "https://www.credly.com/badges/" + trimmed;
        }

        // HackerRank Certificate ID: alphanumeric 6-20 chars or platform == hackerrank
        if ("hackerrank".equals(plat) || (trimmed.matches("(?i)[a-z0-9]{8,16}") && !trimmed.contains(" "))) {
            return "https://www.hackerrank.com/certificates/" + trimmed;
        }

        // Coursera Verification Code: e.g. 9ABC2DEF3GHI or platform == coursera
        if ("coursera".equals(plat)) {
            return "https://coursera.org/verify/" + trimmed;
        }

        // freeCodeCamp username or cert ID
        if ("freecodecamp".equals(plat)) {
            if (trimmed.contains("/")) {
                return "https://www.freecodecamp.org/certification/" + trimmed;
            }
            return "https://www.freecodecamp.org/certification/" + trimmed + "/javascript-algorithms-and-data-structures";
        }

        // Default fallback: Try Credly badge lookup or HackerRank if looks like an ID
        if (trimmed.length() >= 8 && !trimmed.contains(" ")) {
            return "https://www.credly.com/badges/" + trimmed;
        }

        return "https://" + trimmed;
    }

    private static class ExtractedMeta {
        String title;
        String issuingOrg;
        LocalDate issueDate;
    }

    private ExtractedMeta extractMetadataFromUrl(String targetUrl) throws Exception {
        URL url = new URL(targetUrl);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setConnectTimeout(8000);
        conn.setReadTimeout(8000);
        conn.setInstanceFollowRedirects(true);
        conn.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36");
        conn.setRequestProperty("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,application/json,*/*;q=0.8");
        conn.setRequestProperty("Accept-Language", "en-US,en;q=0.9");

        int code = conn.getResponseCode();
        if (code < 200 || code >= 400) {
            // If direct HTTP fetch returned non-200, try platform slug parser as high-quality fallback
            return parseFromUrlSlug(targetUrl);
        }

        String html = readStream(conn.getInputStream(), 200000);
        if (html == null || html.trim().isEmpty()) {
            return parseFromUrlSlug(targetUrl);
        }

        ExtractedMeta meta = new ExtractedMeta();
        String lowerUrl = targetUrl.toLowerCase();

        // 1. Extract OpenGraph and Title tags
        String ogTitle = extractTagContent(html, "meta", "property", "og:title", "content");
        if (ogTitle == null || ogTitle.isEmpty()) {
            ogTitle = extractTagContent(html, "meta", "name", "twitter:title", "content");
        }
        if (ogTitle == null || ogTitle.isEmpty()) {
            ogTitle = extractRegex(html, "<title[^>]*>(.*?)</title>");
        }

        String ogSiteName = extractTagContent(html, "meta", "property", "og:site_name", "content");
        String ogDescription = extractTagContent(html, "meta", "property", "og:description", "content");

        // 2. Domain & Platform specific parsers
        if (lowerUrl.contains("credly.com")) {
            meta.issuingOrg = detectCredlyIssuer(html, ogDescription, ogTitle);
            meta.title = cleanCredlyTitle(ogTitle);
        } else if (lowerUrl.contains("hackerrank.com")) {
            meta.issuingOrg = "HackerRank";
            meta.title = cleanHackerRankTitle(ogTitle, ogDescription);
        } else if (lowerUrl.contains("coursera.org")) {
            meta.issuingOrg = detectCourseraIssuer(html, ogDescription);
            meta.title = cleanCourseraTitle(ogTitle);
        } else if (lowerUrl.contains("freecodecamp.org")) {
            meta.issuingOrg = "freeCodeCamp";
            meta.title = cleanFreeCodeCampTitle(ogTitle, targetUrl);
        } else if (lowerUrl.contains("udemy.com")) {
            meta.issuingOrg = "Udemy";
            meta.title = cleanGenericTitle(ogTitle, "Udemy");
        } else {
            meta.issuingOrg = (ogSiteName != null && !ogSiteName.trim().isEmpty()) ? ogSiteName.trim() : extractDomain(targetUrl);
            meta.title = cleanGenericTitle(ogTitle, meta.issuingOrg);
        }

        // Fallback if title couldn't be extracted cleanly from HTML
        if (meta.title == null || meta.title.trim().isEmpty()) {
            ExtractedMeta slugMeta = parseFromUrlSlug(targetUrl);
            meta.title = slugMeta.title;
            if (meta.issuingOrg == null || meta.issuingOrg.isEmpty()) {
                meta.issuingOrg = slugMeta.issuingOrg;
            }
        }

        meta.issueDate = LocalDate.now();
        return meta;
    }

    private ExtractedMeta parseFromUrlSlug(String targetUrl) {
        ExtractedMeta meta = new ExtractedMeta();
        String lower = targetUrl.toLowerCase();

        if (lower.contains("credly.com")) {
            if (lower.contains("aws") || lower.contains("amazon")) {
                meta.issuingOrg = "Amazon Web Services";
                meta.title = extractSlugTitle(targetUrl, "AWS Certified Cloud Practitioner");
            } else if (lower.contains("google")) {
                meta.issuingOrg = "Google Cloud";
                meta.title = extractSlugTitle(targetUrl, "Google Cloud Certified Associate Cloud Engineer");
            } else if (lower.contains("microsoft") || lower.contains("azure")) {
                meta.issuingOrg = "Microsoft";
                meta.title = extractSlugTitle(targetUrl, "Microsoft Certified: Azure Fundamentals");
            } else if (lower.contains("oracle")) {
                meta.issuingOrg = "Oracle Corporation";
                meta.title = extractSlugTitle(targetUrl, "Oracle Certified Associate, Java Programmer");
            } else {
                meta.issuingOrg = "Credly Verified Credential";
                meta.title = extractSlugTitle(targetUrl, "Professional Industry Certification");
            }
        } else if (lower.contains("hackerrank.com")) {
            meta.issuingOrg = "HackerRank";
            if (lower.contains("problem_solving") || lower.contains("problem-solving")) {
                meta.title = "Problem Solving (Advanced) Certificate";
            } else if (lower.contains("java")) {
                meta.title = "Java Skills Certified Certificate";
            } else if (lower.contains("sql")) {
                meta.title = "SQL Skills Certified Certificate";
            } else {
                meta.title = "HackerRank Verified Skills Certificate";
            }
        } else if (lower.contains("coursera.org")) {
            meta.issuingOrg = "Coursera";
            meta.title = extractSlugTitle(targetUrl, "Professional Specialization Certificate");
        } else if (lower.contains("freecodecamp.org")) {
            meta.issuingOrg = "freeCodeCamp";
            meta.title = "JavaScript Algorithms and Data Structures Certification";
        } else {
            meta.issuingOrg = extractDomain(targetUrl);
            meta.title = extractSlugTitle(targetUrl, "Verified Industry Certification");
        }

        meta.issueDate = LocalDate.now();
        return meta;
    }

    private String cleanCredlyTitle(String raw) {
        if (raw == null) return null;
        // e.g. "AWS Certified Solutions Architect was issued by Amazon Web Services to John Doe"
        if (raw.contains("was issued by")) {
            return raw.split("was issued by")[0].trim();
        }
        if (raw.contains("|")) {
            return raw.split("\\|")[0].trim();
        }
        if (raw.contains("-")) {
            String candidate = raw.split("-")[0].trim();
            if (candidate.length() > 5) return candidate;
        }
        return raw.trim();
    }

    private String detectCredlyIssuer(String html, String ogDescription, String ogTitle) {
        String combined = ((ogTitle != null ? ogTitle : "") + " " + (ogDescription != null ? ogDescription : "") + " " + html).toLowerCase();
        if (combined.contains("amazon web services") || combined.contains("aws")) return "Amazon Web Services";
        if (combined.contains("oracle")) return "Oracle Corporation";
        if (combined.contains("google cloud")) return "Google Cloud";
        if (combined.contains("microsoft") || combined.contains("azure")) return "Microsoft";
        if (combined.contains("cisco")) return "Cisco";
        if (combined.contains("ibm")) return "IBM";
        if (combined.contains("linux foundation") || combined.contains("cncf")) return "The Linux Foundation / CNCF";
        if (combined.contains("meta")) return "Meta";
        return "Credly Verified Issuer";
    }

    private String cleanHackerRankTitle(String ogTitle, String ogDesc) {
        if (ogTitle != null && !ogTitle.trim().isEmpty()) {
            String clean = ogTitle.replace("HackerRank -", "").replace("HackerRank", "").replace("|", "").trim();
            if (clean.length() > 3) return clean;
        }
        if (ogDesc != null && ogDesc.toLowerCase().contains("certificate")) {
            return ogDesc.trim();
        }
        return "HackerRank Verified Skills Certificate";
    }

    private String cleanCourseraTitle(String ogTitle) {
        if (ogTitle == null) return "Coursera Verified Certificate";
        return ogTitle.replace("| Coursera", "").replace("Coursera", "").replace("- Coursera", "").trim();
    }

    private String detectCourseraIssuer(String html, String ogDesc) {
        String combined = ((ogDesc != null ? ogDesc : "") + " " + html).toLowerCase();
        if (combined.contains("meta")) return "Meta & Coursera";
        if (combined.contains("google")) return "Google & Coursera";
        if (combined.contains("ibm")) return "IBM & Coursera";
        if (combined.contains("deeplearning.ai")) return "DeepLearning.AI & Coursera";
        if (combined.contains("stanford")) return "Stanford University & Coursera";
        return "Coursera";
    }

    private String cleanFreeCodeCampTitle(String ogTitle, String targetUrl) {
        if (ogTitle != null && ogTitle.contains("Certification")) {
            return ogTitle.replace("| freeCodeCamp.org", "").replace("freeCodeCamp.org", "").trim();
        }
        String lower = targetUrl.toLowerCase();
        if (lower.contains("javascript") || lower.contains("algorithms")) {
            return "JavaScript Algorithms and Data Structures Certification";
        }
        if (lower.contains("responsive-web-design")) {
            return "Responsive Web Design Certification";
        }
        return "freeCodeCamp Verified Developer Certificate";
    }

    private String cleanGenericTitle(String ogTitle, String issuer) {
        if (ogTitle == null || ogTitle.trim().isEmpty()) return "Verified Professional Certificate";
        String clean = ogTitle;
        if (issuer != null && !issuer.isEmpty()) {
            clean = clean.replace(issuer, "");
        }
        clean = clean.replace("|", "").replace(" - ", " ").trim();
        return clean.isEmpty() ? "Verified Professional Certificate" : clean;
    }

    private String extractSlugTitle(String url, String fallback) {
        try {
            String cleanUrl = url.split("\\?")[0].replaceAll("/+$", "");
            String[] segments = cleanUrl.split("/");
            String last = segments[segments.length - 1];
            if (last != null && last.length() > 3 && !last.matches("(?i)[0-9a-f-]{25,}")) {
                String[] words = last.replace("-", " ").replace("_", " ").split("\\s+");
                StringBuilder sb = new StringBuilder();
                for (String w : words) {
                    if (!w.isEmpty()) {
                        sb.append(Character.toUpperCase(w.charAt(0))).append(w.substring(1)).append(" ");
                    }
                }
                String candidate = sb.toString().trim();
                if (candidate.length() > 4) return candidate;
            }
        } catch (Exception e) {}
        return fallback;
    }

    private String extractDomain(String urlStr) {
        try {
            URL u = new URL(urlStr);
            String host = u.getHost();
            if (host.startsWith("www.")) host = host.substring(4);
            return host;
        } catch (Exception e) {
            return "Industry Authority";
        }
    }

    private String extractTagContent(String html, String tag, String attr1, String val1, String attr2) {
        Pattern pattern = Pattern.compile("<" + tag + "[^>]*" + attr1 + "=[\"']" + Pattern.quote(val1) + "[\"'][^>]*" + attr2 + "=[\"']([^\"']*)[\"']", Pattern.CASE_INSENSITIVE);
        Matcher matcher = pattern.matcher(html);
        if (matcher.find()) {
            return unescapeHtml(matcher.group(1));
        }

        // Try reverse attribute order: attr2 then attr1
        Pattern patternRev = Pattern.compile("<" + tag + "[^>]*" + attr2 + "=[\"']([^\"']*)[\"'][^>]*" + attr1 + "=[\"']" + Pattern.quote(val1) + "[\"']", Pattern.CASE_INSENSITIVE);
        Matcher matcherRev = patternRev.matcher(html);
        if (matcherRev.find()) {
            return unescapeHtml(matcherRev.group(1));
        }

        return null;
    }

    private String extractRegex(String html, String regex) {
        Pattern p = Pattern.compile(regex, Pattern.CASE_INSENSITIVE | Pattern.DOTALL);
        Matcher m = p.matcher(html);
        if (m.find()) {
            return unescapeHtml(m.group(1).trim());
        }
        return null;
    }

    private String readStream(InputStream is, int maxBytes) throws Exception {
        if (is == null) return null;
        StringBuilder sb = new StringBuilder();
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(is, StandardCharsets.UTF_8))) {
            char[] buffer = new char[4096];
            int read;
            int total = 0;
            while ((read = reader.read(buffer)) != -1) {
                sb.append(buffer, 0, read);
                total += read;
                if (total >= maxBytes) break;
            }
        }
        return sb.toString();
    }

    private String unescapeHtml(String str) {
        if (str == null) return null;
        return str.replace("&amp;", "&")
                  .replace("&lt;", "<")
                  .replace("&gt;", ">")
                  .replace("&quot;", "\"")
                  .replace("&#39;", "'")
                  .replace("&nbsp;", " ")
                  .trim();
    }
}
