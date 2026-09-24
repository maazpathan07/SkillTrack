package com.skilltrack.dao;

import com.skilltrack.config.DBConnection;
import com.skilltrack.constants.TaskStatus;
import com.skilltrack.models.PreparationTask;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class TaskDAO {

    private static final Logger LOGGER = Logger.getLogger(TaskDAO.class.getName());

    public List<PreparationTask> findByStudentId(int studentId) throws SQLException {
        String sql = "SELECT task_id, student_id, title, description, status, target_date, created_at, updated_at " +
                     "FROM preparation_tasks WHERE student_id = ? ORDER BY status ASC, target_date ASC, created_at DESC";
        List<PreparationTask> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToTask(rs));
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching tasks for student: " + studentId, e);
            throw e;
        }
        return list;
    }

    public PreparationTask findById(int taskId, int studentId) throws SQLException {
        String sql = "SELECT task_id, student_id, title, description, status, target_date, created_at, updated_at " +
                     "FROM preparation_tasks WHERE task_id = ? AND student_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, taskId);
            ps.setInt(2, studentId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToTask(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding task ID: " + taskId + " for student: " + studentId, e);
            throw e;
        }
        return null;
    }

    public int createTask(PreparationTask task) throws SQLException {
        String sql = "INSERT INTO preparation_tasks (student_id, title, description, status, target_date) " +
                     "VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, task.getStudentId());
            ps.setString(2, task.getTitle().trim());
            ps.setString(3, task.getDescription() != null ? task.getDescription().trim() : null);
            ps.setString(4, task.getStatus().name());
            if (task.getTargetDate() != null) {
                ps.setDate(5, Date.valueOf(task.getTargetDate()));
            } else {
                ps.setNull(5, Types.DATE);
            }

            int affected = ps.executeUpdate();
            if (affected == 0) {
                throw new SQLException("Creating task failed, no rows affected.");
            }
            try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    int id = generatedKeys.getInt(1);
                    task.setTaskId(id);
                    return id;
                } else {
                    throw new SQLException("Creating task failed, no ID obtained.");
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error creating task for student: " + task.getStudentId(), e);
            throw e;
        }
    }

    public boolean updateTask(PreparationTask task) throws SQLException {
        String sql = "UPDATE preparation_tasks SET title = ?, description = ?, status = ?, target_date = ? " +
                     "WHERE task_id = ? AND student_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, task.getTitle().trim());
            ps.setString(2, task.getDescription() != null ? task.getDescription().trim() : null);
            ps.setString(3, task.getStatus().name());
            if (task.getTargetDate() != null) {
                ps.setDate(4, Date.valueOf(task.getTargetDate()));
            } else {
                ps.setNull(4, Types.DATE);
            }
            ps.setInt(5, task.getTaskId());
            ps.setInt(6, task.getStudentId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating task ID: " + task.getTaskId() + " for student: " + task.getStudentId(), e);
            throw e;
        }
    }

    public boolean updateStatus(int taskId, int studentId, TaskStatus status) throws SQLException {
        String sql = "UPDATE preparation_tasks SET status = ? WHERE task_id = ? AND student_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status.name());
            ps.setInt(2, taskId);
            ps.setInt(3, studentId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating task status for task " + taskId + ", student " + studentId, e);
            throw e;
        }
    }

    public boolean deleteTask(int taskId, int studentId) throws SQLException {
        String sql = "DELETE FROM preparation_tasks WHERE task_id = ? AND student_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, taskId);
            ps.setInt(2, studentId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting task ID: " + taskId + " for student: " + studentId, e);
            throw e;
        }
    }

    public int countTotalTasks(int studentId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM preparation_tasks WHERE student_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error counting total tasks for student: " + studentId, e);
            throw e;
        }
        return 0;
    }

    public int countCompletedTasks(int studentId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM preparation_tasks WHERE student_id = ? AND status = 'COMPLETED'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error counting completed tasks for student: " + studentId, e);
            throw e;
        }
        return 0;
    }

    private PreparationTask mapResultSetToTask(ResultSet rs) throws SQLException {
        PreparationTask t = new PreparationTask();
        t.setTaskId(rs.getInt("task_id"));
        t.setStudentId(rs.getInt("student_id"));
        t.setTitle(rs.getString("title"));
        t.setDescription(rs.getString("description"));
        t.setStatus(TaskStatus.fromString(rs.getString("status")));
        if (rs.getDate("target_date") != null) {
            t.setTargetDate(rs.getDate("target_date").toLocalDate());
        }
        if (rs.getTimestamp("created_at") != null) {
            t.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
        }
        if (rs.getTimestamp("updated_at") != null) {
            t.setUpdatedAt(rs.getTimestamp("updated_at").toLocalDateTime());
        }
        return t;
    }
}
