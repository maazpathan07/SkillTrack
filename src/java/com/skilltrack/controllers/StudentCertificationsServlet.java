package com.skilltrack.controllers;

import com.skilltrack.constants.AppConstants;
import com.skilltrack.models.Certification;
import com.skilltrack.services.CertificateVerificationService;
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

@WebServlet(name = "StudentCertificationsServlet", urlPatterns = {"/app/student/certifications"})
public class StudentCertificationsServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(StudentCertificationsServlet.class.getName());

    private final StudentService studentService = new StudentService();
    private final CertificateVerificationService certVerificationService = new CertificateVerificationService();

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
            List<Certification> certs = studentService.getStudentCertifications(studentId);
            request.setAttribute("certifications", certs);

            if (editId > 0) {
                Certification editCert = studentService.getCertification(studentId, editId);
                request.setAttribute("editCert", editCert);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error loading certifications for student: " + studentId, e);
            request.setAttribute(AppConstants.FLASH_ERROR, "Error loading certifications.");
        }

        request.getRequestDispatcher("/WEB-INF/views/student/certifications.jsp").forward(request, response);
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

        if ("auto-fetch".equalsIgnoreCase(action)) {
            String certInput = request.getParameter("certInput");
            String platform = request.getParameter("platform");

            CertificateVerificationService.AutoFetchResult result = 
                    certVerificationService.autoFetchAndSaveCertificate(studentId, certInput, platform);

            if (result.isSuccess()) {
                request.getSession().setAttribute(AppConstants.FLASH_SUCCESS, result.getMessage());
            } else {
                request.getSession().setAttribute(AppConstants.FLASH_ERROR, result.getMessage());
            }
            response.sendRedirect(request.getContextPath() + "/app/student/certifications");
            return;
        }

        String certIdStr = request.getParameter("certId");
        int certId = ValidationUtil.parsePositiveInt(certIdStr, 0);

        try {
            if ("delete".equalsIgnoreCase(action)) {
                if (certId > 0) {
                    studentService.deleteCertification(studentId, certId);
                    request.getSession().setAttribute(AppConstants.FLASH_SUCCESS, "Certification removed successfully.");
                }
            } else {
                String title = request.getParameter("title");
                String issuingOrg = request.getParameter("issuingOrg");
                String issueDateStr = request.getParameter("issueDate");
                String credentialUrl = request.getParameter("credentialUrl");

                LocalDate issueDate = DateUtil.parseDate(issueDateStr);
                if (issueDate == null) {
                    throw new IllegalArgumentException("Please provide a valid issue date (YYYY-MM-DD).");
                }

                if (certId > 0) {
                    studentService.updateCertification(studentId, certId, title, issuingOrg, issueDate, credentialUrl);
                    request.getSession().setAttribute(AppConstants.FLASH_SUCCESS, "Certification updated successfully.");
                } else {
                    studentService.addCertification(studentId, title, issuingOrg, issueDate, credentialUrl);
                    request.getSession().setAttribute(AppConstants.FLASH_SUCCESS, "New certification added to profile.");
                }
            }
        } catch (IllegalArgumentException e) {
            request.getSession().setAttribute(AppConstants.FLASH_ERROR, e.getMessage());
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Database error saving certification for student: " + studentId, e);
            request.getSession().setAttribute(AppConstants.FLASH_ERROR, "A database error occurred while saving the certification.");
        }

        response.sendRedirect(request.getContextPath() + "/app/student/certifications");
    }
}
