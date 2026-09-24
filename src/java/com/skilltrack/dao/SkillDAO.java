package com.skilltrack.dao;

import com.skilltrack.config.DBConnection;
import com.skilltrack.constants.SkillCategory;
import com.skilltrack.constants.SkillLevel;
import com.skilltrack.models.Skill;
import com.skilltrack.models.StudentSkill;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class SkillDAO {

    private static final Logger LOGGER = Logger.getLogger(SkillDAO.class.getName());

    public List<Skill> findAll() throws SQLException {
        String sql = "SELECT skill_id, skill_name, category, description, created_at FROM skills ORDER BY category, skill_name ASC";
        List<Skill> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapResultSetToSkill(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching all skills", e);
            throw e;
        }
        return list;
    }

    public Skill findById(int skillId) throws SQLException {
        String sql = "SELECT skill_id, skill_name, category, description, created_at FROM skills WHERE skill_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, skillId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToSkill(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding skill by ID: " + skillId, e);
            throw e;
        }
        return null;
    }

    public Skill findByName(String skillName) throws SQLException {
        String sql = "SELECT skill_id, skill_name, category, description, created_at FROM skills WHERE LOWER(skill_name) = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, skillName.trim().toLowerCase());
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToSkill(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding skill by name: " + skillName, e);
            throw e;
        }
        return null;
    }

    public int createSkill(Skill skill) throws SQLException {
        String sql = "INSERT INTO skills (skill_name, category, description) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, skill.getSkillName().trim());
            ps.setString(2, skill.getCategory().name());
            ps.setString(3, skill.getDescription());

            int affected = ps.executeUpdate();
            if (affected == 0) {
                throw new SQLException("Creating skill failed, no rows affected.");
            }
            try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    int id = generatedKeys.getInt(1);
                    skill.setSkillId(id);
                    return id;
                } else {
                    throw new SQLException("Creating skill failed, no ID obtained.");
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error creating skill: " + skill.getSkillName(), e);
            throw e;
        }
    }

    public boolean updateSkill(Skill skill) throws SQLException {
        String sql = "UPDATE skills SET skill_name = ?, category = ?, description = ? WHERE skill_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, skill.getSkillName().trim());
            ps.setString(2, skill.getCategory().name());
            ps.setString(3, skill.getDescription());
            ps.setInt(4, skill.getSkillId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating skill ID: " + skill.getSkillId(), e);
            throw e;
        }
    }

    public boolean deleteSkill(int skillId) throws SQLException {
        String sql = "DELETE FROM skills WHERE skill_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, skillId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting skill ID: " + skillId, e);
            throw e;
        }
    }

    public List<StudentSkill> findByStudentId(int studentId) throws SQLException {
        String sql = "SELECT ss.student_skill_id, ss.student_id, ss.skill_id, ss.proficiency_level, " +
                     "s.skill_name, s.category, ss.created_at, ss.updated_at " +
                     "FROM student_skills ss " +
                     "JOIN skills s ON ss.skill_id = s.skill_id " +
                     "WHERE ss.student_id = ? " +
                     "ORDER BY s.category, s.skill_name ASC";
        List<StudentSkill> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    StudentSkill ss = new StudentSkill();
                    ss.setStudentSkillId(rs.getInt("student_skill_id"));
                    ss.setStudentId(rs.getInt("student_id"));
                    ss.setSkillId(rs.getInt("skill_id"));
                    ss.setSkillName(rs.getString("skill_name"));
                    ss.setSkillCategory(SkillCategory.fromString(rs.getString("category")));
                    ss.setProficiencyLevel(SkillLevel.fromString(rs.getString("proficiency_level")));
                    if (rs.getTimestamp("created_at") != null) {
                        ss.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                    }
                    if (rs.getTimestamp("updated_at") != null) {
                        ss.setUpdatedAt(rs.getTimestamp("updated_at").toLocalDateTime());
                    }
                    list.add(ss);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching student skills for student ID: " + studentId, e);
            throw e;
        }
        return list;
    }

    public StudentSkill findStudentSkill(int studentId, int skillId) throws SQLException {
        String sql = "SELECT ss.student_skill_id, ss.student_id, ss.skill_id, ss.proficiency_level, " +
                     "s.skill_name, s.category, ss.created_at, ss.updated_at " +
                     "FROM student_skills ss " +
                     "JOIN skills s ON ss.skill_id = s.skill_id " +
                     "WHERE ss.student_id = ? AND ss.skill_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            ps.setInt(2, skillId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    StudentSkill ss = new StudentSkill();
                    ss.setStudentSkillId(rs.getInt("student_skill_id"));
                    ss.setStudentId(rs.getInt("student_id"));
                    ss.setSkillId(rs.getInt("skill_id"));
                    ss.setSkillName(rs.getString("skill_name"));
                    ss.setSkillCategory(SkillCategory.fromString(rs.getString("category")));
                    ss.setProficiencyLevel(SkillLevel.fromString(rs.getString("proficiency_level")));
                    return ss;
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching student skill for student " + studentId + ", skill " + skillId, e);
            throw e;
        }
        return null;
    }

    public boolean upsertStudentSkill(int studentId, int skillId, SkillLevel level) throws SQLException {
        String sql = "INSERT INTO student_skills (student_id, skill_id, proficiency_level) VALUES (?, ?, ?) " +
                     "ON DUPLICATE KEY UPDATE proficiency_level = VALUES(proficiency_level)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            ps.setInt(2, skillId);
            ps.setString(3, level.name());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error upserting student skill: student " + studentId + ", skill " + skillId, e);
            throw e;
        }
    }

    public boolean deleteStudentSkill(int studentId, int skillId) throws SQLException {
        String sql = "DELETE FROM student_skills WHERE student_id = ? AND skill_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            ps.setInt(2, skillId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting student skill: student " + studentId + ", skill " + skillId, e);
            throw e;
        }
    }

    private Skill mapResultSetToSkill(ResultSet rs) throws SQLException {
        Skill s = new Skill();
        s.setSkillId(rs.getInt("skill_id"));
        s.setSkillName(rs.getString("skill_name"));
        s.setCategory(SkillCategory.fromString(rs.getString("category")));
        s.setDescription(rs.getString("description"));
        if (rs.getTimestamp("created_at") != null) {
            s.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
        }
        return s;
    }
}
