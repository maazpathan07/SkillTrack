package com.skilltrack.controllers;

import com.skilltrack.config.OAuthConfig;
import com.skilltrack.constants.AppConstants;
import com.skilltrack.constants.OAuthProvider;
import com.skilltrack.services.OAuthService;
import com.skilltrack.utils.SessionUtil;
import java.io.IOException;
import java.util.UUID;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "OAuthLoginServlet", urlPatterns = {"/auth/oauth/login"})
public class OAuthLoginServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(OAuthLoginServlet.class.getName());
    private final OAuthService oauthService = new OAuthService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String providerParam = request.getParameter("provider");
        OAuthProvider provider = OAuthProvider.fromString(providerParam);

        if (provider == OAuthProvider.LOCAL) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Generate cryptographic state to prevent CSRF attacks
        String oauthState = UUID.randomUUID().toString();
        request.getSession().setAttribute("OAUTH_STATE", oauthState);
        request.getSession().setAttribute("OAUTH_PROVIDER", provider.name());

        // Determine dynamic redirect URI
        String redirectUri = buildRedirectUri(request);

        // Check if real provider credentials (Client ID / Secret) are configured
        if (OAuthConfig.isProviderConfigured(provider)) {
            String authUrl = oauthService.getAuthorizationUrl(provider, oauthState, redirectUri);
            if (authUrl != null) {
                response.sendRedirect(authUrl);
                return;
            }
        }

        // Interactive Development & Test Consent Screen (when API keys are not yet configured)
        request.setAttribute("provider", provider);
        request.setAttribute("oauthState", oauthState);
        request.setAttribute("redirectUri", redirectUri);
        request.getRequestDispatcher("/WEB-INF/views/auth/oauth-dev-consent.jsp").forward(request, response);
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
