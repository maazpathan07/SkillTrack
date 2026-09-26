package com.skilltrack.dao;

import com.skilltrack.config.DBConnection;
import com.skilltrack.models.CustomJdEvaluation;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CustomJdEvaluationDAO {

    private static final Logger LOGGER = Logger.getLogger(CustomJdEvaluationDAO.class.getName());

    public int saveEvaluation(CustomJdEvaluation eval) throws SQLException {
        String sql = "INSERT INTO custom_jd_evaluations " +
                     "(student_id, target_company, target_role, source_type, source_url, raw_jd_text, " +
                     " overall_match_score, dsa_score, project_score, cert_score, skill_score, academic_score, " +
                     " matched_skills_json, missing_skills_json, action_items_json) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, eval.getStudentId());
            ps.setString(2, eval.getTargetCompany());
            ps.setString(3, eval.getTargetRole());
            ps.setString(4, eval.getSourceType() != null ? eval.getSourceType() : "CUSTOM_PASTE");
            ps.setString(5, eval.getSourceUrl());
            ps.setString(6, eval.getRawJdText());
            ps.setInt(7, eval.getOverallMatchScore());
            ps.setInt(8, eval.getDsaScore());
            ps.setInt(9, eval.getProjectScore());
            ps.setInt(10, eval.getCertScore());
            ps.setInt(11, eval.getSkillScore());
            ps.setInt(12, eval.getAcademicScore());
            ps.setString(13, eval.getMatchedSkillsJson());
            ps.setString(14, eval.getMissingSkillsJson());
            ps.setString(15, eval.getActionItemsJson());

            int affected = ps.executeUpdate();
            if (affected == 0) {
                throw new SQLException("Saving evaluation failed, no rows affected.");
            }
            try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    int id = generatedKeys.getInt(1);
                    eval.setEvalId(id);
                    return id;
                } else {
                    throw new SQLException("Saving evaluation failed, no ID obtained.");
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error saving custom JD evaluation for student: " + eval.getStudentId(), e);
            throw e;
        }
    }

    public List<CustomJdEvaluation> findRecentByStudentId(int studentId, int limit) {
        String sql = "SELECT eval_id, student_id, target_company, target_role, source_type, source_url, raw_jd_text, " +
                     "overall_match_score, dsa_score, project_score, cert_score, skill_score, academic_score, " +
                     "matched_skills_json, missing_skills_json, action_items_json, evaluated_at " +
                     "FROM custom_jd_evaluations WHERE student_id = ? ORDER BY evaluated_at DESC LIMIT ?";
        List<CustomJdEvaluation> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            ps.setInt(2, limit > 0 ? limit : 10);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToEvaluation(rs));
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching recent JD evaluations for student: " + studentId, e);
        }
        return list;
    }

    public CustomJdEvaluation findById(int evalId, int studentId) {
        String sql = "SELECT eval_id, student_id, target_company, target_role, source_type, source_url, raw_jd_text, " +
                     "overall_match_score, dsa_score, project_score, cert_score, skill_score, academic_score, " +
                     "matched_skills_json, missing_skills_json, action_items_json, evaluated_at " +
                     "FROM custom_jd_evaluations WHERE eval_id = ? AND student_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, evalId);
            ps.setInt(2, studentId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToEvaluation(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching JD evaluation by ID: " + evalId + " for student: " + studentId, e);
        }
        return null;
    }

    public boolean deleteEvaluation(int evalId, int studentId) throws SQLException {
        String sql = "DELETE FROM custom_jd_evaluations WHERE eval_id = ? AND student_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, evalId);
            ps.setInt(2, studentId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting JD evaluation " + evalId + " for student " + studentId, e);
            throw e;
        }
    }

    private CustomJdEvaluation mapResultSetToEvaluation(ResultSet rs) throws SQLException {
        CustomJdEvaluation e = new CustomJdEvaluation();
        e.setEvalId(rs.getInt("eval_id"));
        e.setStudentId(rs.getInt("student_id"));
        e.setTargetCompany(rs.getString("target_company"));
        e.setTargetRole(rs.getString("target_role"));
        e.setSourceType(rs.getString("source_type"));
        e.setSourceUrl(rs.getString("source_url"));
        e.setRawJdText(rs.getString("raw_jd_text"));
        e.setOverallMatchScore(rs.getInt("overall_match_score"));
        e.setDsaScore(rs.getInt("dsa_score"));
        e.setProjectScore(rs.getInt("project_score"));
        e.setCertScore(rs.getInt("cert_score"));
        e.setSkillScore(rs.getInt("skill_score"));
        e.setAcademicScore(rs.getInt("academic_score"));
        e.setMatchedSkillsJson(rs.getString("matched_skills_json"));
        e.setMissingSkillsJson(rs.getString("missing_skills_json"));
        e.setActionItemsJson(rs.getString("action_items_json"));
        Timestamp ts = rs.getTimestamp("evaluated_at");
        if (ts != null) {
            e.setEvaluatedAt(ts.toLocalDateTime());
        }
        return e;
    }
}
