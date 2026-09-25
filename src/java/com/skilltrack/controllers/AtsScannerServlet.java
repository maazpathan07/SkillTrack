package com.skilltrack.controllers;

import com.skilltrack.constants.AppConstants;
import com.skilltrack.dao.PlacementCriteriaDAO;
import com.skilltrack.dao.TargetRoleDAO;
import com.skilltrack.dto.AtsScanResultDTO;
import com.skilltrack.dto.StudentProfileDTO;
import com.skilltrack.models.PlacementCriteria;
import com.skilltrack.models.TargetRole;
import com.skilltrack.services.AtsScannerService;
import com.skilltrack.services.StudentService;
import com.skilltrack.utils.CsrfUtil;
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

@WebServlet(name = "AtsScannerServlet", urlPatterns = {"/app/student/ats-scanner"})
public class AtsScannerServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(AtsScannerServlet.class.getName());

    private final StudentService studentService = new StudentService();
    private final AtsScannerService atsScannerService = new AtsScannerService();
    private final TargetRoleDAO targetRoleDAO = new TargetRoleDAO();
    private final PlacementCriteriaDAO placementCriteriaDAO = new PlacementCriteriaDAO();

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
            request.getSession().setAttribute(AppConstants.FLASH_ERROR, "Student profile not found.");
            response.sendRedirect(request.getContextPath() + "/app/student/dashboard");
            return;
        }

        loadFormData(request);

        Integer defaultRoleId = profile.getStudent().getTargetRoleId();
        // Perform initial baseline scan using student profile data
        AtsScanResultDTO baselineScan = atsScannerService.scanResume(null, defaultRoleId, null, profile);

        request.setAttribute("profile", profile);
        request.setAttribute("student", profile.getStudent());
        request.setAttribute("scanResult", baselineScan);
        request.setAttribute("selectedRoleId", defaultRoleId);

        request.getRequestDispatcher("/WEB-INF/views/student/ats-scanner.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Integer studentId = SessionUtil.getStudentId(request);
        if (studentId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        if (!CsrfUtil.isValidToken(request)) {
            request.getSession().setAttribute(AppConstants.FLASH_ERROR, "Invalid security token. Please try again.");
            response.sendRedirect(request.getContextPath() + "/app/student/ats-scanner");
            return;
        }

        StudentProfileDTO profile = studentService.getStudentProfile(studentId);
        if (profile == null) {
            request.getSession().setAttribute(AppConstants.FLASH_ERROR, "Student profile not found.");
            response.sendRedirect(request.getContextPath() + "/app/student/dashboard");
            return;
        }

        String resumeText = request.getParameter("resumeText");
        String roleIdStr = request.getParameter("targetRoleId");
        String criteriaIdStr = request.getParameter("criteriaId");

        Integer targetRoleId = ValidationUtil.parsePositiveInt(roleIdStr, 0);
        if (targetRoleId <= 0) targetRoleId = profile.getStudent().getTargetRoleId();

        Integer criteriaId = ValidationUtil.parsePositiveInt(criteriaIdStr, 0);
        if (criteriaId <= 0) criteriaId = null;

        AtsScanResultDTO scanResult = atsScannerService.scanResume(resumeText, targetRoleId, criteriaId, profile);

        loadFormData(request);

        request.setAttribute("profile", profile);
        request.setAttribute("student", profile.getStudent());
        request.setAttribute("scanResult", scanResult);
        request.setAttribute("resumeText", resumeText);
        request.setAttribute("selectedRoleId", targetRoleId);
        request.setAttribute("selectedCriteriaId", criteriaId);

        request.getRequestDispatcher("/WEB-INF/views/student/ats-scanner.jsp").forward(request, response);
    }

    private void loadFormData(HttpServletRequest request) {
        try {
            List<TargetRole> targetRoles = targetRoleDAO.findAll(true);
            List<PlacementCriteria> criteriaList = placementCriteriaDAO.findAll(true);
            request.setAttribute("targetRoles", targetRoles);
            request.setAttribute("criteriaList", criteriaList);
        } catch (SQLException e) {
            LOGGER.log(Level.WARNING, "Error loading form dropdowns for ATS scanner", e);
        }
    }
}
