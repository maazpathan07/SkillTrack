package com.skilltrack.filters;

import com.skilltrack.constants.AppConstants;
import com.skilltrack.constants.UserRole;
import com.skilltrack.utils.SessionUtil;
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

@WebFilter(filterName = "RoleFilter", urlPatterns = {"/app/student/*", "/app/admin/*"})
public class RoleFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        String uri = request.getRequestURI();
        String contextPath = request.getContextPath();
        String path = uri.substring(contextPath.length());

        UserRole role = SessionUtil.getUserRole(request);
        if (role == null) {
            response.sendRedirect(contextPath + "/login");
            return;
        }

        if (path.startsWith("/app/admin/")) {
            if (role != UserRole.ADMIN) {
                request.getSession().setAttribute(AppConstants.FLASH_ERROR, "Access denied. Administrator privileges required.");
                response.sendRedirect(contextPath + "/app/student/dashboard");
                return;
            }
        } else if (path.startsWith("/app/student/")) {
            if (role != UserRole.STUDENT) {
                request.getSession().setAttribute(AppConstants.FLASH_ERROR, "Access denied. Student account required.");
                response.sendRedirect(contextPath + "/app/admin/dashboard");
                return;
            }
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }
}
