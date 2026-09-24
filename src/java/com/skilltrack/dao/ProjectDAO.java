package com.skilltrack.dao;

import com.skilltrack.config.DBConnection;
import com.skilltrack.models.Project;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ProjectDAO {

    private static final Logger LOGGER = Logger.getLogger(ProjectDAO.class.getName());

    public List<Project> findByStudentId(int studentId) throws SQLException {
        String sql = "SELECT project_id, student_id, title, description, tech_stack, github_url, live_demo_url, created_at, updated_at " +
                     "FROM projects WHERE student_id = ? ORDER BY created_at DESC";
        List<Project> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToProject(rs));
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching projects for student ID: " + studentId, e);
            throw e;
        }
        return list;
    }

    public Project findById(int projectId, int studentId) throws SQLException {
        String sql = "SELECT project_id, student_id, title, description, tech_stack, github_url, live_demo_url, created_at, updated_at " +
                     "FROM projects WHERE project_id = ? AND student_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, projectId);
            ps.setInt(2, studentId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToProject(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding project ID: " + projectId + " for student: " + studentId, e);
            throw e;
        }
        return null;
    }

    public int createProject(Project project) throws SQLException {
        String sql = "INSERT INTO projects (student_id, title, description, tech_stack, github_url, live_demo_url) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, project.getStudentId());
            ps.setString(2, project.getTitle().trim());
            ps.setString(3, project.getDescription().trim());
            ps.setString(4, project.getTechStack().trim());
            ps.setString(5, project.getGithubUrl() != null ? project.getGithubUrl().trim() : null);
            ps.setString(6, project.getLiveDemoUrl() != null ? project.getLiveDemoUrl().trim() : null);

            int affected = ps.executeUpdate();
            if (affected == 0) {
                throw new SQLException("Creating project failed, no rows affected.");
            }
            try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    int id = generatedKeys.getInt(1);
                    project.setProjectId(id);
                    return id;
                } else {
                    throw new SQLException("Creating project failed, no ID obtained.");
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error creating project for student: " + project.getStudentId(), e);
            throw e;
        }
    }

    public boolean updateProject(Project project) throws SQLException {
        String sql = "UPDATE projects SET title = ?, description = ?, tech_stack = ?, github_url = ?, live_demo_url = ? " +
                     "WHERE project_id = ? AND student_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, project.getTitle().trim());
            ps.setString(2, project.getDescription().trim());
            ps.setString(3, project.getTechStack().trim());
            ps.setString(4, project.getGithubUrl() != null ? project.getGithubUrl().trim() : null);
            ps.setString(5, project.getLiveDemoUrl() != null ? project.getLiveDemoUrl().trim() : null);
            ps.setInt(6, project.getProjectId());
            ps.setInt(7, project.getStudentId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating project ID: " + project.getProjectId() + " for student: " + project.getStudentId(), e);
            throw e;
        }
    }

    public boolean deleteProject(int projectId, int studentId) throws SQLException {
        String sql = "DELETE FROM projects WHERE project_id = ? AND student_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, projectId);
            ps.setInt(2, studentId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting project ID: " + projectId + " for student: " + studentId, e);
            throw e;
        }
    }

    public int countByStudentId(int studentId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM projects WHERE student_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error counting projects for student: " + studentId, e);
            throw e;
        }
        return 0;
    }

    private Project mapResultSetToProject(ResultSet rs) throws SQLException {
        Project p = new Project();
        p.setProjectId(rs.getInt("project_id"));
        p.setStudentId(rs.getInt("student_id"));
        p.setTitle(rs.getString("title"));
        p.setDescription(rs.getString("description"));
        p.setTechStack(rs.getString("tech_stack"));
        p.setGithubUrl(rs.getString("github_url"));
        p.setLiveDemoUrl(rs.getString("live_demo_url"));
        if (rs.getTimestamp("created_at") != null) {
            p.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
        }
        if (rs.getTimestamp("updated_at") != null) {
            p.setUpdatedAt(rs.getTimestamp("updated_at").toLocalDateTime());
        }
        return p;
    }
}
