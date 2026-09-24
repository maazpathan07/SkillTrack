package com.skilltrack.controllers;

import com.skilltrack.constants.AppConstants;
import com.skilltrack.dto.ReadinessScoreDTO;
import com.skilltrack.dto.SkillGapDTO;
import com.skilltrack.dto.StudentDashboardDTO;
import com.skilltrack.models.PreparationTask;
import com.skilltrack.models.Project;
import com.skilltrack.models.Student;
import com.skilltrack.services.ReadinessScoreService;
import com.skilltrack.services.SkillGapService;
import com.skilltrack.services.StudentService;
import com.skilltrack.utils.SessionUtil;
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

@WebServlet(name = "StudentDashboardServlet", urlPatterns = {"/app/student/dashboard"})
public class StudentDashboardServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(StudentDashboardServlet.class.getName());

    private final StudentService studentService = new StudentService();
    private final SkillGapService skillGapService = new SkillGapService();
    private final ReadinessScoreService readinessScoreService = new ReadinessScoreService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Integer studentId = SessionUtil.getStudentId(request);
        if (studentId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Student student = studentService.getStudentById(studentId);
        if (student == null) {
            request.getSession().setAttribute(AppConstants.FLASH_ERROR, "Student profile not found.");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        StudentDashboardDTO dto = new StudentDashboardDTO();
        dto.setStudent(student);

        // Single Source of Truth metrics
        ReadinessScoreDTO readiness = readinessScoreService.calculateReadiness(studentId);
        dto.setReadinessScore(readiness);

        SkillGapDTO skillGap = skillGapService.calculateSkillGap(studentId, student.getTargetRoleId());
        dto.setSkillGap(skillGap);

        try {
            dto.setSkillsCount(studentService.getStudentSkills(studentId).size());
            List<Project> projs = studentService.getStudentProjects(studentId);
            dto.setProjectsCount(projs.size());
            dto.setRecentProjects(projs.size() > 3 ? projs.subList(0, 3) : projs);

            dto.setCertsCount(studentService.getStudentCertifications(studentId).size());

            dto.setDsaProblemsSolved(readiness.getDsaSolved());
            dto.setTotalDsaTopics(18);

            List<PreparationTask> tasks = studentService.getStudentTasks(studentId);
            int pending = 0;
            int completed = 0;
            for (PreparationTask t : tasks) {
                if (t.isCompleted()) completed++;
                else pending++;
            }
            dto.setPendingTasksCount(pending);
            dto.setCompletedTasksCount(completed);
            dto.setRecentTasks(tasks.size() > 5 ? tasks.subList(0, 5) : tasks);

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error loading student dashboard for student: " + studentId, e);
        }

        request.setAttribute("dashboard", dto);
        request.setAttribute("disclaimer", AppConstants.READINESS_DISCLAIMER);
        request.getRequestDispatcher("/WEB-INF/views/student/dashboard.jsp").forward(request, response);
    }
}
