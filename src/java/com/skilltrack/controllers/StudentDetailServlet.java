package com.skilltrack.controllers;

import com.skilltrack.constants.AppConstants;
import com.skilltrack.dto.ReadinessScoreDTO;
import com.skilltrack.dto.SkillGapDTO;
import com.skilltrack.dto.StudentProfileDTO;
import com.skilltrack.services.ReadinessScoreService;
import com.skilltrack.services.SkillGapService;
import com.skilltrack.services.StudentService;
import com.skilltrack.utils.ValidationUtil;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "StudentDetailServlet", urlPatterns = {"/app/admin/student-detail", "/app/admin/students/detail"})
public class StudentDetailServlet extends HttpServlet {

    private final StudentService studentService = new StudentService();
    private final ReadinessScoreService readinessScoreService = new ReadinessScoreService();
    private final SkillGapService skillGapService = new SkillGapService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String studentIdStr = request.getParameter("studentId");
        if (studentIdStr == null || studentIdStr.trim().isEmpty()) {
            studentIdStr = request.getParameter("id");
        }
        int studentId = ValidationUtil.parsePositiveInt(studentIdStr, 0);

        if (studentId <= 0) {
            request.getSession().setAttribute(AppConstants.FLASH_ERROR, "Invalid student specified.");
            response.sendRedirect(request.getContextPath() + "/app/admin/students");
            return;
        }

        StudentProfileDTO profile = studentService.getStudentProfile(studentId);
        if (profile == null) {
            request.getSession().setAttribute(AppConstants.FLASH_ERROR, "Student profile not found.");
            response.sendRedirect(request.getContextPath() + "/app/admin/students");
            return;
        }

        ReadinessScoreDTO readiness = readinessScoreService.calculateReadiness(studentId);
        SkillGapDTO skillGap = skillGapService.calculateSkillGap(studentId, profile.getStudent().getTargetRoleId());

        request.setAttribute("profile", profile);
        request.setAttribute("student", profile.getStudent());
        request.setAttribute("readiness", readiness);
        request.setAttribute("skillGap", skillGap);
        request.setAttribute("disclaimer", AppConstants.READINESS_DISCLAIMER);

        request.getRequestDispatcher("/WEB-INF/views/admin/student-detail.jsp").forward(request, response);
    }
}
