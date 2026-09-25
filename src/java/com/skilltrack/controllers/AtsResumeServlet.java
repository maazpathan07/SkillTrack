package com.skilltrack.controllers;

import com.skilltrack.constants.AppConstants;
import com.skilltrack.constants.UserRole;
import com.skilltrack.dto.ReadinessScoreDTO;
import com.skilltrack.dto.StudentProfileDTO;
import com.skilltrack.models.Student;
import com.skilltrack.models.StudentSkill;
import com.skilltrack.services.ReadinessScoreService;
import com.skilltrack.services.StudentService;
import com.skilltrack.utils.DateUtil;
import com.skilltrack.utils.SessionUtil;
import com.skilltrack.utils.ValidationUtil;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "AtsResumeServlet", urlPatterns = {"/app/student/ats-resume", "/app/admin/ats-resume"})
public class AtsResumeServlet extends HttpServlet {

    private final StudentService studentService = new StudentService();
    private final ReadinessScoreService readinessScoreService = new ReadinessScoreService();

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

        // Group skills by category for ATS resume structure
        Map<String, List<String>> categorizedSkills = new LinkedHashMap<>();
        if (profile.getSkills() != null) {
            for (StudentSkill sk : profile.getSkills()) {
                String cat = (sk.getSkillCategory() != null) ? sk.getSkillCategory().getDisplayName() : "Technical Skills";
                categorizedSkills.computeIfAbsent(cat, k -> new ArrayList<>()).add(sk.getSkillName());
            }
        }

        request.setAttribute("profile", profile);
        request.setAttribute("student", profile.getStudent());
        request.setAttribute("readiness", readiness);
        request.setAttribute("categorizedSkills", categorizedSkills);
        request.setAttribute("generatedTimestamp", DateUtil.formatDateTime(LocalDateTime.now()));

        request.getRequestDispatcher("/WEB-INF/views/student/ats-resume.jsp").forward(request, response);
    }
}
