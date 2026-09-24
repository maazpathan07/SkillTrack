package com.skilltrack.controllers;

import com.skilltrack.constants.AppConstants;
import com.skilltrack.constants.UserRole;
import com.skilltrack.dto.ReadinessScoreDTO;
import com.skilltrack.dto.SkillGapDTO;
import com.skilltrack.dto.StudentProfileDTO;
import com.skilltrack.models.Student;
import com.skilltrack.services.ReadinessScoreService;
import com.skilltrack.services.SkillGapService;
import com.skilltrack.services.StudentService;
import com.skilltrack.utils.DateUtil;
import com.skilltrack.utils.SessionUtil;
import com.skilltrack.utils.ValidationUtil;
import java.io.IOException;
import java.time.LocalDateTime;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ReadinessCardServlet", urlPatterns = {"/app/student/readiness-card", "/app/admin/readiness-card"})
public class ReadinessCardServlet extends HttpServlet {

    private final StudentService studentService = new StudentService();
    private final ReadinessScoreService readinessScoreService = new ReadinessScoreService();
    private final SkillGapService skillGapService = new SkillGapService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserRole role = SessionUtil.getUserRole(request);
        Integer studentId = null;

        if (role == UserRole.ADMIN) {
            String studentIdStr = request.getParameter("studentId");
            int parsedId = ValidationUtil.parsePositiveInt(studentIdStr, 0);
            if (parsedId > 0) {
                studentId = parsedId;
            }
        }

        if (studentId == null) {
            studentId = SessionUtil.getStudentId(request);
        }

        if (studentId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        StudentProfileDTO profile = studentService.getStudentProfile(studentId);
        if (profile == null) {
            request.getSession().setAttribute(AppConstants.FLASH_ERROR, "Student profile not found.");
            response.sendRedirect(request.getContextPath() + (role == UserRole.ADMIN ? "/app/admin/students" : "/app/student/dashboard"));
            return;
        }

        ReadinessScoreDTO readiness = readinessScoreService.calculateReadiness(studentId);
        SkillGapDTO skillGap = skillGapService.calculateSkillGap(studentId, profile.getStudent().getTargetRoleId());

        request.setAttribute("profile", profile);
        request.setAttribute("student", profile.getStudent());
        request.setAttribute("readiness", readiness);
        request.setAttribute("skillGap", skillGap);
        request.setAttribute("generatedTimestamp", DateUtil.formatDateTime(LocalDateTime.now()));
        request.setAttribute("disclaimer", AppConstants.READINESS_DISCLAIMER);

        request.getRequestDispatcher("/WEB-INF/views/student/readiness-card.jsp").forward(request, response);
    }
}
