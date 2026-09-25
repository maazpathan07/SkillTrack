package com.skilltrack.controllers;

import com.skilltrack.dto.PlacementCriteriaEvaluationDTO;
import com.skilltrack.services.PlacementCriteriaService;
import com.skilltrack.utils.SessionUtil;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "PlacementCriteriaServlet", urlPatterns = {"/app/student/placement-criteria"})
public class PlacementCriteriaServlet extends HttpServlet {

    private final PlacementCriteriaService placementCriteriaService = new PlacementCriteriaService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Integer studentId = SessionUtil.getStudentId(request);
        if (studentId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<PlacementCriteriaEvaluationDTO> evaluations = placementCriteriaService.evaluateStudentAgainstAllCriteria(studentId);
        int eligibleCount = 0;
        int nearCount = 0;
        int ineligibleCount = 0;

        for (PlacementCriteriaEvaluationDTO eval : evaluations) {
            if (eval.getOverallStatus() != null) {
                switch (eval.getOverallStatus()) {
                    case MEETS_REQUIREMENT:
                        eligibleCount++;
                        break;
                    case NEEDS_IMPROVEMENT:
                        nearCount++;
                        break;
                    default:
                        ineligibleCount++;
                        break;
                }
            }
        }

        request.setAttribute("evaluations", evaluations);
        request.setAttribute("eligibleCount", eligibleCount);
        request.setAttribute("nearCount", nearCount);
        request.setAttribute("ineligibleCount", ineligibleCount);

        request.getRequestDispatcher("/WEB-INF/views/student/placement-criteria.jsp").forward(request, response);
    }
}
