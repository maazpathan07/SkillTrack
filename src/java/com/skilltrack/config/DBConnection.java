package com.skilltrack.config;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBConnection {

    private static final Logger LOGGER = Logger.getLogger(DBConnection.class.getName());
    private static final Properties properties = new Properties();

    private static String driver;
    private static String url;
    private static String username;
    private static String password;

    static {
        loadProperties();
    }

    private static synchronized void loadProperties() {
        try (InputStream input = DBConnection.class.getClassLoader().getResourceAsStream("database.properties")) {
            if (input != null) {
                properties.load(input);
                driver = properties.getProperty("db.driver", "com.mysql.cj.jdbc.Driver");
                url = properties.getProperty("db.url", "jdbc:mysql://localhost:3306/skilltrack_db?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true&characterEncoding=UTF-8");
                username = properties.getProperty("db.username", "root");
                password = properties.getProperty("db.password", "");
            } else {
                LOGGER.warning("database.properties not found on classpath, falling back to defaults.");
                driver = "com.mysql.cj.jdbc.Driver";
                url = "jdbc:mysql://localhost:3306/skilltrack_db?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true&characterEncoding=UTF-8";
                username = "root";
                password = "";
            }

            Class.forName(driver);
            LOGGER.info("MySQL JDBC Driver registered successfully: " + driver);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Failed to load database configuration or register JDBC driver", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        if (url == null) {
            loadProperties();
        }
        return DriverManager.getConnection(url, username, password);
    }

    public static void reloadConfiguration() {
        loadProperties();
    }
}
