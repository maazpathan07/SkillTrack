package com.skilltrack.utils;

public final class UrlUtil {

    private UrlUtil() {
    }

    public static boolean isValidHttpUrl(String url) {
        if (url == null || url.trim().isEmpty()) {
            return false;
        }
        String trimmed = url.trim().toLowerCase();
        return trimmed.startsWith("http://") || trimmed.startsWith("https://");
    }

    public static String sanitizeUrl(String url) {
        if (url == null) return null;
        String trimmed = url.trim();
        if (trimmed.isEmpty()) return null;
        if (!isValidHttpUrl(trimmed)) {
            return "https://" + trimmed;
        }
        return trimmed;
    }
}
