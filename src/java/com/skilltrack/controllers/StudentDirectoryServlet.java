package com.skilltrack.controllers;

import com.skilltrack.constants.AppConstants;
import com.skilltrack.constants.SkillLevel;
import com.skilltrack.dao.SkillDAO;
import com.skilltrack.dao.TargetRoleDAO;
import com.skilltrack.dto.StudentDirectoryDTO;
import com.skilltrack.models.Skill;
import com.skilltrack.models.TargetRole;
import com.skilltrack.services.AnalyticsService;
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

@WebServlet(name = "StudentDirectoryServlet", urlPatterns = {"/app/admin/students"})
public class StudentDirectoryServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(StudentDirectoryServlet.class.getName());

    private final AnalyticsService analyticsService = new AnalyticsService();
    private final TargetRoleDAO targetRoleDAO = new TargetRoleDAO();
    private final SkillDAO skillDAO = new SkillDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String search = request.getParameter("search");
        String dept = request.getParameter("department");
        String gradYearStr = request.getParameter("graduationYear");
        String roleIdStr = request.getParameter("targetRoleId");
        String minCgpaStr = request.getParameter("minCgpa");
        String minReadinessStr = request.getParameter("minReadiness");
        String skillIdStr = request.getParameter("skillId");
        String skillLevel = request.getParameter("skillLevel");
        String pageStr = request.getParameter("page");

        Integer gradYear = (gradYearStr != null && !gradYearStr.isEmpty()) ? ValidationUtil.parsePositiveInt(gradYearStr, 0) : null;
        Integer targetRoleId = (roleIdStr != null && !roleIdStr.isEmpty()) ? ValidationUtil.parsePositiveInt(roleIdStr, 0) : null;
        Double minCgpa = (minCgpaStr != null && !minCgpaStr.isEmpty()) ? ValidationUtil.parseDouble(minCgpaStr, 0.0) : null;
        Double minReadiness = (minReadinessStr != null && !minReadinessStr.isEmpty()) ? ValidationUtil.parseDouble(minReadinessStr, 0.0) : null;
        Integer skillId = (skillIdStr != null && !skillIdStr.isEmpty()) ? ValidationUtil.parsePositiveInt(skillIdStr, 0) : null;
        int page = ValidationUtil.parsePositiveInt(pageStr, 1);

        StudentDirectoryDTO directory = analyticsService.getStudentDirectory(
            search, dept, (gradYear != null && gradYear > 0 ? gradYear : null),
            (targetRoleId != null && targetRoleId > 0 ? targetRoleId : null),
            (minCgpa != null && minCgpa > 0.0 ? minCgpa : null),
            (minReadiness != null && minReadiness > 0.0 ? minReadiness : null),
            (skillId != null && skillId > 0 ? skillId : null),
            skillLevel, page, AppConstants.DEFAULT_PAGE_SIZE
        );

        try {
            List<TargetRole> roles = targetRoleDAO.findAll(true);
            List<Skill> skills = skillDAO.findAll();
            request.setAttribute("targetRoles", roles);
            request.setAttribute("skills", skills);
            request.setAttribute("skillLevels", SkillLevel.values());
        } catch (SQLException e) {
            LOGGER.log(Level.WARNING, "Error loading filter dropdown data", e);
        }

        request.setAttribute("directory", directory);
        request.getRequestDispatcher("/WEB-INF/views/admin/student-directory.jsp").forward(request, response);
    }
}
