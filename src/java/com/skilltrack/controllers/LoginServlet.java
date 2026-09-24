package com.skilltrack.controllers;

import com.skilltrack.constants.AppConstants;
import com.skilltrack.constants.UserRole;
import com.skilltrack.services.AuthService;
import com.skilltrack.utils.SessionUtil;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    private final AuthService authService = new AuthService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (SessionUtil.isAuthenticated(request)) {
            UserRole role = SessionUtil.getUserRole(request);
            if (role == UserRole.ADMIN) {
                response.sendRedirect(request.getContextPath() + "/app/admin/dashboard");
            } else {
                response.sendRedirect(request.getContextPath() + "/app/student/dashboard");
            }
            return;
        }

        request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        AuthService.AuthResult result = authService.login(email, password);

        if (result.isSuccess()) {
            Integer studentId = (result.getStudent() != null) ? result.getStudent().getStudentId() : null;
            Integer adminId = (result.getAdmin() != null) ? result.getAdmin().getAdminId() : null;
            String name = (result.getStudent() != null) ? result.getStudent().getFullName() :
                          (result.getAdmin() != null) ? result.getAdmin().getFullName() : "User";

            SessionUtil.setSessionAttributes(
                request,
                result.getUser().getUserId(),
                result.getUser().getEmail(),
                name,
                result.getUser().getRole(),
                studentId,
                adminId
            );

            request.getSession().setAttribute(AppConstants.FLASH_SUCCESS, "Welcome back, " + name + "!");

            if (result.getUser().getRole() == UserRole.ADMIN) {
                response.sendRedirect(request.getContextPath() + "/app/admin/dashboard");
            } else {
                response.sendRedirect(request.getContextPath() + "/app/student/dashboard");
            }
        } else {
            request.setAttribute(AppConstants.FLASH_ERROR, result.getErrorMessage());
            request.setAttribute("email", email);
            request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
        }
    }
}
