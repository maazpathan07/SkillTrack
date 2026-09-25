package com.skilltrack.controllers;

import com.skilltrack.config.OAuthConfig;
import com.skilltrack.constants.AppConstants;
import com.skilltrack.constants.OAuthProvider;
import com.skilltrack.constants.UserRole;
import com.skilltrack.dto.OAuthUserInfo;
import com.skilltrack.services.AuthService;
import com.skilltrack.services.OAuthService;
import com.skilltrack.utils.SessionUtil;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "OAuthCallbackServlet", urlPatterns = {"/auth/oauth/callback"})
public class OAuthCallbackServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(OAuthCallbackServlet.class.getName());
    private final OAuthService oauthService = new OAuthService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String error = request.getParameter("error");
        if (error != null && !error.isEmpty()) {
            String errorDesc = request.getParameter("error_description");
            LOGGER.warning("OAuth provider returned error: " + error + " (" + errorDesc + ")");
            request.getSession().setAttribute(AppConstants.FLASH_ERROR, "Authentication with provider was cancelled or denied.");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String code = request.getParameter("code");
        String state = request.getParameter("state");
        String sessionState = (String) request.getSession().getAttribute("OAUTH_STATE");
        String sessionProviderStr = (String) request.getSession().getAttribute("OAUTH_PROVIDER");

        // Clean session state
        request.getSession().removeAttribute("OAUTH_STATE");
        request.getSession().removeAttribute("OAUTH_PROVIDER");

        // Validate state token against CSRF
        if (state == null || sessionState == null || !state.equals(sessionState)) {
            LOGGER.warning("Invalid OAuth state token mismatch.");
            request.getSession().setAttribute(AppConstants.FLASH_ERROR, "Security validation failed. Please try signing in again.");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        OAuthProvider provider = OAuthProvider.fromString(sessionProviderStr);
        String redirectUri = buildRedirectUri(request);

        OAuthUserInfo userInfo = null;

        // Check if this is simulated demo callback or live OAuth exchange
        String isSimulated = request.getParameter("simulated");
        if ("true".equalsIgnoreCase(isSimulated)) {
            String simEmail = request.getParameter("email");
            String simName = request.getParameter("name");
            String simId = request.getParameter("id");
            if (simEmail != null && !simEmail.isEmpty()) {
                userInfo = new OAuthUserInfo(provider, simId != null ? simId : "sim-" + System.currentTimeMillis(), simEmail, simName, null, null);
            }
        } else {
            try {
                userInfo = oauthService.exchangeCodeForUserInfo(provider, code, redirectUri);
            } catch (Exception e) {
                LOGGER.log(Level.SEVERE, "Error exchanging OAuth code for " + provider, e);
                request.getSession().setAttribute(AppConstants.FLASH_ERROR, "Could not complete sign in with " + provider.getDisplayName() + ": " + e.getMessage());
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }
        }

        if (userInfo == null) {
            request.getSession().setAttribute(AppConstants.FLASH_ERROR, "Failed to retrieve user profile from " + provider.getDisplayName());
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Process login / registration
        AuthService.AuthResult result = oauthService.processOAuthLogin(userInfo);

        if (result.isSuccess()) {
            Integer studentId = (result.getStudent() != null) ? result.getStudent().getStudentId() : null;
            Integer adminId = (result.getAdmin() != null) ? result.getAdmin().getAdminId() : null;
            String name = (result.getStudent() != null) ? result.getStudent().getFullName() :
                          (result.getAdmin() != null) ? result.getAdmin().getFullName() : "User";

            SessionUtil.setSessionAttributes(
                request,
                result.getUser().getUserId(),
                result.getUser().getEmail(),
                name,
                result.getUser().getRole(),
                studentId,
                adminId
            );

            request.getSession().setAttribute(AppConstants.FLASH_SUCCESS, "Welcome to SkillTrack, " + name + "! Signed in via " + provider.getDisplayName() + ".");

            if (result.getUser().getRole() == UserRole.ADMIN) {
                response.sendRedirect(request.getContextPath() + "/app/admin/dashboard");
            } else {
                response.sendRedirect(request.getContextPath() + "/app/student/dashboard");
            }
        } else {
            request.getSession().setAttribute(AppConstants.FLASH_ERROR, result.getErrorMessage());
            response.sendRedirect(request.getContextPath() + "/login");
        }
    }

    private String buildRedirectUri(HttpServletRequest request) {
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

        sb.append(contextPath).append("/auth/oauth/callback");
        return sb.toString();
    }
}
