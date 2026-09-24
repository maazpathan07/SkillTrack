package com.skilltrack.services;

import com.skilltrack.config.DBConnection;
import com.skilltrack.constants.UserRole;
import com.skilltrack.dao.AdminDAO;
import com.skilltrack.dao.StudentDAO;
import com.skilltrack.dao.UserDAO;
import com.skilltrack.models.Admin;
import com.skilltrack.models.Student;
import com.skilltrack.models.User;
import com.skilltrack.utils.PasswordUtil;
import com.skilltrack.utils.ValidationUtil;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class AuthService {

    private static final Logger LOGGER = Logger.getLogger(AuthService.class.getName());

    private final UserDAO userDAO;
    private final StudentDAO studentDAO;
    private final AdminDAO adminDAO;

    public AuthService() {
        this.userDAO = new UserDAO();
        this.studentDAO = new StudentDAO();
        this.adminDAO = new AdminDAO();
    }

    public AuthService(UserDAO userDAO, StudentDAO studentDAO, AdminDAO adminDAO) {
        this.userDAO = userDAO;
        this.studentDAO = studentDAO;
        this.adminDAO = adminDAO;
    }

    public static class AuthResult {
        private final boolean success;
        private final String errorMessage;
        private final User user;
        private final Student student;
        private final Admin admin;

        public AuthResult(boolean success, String errorMessage, User user, Student student, Admin admin) {
            this.success = success;
            this.errorMessage = errorMessage;
            this.user = user;
            this.student = student;
            this.admin = admin;
        }

        public static AuthResult failure(String errorMessage) {
            return new AuthResult(false, errorMessage, null, null, null);
        }

        public static AuthResult success(User user, Student student, Admin admin) {
            return new AuthResult(true, null, user, student, admin);
        }

        public boolean isSuccess() {
            return success;
        }

        public String getErrorMessage() {
            return errorMessage;
        }

        public User getUser() {
            return user;
        }

        public Student getStudent() {
            return student;
        }

        public Admin getAdmin() {
            return admin;
        }
    }

    public AuthResult login(String email, String password) {
        if (!ValidationUtil.isValidEmail(email) || password == null || password.trim().isEmpty()) {
            return AuthResult.failure("Invalid email address or password.");
        }

        try {
            User user = userDAO.findByEmail(email);
            if (user == null || !user.isActive()) {
                return AuthResult.failure("Invalid email or password.");
            }

            boolean passwordMatches = PasswordUtil.verifyPassword(password, user.getPasswordHash(), user.getSalt());
            if (!passwordMatches) {
                return AuthResult.failure("Invalid email or password.");
            }

            Student student = null;
            Admin admin = null;

            if (user.getRole() == UserRole.STUDENT) {
                student = studentDAO.findByUserId(user.getUserId());
                if (student == null) {
                    return AuthResult.failure("Student profile not found. Please contact support.");
                }
            } else if (user.getRole() == UserRole.ADMIN) {
                admin = adminDAO.findByUserId(user.getUserId());
                if (admin == null) {
                    return AuthResult.failure("Admin profile not found. Please contact support.");
                }
            }

            return AuthResult.success(user, student, admin);
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Database error during login for email: " + email, e);
            return AuthResult.failure("A database error occurred. Please try again later.");
        }
    }

    public AuthResult registerStudent(String email, String password, String fullName, String rollNumber,
                                      String department, int gradYear, double cgpa, Integer targetRoleId) {
        // Server-side validation
        if (!ValidationUtil.isValidEmail(email)) {
            return AuthResult.failure("Please provide a valid email address.");
        }
        if (!ValidationUtil.isValidPassword(password)) {
            return AuthResult.failure("Password must be at least 6 characters.");
        }
        if (!ValidationUtil.isNotEmpty(fullName)) {
            return AuthResult.failure("Full Name is required.");
        }
        if (!ValidationUtil.isValidRollNumber(rollNumber)) {
            return AuthResult.failure("Valid Roll Number is required (alphanumeric, 3-30 chars).");
        }
        if (!ValidationUtil.isNotEmpty(department)) {
            return AuthResult.failure("Department is required.");
        }
        if (!ValidationUtil.isValidGraduationYear(gradYear)) {
            return AuthResult.failure("Please enter a valid graduation year (2000-2040).");
        }
        if (!ValidationUtil.isValidCgpa(cgpa)) {
            return AuthResult.failure("CGPA must be between 0.00 and 10.00.");
        }

        Connection conn = null;
        try {
            if (userDAO.emailExists(email)) {
                return AuthResult.failure("An account with this email address already exists.");
            }
            if (studentDAO.rollNumberExists(rollNumber, 0)) {
                return AuthResult.failure("A student with this roll number already exists.");
            }

            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            String salt = PasswordUtil.generateSalt();
            String hash = PasswordUtil.hashPassword(password, salt);

            User user = new User();
            user.setEmail(email.trim().toLowerCase());
            user.setPasswordHash(hash);
            user.setSalt(salt);
            user.setRole(UserRole.STUDENT);
            user.setActive(true);

            int userId = userDAO.createUser(user, conn);

            Student student = new Student();
            student.setUserId(userId);
            student.setFullName(fullName.trim());
            student.setRollNumber(rollNumber.trim().toUpperCase());
            student.setDepartment(department.trim());
            student.setGraduationYear(gradYear);
            student.setCgpa(cgpa);
            student.setTargetRoleId(targetRoleId);

            studentDAO.createStudent(student, conn);

            conn.commit();
            LOGGER.info("Successfully registered student account for email: " + email);
            return AuthResult.success(user, student, null);
        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    LOGGER.log(Level.SEVERE, "Rollback error during registration", ex);
                }
            }
            LOGGER.log(Level.SEVERE, "Registration transaction failed for email: " + email, e);
            return AuthResult.failure("Registration failed due to a database error. Please try again.");
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException ex) {
                    LOGGER.log(Level.WARNING, "Error closing connection", ex);
                }
            }
        }
    }
}
