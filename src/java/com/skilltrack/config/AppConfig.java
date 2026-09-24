package com.skilltrack.config;

import java.io.InputStream;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

public class AppConfig {

    private static final Logger LOGGER = Logger.getLogger(AppConfig.class.getName());
    private static final Properties config = new Properties();

    static {
        loadConfig();
    }

    private static void loadConfig() {
        try (InputStream input = AppConfig.class.getClassLoader().getResourceAsStream("database.properties")) {
            if (input != null) {
                config.load(input);
            }
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Unable to load configuration", e);
        }
    }

    public static String getProperty(String key, String defaultValue) {
        return config.getProperty(key, defaultValue);
    }

    public static int getIntProperty(String key, int defaultValue) {
        String val = config.getProperty(key);
        if (val == null) return defaultValue;
        try {
            return Integer.parseInt(val.trim());
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }
}
