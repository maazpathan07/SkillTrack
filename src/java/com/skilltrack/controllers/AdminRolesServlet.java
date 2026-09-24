package com.skilltrack.controllers;

import com.skilltrack.constants.AppConstants;
import com.skilltrack.constants.SkillLevel;
import com.skilltrack.dao.SkillDAO;
import com.skilltrack.dao.TargetRoleDAO;
import com.skilltrack.models.RoleSkillRequirement;
import com.skilltrack.models.Skill;
import com.skilltrack.models.TargetRole;
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

@WebServlet(name = "AdminRolesServlet", urlPatterns = {"/app/admin/roles"})
public class AdminRolesServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(AdminRolesServlet.class.getName());

    private final TargetRoleDAO targetRoleDAO = new TargetRoleDAO();
    private final SkillDAO skillDAO = new SkillDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String roleIdStr = request.getParameter("roleId");
        int roleId = ValidationUtil.parsePositiveInt(roleIdStr, 0);

        try {
            List<TargetRole> roles = targetRoleDAO.findAll(false);
            List<Skill> allSkills = skillDAO.findAll();

            request.setAttribute("roles", roles);
            request.setAttribute("allSkills", allSkills);
            request.setAttribute("skillLevels", SkillLevel.values());

            if (roleId > 0) {
                TargetRole editRole = targetRoleDAO.findById(roleId);
                request.setAttribute("editRole", editRole);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching target roles for admin management", e);
            request.setAttribute(AppConstants.FLASH_ERROR, "Error loading roles.");
        }

        request.getRequestDispatcher("/WEB-INF/views/admin/role-management.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String roleIdStr = request.getParameter("roleId");
        int roleId = ValidationUtil.parsePositiveInt(roleIdStr, 0);

        try {
            if ("delete".equalsIgnoreCase(action)) {
                if (roleId > 0) {
                    targetRoleDAO.deleteRole(roleId);
                    request.getSession().setAttribute(AppConstants.FLASH_SUCCESS, "Role deleted successfully.");
                }
            } else {
                String roleTitle = request.getParameter("roleTitle");
                String description = request.getParameter("description");
                boolean isActive = "1".equals(request.getParameter("isActive")) || "true".equalsIgnoreCase(request.getParameter("isActive")) || request.getParameter("isActive") == null;

                if (!ValidationUtil.isNotEmpty(roleTitle)) {
                    throw new IllegalArgumentException("Role Title is required.");
                }

                TargetRole role = new TargetRole();
                role.setRoleId(roleId);
                role.setRoleTitle(roleTitle.trim());
                role.setDescription(description != null ? description.trim() : null);
                role.setActive(isActive);

                // Parse mapped skill requirements
                List<RoleSkillRequirement> requirements = new ArrayList<>();
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

                            RoleSkillRequirement req = new RoleSkillRequirement();
                            req.setSkillId(sId);
                            req.setMinProficiency(minProf);
                            req.setMandatory(mandatory);
                            requirements.add(req);
                        }
                    }
                }

                if (roleId > 0) {
                    targetRoleDAO.updateRole(role);
                    targetRoleDAO.saveRoleRequirements(roleId, requirements);
                    request.getSession().setAttribute(AppConstants.FLASH_SUCCESS, "Target role updated successfully.");
                } else {
                    int newRoleId = targetRoleDAO.createRole(role);
                    targetRoleDAO.saveRoleRequirements(newRoleId, requirements);
                    request.getSession().setAttribute(AppConstants.FLASH_SUCCESS, "New target role created successfully.");
                }
            }
        } catch (IllegalArgumentException e) {
            request.getSession().setAttribute(AppConstants.FLASH_ERROR, e.getMessage());
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Database error saving target role", e);
            request.getSession().setAttribute(AppConstants.FLASH_ERROR, "A database error occurred while saving the role.");
        }

        response.sendRedirect(request.getContextPath() + "/app/admin/roles");
    }
}
