package com.skilltrack.controllers;

import com.skilltrack.constants.AppConstants;
import com.skilltrack.constants.Department;
import com.skilltrack.constants.SkillLevel;
import com.skilltrack.dao.PlacementCriteriaDAO;
import com.skilltrack.dao.SkillDAO;
import com.skilltrack.models.CriteriaSkillRequirement;
import com.skilltrack.models.PlacementCriteria;
import com.skilltrack.models.Skill;
import com.skilltrack.services.PlacementCriteriaService;
import com.skilltrack.utils.ValidationUtil;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "AdminCriteriaServlet", urlPatterns = {"/app/admin/criteria"})
public class AdminCriteriaServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(AdminCriteriaServlet.class.getName());

    private final PlacementCriteriaService placementCriteriaService = new PlacementCriteriaService();
    private final SkillDAO skillDAO = new SkillDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String criteriaIdStr = request.getParameter("criteriaId");
        int criteriaId = ValidationUtil.parsePositiveInt(criteriaIdStr, 0);

        try {
            List<PlacementCriteria> criteriaList = placementCriteriaService.getAllCriteria(false);
            List<Skill> allSkills = skillDAO.findAll();

            request.setAttribute("criteriaList", criteriaList);
            request.setAttribute("allSkills", allSkills);
            request.setAttribute("skillLevels", SkillLevel.values());
            request.setAttribute("departments", Department.values());

            if (criteriaId > 0) {
                PlacementCriteria editCriteria = placementCriteriaService.getCriteriaById(criteriaId);
                request.setAttribute("editCriteria", editCriteria);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error loading placement criteria for admin", e);
            request.setAttribute(AppConstants.FLASH_ERROR, "Error loading criteria profiles.");
        }

        request.getRequestDispatcher("/WEB-INF/views/admin/criteria-management.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String criteriaIdStr = request.getParameter("criteriaId");
        int criteriaId = ValidationUtil.parsePositiveInt(criteriaIdStr, 0);

        try {
            if ("delete".equalsIgnoreCase(action)) {
                if (criteriaId > 0) {
                    placementCriteriaService.deleteCriteria(criteriaId);
                    request.getSession().setAttribute(AppConstants.FLASH_SUCCESS, "Criteria profile deleted successfully.");
                }
            } else {
                String companyName = request.getParameter("companyName");
                String roleTitle = request.getParameter("roleTitle");
                String minCgpaStr = request.getParameter("minCgpa");
                String minDsaStr = request.getParameter("minDsaProblems");
                String minProjectsStr = request.getParameter("minProjects");
                String minCertsStr = request.getParameter("minCertifications");
                String[] deptsArray = request.getParameterValues("allowedDepartments");
                boolean isActive = "1".equals(request.getParameter("isActive")) || "true".equalsIgnoreCase(request.getParameter("isActive")) || request.getParameter("isActive") == null;

                if (!ValidationUtil.isNotEmpty(companyName)) {
                    throw new IllegalArgumentException("Company Name is required.");
                }
                if (!ValidationUtil.isNotEmpty(roleTitle)) {
                    throw new IllegalArgumentException("Role Title is required.");
                }

                double minCgpa = ValidationUtil.parseDouble(minCgpaStr, 0.0);
                int minDsa = ValidationUtil.parsePositiveInt(minDsaStr, 0);
                int minProj = ValidationUtil.parsePositiveInt(minProjectsStr, 0);
                int minCerts = ValidationUtil.parsePositiveInt(minCertsStr, 0);

                String allowedDepts = "ALL";
                if (deptsArray != null && deptsArray.length > 0) {
                    allowedDepts = String.join(",", deptsArray);
                }

                PlacementCriteria c = new PlacementCriteria();
                c.setCriteriaId(criteriaId);
                c.setCompanyName(companyName.trim());
                c.setRoleTitle(roleTitle.trim());
                c.setMinCgpa(minCgpa);
                c.setMinDsaProblems(minDsa);
                c.setMinProjects(minProj);
                c.setMinCertifications(minCerts);
                c.setAllowedDepartments(allowedDepts);
                c.setActive(isActive);

                // Parse mapped skill requirements
                List<CriteriaSkillRequirement> requirements = new ArrayList<>();
                String[] skillIds = request.getParameterValues("selectedSkills");
                if (skillIds != null) {
                    for (String sIdStr : skillIds) {
                        int sId = ValidationUtil.parsePositiveInt(sIdStr, 0);
                        if (sId > 0) {
                            String profStr = request.getParameter("minProficiency_" + sId);
                            SkillLevel minProf = SkillLevel.fromString(profStr);
                            if (minProf == null) minProf = SkillLevel.BEGINNER;

                            boolean mandatory = "1".equals(request.getParameter("mandatory_" + sId)) ||
                                                "true".equalsIgnoreCase(request.getParameter("mandatory_" + sId));

                            CriteriaSkillRequirement req = new CriteriaSkillRequirement();
                            req.setSkillId(sId);
                            req.setMinProficiency(minProf);
                            req.setMandatory(mandatory);
                            requirements.add(req);
                        }
                    }
                }

                if (criteriaId > 0) {
                    placementCriteriaService.updateCriteria(c, requirements);
                    request.getSession().setAttribute(AppConstants.FLASH_SUCCESS, "Criteria profile updated successfully.");
                } else {
                    placementCriteriaService.createCriteria(c, requirements);
                    request.getSession().setAttribute(AppConstants.FLASH_SUCCESS, "New criteria profile created successfully.");
                }
            }
        } catch (IllegalArgumentException e) {
            request.getSession().setAttribute(AppConstants.FLASH_ERROR, e.getMessage());
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Database error modifying criteria profile", e);
            request.getSession().setAttribute(AppConstants.FLASH_ERROR, "A database error occurred while modifying the criteria.");
        }

        response.sendRedirect(request.getContextPath() + "/app/admin/criteria");
    }
}
