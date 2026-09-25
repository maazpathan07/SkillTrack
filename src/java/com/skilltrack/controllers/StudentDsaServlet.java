package com.skilltrack.controllers;

import com.skilltrack.constants.AppConstants;
import com.skilltrack.models.StudentDsaProgress;
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

@WebServlet(name = "StudentDsaServlet", urlPatterns = {"/app/student/dsa"})
public class StudentDsaServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(StudentDsaServlet.class.getName());

    private final StudentService studentService = new StudentService();
    private final com.skilltrack.services.CodePlatformSyncService syncService = new com.skilltrack.services.CodePlatformSyncService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Integer studentId = SessionUtil.getStudentId(request);
        if (studentId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            List<StudentDsaProgress> progressList = studentService.getDsaProgress(studentId);
            com.skilltrack.models.StudentCodingProfile codingProfile = syncService.getStudentCodingProfile(studentId);

            int totalSolved = 0;
            int completedTopics = 0;
            int inProgressTopics = 0;

            for (StudentDsaProgress p : progressList) {
                totalSolved += p.getProblemsSolved();
                if ("COMPLETED".equalsIgnoreCase(p.getStatus())) {
                    completedTopics++;
                } else if ("IN_PROGRESS".equalsIgnoreCase(p.getStatus())) {
                    inProgressTopics++;
                }
            }

            request.setAttribute("progressList", progressList);
            request.setAttribute("codingProfile", codingProfile);
            request.setAttribute("totalSolved", totalSolved);
            request.setAttribute("completedTopics", completedTopics);
            request.setAttribute("inProgressTopics", inProgressTopics);
            request.setAttribute("totalTopics", progressList.size());
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error loading DSA progress for student: " + studentId, e);
            request.setAttribute(AppConstants.FLASH_ERROR, "Error loading DSA tracker.");
        }

        request.getRequestDispatcher("/WEB-INF/views/student/dsa-tracker.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Integer studentId = SessionUtil.getStudentId(request);
        if (studentId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String topicIdStr = request.getParameter("topicId");
        String status = request.getParameter("status");
        String problemsSolvedStr = request.getParameter("problemsSolved");
        String notes = request.getParameter("notes");

        int topicId = ValidationUtil.parsePositiveInt(topicIdStr, 0);
        int problemsSolved = ValidationUtil.parsePositiveInt(problemsSolvedStr, 0);

        if (topicId <= 0) {
            request.getSession().setAttribute(AppConstants.FLASH_ERROR, "Invalid DSA topic specified.");
        } else {
            try {
                studentService.updateDsaProgress(studentId, topicId, status, problemsSolved, notes);
                request.getSession().setAttribute(AppConstants.FLASH_SUCCESS, "Topic progress updated successfully.");
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "Error updating DSA progress for student: " + studentId, e);
                request.getSession().setAttribute(AppConstants.FLASH_ERROR, "A database error occurred while updating progress.");
            }
        }

        response.sendRedirect(request.getContextPath() + "/app/student/dsa");
    }
}
