package com.skilltrack.utils;

import com.skilltrack.constants.AppConstants;
import com.skilltrack.constants.UserRole;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public final class SessionUtil {

    private SessionUtil() {
    }

    public static boolean isAuthenticated(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null && session.getAttribute(AppConstants.SESSION_USER_ID) != null;
    }

    public static Integer getUserId(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) return null;
        Object userIdObj = session.getAttribute(AppConstants.SESSION_USER_ID);
        return (userIdObj instanceof Integer) ? (Integer) userIdObj : null;
    }

    public static UserRole getUserRole(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) return null;
        Object roleObj = session.getAttribute(AppConstants.SESSION_USER_ROLE);
        if (roleObj instanceof UserRole) {
            return (UserRole) roleObj;
        } else if (roleObj instanceof String) {
            return UserRole.fromString((String) roleObj);
        }
        return null;
    }

    public static Integer getStudentId(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) return null;
        Object studentIdObj = session.getAttribute(AppConstants.SESSION_STUDENT_ID);
        return (studentIdObj instanceof Integer) ? (Integer) studentIdObj : null;
    }

    public static Integer getAdminId(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) return null;
        Object adminIdObj = session.getAttribute(AppConstants.SESSION_ADMIN_ID);
        return (adminIdObj instanceof Integer) ? (Integer) adminIdObj : null;
    }

    public static String getUserEmail(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) return null;
        Object emailObj = session.getAttribute(AppConstants.SESSION_USER_EMAIL);
        return (emailObj instanceof String) ? (String) emailObj : null;
    }

    public static String getUserName(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) return null;
        Object nameObj = session.getAttribute(AppConstants.SESSION_USER_NAME);
        return (nameObj instanceof String) ? (String) nameObj : null;
    }

    public static void setSessionAttributes(HttpServletRequest request, int userId, String email, String fullName, UserRole role, Integer studentId, Integer adminId) {
        HttpSession session = request.getSession(true);
        session.setAttribute(AppConstants.SESSION_USER_ID, userId);
        session.setAttribute(AppConstants.SESSION_USER_EMAIL, email);
        session.setAttribute(AppConstants.SESSION_USER_NAME, fullName);
        session.setAttribute(AppConstants.SESSION_USER_ROLE, role);
        if (studentId != null) {
            session.setAttribute(AppConstants.SESSION_STUDENT_ID, studentId);
        }
        if (adminId != null) {
            session.setAttribute(AppConstants.SESSION_ADMIN_ID, adminId);
        }
    }

    public static void invalidateSession(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
    }
}
