package com.skilltrack.utils;

import com.skilltrack.constants.AppConstants;
import java.security.SecureRandom;
import java.util.Base64;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public final class CsrfUtil {

    private static final SecureRandom RANDOM = new SecureRandom();

    private CsrfUtil() {
    }

    public static String getOrCreateToken(HttpSession session) {
        if (session == null) return "";
        synchronized (session) {
            String token = (String) session.getAttribute(AppConstants.SESSION_CSRF_TOKEN);
            if (token == null || token.trim().isEmpty()) {
                byte[] bytes = new byte[32];
                RANDOM.nextBytes(bytes);
                token = Base64.getUrlEncoder().withoutPadding().encodeToString(bytes);
                session.setAttribute(AppConstants.SESSION_CSRF_TOKEN, token);
            }
            return token;
        }
    }

    public static boolean isValidToken(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return false;
        }
        String sessionToken = (String) session.getAttribute(AppConstants.SESSION_CSRF_TOKEN);
        if (sessionToken == null || sessionToken.trim().isEmpty()) {
            return false;
        }

        // Check request parameter
        String requestToken = request.getParameter(AppConstants.CSRF_PARAM_NAME);
        if (requestToken == null || requestToken.trim().isEmpty()) {
            // Check request header (for AJAX if applicable)
            requestToken = request.getHeader(AppConstants.CSRF_HEADER_NAME);
        }

        if (requestToken == null) {
            return false;
        }

        return constantTimeEquals(sessionToken, requestToken.trim());
    }

    private static boolean constantTimeEquals(String a, String b) {
        if (a == null || b == null) {
            return false;
        }
        byte[] aBytes = a.getBytes();
        byte[] bBytes = b.getBytes();
        if (aBytes.length != bBytes.length) {
            return false;
        }
        int result = 0;
        for (int i = 0; i < aBytes.length; i++) {
            result |= aBytes[i] ^ bBytes[i];
        }
        return result == 0;
    }
}
