package com.skilltrack.controllers;

import com.skilltrack.constants.AppConstants;
import com.skilltrack.constants.TaskStatus;
import com.skilltrack.models.PreparationTask;
import com.skilltrack.services.StudentService;
import com.skilltrack.utils.DateUtil;
import com.skilltrack.utils.SessionUtil;
import com.skilltrack.utils.ValidationUtil;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "StudentTasksServlet", urlPatterns = {"/app/student/tasks"})
public class StudentTasksServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(StudentTasksServlet.class.getName());

    private final StudentService studentService = new StudentService();

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
            List<PreparationTask> tasks = studentService.getStudentTasks(studentId);
            request.setAttribute("tasks", tasks);

            if (editId > 0) {
                PreparationTask editTask = studentService.getTask(studentId, editId);
                request.setAttribute("editTask", editTask);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error loading tasks for student: " + studentId, e);
            request.setAttribute(AppConstants.FLASH_ERROR, "Error loading preparation tasks.");
        }

        request.getRequestDispatcher("/WEB-INF/views/student/tasks.jsp").forward(request, response);
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
        String taskIdStr = request.getParameter("taskId");
        int taskId = ValidationUtil.parsePositiveInt(taskIdStr, 0);

        try {
            if ("delete".equalsIgnoreCase(action)) {
                if (taskId > 0) {
                    studentService.deleteTask(studentId, taskId);
                    request.getSession().setAttribute(AppConstants.FLASH_SUCCESS, "Task deleted.");
                }
            } else if ("toggle".equalsIgnoreCase(action)) {
                String statusStr = request.getParameter("status");
                TaskStatus newStatus = TaskStatus.fromString(statusStr);
                if (taskId > 0 && newStatus != null) {
                    studentService.updateTaskStatus(studentId, taskId, newStatus);
                    request.getSession().setAttribute(AppConstants.FLASH_SUCCESS, "Task status updated.");
                }
            } else {
                String title = request.getParameter("title");
                String description = request.getParameter("description");
                String targetDateStr = request.getParameter("targetDate");
                String statusStr = request.getParameter("status");

                LocalDate targetDate = DateUtil.parseDate(targetDateStr);
                TaskStatus status = TaskStatus.fromString(statusStr);

                if (taskId > 0) {
                    studentService.updateTask(studentId, taskId, title, description, status, targetDate);
                    request.getSession().setAttribute(AppConstants.FLASH_SUCCESS, "Task updated.");
                } else {
                    studentService.addTask(studentId, title, description, targetDate);
                    request.getSession().setAttribute(AppConstants.FLASH_SUCCESS, "New task added.");
                }
            }
        } catch (IllegalArgumentException e) {
            request.getSession().setAttribute(AppConstants.FLASH_ERROR, e.getMessage());
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Database error saving task for student: " + studentId, e);
            request.getSession().setAttribute(AppConstants.FLASH_ERROR, "A database error occurred while saving the task.");
        }

        response.sendRedirect(request.getContextPath() + "/app/student/tasks");
    }
}
