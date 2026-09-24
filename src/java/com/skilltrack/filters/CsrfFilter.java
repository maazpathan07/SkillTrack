package com.skilltrack.filters;

import com.skilltrack.constants.AppConstants;
import com.skilltrack.utils.CsrfUtil;
import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter(filterName = "CsrfFilter", urlPatterns = {"/*"})
public class CsrfFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        // Ensure CSRF token is available on session
        HttpSession session = request.getSession(true);
        String token = CsrfUtil.getOrCreateToken(session);
        request.setAttribute(AppConstants.CSRF_PARAM_NAME, token);

        String method = request.getMethod();

        // Enforce token validation on state-modifying requests under protected or form routes
        if ("POST".equalsIgnoreCase(method) || "PUT".equalsIgnoreCase(method) || "DELETE".equalsIgnoreCase(method)) {
            String uri = request.getRequestURI();
            String contextPath = request.getContextPath();
            String path = uri.substring(contextPath.length());

            // Exclude static assets
            if (!path.startsWith("/assets/")) {
                if (!CsrfUtil.isValidToken(request)) {
                    session.setAttribute(AppConstants.FLASH_ERROR, "Security validation failed (invalid or expired session token). Please try again.");
                    String referer = request.getHeader("Referer");
                    if (referer != null && referer.contains(contextPath)) {
                        response.sendRedirect(referer);
                    } else {
                        response.sendRedirect(contextPath + "/login");
                    }
                    return;
                }
            }
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }
}
