package com.skilltrack.dao;

import com.skilltrack.config.DBConnection;
import com.skilltrack.constants.SkillCategory;
import com.skilltrack.constants.SkillLevel;
import com.skilltrack.models.CriteriaSkillRequirement;
import com.skilltrack.models.PlacementCriteria;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class PlacementCriteriaDAO {

    private static final Logger LOGGER = Logger.getLogger(PlacementCriteriaDAO.class.getName());

    public List<PlacementCriteria> findAll(boolean activeOnly) throws SQLException {
        String sql = "SELECT criteria_id, company_name, role_title, min_cgpa, min_dsa_problems, " +
                     "min_projects, min_certifications, allowed_departments, is_active, created_at, updated_at " +
                     "FROM placement_criteria " +
                     (activeOnly ? "WHERE is_active = 1 " : "") +
                     "ORDER BY company_name, role_title ASC";
        List<PlacementCriteria> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapResultSetToCriteria(rs));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching placement criteria", e);
            throw e;
        }
        return list;
    }

    public PlacementCriteria findById(int criteriaId) throws SQLException {
        String sql = "SELECT criteria_id, company_name, role_title, min_cgpa, min_dsa_problems, " +
                     "min_projects, min_certifications, allowed_departments, is_active, created_at, updated_at " +
                     "FROM placement_criteria WHERE criteria_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, criteriaId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    PlacementCriteria c = mapResultSetToCriteria(rs);
                    c.setSkillRequirements(getCriteriaRequirements(criteriaId));
                    return c;
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding placement criteria by ID: " + criteriaId, e);
            throw e;
        }
        return null;
    }

    public int createCriteria(PlacementCriteria c) throws SQLException {
        String sql = "INSERT INTO placement_criteria (company_name, role_title, min_cgpa, min_dsa_problems, min_projects, min_certifications, allowed_departments, is_active) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, c.getCompanyName().trim());
            ps.setString(2, c.getRoleTitle().trim());
            ps.setDouble(3, c.getMinCgpa());
            ps.setInt(4, c.getMinDsaProblems());
            ps.setInt(5, c.getMinProjects());
            ps.setInt(6, c.getMinCertifications());
            ps.setString(7, c.getAllowedDepartments() != null ? c.getAllowedDepartments().trim() : "ALL");
            ps.setInt(8, c.isActive() ? 1 : 0);

            int affected = ps.executeUpdate();
            if (affected == 0) {
                throw new SQLException("Creating criteria failed, no rows affected.");
            }
            try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    int id = generatedKeys.getInt(1);
                    c.setCriteriaId(id);
                    return id;
                } else {
                    throw new SQLException("Creating criteria failed, no ID obtained.");
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error creating placement criteria: " + c.getCompanyName(), e);
            throw e;
        }
    }

    public boolean updateCriteria(PlacementCriteria c) throws SQLException {
        String sql = "UPDATE placement_criteria SET company_name = ?, role_title = ?, min_cgpa = ?, " +
                     "min_dsa_problems = ?, min_projects = ?, min_certifications = ?, allowed_departments = ?, is_active = ? " +
                     "WHERE criteria_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, c.getCompanyName().trim());
            ps.setString(2, c.getRoleTitle().trim());
            ps.setDouble(3, c.getMinCgpa());
            ps.setInt(4, c.getMinDsaProblems());
            ps.setInt(5, c.getMinProjects());
            ps.setInt(6, c.getMinCertifications());
            ps.setString(7, c.getAllowedDepartments() != null ? c.getAllowedDepartments().trim() : "ALL");
            ps.setInt(8, c.isActive() ? 1 : 0);
            ps.setInt(9, c.getCriteriaId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating placement criteria ID: " + c.getCriteriaId(), e);
            throw e;
        }
    }

    public boolean deleteCriteria(int criteriaId) throws SQLException {
        String sql = "DELETE FROM placement_criteria WHERE criteria_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, criteriaId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting placement criteria ID: " + criteriaId, e);
            throw e;
        }
    }

    public List<CriteriaSkillRequirement> getCriteriaRequirements(int criteriaId) throws SQLException {
        String sql = "SELECT csr.requirement_id, csr.criteria_id, csr.skill_id, csr.min_proficiency, csr.is_mandatory, " +
                     "s.skill_name, s.category, csr.created_at " +
                     "FROM criteria_skill_requirements csr " +
                     "JOIN skills s ON csr.skill_id = s.skill_id " +
                     "WHERE csr.criteria_id = ? " +
                     "ORDER BY s.category, s.skill_name ASC";
        List<CriteriaSkillRequirement> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, criteriaId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CriteriaSkillRequirement req = new CriteriaSkillRequirement();
                    req.setRequirementId(rs.getInt("requirement_id"));
                    req.setCriteriaId(rs.getInt("criteria_id"));
                    req.setSkillId(rs.getInt("skill_id"));
                    req.setMinProficiency(SkillLevel.fromString(rs.getString("min_proficiency")));
                    req.setMandatory(rs.getInt("is_mandatory") == 1);
                    req.setSkillName(rs.getString("skill_name"));
                    req.setSkillCategory(SkillCategory.fromString(rs.getString("category")));
                    if (rs.getTimestamp("created_at") != null) {
                        req.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                    }
                    list.add(req);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching criteria skill requirements for criteria: " + criteriaId, e);
            throw e;
        }
        return list;
    }

    public void saveCriteriaRequirements(int criteriaId, List<CriteriaSkillRequirement> requirements) throws SQLException {
        String deleteSql = "DELETE FROM criteria_skill_requirements WHERE criteria_id = ?";
        String insertSql = "INSERT INTO criteria_skill_requirements (criteria_id, skill_id, min_proficiency, is_mandatory) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);
            try {
                try (PreparedStatement delPs = conn.prepareStatement(deleteSql)) {
                    delPs.setInt(1, criteriaId);
                    delPs.executeUpdate();
                }

                if (requirements != null && !requirements.isEmpty()) {
                    try (PreparedStatement insPs = conn.prepareStatement(insertSql)) {
                        for (CriteriaSkillRequirement req : requirements) {
                            insPs.setInt(1, criteriaId);
                            insPs.setInt(2, req.getSkillId());
                            insPs.setString(3, req.getMinProficiency().name());
                            insPs.setInt(4, req.isMandatory() ? 1 : 0);
                            insPs.addBatch();
                        }
                        insPs.executeBatch();
                    }
                }
                conn.commit();
            } catch (SQLException e) {
                conn.rollback();
                LOGGER.log(Level.SEVERE, "Failed to save criteria requirements in transaction for criteria: " + criteriaId, e);
                throw e;
            } finally {
                conn.setAutoCommit(true);
            }
        }
    }

    private PlacementCriteria mapResultSetToCriteria(ResultSet rs) throws SQLException {
        PlacementCriteria c = new PlacementCriteria();
        c.setCriteriaId(rs.getInt("criteria_id"));
        c.setCompanyName(rs.getString("company_name"));
        c.setRoleTitle(rs.getString("role_title"));
        c.setMinCgpa(rs.getDouble("min_cgpa"));
        c.setMinDsaProblems(rs.getInt("min_dsa_problems"));
        c.setMinProjects(rs.getInt("min_projects"));
        c.setMinCertifications(rs.getInt("min_certifications"));
        c.setAllowedDepartments(rs.getString("allowed_departments"));
        c.setActive(rs.getInt("is_active") == 1);
        if (rs.getTimestamp("created_at") != null) {
            c.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
        }
        if (rs.getTimestamp("updated_at") != null) {
            c.setUpdatedAt(rs.getTimestamp("updated_at").toLocalDateTime());
        }
        return c;
    }
}
