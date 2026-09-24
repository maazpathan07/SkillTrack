package com.skilltrack.dao;

import com.skilltrack.config.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

public class SettingsDAO {

    private static final Logger LOGGER = Logger.getLogger(SettingsDAO.class.getName());

    public Map<String, String> getAllSettings() throws SQLException {
        String sql = "SELECT setting_key, setting_value FROM app_settings";
        Map<String, String> map = new HashMap<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                map.put(rs.getString("setting_key"), rs.getString("setting_value"));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching app settings", e);
            throw e;
        }
        return map;
    }

    public String getSetting(String key, String defaultValue) {
        String sql = "SELECT setting_value FROM app_settings WHERE setting_key = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, key);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("setting_value");
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.WARNING, "Error reading setting: " + key + ", using default: " + defaultValue, e);
        }
        return defaultValue;
    }

    public double getDoubleSetting(String key, double defaultValue) {
        String val = getSetting(key, String.valueOf(defaultValue));
        try {
            return Double.parseDouble(val.trim());
        } catch (Exception e) {
            return defaultValue;
        }
    }

    public int getIntSetting(String key, int defaultValue) {
        String val = getSetting(key, String.valueOf(defaultValue));
        try {
            return Integer.parseInt(val.trim());
        } catch (Exception e) {
            return defaultValue;
        }
    }

    public boolean updateSetting(String key, String value) throws SQLException {
        String sql = "INSERT INTO app_settings (setting_key, setting_value) VALUES (?, ?) " +
                     "ON DUPLICATE KEY UPDATE setting_value = VALUES(setting_value)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, key);
            ps.setString(2, value);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating setting: " + key, e);
            throw e;
        }
    }
}
