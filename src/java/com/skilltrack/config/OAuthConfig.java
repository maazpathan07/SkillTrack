package com.skilltrack.config;

import com.skilltrack.constants.OAuthProvider;
import java.io.InputStream;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

public class OAuthConfig {

    private static final Logger LOGGER = Logger.getLogger(OAuthConfig.class.getName());
    private static final Properties properties = new Properties();

    static {
        loadProperties();
    }

    public static synchronized void loadProperties() {
        try (InputStream input = OAuthConfig.class.getClassLoader().getResourceAsStream("oauth.properties")) {
            if (input != null) {
                properties.load(input);
                LOGGER.info("oauth.properties loaded successfully.");
            } else {
                LOGGER.info("oauth.properties not found on classpath. Using environment variables / defaults.");
            }
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Error loading oauth.properties", e);
        }
    }

    public static String getClientId(OAuthProvider provider) {
        String key = provider.name().toLowerCase() + ".client.id";
        String val = properties.getProperty(key);
        if (val == null || val.trim().isEmpty()) {
            val = System.getenv("OAUTH_" + provider.name() + "_CLIENT_ID");
        }
        return val != null ? val.trim() : "";
    }

    public static String getClientSecret(OAuthProvider provider) {
        String key = provider.name().toLowerCase() + ".client.secret";
        String val = properties.getProperty(key);
        if (val == null || val.trim().isEmpty()) {
            val = System.getenv("OAUTH_" + provider.name() + "_CLIENT_SECRET");
        }
        return val != null ? val.trim() : "";
    }

    public static String getRedirectUri(OAuthProvider provider, String fallbackUri) {
        if (fallbackUri != null && !fallbackUri.trim().isEmpty()) {
            return fallbackUri.trim();
        }
        String key = provider.name().toLowerCase() + ".redirect.uri";
        String val = properties.getProperty(key);
        if (val != null && !val.trim().isEmpty()) {
            return val.trim();
        }
        return fallbackUri;
    }

    public static boolean isProviderConfigured(OAuthProvider provider) {
        String clientId = getClientId(provider);
        String clientSecret = getClientSecret(provider);
        return clientId != null && !clientId.isEmpty() && !clientId.startsWith("YOUR_")
                && clientSecret != null && !clientSecret.isEmpty() && !clientSecret.startsWith("YOUR_");
    }
}
