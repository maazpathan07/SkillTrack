package com.skilltrack.controllers;

import com.skilltrack.constants.AppConstants;
import com.skilltrack.dto.CodingProfileSyncDTO;
import com.skilltrack.models.StudentCodingProfile;
import com.skilltrack.services.CodePlatformSyncService;
import com.skilltrack.utils.CsrfUtil;
import com.skilltrack.utils.SessionUtil;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "CodeSyncServlet", urlPatterns = {"/app/student/sync-platforms"})
public class CodeSyncServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(CodeSyncServlet.class.getName());
    private final CodePlatformSyncService syncService = new CodePlatformSyncService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Integer studentId = SessionUtil.getStudentId(request);
        if (studentId == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        StudentCodingProfile profile = syncService.getStudentCodingProfile(studentId);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        if (profile == null) {
            response.getWriter().write("{\"synced\":false}");
            return;
        }

        StringBuilder sb = new StringBuilder();
        sb.append("{")
          .append("\"synced\":true,")
          .append("\"leetcodeUsername\":\"").append(profile.getLeetcodeUsername() != null ? escapeJson(profile.getLeetcodeUsername()) : "").append("\",")
          .append("\"totalSolved\":").append(profile.getLeetcodeTotalSolved()).append(",")
          .append("\"easySolved\":").append(profile.getLeetcodeEasySolved()).append(",")
          .append("\"mediumSolved\":").append(profile.getLeetcodeMediumSolved()).append(",")
          .append("\"hardSolved\":").append(profile.getLeetcodeHardSolved()).append(",")
          .append("\"ranking\":").append(profile.getLeetcodeRanking()).append(",")
          .append("\"githubUsername\":\"").append(profile.getGithubUsername() != null ? escapeJson(profile.getGithubUsername()) : "").append("\",")
          .append("\"publicRepos\":").append(profile.getGithubReposCount()).append(",")
          .append("\"followers\":").append(profile.getGithubFollowers())
          .append("}");

        response.getWriter().write(sb.toString());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Integer studentId = SessionUtil.getStudentId(request);
        if (studentId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String isAjax = request.getHeader("X-Requested-With");
        boolean ajax = "XMLHttpRequest".equalsIgnoreCase(isAjax) || (request.getHeader("Accept") != null && request.getHeader("Accept").contains("application/json"));

        String leetcodeUsername = request.getParameter("leetcodeUsername");
        String githubUsername = request.getParameter("githubUsername");
        String autoDistributeStr = request.getParameter("autoDistribute");
        boolean autoDistribute = "true".equalsIgnoreCase(autoDistributeStr) || "1".equals(autoDistributeStr) || "on".equalsIgnoreCase(autoDistributeStr);

        if ((leetcodeUsername == null || leetcodeUsername.trim().isEmpty()) &&
            (githubUsername == null || githubUsername.trim().isEmpty())) {
            if (ajax) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"success\":false,\"message\":\"Please provide a LeetCode or GitHub username to sync.\"}");
                return;
            }
            request.getSession().setAttribute(AppConstants.FLASH_ERROR, "Please provide a valid username to sync.");
            String redirectUri = request.getParameter("redirectUri");
            if (redirectUri != null && redirectUri.startsWith("/app/student")) {
                response.sendRedirect(request.getContextPath() + redirectUri);
            } else {
                response.sendRedirect(request.getContextPath() + "/app/student/dsa");
            }
            return;
        }

        try {
            CodingProfileSyncDTO result = syncService.syncPlatforms(studentId, leetcodeUsername, githubUsername, autoDistribute);

            if (ajax) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                StringBuilder sb = new StringBuilder();
                sb.append("{")
                  .append("\"success\":").append(result.isSuccess()).append(",")
                  .append("\"message\":\"").append(escapeJson(result.getMessage())).append("\",")
                  .append("\"leetcodeUsername\":\"").append(result.getLeetcodeUsername() != null ? escapeJson(result.getLeetcodeUsername()) : "").append("\",")
                  .append("\"totalSolved\":").append(result.getTotalSolved()).append(",")
                  .append("\"easySolved\":").append(result.getEasySolved()).append(",")
                  .append("\"mediumSolved\":").append(result.getMediumSolved()).append(",")
                  .append("\"hardSolved\":").append(result.getHardSolved()).append(",")
                  .append("\"ranking\":").append(result.getRanking()).append(",")
                  .append("\"githubUsername\":\"").append(result.getGithubUsername() != null ? escapeJson(result.getGithubUsername()) : "").append("\",")
                  .append("\"publicRepos\":").append(result.getPublicRepos()).append(",")
                  .append("\"followers\":").append(result.getFollowers()).append(",")
                  .append("\"githubBio\":\"").append(result.getGithubBio() != null ? escapeJson(result.getGithubBio()) : "").append("\",")
                  .append("\"avatarUrl\":\"").append(result.getAvatarUrl() != null ? escapeJson(result.getAvatarUrl()) : "").append("\"")
                  .append("}");
                response.getWriter().write(sb.toString());
                return;
            }

            if (result.isSuccess()) {
                request.getSession().setAttribute(AppConstants.FLASH_SUCCESS, "Coding profiles synchronized: " + result.getMessage());
            } else {
                request.getSession().setAttribute(AppConstants.FLASH_ERROR, "Sync warning: " + result.getMessage());
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error syncing coding profiles for student: " + studentId, e);
            if (ajax) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"success\":false,\"message\":\"Server error during live profile sync.\"}");
                return;
            }
            request.getSession().setAttribute(AppConstants.FLASH_ERROR, "Failed to synchronize profile stats.");
        }

        String redirectUri = request.getParameter("redirectUri");
        if (redirectUri != null && redirectUri.startsWith("/app/student")) {
            response.sendRedirect(request.getContextPath() + redirectUri);
        } else {
            response.sendRedirect(request.getContextPath() + "/app/student/dsa");
        }
    }

    private String escapeJson(String str) {
        if (str == null) return "";
        return str.replace("\\", "\\\\")
                  .replace("\"", "\\\"")
                  .replace("\b", "\\b")
                  .replace("\f", "\\f")
                  .replace("\n", "\\n")
                  .replace("\r", "\\r")
                  .replace("\t", "\\t");
    }
}
