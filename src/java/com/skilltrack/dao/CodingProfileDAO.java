package com.skilltrack.dao;

import com.skilltrack.config.DBConnection;
import com.skilltrack.models.StudentCodingProfile;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CodingProfileDAO {

    private static final Logger LOGGER = Logger.getLogger(CodingProfileDAO.class.getName());
    private static volatile boolean tableInitialized = false;

    public CodingProfileDAO() {
        ensureTableExists();
    }

    private synchronized void ensureTableExists() {
        if (tableInitialized) return;
        String sql = "CREATE TABLE IF NOT EXISTS student_coding_profiles (" +
                     "    student_id INT PRIMARY KEY," +
                     "    leetcode_username VARCHAR(100) NULL," +
                     "    leetcode_total_solved INT NOT NULL DEFAULT 0," +
                     "    leetcode_easy_solved INT NOT NULL DEFAULT 0," +
                     "    leetcode_medium_solved INT NOT NULL DEFAULT 0," +
                     "    leetcode_hard_solved INT NOT NULL DEFAULT 0," +
                     "    leetcode_ranking INT NOT NULL DEFAULT 0," +
                     "    leetcode_contest_rating VARCHAR(50) NULL," +
                     "    leetcode_synced_at DATETIME NULL," +
                     "    github_username VARCHAR(100) NULL," +
                     "    github_repos_count INT NOT NULL DEFAULT 0," +
                     "    github_followers INT NOT NULL DEFAULT 0," +
                     "    github_bio TEXT NULL," +
                     "    github_avatar_url VARCHAR(255) NULL," +
                     "    github_profile_url VARCHAR(255) NULL," +
                     "    github_synced_at DATETIME NULL," +
                     "    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP," +
                     "    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP," +
                     "    CONSTRAINT fk_coding_prof_student FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE" +
                     ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;";

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement()) {
            stmt.executeUpdate(sql);
            tableInitialized = true;
        } catch (SQLException e) {
            LOGGER.log(Level.WARNING, "Notice: Table check/creation for student_coding_profiles: " + e.getMessage());
            tableInitialized = true; // Avoid retry loop
        }
    }

    public StudentCodingProfile findByStudentId(int studentId) throws SQLException {
        String sql = "SELECT student_id, leetcode_username, leetcode_total_solved, leetcode_easy_solved, " +
                     "leetcode_medium_solved, leetcode_hard_solved, leetcode_ranking, leetcode_contest_rating, " +
                     "leetcode_synced_at, github_username, github_repos_count, github_followers, github_bio, " +
                     "github_avatar_url, github_profile_url, github_synced_at, created_at, updated_at " +
                     "FROM student_coding_profiles WHERE student_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToProfile(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding coding profile for student: " + studentId, e);
            throw e;
        }
        return null;
    }

    public boolean saveOrUpdate(StudentCodingProfile profile) throws SQLException {
        if (profile == null || profile.getStudentId() <= 0) return false;

        String sql = "INSERT INTO student_coding_profiles (" +
                     "    student_id, leetcode_username, leetcode_total_solved, leetcode_easy_solved, " +
                     "    leetcode_medium_solved, leetcode_hard_solved, leetcode_ranking, leetcode_contest_rating, " +
                     "    leetcode_synced_at, github_username, github_repos_count, github_followers, " +
                     "    github_bio, github_avatar_url, github_profile_url, github_synced_at" +
                     ") VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) " +
                     "ON DUPLICATE KEY UPDATE " +
                     "    leetcode_username = VALUES(leetcode_username), " +
                     "    leetcode_total_solved = VALUES(leetcode_total_solved), " +
                     "    leetcode_easy_solved = VALUES(leetcode_easy_solved), " +
                     "    leetcode_medium_solved = VALUES(leetcode_medium_solved), " +
                     "    leetcode_hard_solved = VALUES(leetcode_hard_solved), " +
                     "    leetcode_ranking = VALUES(leetcode_ranking), " +
                     "    leetcode_contest_rating = VALUES(leetcode_contest_rating), " +
                     "    leetcode_synced_at = VALUES(leetcode_synced_at), " +
                     "    github_username = VALUES(github_username), " +
                     "    github_repos_count = VALUES(github_repos_count), " +
                     "    github_followers = VALUES(github_followers), " +
                     "    github_bio = VALUES(github_bio), " +
                     "    github_avatar_url = VALUES(github_avatar_url), " +
                     "    github_profile_url = VALUES(github_profile_url), " +
                     "    github_synced_at = VALUES(github_synced_at)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, profile.getStudentId());
            ps.setString(2, profile.getLeetcodeUsername());
            ps.setInt(3, profile.getLeetcodeTotalSolved());
            ps.setInt(4, profile.getLeetcodeEasySolved());
            ps.setInt(5, profile.getLeetcodeMediumSolved());
            ps.setInt(6, profile.getLeetcodeHardSolved());
            ps.setInt(7, profile.getLeetcodeRanking());
            ps.setString(8, profile.getLeetcodeContestRating());
            ps.setTimestamp(9, profile.getLeetcodeSyncedAt() != null ? Timestamp.valueOf(profile.getLeetcodeSyncedAt()) : null);

            ps.setString(10, profile.getGithubUsername());
            ps.setInt(11, profile.getGithubReposCount());
            ps.setInt(12, profile.getGithubFollowers());
            ps.setString(13, profile.getGithubBio());
            ps.setString(14, profile.getGithubAvatarUrl());
            ps.setString(15, profile.getGithubProfileUrl());
            ps.setTimestamp(16, profile.getGithubSyncedAt() != null ? Timestamp.valueOf(profile.getGithubSyncedAt()) : null);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error saving/updating coding profile for student " + profile.getStudentId(), e);
            throw e;
        }
    }

    private StudentCodingProfile mapResultSetToProfile(ResultSet rs) throws SQLException {
        StudentCodingProfile p = new StudentCodingProfile();
        p.setStudentId(rs.getInt("student_id"));
        p.setLeetcodeUsername(rs.getString("leetcode_username"));
        p.setLeetcodeTotalSolved(rs.getInt("leetcode_total_solved"));
        p.setLeetcodeEasySolved(rs.getInt("leetcode_easy_solved"));
        p.setLeetcodeMediumSolved(rs.getInt("leetcode_medium_solved"));
        p.setLeetcodeHardSolved(rs.getInt("leetcode_hard_solved"));
        p.setLeetcodeRanking(rs.getInt("leetcode_ranking"));
        p.setLeetcodeContestRating(rs.getString("leetcode_contest_rating"));

        Timestamp lcSync = rs.getTimestamp("leetcode_synced_at");
        if (lcSync != null) p.setLeetcodeSyncedAt(lcSync.toLocalDateTime());

        p.setGithubUsername(rs.getString("github_username"));
        p.setGithubReposCount(rs.getInt("github_repos_count"));
        p.setGithubFollowers(rs.getInt("github_followers"));
        p.setGithubBio(rs.getString("github_bio"));
        p.setGithubAvatarUrl(rs.getString("github_avatar_url"));
        p.setGithubProfileUrl(rs.getString("github_profile_url"));

        Timestamp ghSync = rs.getTimestamp("github_synced_at");
        if (ghSync != null) p.setGithubSyncedAt(ghSync.toLocalDateTime());

        Timestamp cat = rs.getTimestamp("created_at");
        if (cat != null) p.setCreatedAt(cat.toLocalDateTime());

        Timestamp uat = rs.getTimestamp("updated_at");
        if (uat != null) p.setUpdatedAt(uat.toLocalDateTime());

        return p;
    }
}
