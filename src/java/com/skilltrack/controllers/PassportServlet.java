package com.skilltrack.controllers;

import com.skilltrack.constants.AppConstants;
import com.skilltrack.constants.UserRole;
import com.skilltrack.dao.StudentDAO;
import com.skilltrack.dto.ReadinessScoreDTO;
import com.skilltrack.dto.SkillGapDTO;
import com.skilltrack.dto.StudentProfileDTO;
import com.skilltrack.models.Student;
import com.skilltrack.services.ReadinessScoreService;
import com.skilltrack.services.SkillGapService;
import com.skilltrack.services.StudentService;
import com.skilltrack.utils.SessionUtil;
import com.skilltrack.utils.ValidationUtil;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "PassportServlet", urlPatterns = {"/passport", "/verify", "/public/passport"})
public class PassportServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(PassportServlet.class.getName());

    private final StudentDAO studentDAO = new StudentDAO();
    private final StudentService studentService = new StudentService();
    private final ReadinessScoreService readinessScoreService = new ReadinessScoreService();
    private final SkillGapService skillGapService = new SkillGapService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        String rollParam = request.getParameter("roll");
        String codeParam = request.getParameter("code");

        Student student = null;

        try {
            // 1. Try by code or roll parameter
            String lookupCode = (codeParam != null && !codeParam.trim().isEmpty()) ? codeParam.trim() :
                               (rollParam != null && !rollParam.trim().isEmpty()) ? rollParam.trim() : null;

            if (lookupCode != null) {
                // 1. Try exact roll match
                student = studentDAO.findByRollNumber(lookupCode);
                
                // 2. If code starts with ST-
                if (student == null && lookupCode.toUpperCase().startsWith("ST-")) {
                    String withoutPrefix = lookupCode.substring(3).trim();
                    student = studentDAO.findByRollNumber(withoutPrefix);
                    
                    // If format is ST-YYYY-ROLL (e.g. ST-2026-002)
                    if (student == null && withoutPrefix.contains("-")) {
                        String rollAfterYear = withoutPrefix.substring(withoutPrefix.indexOf('-') + 1).trim();
                        student = studentDAO.findByRollNumber(rollAfterYear);
                    }
                }

                // 3. Try parsing numeric ID if roll lookup didn't match
                if (student == null) {
                    int numId = ValidationUtil.parsePositiveInt(lookupCode.replace("ST-", "").trim(), 0);
                    if (numId > 0) {
                        student = studentDAO.findById(numId);
                    }
                }
            }

            // 2. Try by id parameter
            if (student == null && idParam != null && !idParam.trim().isEmpty()) {
                int studentId = ValidationUtil.parsePositiveInt(idParam, 0);
                if (studentId > 0) {
                    student = studentDAO.findById(studentId);
                }
            }

            // 3. Fallback: If logged-in student accesses /passport without params
            if (student == null && SessionUtil.isAuthenticated(request)) {
                Integer sessionStudentId = SessionUtil.getStudentId(request);
                if (sessionStudentId != null) {
                    student = studentDAO.findById(sessionStudentId);
                }
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Database error looking up candidate passport", e);
        }

        if (student == null) {
            request.setAttribute("passportNotFound", true);
            request.getRequestDispatcher("/WEB-INF/views/public/passport.jsp").forward(request, response);
            return;
        }

        int studentId = student.getStudentId();
        StudentProfileDTO profile = studentService.getStudentProfile(studentId);
        ReadinessScoreDTO readiness = readinessScoreService.calculateReadiness(studentId);
        SkillGapDTO skillGap = null;

        if (student.getTargetRoleId() != null && student.getTargetRoleId() > 0) {
            skillGap = skillGapService.calculateSkillGap(studentId, student.getTargetRoleId());
        }

        // Build permanent verification URL for QR Code & Sharing
        String verificationUrl = buildPublicVerificationUrl(request, student);

        // Verification metadata
        String verificationCode = "ST-" + student.getGraduationYear() + "-" + student.getRollNumber().replaceAll("[^a-zA-Z0-9]", "").toUpperCase();
        String verifiedAt = LocalDateTime.now().format(DateTimeFormatter.ofPattern("dd MMM yyyy, hh:mm a"));

        request.setAttribute("student", student);
        request.setAttribute("profile", profile);
        request.setAttribute("readiness", readiness);
        request.setAttribute("skillGap", skillGap);
        request.setAttribute("verificationUrl", verificationUrl);
        request.setAttribute("verificationCode", verificationCode);
        request.setAttribute("verifiedAt", verifiedAt);

        request.getRequestDispatcher("/WEB-INF/views/public/passport.jsp").forward(request, response);
    }

    private String buildPublicVerificationUrl(HttpServletRequest request, Student student) {
        String scheme = request.getScheme();
        String serverName = request.getServerName();
        int serverPort = request.getServerPort();
        String contextPath = request.getContextPath();

        StringBuilder sb = new StringBuilder();
        sb.append(scheme).append("://").append(serverName);

        if (("http".equalsIgnoreCase(scheme) && serverPort != 80)
                || ("https".equalsIgnoreCase(scheme) && serverPort != 443)) {
            sb.append(":").append(serverPort);
        }

        sb.append(contextPath).append("/passport?code=").append(ValidationUtil.urlEncode(student.getRollNumber()));
        return sb.toString();
    }
}
