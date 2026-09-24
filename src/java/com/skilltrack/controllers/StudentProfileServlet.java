package com.skilltrack.controllers;

import com.skilltrack.constants.AppConstants;
import com.skilltrack.dao.TargetRoleDAO;
import com.skilltrack.dto.StudentProfileDTO;
import com.skilltrack.models.TargetRole;
import com.skilltrack.services.StudentService;
import com.skilltrack.utils.SessionUtil;
import com.skilltrack.utils.ValidationUtil;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "StudentProfileServlet", urlPatterns = {"/app/student/profile"})
public class StudentProfileServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(StudentProfileServlet.class.getName());

    private final StudentService studentService = new StudentService();
    private final TargetRoleDAO targetRoleDAO = new TargetRoleDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Integer studentId = SessionUtil.getStudentId(request);
        if (studentId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        StudentProfileDTO profile = studentService.getStudentProfile(studentId);
        if (profile == null) {
            request.getSession().setAttribute(AppConstants.FLASH_ERROR, "Profile not found.");
            response.sendRedirect(request.getContextPath() + "/app/student/dashboard");
            return;
        }

        try {
            List<TargetRole> targetRoles = targetRoleDAO.findAll(true);
            request.setAttribute("targetRoles", targetRoles);
        } catch (SQLException e) {
            LOGGER.log(Level.WARNING, "Error fetching target roles", e);
        }

        request.setAttribute("profile", profile);
        request.getRequestDispatcher("/WEB-INF/views/student/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Integer studentId = SessionUtil.getStudentId(request);
        if (studentId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String fullName = request.getParameter("fullName");
        String rollNumber = request.getParameter("rollNumber");
        String department = request.getParameter("department");
        String gradYearStr = request.getParameter("graduationYear");
        String cgpaStr = request.getParameter("cgpa");
        String targetRoleIdStr = request.getParameter("targetRoleId");

        int gradYear = ValidationUtil.parsePositiveInt(gradYearStr, 0);
        double cgpa = ValidationUtil.parseDouble(cgpaStr, 0.0);
        int targetRoleId = ValidationUtil.parsePositiveInt(targetRoleIdStr, 0);
        Integer roleId = (targetRoleId > 0) ? targetRoleId : null;

        try {
            studentService.updateProfile(studentId, fullName, rollNumber, department, gradYear, cgpa, roleId);
            // Update session name if changed
            request.getSession().setAttribute(AppConstants.SESSION_USER_NAME, fullName.trim());
            request.getSession().setAttribute(AppConstants.FLASH_SUCCESS, "Profile updated successfully.");
            response.sendRedirect(request.getContextPath() + "/app/student/profile");
        } catch (IllegalArgumentException e) {
            request.getSession().setAttribute(AppConstants.FLASH_ERROR, e.getMessage());
            response.sendRedirect(request.getContextPath() + "/app/student/profile");
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Database error updating profile for student: " + studentId, e);
            request.getSession().setAttribute(AppConstants.FLASH_ERROR, "A database error occurred while updating profile.");
            response.sendRedirect(request.getContextPath() + "/app/student/profile");
        }
    }
}
