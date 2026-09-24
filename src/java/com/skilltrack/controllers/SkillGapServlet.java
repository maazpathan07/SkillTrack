package com.skilltrack.controllers;

import com.skilltrack.constants.AppConstants;
import com.skilltrack.dao.TargetRoleDAO;
import com.skilltrack.dto.SkillGapDTO;
import com.skilltrack.models.Student;
import com.skilltrack.models.TargetRole;
import com.skilltrack.services.SkillGapService;
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

@WebServlet(name = "SkillGapServlet", urlPatterns = {"/app/student/skill-gap"})
public class SkillGapServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(SkillGapServlet.class.getName());

    private final SkillGapService skillGapService = new SkillGapService();
    private final StudentService studentService = new StudentService();
    private final TargetRoleDAO targetRoleDAO = new TargetRoleDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Integer studentId = SessionUtil.getStudentId(request);
        if (studentId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Student student = studentService.getStudentById(studentId);
        String roleIdStr = request.getParameter("roleId");
        int requestedRoleId = ValidationUtil.parsePositiveInt(roleIdStr, 0);

        Integer evalRoleId = (requestedRoleId > 0) ? requestedRoleId :
                             (student != null && student.getTargetRoleId() != null ? student.getTargetRoleId() : null);

        SkillGapDTO skillGap = skillGapService.calculateSkillGap(studentId, evalRoleId);

        try {
            List<TargetRole> targetRoles = targetRoleDAO.findAll(true);
            request.setAttribute("targetRoles", targetRoles);
        } catch (SQLException e) {
            LOGGER.log(Level.WARNING, "Error loading target roles list", e);
        }

        request.setAttribute("student", student);
        request.setAttribute("selectedRoleId", evalRoleId);
        request.setAttribute("skillGap", skillGap);

        request.getRequestDispatcher("/WEB-INF/views/student/skill-gap.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Integer studentId = SessionUtil.getStudentId(request);
        if (studentId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String targetRoleIdStr = request.getParameter("targetRoleId");
        int targetRoleId = ValidationUtil.parsePositiveInt(targetRoleIdStr, 0);

        try {
            if (targetRoleId > 0) {
                studentService.updateTargetRole(studentId, targetRoleId);
                request.getSession().setAttribute(AppConstants.FLASH_SUCCESS, "Target role updated successfully.");
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error setting target role for student: " + studentId, e);
            request.getSession().setAttribute(AppConstants.FLASH_ERROR, "A database error occurred while updating target role.");
        }

        response.sendRedirect(request.getContextPath() + "/app/student/skill-gap?roleId=" + targetRoleId);
    }
}
