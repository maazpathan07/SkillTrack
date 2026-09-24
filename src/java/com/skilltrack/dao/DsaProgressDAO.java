package com.skilltrack.dao;

import com.skilltrack.config.DBConnection;
import com.skilltrack.constants.TopicCategory;
import com.skilltrack.models.DsaTopic;
import com.skilltrack.models.StudentDsaProgress;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DsaProgressDAO {

    private static final Logger LOGGER = Logger.getLogger(DsaProgressDAO.class.getName());

    public List<DsaTopic> getAllTopics() throws SQLException {
        String sql = "SELECT topic_id, topic_name, category, created_at FROM dsa_topics ORDER BY topic_id ASC";
        List<DsaTopic> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                DsaTopic t = new DsaTopic();
                t.setTopicId(rs.getInt("topic_id"));
                t.setTopicName(rs.getString("topic_name"));
                t.setCategory(TopicCategory.fromString(rs.getString("category")));
                if (rs.getTimestamp("created_at") != null) {
                    t.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                }
                list.add(t);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching all DSA topics", e);
            throw e;
        }
        return list;
    }

    public List<StudentDsaProgress> getStudentDsaProgress(int studentId) throws SQLException {
        String sql = "SELECT t.topic_id, t.topic_name, t.category, " +
                     "COALESCE(p.progress_id, 0) AS progress_id, " +
                     "COALESCE(p.status, 'NOT_STARTED') AS status, " +
                     "COALESCE(p.problems_solved, 0) AS problems_solved, " +
                     "p.notes, p.updated_at " +
                     "FROM dsa_topics t " +
                     "LEFT JOIN student_dsa_progress p ON t.topic_id = p.topic_id AND p.student_id = ? " +
                     "ORDER BY t.topic_id ASC";
        List<StudentDsaProgress> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    StudentDsaProgress sp = new StudentDsaProgress();
                    sp.setTopicId(rs.getInt("topic_id"));
                    sp.setTopicName(rs.getString("topic_name"));
                    sp.setTopicCategory(TopicCategory.fromString(rs.getString("category")));
                    sp.setProgressId(rs.getInt("progress_id"));
                    sp.setStudentId(studentId);
                    sp.setStatus(rs.getString("status"));
                    sp.setProblemsSolved(rs.getInt("problems_solved"));
                    sp.setNotes(rs.getString("notes"));
                    if (rs.getTimestamp("updated_at") != null) {
                        sp.setUpdatedAt(rs.getTimestamp("updated_at").toLocalDateTime());
                    }
                    list.add(sp);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching student DSA progress for student ID: " + studentId, e);
            throw e;
        }
        return list;
    }

    public boolean upsertProgress(int studentId, int topicId, String status, int problemsSolved, String notes) throws SQLException {
        String sql = "INSERT INTO student_dsa_progress (student_id, topic_id, status, problems_solved, notes) " +
                     "VALUES (?, ?, ?, ?, ?) " +
                     "ON DUPLICATE KEY UPDATE status = VALUES(status), problems_solved = VALUES(problems_solved), notes = VALUES(notes)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            ps.setInt(2, topicId);
            ps.setString(3, status != null ? status : "NOT_STARTED");
            ps.setInt(4, Math.max(0, problemsSolved));
            ps.setString(5, notes != null ? notes.trim() : null);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error upserting DSA progress for student " + studentId + ", topic " + topicId, e);
            throw e;
        }
    }

    public int getTotalProblemsSolved(int studentId) throws SQLException {
        String sql = "SELECT COALESCE(SUM(problems_solved), 0) FROM student_dsa_progress WHERE student_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting total DSA problems solved for student: " + studentId, e);
            throw e;
        }
        return 0;
    }

    public int getCompletedTopicsCount(int studentId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM student_dsa_progress WHERE student_id = ? AND status = 'COMPLETED'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error counting completed DSA topics for student: " + studentId, e);
            throw e;
        }
        return 0;
    }
}
