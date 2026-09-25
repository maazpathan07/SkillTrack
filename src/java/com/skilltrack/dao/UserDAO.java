package com.skilltrack.dao;

import com.skilltrack.config.DBConnection;
import com.skilltrack.constants.OAuthProvider;
import com.skilltrack.constants.UserRole;
import com.skilltrack.models.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

public class UserDAO {

    private static final Logger LOGGER = Logger.getLogger(UserDAO.class.getName());
    private static volatile boolean schemaMigrated = false;

    public UserDAO() {
        ensureOAuthSchema();
    }

    private static synchronized void ensureOAuthSchema() {
        if (schemaMigrated) return;
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement()) {
            try {
                stmt.executeUpdate("ALTER TABLE users ADD COLUMN oauth_provider VARCHAR(20) NOT NULL DEFAULT 'LOCAL'");
            } catch (SQLException ignored) {}
            try {
                stmt.executeUpdate("ALTER TABLE users ADD COLUMN oauth_id VARCHAR(100) NULL");
            } catch (SQLException ignored) {}
            try {
                stmt.executeUpdate("ALTER TABLE users MODIFY password_hash VARCHAR(255) NULL");
            } catch (SQLException ignored) {}
            try {
                stmt.executeUpdate("ALTER TABLE users MODIFY salt VARCHAR(64) NULL");
            } catch (SQLException ignored) {}
            schemaMigrated = true;
        } catch (Exception e) {
            LOGGER.log(Level.FINE, "OAuth schema check note: " + e.getMessage());
        }
    }

    public User findByEmail(String email) throws SQLException {
        String sql = "SELECT user_id, email, password_hash, salt, role, is_active, oauth_provider, oauth_id, created_at, updated_at " +
                     "FROM users WHERE email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email.trim().toLowerCase());
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }
        } catch (SQLException e) {
            // Fallback for query without oauth columns if needed
            return findByEmailLegacy(email);
        }
        return null;
    }

    private User findByEmailLegacy(String email) throws SQLException {
        String sql = "SELECT user_id, email, password_hash, salt, role, is_active, created_at, updated_at " +
                     "FROM users WHERE email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email.trim().toLowerCase());
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding user by email: " + email, e);
            throw e;
        }
        return null;
    }

    public User findByOAuth(OAuthProvider provider, String oauthId) throws SQLException {
        if (provider == null || oauthId == null || oauthId.trim().isEmpty()) return null;
        String sql = "SELECT user_id, email, password_hash, salt, role, is_active, oauth_provider, oauth_id, created_at, updated_at " +
                     "FROM users WHERE oauth_provider = ? AND oauth_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, provider.name());
            ps.setString(2, oauthId.trim());
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.FINE, "Error querying user by OAuth: " + e.getMessage());
        }
        return null;
    }

    public User findById(int userId) throws SQLException {
        String sql = "SELECT user_id, email, password_hash, salt, role, is_active, oauth_provider, oauth_id, created_at, updated_at " +
                     "FROM users WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding user by ID: " + userId, e);
            throw e;
        }
        return null;
    }

    public int createUser(User user, Connection conn) throws SQLException {
        String sql = "INSERT INTO users (email, password_hash, salt, role, is_active, oauth_provider, oauth_id) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, user.getEmail().trim().toLowerCase());
            ps.setString(2, user.getPasswordHash());
            ps.setString(3, user.getSalt());
            ps.setString(4, user.getRole().name());
            ps.setInt(5, user.isActive() ? 1 : 0);
            ps.setString(6, user.getOAuthProvider() != null ? user.getOAuthProvider().name() : "LOCAL");
            ps.setString(7, user.getOAuthId());

            int affected = ps.executeUpdate();
            if (affected == 0) {
                throw new SQLException("Creating user failed, no rows affected.");
            }

            try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    int id = generatedKeys.getInt(1);
                    user.setUserId(id);
                    return id;
                } else {
                    throw new SQLException("Creating user failed, no ID obtained.");
                }
            }
        } catch (SQLException e) {
            // Fallback for legacy insert if columns not yet active
            return createUserLegacy(user, conn);
        }
    }

    private int createUserLegacy(User user, Connection conn) throws SQLException {
        String sql = "INSERT INTO users (email, password_hash, salt, role, is_active) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, user.getEmail().trim().toLowerCase());
            ps.setString(2, user.getPasswordHash() != null ? user.getPasswordHash() : "");
            ps.setString(3, user.getSalt() != null ? user.getSalt() : "");
            ps.setString(4, user.getRole().name());
            ps.setInt(5, user.isActive() ? 1 : 0);

            int affected = ps.executeUpdate();
            if (affected == 0) {
                throw new SQLException("Creating user failed, no rows affected.");
            }

            try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    int id = generatedKeys.getInt(1);
                    user.setUserId(id);
                    return id;
                } else {
                    throw new SQLException("Creating user failed, no ID obtained.");
                }
            }
        }
    }

    public void updateOAuthInfo(int userId, OAuthProvider provider, String oauthId) throws SQLException {
        String sql = "UPDATE users SET oauth_provider = ?, oauth_id = ? WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, provider != null ? provider.name() : "LOCAL");
            ps.setString(2, oauthId);
            ps.setInt(3, userId);
            ps.executeUpdate();
        } catch (SQLException e) {
            LOGGER.log(Level.WARNING, "Error updating OAuth info for user: " + userId, e);
        }
    }

    public boolean emailExists(String email) throws SQLException {
        String sql = "SELECT 1 FROM users WHERE email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email.trim().toLowerCase());
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error checking email existence: " + email, e);
            throw e;
        }
    }

    private User mapResultSetToUser(ResultSet rs) throws SQLException {
        User user = new User();
        user.setUserId(rs.getInt("user_id"));
        user.setEmail(rs.getString("email"));
        user.setPasswordHash(rs.getString("password_hash"));
        user.setSalt(rs.getString("salt"));
        user.setRole(UserRole.fromString(rs.getString("role")));
        user.setActive(rs.getInt("is_active") == 1);

        try {
            String op = rs.getString("oauth_provider");
            user.setOAuthProvider(OAuthProvider.fromString(op));
            user.setOAuthId(rs.getString("oauth_id"));
        } catch (SQLException ignored) {
            user.setOAuthProvider(OAuthProvider.LOCAL);
        }

        if (rs.getTimestamp("created_at") != null) {
            user.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
        }
        if (rs.getTimestamp("updated_at") != null) {
            user.setUpdatedAt(rs.getTimestamp("updated_at").toLocalDateTime());
        }
        return user;
    }
}
