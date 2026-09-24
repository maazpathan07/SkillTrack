package com.skilltrack.controllers;

import com.skilltrack.constants.AppConstants;
import com.skilltrack.utils.SessionUtil;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "LogoutServlet", urlPatterns = {"/logout"})
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        SessionUtil.invalidateSession(request);
        HttpSession newSession = request.getSession(true);
        newSession.setAttribute(AppConstants.FLASH_INFO, "You have been logged out successfully.");
        response.sendRedirect(request.getContextPath() + "/login");
    }
}
