package com.skilltrack.controllers;

import com.skilltrack.constants.AppConstants;
import com.skilltrack.models.Project;
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

@WebServlet(name = "StudentProjectsServlet", urlPatterns = {"/app/student/projects"})
public class StudentProjectsServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(StudentProjectsServlet.class.getName());

    private final StudentService studentService = new StudentService();
    private final com.skilltrack.services.CodePlatformSyncService syncService = new com.skilltrack.services.CodePlatformSyncService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Integer studentId = SessionUtil.getStudentId(request);
        if (studentId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String editIdStr = request.getParameter("editId");
        int editId = ValidationUtil.parsePositiveInt(editIdStr, 0);

        try {
            List<Project> projects = studentService.getStudentProjects(studentId);
            com.skilltrack.models.StudentCodingProfile codingProfile = syncService.getStudentCodingProfile(studentId);
            request.setAttribute("projects", projects);
            request.setAttribute("codingProfile", codingProfile);

            if (editId > 0) {
                Project editProject = studentService.getProject(studentId, editId);
                request.setAttribute("editProject", editProject);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error loading projects for student: " + studentId, e);
            request.setAttribute(AppConstants.FLASH_ERROR, "Error loading project portfolio.");
        }

        request.getRequestDispatcher("/WEB-INF/views/student/projects.jsp").forward(request, response);
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
        String projectIdStr = request.getParameter("projectId");
        int projectId = ValidationUtil.parsePositiveInt(projectIdStr, 0);

        try {
            if ("delete".equalsIgnoreCase(action)) {
                if (projectId > 0) {
                    studentService.deleteProject(studentId, projectId);
                    request.getSession().setAttribute(AppConstants.FLASH_SUCCESS, "Project deleted successfully.");
                }
            } else {
                String title = request.getParameter("title");
                String description = request.getParameter("description");
                String techStack = request.getParameter("techStack");
                String githubUrl = request.getParameter("githubUrl");
                String liveDemoUrl = request.getParameter("liveDemoUrl");

                if (projectId > 0) {
                    studentService.updateProject(studentId, projectId, title, description, techStack, githubUrl, liveDemoUrl);
                    request.getSession().setAttribute(AppConstants.FLASH_SUCCESS, "Project updated successfully.");
                } else {
                    studentService.addProject(studentId, title, description, techStack, githubUrl, liveDemoUrl);
                    request.getSession().setAttribute(AppConstants.FLASH_SUCCESS, "New project added to portfolio.");
                }
            }
        } catch (IllegalArgumentException e) {
            request.getSession().setAttribute(AppConstants.FLASH_ERROR, e.getMessage());
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Database error saving project for student: " + studentId, e);
            request.getSession().setAttribute(AppConstants.FLASH_ERROR, "A database error occurred while saving the project.");
        }

        response.sendRedirect(request.getContextPath() + "/app/student/projects");
    }
}
