package com.skilltrack.controllers;

import com.skilltrack.constants.CriteriaStatus;
import com.skilltrack.dto.CriteriaResultItemDTO;
import com.skilltrack.dto.DriveShortlistDTO;
import com.skilltrack.dto.PlacementCriteriaEvaluationDTO;
import com.skilltrack.models.PlacementCriteria;
import com.skilltrack.models.Student;
import com.skilltrack.services.PlacementCriteriaService;
import com.skilltrack.utils.DateUtil;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "AdminDriveShortlistServlet", urlPatterns = {"/app/admin/criteria/shortlist"})
public class AdminDriveShortlistServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(AdminDriveShortlistServlet.class.getName());
    private final PlacementCriteriaService criteriaService = new PlacementCriteriaService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String criteriaIdParam = request.getParameter("criteriaId");
        if (criteriaIdParam == null || criteriaIdParam.trim().isEmpty()) {
            criteriaIdParam = request.getParameter("id");
        }

        int criteriaId = 0;
        try {
            if (criteriaIdParam != null && !criteriaIdParam.trim().isEmpty()) {
                criteriaId = Integer.parseInt(criteriaIdParam.trim());
            }
        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Invalid criteriaId parameter: " + criteriaIdParam);
        }

        List<PlacementCriteria> allCriteria = criteriaService.getAllCriteria(false);
        if (criteriaId <= 0 && !allCriteria.isEmpty()) {
            criteriaId = allCriteria.get(0).getCriteriaId();
        }

        if (criteriaId <= 0) {
            request.setAttribute("errorMessage", "No active placement drive criteria found to shortlist.");
            response.sendRedirect(request.getContextPath() + "/app/admin/criteria");
            return;
        }

        DriveShortlistDTO shortlist = criteriaService.generateDriveShortlist(criteriaId);
        PlacementCriteria criteria = shortlist.getCriteria();

        if (criteria == null) {
            request.setAttribute("errorMessage", "Placement criteria not found.");
            response.sendRedirect(request.getContextPath() + "/app/admin/criteria");
            return;
        }

        String exportType = request.getParameter("export");
        if ("csv".equalsIgnoreCase(exportType)) {
            exportShortlistToCsv(response, shortlist, criteria);
            return;
        }

        String statusFilter = request.getParameter("status");
        String deptFilter = request.getParameter("dept");

        request.setAttribute("shortlist", shortlist);
        request.setAttribute("criteria", criteria);
        request.setAttribute("allCriteria", allCriteria);
        request.setAttribute("selectedCriteriaId", criteriaId);
        request.setAttribute("statusFilter", statusFilter);
        request.setAttribute("deptFilter", deptFilter);
        request.setAttribute("generatedTimestamp", DateUtil.formatDateTime(java.time.LocalDateTime.now()));

        request.getRequestDispatcher("/WEB-INF/views/admin/drive-shortlist.jsp").forward(request, response);
    }

    private void exportShortlistToCsv(HttpServletResponse response, DriveShortlistDTO shortlist, PlacementCriteria criteria)
            throws IOException {
        String safeCompany = criteria.getCompanyName().replaceAll("[^a-zA-Z0-9_-]", "_");
        String safeRole = criteria.getRoleTitle().replaceAll("[^a-zA-Z0-9_-]", "_");
        String dateStr = new SimpleDateFormat("yyyyMMdd_HHmm").format(new Date());
        String filename = "Drive_Shortlist_" + safeCompany + "_" + safeRole + "_" + dateStr + ".csv";

        response.setContentType("text/csv; charset=UTF-8");
        response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");
        response.setCharacterEncoding("UTF-8");

        PrintWriter writer = response.getWriter();
        // UTF-8 BOM for Excel compatibility
        writer.write('\ufeff');

        // CSV Header
        writer.println("Candidate Name,Roll Number,Email,Department,Graduation Year,CGPA,DSA Solved,Projects,Certifications,Eligibility Status,Passed Checks,Total Checks,Remarks / Gaps");

        for (PlacementCriteriaEvaluationDTO eval : shortlist.getAllEvaluations()) {
            Student s = eval.getStudent();
            StringBuilder remarksBuilder = new StringBuilder();
            if (eval.getResultItems() != null) {
                for (CriteriaResultItemDTO item : eval.getResultItems()) {
                    if (item.getStatus() != CriteriaStatus.MEETS_REQUIREMENT) {
                        if (remarksBuilder.length() > 0) remarksBuilder.append(" | ");
                        remarksBuilder.append(item.getCriterionName()).append(": ").append(item.getRemarks());
                    }
                }
            }

            String remarks = remarksBuilder.toString().replace("\"", "\"\"");

            writer.printf("\"%s\",\"%s\",\"%s\",\"%s\",%d,%.2f,%d,%d,%d,\"%s\",%d,%d,\"%s\"%n",
                    s != null ? s.getFullName() : "N/A",
                    s != null ? s.getRollNumber() : "N/A",
                    s != null ? s.getEmail() : "N/A",
                    s != null ? s.getDepartment() : "N/A",
                    s != null ? s.getGraduationYear() : 0,
                    s != null ? s.getCgpa() : 0.00,
                    eval.getResultItems() != null ? getDsaSolvedCount(eval) : 0,
                    eval.getResultItems() != null ? getProjectsCount(eval) : 0,
                    eval.getResultItems() != null ? getCertsCount(eval) : 0,
                    eval.getOverallStatus() != null ? eval.getOverallStatus().getDisplayName() : "N/A",
                    eval.getPassedCount(),
                    eval.getTotalChecks(),
                    remarks
            );
        }

        writer.flush();
    }

    private int getDsaSolvedCount(PlacementCriteriaEvaluationDTO eval) {
        if (eval.getResultItems() != null) {
            for (CriteriaResultItemDTO item : eval.getResultItems()) {
                if ("DSA Problems Solved".equalsIgnoreCase(item.getCriterionName())) {
                    try {
                        return Integer.parseInt(item.getStudentValue().trim());
                    } catch (Exception ignored) {}
                }
            }
        }
        return 0;
    }

    private int getProjectsCount(PlacementCriteriaEvaluationDTO eval) {
        if (eval.getResultItems() != null) {
            for (CriteriaResultItemDTO item : eval.getResultItems()) {
                if ("Completed Projects".equalsIgnoreCase(item.getCriterionName())) {
                    try {
                        return Integer.parseInt(item.getStudentValue().trim());
                    } catch (Exception ignored) {}
                }
            }
        }
        return 0;
    }

    private int getCertsCount(PlacementCriteriaEvaluationDTO eval) {
        if (eval.getResultItems() != null) {
            for (CriteriaResultItemDTO item : eval.getResultItems()) {
                if ("Verified Certifications".equalsIgnoreCase(item.getCriterionName())) {
                    try {
                        return Integer.parseInt(item.getStudentValue().trim());
                    } catch (Exception ignored) {}
                }
            }
        }
        return 0;
    }
}
