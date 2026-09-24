package com.skilltrack.dao;

import com.skilltrack.config.DBConnection;
import com.skilltrack.models.Certification;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CertificationDAO {

    private static final Logger LOGGER = Logger.getLogger(CertificationDAO.class.getName());

    public List<Certification> findByStudentId(int studentId) throws SQLException {
        String sql = "SELECT cert_id, student_id, title, issuing_org, issue_date, credential_url, created_at, updated_at " +
                     "FROM certifications WHERE student_id = ? ORDER BY issue_date DESC";
        List<Certification> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToCertification(rs));
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching certifications for student: " + studentId, e);
            throw e;
        }
        return list;
    }

    public Certification findById(int certId, int studentId) throws SQLException {
        String sql = "SELECT cert_id, student_id, title, issuing_org, issue_date, credential_url, created_at, updated_at " +
                     "FROM certifications WHERE cert_id = ? AND student_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, certId);
            ps.setInt(2, studentId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToCertification(rs);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding certification ID: " + certId + " for student: " + studentId, e);
            throw e;
        }
        return null;
    }

    public int createCertification(Certification cert) throws SQLException {
        String sql = "INSERT INTO certifications (student_id, title, issuing_org, issue_date, credential_url) " +
                     "VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, cert.getStudentId());
            ps.setString(2, cert.getTitle().trim());
            ps.setString(3, cert.getIssuingOrg().trim());
            ps.setDate(4, Date.valueOf(cert.getIssueDate()));
            ps.setString(5, cert.getCredentialUrl() != null ? cert.getCredentialUrl().trim() : null);

            int affected = ps.executeUpdate();
            if (affected == 0) {
                throw new SQLException("Creating certification failed, no rows affected.");
            }
            try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    int id = generatedKeys.getInt(1);
                    cert.setCertId(id);
                    return id;
                } else {
                    throw new SQLException("Creating certification failed, no ID obtained.");
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error creating certification for student: " + cert.getStudentId(), e);
            throw e;
        }
    }

    public boolean updateCertification(Certification cert) throws SQLException {
        String sql = "UPDATE certifications SET title = ?, issuing_org = ?, issue_date = ?, credential_url = ? " +
                     "WHERE cert_id = ? AND student_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, cert.getTitle().trim());
            ps.setString(2, cert.getIssuingOrg().trim());
            ps.setDate(3, Date.valueOf(cert.getIssueDate()));
            ps.setString(4, cert.getCredentialUrl() != null ? cert.getCredentialUrl().trim() : null);
            ps.setInt(5, cert.getCertId());
            ps.setInt(6, cert.getStudentId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating certification ID: " + cert.getCertId() + " for student: " + cert.getStudentId(), e);
            throw e;
        }
    }

    public boolean deleteCertification(int certId, int studentId) throws SQLException {
        String sql = "DELETE FROM certifications WHERE cert_id = ? AND student_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, certId);
            ps.setInt(2, studentId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting certification ID: " + certId + " for student: " + studentId, e);
            throw e;
        }
    }

    public int countByStudentId(int studentId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM certifications WHERE student_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error counting certifications for student: " + studentId, e);
            throw e;
        }
        return 0;
    }

    private Certification mapResultSetToCertification(ResultSet rs) throws SQLException {
        Certification c = new Certification();
        c.setCertId(rs.getInt("cert_id"));
        c.setStudentId(rs.getInt("student_id"));
        c.setTitle(rs.getString("title"));
        c.setIssuingOrg(rs.getString("issuing_org"));
        if (rs.getDate("issue_date") != null) {
            c.setIssueDate(rs.getDate("issue_date").toLocalDate());
        }
        c.setCredentialUrl(rs.getString("credential_url"));
        if (rs.getTimestamp("created_at") != null) {
            c.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
        }
        if (rs.getTimestamp("updated_at") != null) {
            c.setUpdatedAt(rs.getTimestamp("updated_at").toLocalDateTime());
        }
        return c;
    }
}
