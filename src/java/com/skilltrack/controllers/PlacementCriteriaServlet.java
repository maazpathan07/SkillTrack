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
        request.setAttribute("evaluations", evaluations);

        request.getRequestDispatcher("/WEB-INF/views/student/placement-criteria.jsp").forward(request, response);
    }
}
