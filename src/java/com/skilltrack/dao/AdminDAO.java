package com.skilltrack.dao;

import com.skilltrack.config.DBConnection;
import com.skilltrack.models.Admin;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class AdminDAO {

    private static final Logger LOGGER = Logger.getLogger(AdminDAO.class.getName());

    public Admin findByUserId(int userId) throws SQLException {
        String sql = "SELECT a.admin_id, a.user_id, a.full_name, u.email, a.created_at, a.updated_at " +
                     "FROM admins a JOIN users u ON a.user_id = u.user_id " +
                     "WHERE a.user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Admin admin = new Admin();
                    admin.setAdminId(rs.getInt("admin_id"));
                    admin.setUserId(rs.getInt("user_id"));
                    admin.setFullName(rs.getString("full_name"));
                    admin.setEmail(rs.getString("email"));
                    if (rs.getTimestamp("created_at") != null) {
                        admin.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                    }
                    if (rs.getTimestamp("updated_at") != null) {
                        admin.setUpdatedAt(rs.getTimestamp("updated_at").toLocalDateTime());
                    }
                    return admin;
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding admin by userId: " + userId, e);
            throw e;
        }
        return null;
    }
}
