package com.skilltrack.dao;

import com.skilltrack.config.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

public class AnalyticsDAO {

    private static final Logger LOGGER = Logger.getLogger(AnalyticsDAO.class.getName());

    public int getTotalStudents() throws SQLException {
        String sql = "SELECT COUNT(*) FROM students";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error counting total students", e);
            throw e;
        }
        return 0;
    }

    public int getTotalRoles() throws SQLException {
        String sql = "SELECT COUNT(*) FROM target_roles WHERE is_active = 1";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error counting active roles", e);
            throw e;
        }
        return 0;
    }

    public int getTotalSkills() throws SQLException {
        String sql = "SELECT COUNT(*) FROM skills";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error counting total skills", e);
            throw e;
        }
        return 0;
    }

    public int getTotalCriteria() throws SQLException {
        String sql = "SELECT COUNT(*) FROM placement_criteria WHERE is_active = 1";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error counting active criteria", e);
            throw e;
        }
        return 0;
    }

    public Map<String, Integer> getDepartmentDistribution() throws SQLException {
        String sql = "SELECT department, COUNT(*) AS count FROM students GROUP BY department ORDER BY count DESC";
        Map<String, Integer> map = new LinkedHashMap<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                map.put(rs.getString("department"), rs.getInt("count"));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching department distribution", e);
            throw e;
        }
        return map;
    }

    public Map<String, Integer> getRoleDistribution() throws SQLException {
        String sql = "SELECT COALESCE(tr.role_title, 'Not Set') AS role_title, COUNT(s.student_id) AS count " +
                     "FROM students s " +
                     "LEFT JOIN target_roles tr ON s.target_role_id = tr.role_id " +
                     "GROUP BY role_title ORDER BY count DESC";
        Map<String, Integer> map = new LinkedHashMap<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                map.put(rs.getString("role_title"), rs.getInt("count"));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching role distribution", e);
            throw e;
        }
        return map;
    }

    public double getAverageCgpa() throws SQLException {
        String sql = "SELECT COALESCE(AVG(cgpa), 0.0) FROM students";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error calculating average CGPA", e);
            throw e;
        }
        return 0.0;
    }

    public Map<String, Double> getDepartmentAverageCgpa() throws SQLException {
        String sql = "SELECT department, COALESCE(AVG(cgpa), 0.0) AS avg_cgpa FROM students GROUP BY department";
        Map<String, Double> map = new HashMap<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                map.put(rs.getString("department"), rs.getDouble("avg_cgpa"));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching department avg CGPA", e);
            throw e;
        }
        return map;
    }
}
