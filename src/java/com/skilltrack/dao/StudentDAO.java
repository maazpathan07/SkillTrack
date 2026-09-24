package com.skilltrack.dao;

import com.skilltrack.config.DBConnection;
import com.skilltrack.constants.SkillLevel;
import com.skilltrack.models.Student;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class StudentDAO {

    private static final Logger LOGGER = Logger.getLogger(StudentDAO.class.getName());

    public Student findByUserId(int userId) throws SQLException {
        String sql = "SELECT s.student_id, s.user_id, s.full_name, s.roll_number, s.department, " +
                     "s.graduation_year, s.cgpa, s.target_role_id, tr.role_title, u.email, " +
                     "s.created_at, s.updated_at " +
                     "FROM students s " +
                     "JOIN users u ON s.user_id = u.user_id " +
                     "LEFT JOIN target_roles tr ON s.target_role_id = tr.role_id " +
                     "WHERE s.user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToStudent(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding student by userId: " + userId, e);
            throw e;
        }
        return null;
    }

    public Student findById(int studentId) throws SQLException {
        String sql = "SELECT s.student_id, s.user_id, s.full_name, s.roll_number, s.department, " +
                     "s.graduation_year, s.cgpa, s.target_role_id, tr.role_title, u.email, " +
                     "s.created_at, s.updated_at " +
                     "FROM students s " +
                     "JOIN users u ON s.user_id = u.user_id " +
                     "LEFT JOIN target_roles tr ON s.target_role_id = tr.role_id " +
                     "WHERE s.student_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToStudent(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding student by studentId: " + studentId, e);
            throw e;
        }
        return null;
    }

    public boolean rollNumberExists(String rollNumber, int excludeStudentId) throws SQLException {
        String sql = "SELECT 1 FROM students WHERE roll_number = ? AND student_id != ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, rollNumber.trim());
            ps.setInt(2, excludeStudentId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error checking roll number existence: " + rollNumber, e);
            throw e;
        }
    }

    public int createStudent(Student student, Connection conn) throws SQLException {
        String sql = "INSERT INTO students (user_id, full_name, roll_number, department, graduation_year, cgpa, target_role_id) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, student.getUserId());
            ps.setString(2, student.getFullName().trim());
            ps.setString(3, student.getRollNumber().trim().toUpperCase());
            ps.setString(4, student.getDepartment().trim());
            ps.setInt(5, student.getGraduationYear());
            ps.setDouble(6, student.getCgpa());
            if (student.getTargetRoleId() != null && student.getTargetRoleId() > 0) {
                ps.setInt(7, student.getTargetRoleId());
            } else {
                ps.setNull(7, Types.INTEGER);
            }

            int affected = ps.executeUpdate();
            if (affected == 0) {
                throw new SQLException("Creating student profile failed, no rows affected.");
            }

            try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    int id = generatedKeys.getInt(1);
                    student.setStudentId(id);
                    return id;
                } else {
                    throw new SQLException("Creating student profile failed, no ID obtained.");
                }
            }
        }
    }

    public boolean updateProfile(Student student) throws SQLException {
        String sql = "UPDATE students SET full_name = ?, roll_number = ?, department = ?, " +
                     "graduation_year = ?, cgpa = ?, target_role_id = ? " +
                     "WHERE student_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, student.getFullName().trim());
            ps.setString(2, student.getRollNumber().trim().toUpperCase());
            ps.setString(3, student.getDepartment().trim());
            ps.setInt(4, student.getGraduationYear());
            ps.setDouble(5, student.getCgpa());
            if (student.getTargetRoleId() != null && student.getTargetRoleId() > 0) {
                ps.setInt(6, student.getTargetRoleId());
            } else {
                ps.setNull(6, Types.INTEGER);
            }
            ps.setInt(7, student.getStudentId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating student profile for ID: " + student.getStudentId(), e);
            throw e;
        }
    }

    public boolean updateTargetRole(int studentId, Integer targetRoleId) throws SQLException {
        String sql = "UPDATE students SET target_role_id = ? WHERE student_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            if (targetRoleId != null && targetRoleId > 0) {
                ps.setInt(1, targetRoleId);
            } else {
                ps.setNull(1, Types.INTEGER);
            }
            ps.setInt(2, studentId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating target role for student: " + studentId, e);
            throw e;
        }
    }

    public List<Student> findAllStudents(String search, String dept, Integer gradYear, Integer targetRoleId,
                                         Double minCgpa, Integer skillId, String skillLevelStr,
                                         int offset, int limit) throws SQLException {
        StringBuilder sql = new StringBuilder(
            "SELECT DISTINCT s.student_id, s.user_id, s.full_name, s.roll_number, s.department, " +
            "s.graduation_year, s.cgpa, s.target_role_id, tr.role_title, u.email, " +
            "s.created_at, s.updated_at " +
            "FROM students s " +
            "JOIN users u ON s.user_id = u.user_id " +
            "LEFT JOIN target_roles tr ON s.target_role_id = tr.role_id "
        );

        if (skillId != null && skillId > 0) {
            sql.append("JOIN student_skills ss ON s.student_id = ss.student_id AND ss.skill_id = ? ");
        }

        sql.append("WHERE 1=1 ");
        List<Object> params = new ArrayList<>();

        if (skillId != null && skillId > 0) {
            params.add(skillId);
            if (skillLevelStr != null && !skillLevelStr.trim().isEmpty()) {
                SkillLevel reqLevel = SkillLevel.fromString(skillLevelStr);
                if (reqLevel != null) {
                    if (reqLevel == SkillLevel.ADVANCED) {
                        sql.append("AND ss.proficiency_level = 'ADVANCED' ");
                    } else if (reqLevel == SkillLevel.INTERMEDIATE) {
                        sql.append("AND ss.proficiency_level IN ('INTERMEDIATE', 'ADVANCED') ");
                    }
                }
            }
        }

        if (search != null && !search.trim().isEmpty()) {
            sql.append("AND (s.full_name LIKE ? OR s.roll_number LIKE ? OR u.email LIKE ?) ");
            String wildcard = "%" + search.trim() + "%";
            params.add(wildcard);
            params.add(wildcard);
            params.add(wildcard);
        }

        if (dept != null && !dept.trim().isEmpty() && !"ALL".equalsIgnoreCase(dept.trim())) {
            sql.append("AND s.department = ? ");
            params.add(dept.trim());
        }

        if (gradYear != null && gradYear > 0) {
            sql.append("AND s.graduation_year = ? ");
            params.add(gradYear);
        }

        if (targetRoleId != null && targetRoleId > 0) {
            sql.append("AND s.target_role_id = ? ");
            params.add(targetRoleId);
        }

        if (minCgpa != null && minCgpa > 0.0) {
            sql.append("AND s.cgpa >= ? ");
            params.add(minCgpa);
        }

        sql.append("ORDER BY s.student_id DESC LIMIT ? OFFSET ?");
        params.add(limit > 0 ? limit : 10);
        params.add(offset >= 0 ? offset : 0);

        List<Student> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToStudent(rs));
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error executing student directory query", e);
            throw e;
        }
        return list;
    }

    public int countStudents(String search, String dept, Integer gradYear, Integer targetRoleId,
                              Double minCgpa, Integer skillId, String skillLevelStr) throws SQLException {
        StringBuilder sql = new StringBuilder(
            "SELECT COUNT(DISTINCT s.student_id) FROM students s " +
            "JOIN users u ON s.user_id = u.user_id " +
            "LEFT JOIN target_roles tr ON s.target_role_id = tr.role_id "
        );

        if (skillId != null && skillId > 0) {
            sql.append("JOIN student_skills ss ON s.student_id = ss.student_id AND ss.skill_id = ? ");
        }

        sql.append("WHERE 1=1 ");
        List<Object> params = new ArrayList<>();

        if (skillId != null && skillId > 0) {
            params.add(skillId);
            if (skillLevelStr != null && !skillLevelStr.trim().isEmpty()) {
                SkillLevel reqLevel = SkillLevel.fromString(skillLevelStr);
                if (reqLevel != null) {
                    if (reqLevel == SkillLevel.ADVANCED) {
                        sql.append("AND ss.proficiency_level = 'ADVANCED' ");
                    } else if (reqLevel == SkillLevel.INTERMEDIATE) {
                        sql.append("AND ss.proficiency_level IN ('INTERMEDIATE', 'ADVANCED') ");
                    }
                }
            }
        }

        if (search != null && !search.trim().isEmpty()) {
            sql.append("AND (s.full_name LIKE ? OR s.roll_number LIKE ? OR u.email LIKE ?) ");
            String wildcard = "%" + search.trim() + "%";
            params.add(wildcard);
            params.add(wildcard);
            params.add(wildcard);
        }

        if (dept != null && !dept.trim().isEmpty() && !"ALL".equalsIgnoreCase(dept.trim())) {
            sql.append("AND s.department = ? ");
            params.add(dept.trim());
        }

        if (gradYear != null && gradYear > 0) {
            sql.append("AND s.graduation_year = ? ");
            params.add(gradYear);
        }

        if (targetRoleId != null && targetRoleId > 0) {
            sql.append("AND s.target_role_id = ? ");
            params.add(targetRoleId);
        }

        if (minCgpa != null && minCgpa > 0.0) {
            sql.append("AND s.cgpa >= ? ");
            params.add(minCgpa);
        }

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error counting students", e);
            throw e;
        }
        return 0;
    }

    public List<Student> findAll() throws SQLException {
        String sql = "SELECT s.student_id, s.user_id, s.full_name, s.roll_number, s.department, " +
                     "s.graduation_year, s.cgpa, s.target_role_id, tr.role_title, u.email, " +
                     "s.created_at, s.updated_at " +
                     "FROM students s " +
                     "JOIN users u ON s.user_id = u.user_id " +
                     "LEFT JOIN target_roles tr ON s.target_role_id = tr.role_id " +
                     "ORDER BY s.student_id ASC";
        List<Student> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapResultSetToStudent(rs));
            }
        }
        return list;
    }

    private Student mapResultSetToStudent(ResultSet rs) throws SQLException {
        Student s = new Student();
        s.setStudentId(rs.getInt("student_id"));
        s.setUserId(rs.getInt("user_id"));
        s.setFullName(rs.getString("full_name"));
        s.setRollNumber(rs.getString("roll_number"));
        s.setDepartment(rs.getString("department"));
        s.setGraduationYear(rs.getInt("graduation_year"));
        s.setCgpa(rs.getDouble("cgpa"));
        int trId = rs.getInt("target_role_id");
        if (!rs.wasNull()) {
            s.setTargetRoleId(trId);
        }
        s.setTargetRoleTitle(rs.getString("role_title"));
        s.setEmail(rs.getString("email"));
        if (rs.getTimestamp("created_at") != null) {
            s.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
        }
        if (rs.getTimestamp("updated_at") != null) {
            s.setUpdatedAt(rs.getTimestamp("updated_at").toLocalDateTime());
        }
        return s;
    }
}
