package com.skilltrack.dao;

import com.skilltrack.config.DBConnection;
import com.skilltrack.constants.SkillCategory;
import com.skilltrack.constants.SkillLevel;
import com.skilltrack.models.RoleSkillRequirement;
import com.skilltrack.models.TargetRole;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class TargetRoleDAO {

    private static final Logger LOGGER = Logger.getLogger(TargetRoleDAO.class.getName());

    public List<TargetRole> findAll(boolean activeOnly) throws SQLException {
        try (Connection conn = DBConnection.getConnection()) {
            ensureSeededRoles(conn);
            String sql = "SELECT role_id, role_title, description, is_active, created_at, updated_at " +
                         "FROM target_roles " + (activeOnly ? "WHERE is_active = 1 " : "") +
                         "ORDER BY role_title ASC";
            List<TargetRole> list = new ArrayList<>();
            try (PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToTargetRole(rs));
                }
            }
            return list;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching target roles", e);
            throw e;
        }
    }

    private void ensureSeededRoles(Connection conn) {
        String[][] defaultRoles = new String[][] {
            {"Full Stack Java Developer", "End-to-end web developer mastering Java backend, Spring Boot, relational databases, REST APIs, and React/HTML5 frontends."},
            {"Full Stack MERN Developer", "Modern JavaScript full stack engineer specializing in MongoDB, Express.js, React.js, Node.js, and TypeScript."},
            {"Java Backend Developer", "Specialized in building robust, scalable server-side systems, microservices, and high-concurrency APIs using Java and Spring Boot."},
            {"Python Backend Developer", "Develops high-performance web applications, data processing pipelines, and microservices using Python, FastAPI/Django, and SQL."},
            {"Frontend Developer (React / UI)", "Crafts modern, responsive, component-driven user interfaces using modern JavaScript, React.js, HTML5, and CSS3."},
            {"Data Analyst & BI Specialist", "Extracts actionable business insights using SQL, Python (Pandas/NumPy), statistical modeling, and relational DBMS."},
            {"Data Engineer (Big Data & ETL)", "Designs scalable data pipelines, ETL workflows, data warehousing, and distributed streaming using Python, SQL, and cloud storage."},
            {"Machine Learning & AI Engineer", "Builds and deploys predictive models, deep learning networks, and NLP systems using Python, PyTorch, and TensorFlow."},
            {"Cloud & DevOps Engineer", "Automates cloud infrastructure, CI/CD pipelines, containerization, and deployment workflows using Docker, AWS, and Linux."},
            {"Cyber Security & SOC Analyst", "Protects software systems and cloud assets with network security, vulnerability auditing, OWASP standards, and penetration testing."},
            {"Mobile App Developer (Android / Flutter)", "Creates high-performance native and cross-platform mobile apps using Kotlin, Flutter, and RESTful mobile APIs."},
            {"Software Test Engineer (SDET / QA)", "Automates end-to-end software quality assurance, regression suites, API tests, and performance benchmarks using Selenium and Java/Python."},
            {"Systems & Low-Level Software Engineer", "Builds high-performance systems, network protocols, and hardware interfaces using C/C++, Linux internals, and multithreading."},
            {"IT Business & Product Analyst", "Bridges engineering and product requirements with technical documentation, data analytics, SQL queries, and agile workflow management."}
        };

        String insertSql = "INSERT INTO target_roles (role_title, description, is_active) " +
                           "SELECT ?, ?, 1 FROM DUAL WHERE NOT EXISTS " +
                           "(SELECT 1 FROM target_roles WHERE LOWER(role_title) = LOWER(?))";
        try (PreparedStatement ps = conn.prepareStatement(insertSql)) {
            for (String[] r : defaultRoles) {
                ps.setString(1, r[0]);
                ps.setString(2, r[1]);
                ps.setString(3, r[0]);
                ps.executeUpdate();
            }
        } catch (Exception e) {
            LOGGER.log(Level.FINE, "Auto-seeding target roles: " + e.getMessage());
        }
    }

    public TargetRole findById(int roleId) throws SQLException {
        String sql = "SELECT role_id, role_title, description, is_active, created_at, updated_at " +
                     "FROM target_roles WHERE role_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, roleId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    TargetRole role = mapResultSetToTargetRole(rs);
                    role.setRequirements(getRoleRequirements(roleId));
                    return role;
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding target role by ID: " + roleId, e);
            throw e;
        }
        return null;
    }

    public TargetRole findByTitle(String title) throws SQLException {
        String sql = "SELECT role_id, role_title, description, is_active, created_at, updated_at " +
                     "FROM target_roles WHERE LOWER(role_title) = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, title.trim().toLowerCase());
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToTargetRole(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding target role by title: " + title, e);
            throw e;
        }
        return null;
    }

    public int createRole(TargetRole role) throws SQLException {
        String sql = "INSERT INTO target_roles (role_title, description, is_active) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, role.getRoleTitle().trim());
            ps.setString(2, role.getDescription());
            ps.setInt(3, role.isActive() ? 1 : 0);

            int affected = ps.executeUpdate();
            if (affected == 0) {
                throw new SQLException("Creating target role failed, no rows affected.");
            }
            try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    int id = generatedKeys.getInt(1);
                    role.setRoleId(id);
                    return id;
                } else {
                    throw new SQLException("Creating target role failed, no ID obtained.");
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error creating target role: " + role.getRoleTitle(), e);
            throw e;
        }
    }

    public boolean updateRole(TargetRole role) throws SQLException {
        String sql = "UPDATE target_roles SET role_title = ?, description = ?, is_active = ? WHERE role_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, role.getRoleTitle().trim());
            ps.setString(2, role.getDescription());
            ps.setInt(3, role.isActive() ? 1 : 0);
            ps.setInt(4, role.getRoleId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating target role ID: " + role.getRoleId(), e);
            throw e;
        }
    }

    public boolean deleteRole(int roleId) throws SQLException {
        String sql = "DELETE FROM target_roles WHERE role_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, roleId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting target role ID: " + roleId, e);
            throw e;
        }
    }

    public List<RoleSkillRequirement> getRoleRequirements(int roleId) throws SQLException {
        String sql = "SELECT rsr.requirement_id, rsr.role_id, rsr.skill_id, rsr.min_proficiency, rsr.is_mandatory, " +
                     "s.skill_name, s.category, rsr.created_at " +
                     "FROM role_skill_requirements rsr " +
                     "JOIN skills s ON rsr.skill_id = s.skill_id " +
                     "WHERE rsr.role_id = ? " +
                     "ORDER BY s.category, s.skill_name ASC";
        List<RoleSkillRequirement> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, roleId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    RoleSkillRequirement req = new RoleSkillRequirement();
                    req.setRequirementId(rs.getInt("requirement_id"));
                    req.setRoleId(rs.getInt("role_id"));
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
            LOGGER.log(Level.SEVERE, "Error getting role requirements for role ID: " + roleId, e);
            throw e;
        }
        return list;
    }

    public void saveRoleRequirements(int roleId, List<RoleSkillRequirement> requirements) throws SQLException {
        String deleteSql = "DELETE FROM role_skill_requirements WHERE role_id = ?";
        String insertSql = "INSERT INTO role_skill_requirements (role_id, skill_id, min_proficiency, is_mandatory) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);
            try {
                try (PreparedStatement delPs = conn.prepareStatement(deleteSql)) {
                    delPs.setInt(1, roleId);
                    delPs.executeUpdate();
                }

                if (requirements != null && !requirements.isEmpty()) {
                    try (PreparedStatement insPs = conn.prepareStatement(insertSql)) {
                        for (RoleSkillRequirement req : requirements) {
                            insPs.setInt(1, roleId);
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
                LOGGER.log(Level.SEVERE, "Failed to save role requirements in transaction for role: " + roleId, e);
                throw e;
            } finally {
                conn.setAutoCommit(true);
            }
        }
    }

    private TargetRole mapResultSetToTargetRole(ResultSet rs) throws SQLException {
        TargetRole tr = new TargetRole();
        tr.setRoleId(rs.getInt("role_id"));
        tr.setRoleTitle(rs.getString("role_title"));
        tr.setDescription(rs.getString("description"));
        tr.setActive(rs.getInt("is_active") == 1);
        if (rs.getTimestamp("created_at") != null) {
            tr.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
        }
        if (rs.getTimestamp("updated_at") != null) {
            tr.setUpdatedAt(rs.getTimestamp("updated_at").toLocalDateTime());
        }
        return tr;
    }
}
