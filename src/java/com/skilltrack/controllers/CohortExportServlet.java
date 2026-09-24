package com.skilltrack.controllers;

import com.skilltrack.constants.AppConstants;
import com.skilltrack.dto.CohortSummaryDTO;
import com.skilltrack.services.AnalyticsService;
import com.skilltrack.utils.DateUtil;
import java.io.IOException;
import java.time.LocalDateTime;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "CohortExportServlet", urlPatterns = {"/app/admin/cohort-summary"})
public class CohortExportServlet extends HttpServlet {

    private final AnalyticsService analyticsService = new AnalyticsService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CohortSummaryDTO summary = analyticsService.getCohortSummary();

        request.setAttribute("summary", summary);
        request.setAttribute("generatedTimestamp", DateUtil.formatDateTime(LocalDateTime.now()));
        request.setAttribute("disclaimer", AppConstants.READINESS_DISCLAIMER);

        request.getRequestDispatcher("/WEB-INF/views/admin/cohort-export.jsp").forward(request, response);
    }
}
