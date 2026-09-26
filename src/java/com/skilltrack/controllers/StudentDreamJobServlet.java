package com.skilltrack.controllers;

import com.skilltrack.constants.TaskStatus;
import com.skilltrack.dao.CustomJdEvaluationDAO;
import com.skilltrack.dao.PlacementCriteriaDAO;
import com.skilltrack.dao.TaskDAO;
import com.skilltrack.dto.DreamJobMatchDTO;
import com.skilltrack.dto.JobGapRoadmapItemDTO;
import com.skilltrack.models.CustomJdEvaluation;
import com.skilltrack.models.PlacementCriteria;
import com.skilltrack.models.PreparationTask;
import com.skilltrack.services.LiveJobMatchingService;
import com.skilltrack.utils.CsrfUtil;
import com.skilltrack.utils.SessionUtil;
import com.skilltrack.utils.ValidationUtil;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "StudentDreamJobServlet", urlPatterns = {"/app/student/dream-job"})
public class StudentDreamJobServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(StudentDreamJobServlet.class.getName());

    private final LiveJobMatchingService matchingService = new LiveJobMatchingService();
    private final PlacementCriteriaDAO criteriaDAO = new PlacementCriteriaDAO();
    private final CustomJdEvaluationDAO customJdDAO = new CustomJdEvaluationDAO();
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
            List<PlacementCriteria> allPresets = criteriaDAO.findAll(true);
            List<CustomJdEvaluation> recentEvaluations = customJdDAO.findRecentByStudentId(studentId, 8);

            request.setAttribute("companyPresets", allPresets);
            request.setAttribute("recentScans", recentEvaluations);

            String criteriaIdParam = request.getParameter("criteriaId");
            String evalIdParam = request.getParameter("evalId");

            DreamJobMatchDTO currentMatch = null;

            if (criteriaIdParam != null && !criteriaIdParam.trim().isEmpty()) {
                int criteriaId = Integer.parseInt(criteriaIdParam.trim());
                currentMatch = matchingService.matchAgainstCriteria(studentId, criteriaId);
            } else if (evalIdParam != null && !evalIdParam.trim().isEmpty()) {
                int evalId = Integer.parseInt(evalIdParam.trim());
                CustomJdEvaluation savedEval = customJdDAO.findById(evalId, studentId);
                if (savedEval != null) {
                    currentMatch = matchingService.matchAgainstCustomJd(
                        studentId,
                        savedEval.getTargetCompany(),
                        savedEval.getTargetRole(),
                        savedEval.getRawJdText(),
                        savedEval.getSourceType(),
                        savedEval.getSourceUrl()
                    );
                    currentMatch.setEvalId(savedEval.getEvalId());
                }
            }

            // If no criteriaId or evalId is passed, matchResult remains null (allowing toggle off / deselect)
            request.setAttribute("matchResult", currentMatch);
            request.getRequestDispatcher("/WEB-INF/views/student/dream-job-matcher.jsp").forward(request, response);

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error loading dream job matcher for student: " + studentId, e);
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
        if (action == null) action = "evaluate-custom-jd";

        HttpSession session = request.getSession();

        if ("evaluate-custom-jd".equalsIgnoreCase(action)) {
            String targetCompany = request.getParameter("targetCompany");
            String targetRole = request.getParameter("targetRole");
            String rawJdText = request.getParameter("rawJdText");
            String sourceUrl = request.getParameter("sourceUrl");

            if ((rawJdText == null || rawJdText.trim().isEmpty()) && (sourceUrl != null && !sourceUrl.trim().isEmpty())) {
                rawJdText = matchingService.fetchJdFromUrl(sourceUrl);
                if (rawJdText.isEmpty()) {
                    rawJdText = "Targeting " + (targetRole != null ? targetRole : "Software Engineer") + " at " + (targetCompany != null ? targetCompany : "Company");
                }
            }

            if (rawJdText == null || rawJdText.trim().isEmpty()) {
                session.setAttribute("errorMessage", "Please paste Job Description text or provide a valid job listing URL.");
                response.sendRedirect(request.getContextPath() + "/app/student/dream-job");
                return;
            }

            String sourceType = (sourceUrl != null && !sourceUrl.trim().isEmpty()) ? "URL_FETCH" : "CUSTOM_PASTE";
            DreamJobMatchDTO match = matchingService.matchAgainstCustomJd(studentId, targetCompany, targetRole, rawJdText, sourceType, sourceUrl, true);

            session.setAttribute("successMessage", "Live JD evaluation complete! Match score: " + match.getOverallScore() + "%.");
            response.sendRedirect(request.getContextPath() + "/app/student/dream-job?evalId=" + match.getEvalId());
            return;

        } else if ("add-roadmap-task".equalsIgnoreCase(action)) {
            String taskTitle = request.getParameter("taskTitle");
            String taskDescription = request.getParameter("taskDescription");
            boolean isAjax = "true".equalsIgnoreCase(request.getParameter("isAjax"));

            if (taskTitle != null && !taskTitle.trim().isEmpty()) {
                PreparationTask task = new PreparationTask();
                task.setStudentId(studentId);
                task.setTitle(taskTitle.trim());
                task.setDescription(taskDescription != null ? taskDescription.trim() : "");
                task.setStatus(TaskStatus.PENDING);
                task.setTargetDate(LocalDate.now().plusWeeks(2));

                try {
                    taskDAO.createTask(task);
                    if (isAjax) {
                        response.setContentType("application/json");
                        response.setCharacterEncoding("UTF-8");
                        PrintWriter out = response.getWriter();
                        out.print("{\"status\":\"success\",\"message\":\"Task successfully added to your preparation checklist!\"}");
                        out.flush();
                        return;
                    }
                    session.setAttribute("successMessage", "Recommendation added to your Preparation Checklist!");
                } catch (SQLException e) {
                    LOGGER.log(Level.SEVERE, "Error adding roadmap item to preparation tasks", e);
                    if (isAjax) {
                        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                        response.setContentType("application/json");
                        response.getWriter().print("{\"status\":\"error\",\"message\":\"Failed to add task.\"}");
                        return;
                    }
                    session.setAttribute("errorMessage", "Failed to add task to checklist.");
                }
            }
            response.sendRedirect(request.getContextPath() + "/app/student/dream-job");
            return;

        } else if ("delete-eval".equalsIgnoreCase(action)) {
            String evalIdParam = request.getParameter("evalId");
            if (evalIdParam != null) {
                try {
                    int evalId = Integer.parseInt(evalIdParam);
                    customJdDAO.deleteEvaluation(evalId, studentId);
                    session.setAttribute("successMessage", "Evaluation record removed from history.");
                } catch (Exception e) {
                    LOGGER.log(Level.SEVERE, "Error deleting evaluation", e);
                    session.setAttribute("errorMessage", "Could not delete evaluation record.");
                }
            }
            response.sendRedirect(request.getContextPath() + "/app/student/dream-job");
            return;
        }

        response.sendRedirect(request.getContextPath() + "/app/student/dream-job");
    }
}
