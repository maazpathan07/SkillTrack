package com.skilltrack.controllers;

import com.skilltrack.constants.TaskStatus;
import com.skilltrack.dao.PlacementCriteriaDAO;
import com.skilltrack.dao.TaskDAO;
import com.skilltrack.dto.AiCoachOverviewDTO;
import com.skilltrack.dto.CoachChatMessageDTO;
import com.skilltrack.models.PlacementCriteria;
import com.skilltrack.models.PreparationTask;
import com.skilltrack.services.AiPlacementCoachService;
import com.skilltrack.utils.CsrfUtil;
import com.skilltrack.utils.SessionUtil;
import java.io.IOException;
import java.io.PrintWriter;
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

@WebServlet(name = "StudentAiCoachServlet", urlPatterns = {"/app/student/ai-coach"})
public class StudentAiCoachServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(StudentAiCoachServlet.class.getName());

    private final AiPlacementCoachService coachService = new AiPlacementCoachService();
    private final PlacementCriteriaDAO criteriaDAO = new PlacementCriteriaDAO();
    private final TaskDAO taskDAO = new TaskDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Integer studentId = SessionUtil.getStudentId(request);
        if (studentId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            String criteriaIdParam = request.getParameter("criteriaId");
            Integer criteriaId = null;
            if (criteriaIdParam != null && !criteriaIdParam.trim().isEmpty()) {
                try {
                    criteriaId = Integer.parseInt(criteriaIdParam.trim());
                } catch (NumberFormatException ignored) {}
            }

            List<PlacementCriteria> companyPresets = criteriaDAO.findAll(true);
            AiCoachOverviewDTO overview = coachService.getCoachOverview(studentId, criteriaId);

            request.setAttribute("companyPresets", companyPresets);
            request.setAttribute("coachOverview", overview);
            request.setAttribute("selectedCriteriaId", criteriaId);

            request.getRequestDispatcher("/WEB-INF/views/student/ai-coach.jsp").forward(request, response);

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error loading AI Coach for student: " + studentId, e);
            response.sendRedirect(request.getContextPath() + "/app/student/dashboard");
        }
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
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Invalid CSRF token");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }

        switch (action) {
            case "chat-query":
                handleChatQuery(request, response, studentId);
                break;

            case "add-plan-task":
                handleAddPlanTask(request, response, studentId);
                break;

            default:
                response.sendRedirect(request.getContextPath() + "/app/student/ai-coach");
                break;
        }
    }

    private void handleChatQuery(HttpServletRequest request, HttpServletResponse response, int studentId)
            throws IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String query = request.getParameter("query");
        if (query == null || query.trim().isEmpty()) {
            query = request.getParameter("message");
        }
        String criteriaIdParam = request.getParameter("criteriaId");
        Integer criteriaId = null;
        if (criteriaIdParam != null && !criteriaIdParam.trim().isEmpty()) {
            try {
                criteriaId = Integer.parseInt(criteriaIdParam.trim());
            } catch (NumberFormatException ignored) {}
        }

        if (query == null || query.trim().isEmpty()) {
            out.print("{\"status\":\"error\",\"message\":\"Query cannot be empty\"}");
            return;
        }

        CoachChatMessageDTO coachReply = coachService.processStudentQuery(studentId, query.trim(), criteriaId);

        StringBuilder json = new StringBuilder();
        json.append("{");
        json.append("\"status\":\"success\",");
        json.append("\"sender\":\"AI\",");
        json.append("\"message\":").append(escapeJson(coachReply.getContent())).append(",");
        json.append("\"formattedTime\":").append(escapeJson(coachReply.getFormattedTime())).append(",");
        json.append("\"followups\":[");
        List<String> followups = coachReply.getQuickFollowups();
        if (followups != null) {
            for (int i = 0; i < followups.size(); i++) {
                json.append(escapeJson(followups.get(i)));
                if (i < followups.size() - 1) json.append(",");
            }
        }
        json.append("]}");

        out.print(json.toString());
    }

    private void handleAddPlanTask(HttpServletRequest request, HttpServletResponse response, int studentId)
            throws IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String category = request.getParameter("category");

        if (title == null || title.trim().isEmpty()) {
            out.print("{\"status\":\"error\",\"message\":\"Task title is required\"}");
            return;
        }

        try {
            PreparationTask task = new PreparationTask();
            task.setStudentId(studentId);
            task.setTitle("[AI Coach] " + title.trim());
            task.setDescription(description != null ? description.trim() : "Recommended by your AI Placement Coach");
            task.setStatus(TaskStatus.PENDING);
            task.setTargetDate(LocalDate.now().plusDays(7));

            taskDAO.createTask(task);
            out.print("{\"status\":\"success\",\"message\":\"Goal synced to your Preparation Checklist!\"}");

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error syncing coach plan task for student: " + studentId, e);
            out.print("{\"status\":\"error\",\"message\":\"Database error saving task\"}");
        }
    }

    private String escapeJson(String input) {
        if (input == null) return "\"\"";
        StringBuilder sb = new StringBuilder("\"");
        for (int i = 0; i < input.length(); i++) {
            char c = input.charAt(i);
            switch (c) {
                case '\\': sb.append("\\\\"); break;
                case '"': sb.append("\\\""); break;
                case '\b': sb.append("\\b"); break;
                case '\f': sb.append("\\f"); break;
                case '\n': sb.append("\\n"); break;
                case '\r': sb.append("\\r"); break;
                case '\t': sb.append("\\t"); break;
                default:
                    if (c < ' ') {
                        String t = "000" + Integer.toHexString(c);
                        sb.append("\\u").append(t.substring(t.length() - 4));
                    } else {
                        sb.append(c);
                    }
                    break;
            }
        }
        sb.append("\"");
        return sb.toString();
    }
}
