package com.skilltrack.controllers;

import com.skilltrack.constants.AppConstants;
import com.skilltrack.constants.SkillLevel;
import com.skilltrack.dao.SkillDAO;
import com.skilltrack.models.Skill;
import com.skilltrack.models.StudentSkill;
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

@WebServlet(name = "StudentSkillsServlet", urlPatterns = {"/app/student/skills"})
public class StudentSkillsServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(StudentSkillsServlet.class.getName());

    private final StudentService studentService = new StudentService();
    private final SkillDAO skillDAO = new SkillDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Integer studentId = SessionUtil.getStudentId(request);
        if (studentId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            List<StudentSkill> studentSkills = studentService.getStudentSkills(studentId);
            List<Skill> allSkills = skillDAO.findAll();

            String editIdStr = request.getParameter("editSkillId");
            if (editIdStr != null && !editIdStr.trim().isEmpty()) {
                int editSkillId = ValidationUtil.parsePositiveInt(editIdStr, 0);
                for (StudentSkill ss : studentSkills) {
                    if (ss.getSkillId() == editSkillId) {
                        request.setAttribute("editSkill", ss);
                        break;
                    }
                }
            }

            request.setAttribute("studentSkills", studentSkills);
            request.setAttribute("allSkills", allSkills);
            request.setAttribute("skillLevels", SkillLevel.values());
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error loading student skills: " + studentId, e);
            request.setAttribute(AppConstants.FLASH_ERROR, "Error loading skills.");
        }

        request.getRequestDispatcher("/WEB-INF/views/student/skills.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Integer studentId = SessionUtil.getStudentId(request);
        if (studentId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        String skillIdStr = request.getParameter("skillId");
        int skillId = ValidationUtil.parsePositiveInt(skillIdStr, 0);

        try {
            if ("delete".equalsIgnoreCase(action)) {
                if (skillId > 0) {
                    studentService.deleteSkill(studentId, skillId);
                    request.getSession().setAttribute(AppConstants.FLASH_SUCCESS, "Skill removed from profile.");
                }
            } else {
                // Save or update skill
                String levelStr = request.getParameter("proficiencyLevel");
                SkillLevel level = SkillLevel.fromString(levelStr);

                if (skillId <= 0 || level == null) {
                    request.getSession().setAttribute(AppConstants.FLASH_ERROR, "Please select a valid skill and proficiency level.");
                } else {
                    studentService.addOrUpdateSkill(studentId, skillId, level);
                    request.getSession().setAttribute(AppConstants.FLASH_SUCCESS, "Skill proficiency saved successfully.");
                }
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error modifying student skill: " + studentId, e);
            request.getSession().setAttribute(AppConstants.FLASH_ERROR, "An error occurred while saving skill.");
        }

        response.sendRedirect(request.getContextPath() + "/app/student/skills");
    }
}
