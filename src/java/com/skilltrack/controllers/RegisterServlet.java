package com.skilltrack.controllers;

import com.skilltrack.constants.AppConstants;
import com.skilltrack.constants.UserRole;
import com.skilltrack.dao.TargetRoleDAO;
import com.skilltrack.models.TargetRole;
import com.skilltrack.services.AuthService;
import com.skilltrack.utils.SessionUtil;
import com.skilltrack.utils.ValidationUtil;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

    private final AuthService authService = new AuthService();
    private final TargetRoleDAO targetRoleDAO = new TargetRoleDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (SessionUtil.isAuthenticated(request)) {
            response.sendRedirect(request.getContextPath() + "/app/student/dashboard");
            return;
        }

        try {
            List<TargetRole> roles = targetRoleDAO.findAll(true);
            request.setAttribute("targetRoles", roles);
        } catch (SQLException e) {
            request.setAttribute("targetRoles", null);
        }

        request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
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

        AuthService.AuthResult result = authService.registerStudent(
            email, password, fullName, rollNumber, department, gradYear, cgpa, roleId
        );

        if (result.isSuccess()) {
            SessionUtil.setSessionAttributes(
                request,
                result.getUser().getUserId(),
                result.getUser().getEmail(),
                result.getStudent().getFullName(),
                UserRole.STUDENT,
                result.getStudent().getStudentId(),
                null
            );

            request.getSession().setAttribute(AppConstants.FLASH_SUCCESS, "Account created successfully! Welcome to SkillTrack.");
            response.sendRedirect(request.getContextPath() + "/app/student/dashboard");
        } else {
            try {
                List<TargetRole> roles = targetRoleDAO.findAll(true);
                request.setAttribute("targetRoles", roles);
            } catch (SQLException ignored) {
            }

            request.setAttribute(AppConstants.FLASH_ERROR, result.getErrorMessage());
            request.setAttribute("email", email);
            request.setAttribute("fullName", fullName);
            request.setAttribute("rollNumber", rollNumber);
            request.setAttribute("department", department);
            request.setAttribute("graduationYear", gradYearStr);
            request.setAttribute("cgpa", cgpaStr);
            request.setAttribute("targetRoleId", targetRoleIdStr);

            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
        }
    }
}
