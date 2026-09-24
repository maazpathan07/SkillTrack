package com.skilltrack.controllers;

import com.skilltrack.constants.AppConstants;
import com.skilltrack.constants.SkillCategory;
import com.skilltrack.dao.SkillDAO;
import com.skilltrack.models.Skill;
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

@WebServlet(name = "AdminSkillsServlet", urlPatterns = {"/app/admin/skills"})
public class AdminSkillsServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(AdminSkillsServlet.class.getName());

    private final SkillDAO skillDAO = new SkillDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String skillIdStr = request.getParameter("skillId");
        int skillId = ValidationUtil.parsePositiveInt(skillIdStr, 0);

        try {
            List<Skill> skills = skillDAO.findAll();
            request.setAttribute("skills", skills);
            request.setAttribute("categories", SkillCategory.values());

            if (skillId > 0) {
                Skill editSkill = skillDAO.findById(skillId);
                request.setAttribute("editSkill", editSkill);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error loading master skills", e);
            request.setAttribute(AppConstants.FLASH_ERROR, "Error loading master skill taxonomy.");
        }

        request.getRequestDispatcher("/WEB-INF/views/admin/skill-management.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String skillIdStr = request.getParameter("skillId");
        int skillId = ValidationUtil.parsePositiveInt(skillIdStr, 0);

        try {
            if ("delete".equalsIgnoreCase(action)) {
                if (skillId > 0) {
                    skillDAO.deleteSkill(skillId);
                    request.getSession().setAttribute(AppConstants.FLASH_SUCCESS, "Skill deleted successfully.");
                }
            } else {
                String skillName = request.getParameter("skillName");
                String categoryStr = request.getParameter("category");
                String description = request.getParameter("description");

                if (!ValidationUtil.isNotEmpty(skillName)) {
                    throw new IllegalArgumentException("Skill name is required.");
                }

                SkillCategory category = SkillCategory.fromString(categoryStr);
                if (category == null) {
                    throw new IllegalArgumentException("Valid skill category is required.");
                }

                Skill skill = new Skill();
                skill.setSkillId(skillId);
                skill.setSkillName(skillName.trim());
                skill.setCategory(category);
                skill.setDescription(description != null ? description.trim() : null);

                if (skillId > 0) {
                    skillDAO.updateSkill(skill);
                    request.getSession().setAttribute(AppConstants.FLASH_SUCCESS, "Skill updated successfully.");
                } else {
                    skillDAO.createSkill(skill);
                    request.getSession().setAttribute(AppConstants.FLASH_SUCCESS, "New master skill created.");
                }
            }
        } catch (IllegalArgumentException e) {
            request.getSession().setAttribute(AppConstants.FLASH_ERROR, e.getMessage());
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Database error modifying skill", e);
            request.getSession().setAttribute(AppConstants.FLASH_ERROR, "A database error occurred while modifying the skill.");
        }

        response.sendRedirect(request.getContextPath() + "/app/admin/skills");
    }
}
