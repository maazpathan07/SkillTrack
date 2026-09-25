<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Sign In with ${provider.displayName}" />
<%@ include file="/WEB-INF/views/common/header.jspf" %>
<%@ include file="/WEB-INF/views/common/navbar.jspf" %>

<div class="ios-ambient-canvas py-5">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-xl-5 col-lg-6 col-md-8">
                <div class="ios-auth-card mx-auto">
                    <!-- Provider Logo Badge -->
                    <div class="text-center mb-4">
                        <div class="rounded-circle d-flex align-items-center justify-content-center mx-auto mb-3" style="width: 56px; height: 56px; background: #ffffff; border: 1px solid #e2e8f0; box-shadow: 0 4px 14px rgba(0,0,0,0.06);">
                            <c:choose>
                                <c:when test="${provider.name() == 'GOOGLE'}">
                                    <svg width="28" height="28" viewBox="0 0 24 24">
                                        <path fill="#4285F4" d="M23.745 12.27c0-.7-.06-1.4-.19-2.07H12v4.51h6.6c-.29 1.52-1.14 2.82-2.4 3.68v3.05h3.88c2.27-2.09 3.66-5.17 3.66-9.17z"/>
                                        <path fill="#34A853" d="M12 24c3.24 0 5.95-1.08 7.93-2.91l-3.88-3.05c-1.08.72-2.45 1.16-4.05 1.16-3.12 0-5.77-2.1-6.72-4.93H1.24v3.15C3.26 21.36 7.34 24 12 24z"/>
                                        <path fill="#FBBC05" d="M5.28 14.27c-.25-.72-.38-1.49-.38-2.27s.13-1.55.38-2.27V6.58H1.24C.45 8.15 0 9.97 0 12s.45 3.85 1.24 5.42l4.04-3.15z"/>
                                        <path fill="#EA4335" d="M12 4.75c1.77 0 3.35.61 4.6 1.8l3.42-3.42C17.95 1.19 15.24 0 12 0 7.34 0 3.26 2.64 1.24 6.58l4.04 3.15c.95-2.83 3.6-4.98 6.72-4.98z"/>
                                    </svg>
                                </c:when>
                                <c:when test="${provider.name() == 'GITHUB'}">
                                    <svg width="28" height="28" viewBox="0 0 24 24" fill="#24292f">
                                        <path d="M12 0C5.37 0 0 5.37 0 12c0 5.31 3.435 9.795 8.205 11.385.6.105.825-.255.825-.57 0-.285-.015-1.23-.015-2.235-3.015.555-3.795-.735-4.035-1.41-.135-.345-.72-1.41-1.23-1.695-.42-.225-1.02-.78-.015-.795.945-.015 1.62.87 1.845 1.23 1.08 1.815 2.805 1.305 3.495.99.105-.78.42-1.305.765-1.605-2.67-.3-5.46-1.335-5.46-5.925 0-1.305.465-2.385 1.23-3.225-.12-.3-.54-1.53.12-3.18 0 0 1.005-.315 3.3 1.23.96-.27 1.98-.405 3-.405s2.04.135 3 .405c2.295-1.56 3.3-1.23 3.3-1.23.66 1.65.24 2.88.12 3.18.765.84 1.23 1.905 1.23 3.225 0 4.605-2.805 5.625-5.475 5.925.435.375.81 1.095.81 2.22 0 1.605-.015 2.895-.015 3.3 0 .315.225.69.825.57A12.02 12.02 0 0024 12c0-6.63-5.37-12-12-12z"/>
                                    </svg>
                                </c:when>
                                <c:otherwise>
                                    <svg width="28" height="28" viewBox="0 0 24 24" fill="#0a66c2">
                                        <path d="M19 0h-14c-2.761 0-5 2.239-5 5v14c0 2.761 2.239 5 5 5h14c2.762 0 5-2.239 5-5v-14c0-2.761-2.238-5-5-5zm-11 19h-3v-11h3v11zm-1.5-12.268c-.966 0-1.75-.79-1.75-1.764s.784-1.764 1.75-1.764 1.75.79 1.75 1.764-.783 1.764-1.75 1.764zm13.5 12.268h-3v-5.604c0-3.368-4-3.113-4 0v5.604h-3v-11h3v1.765c1.396-2.586 7-2.777 7 2.476v6.759z"/>
                                    </svg>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <h2 class="font-weight-bold mb-1" style="font-size: 1.65rem; letter-spacing: -0.03em; color: var(--ios-text-primary);">
                            Sign in with <c:out value="${provider.displayName}" />
                        </h2>
                        <p class="text-muted small mb-0">
                            Authorize <strong>SkillTrack</strong> to access your profile
                        </p>
                    </div>

                    <!-- Sandbox Notice -->
                    <div class="ios-alert ios-alert-info mb-4" style="border-radius: var(--ios-radius-md);">
                        <div class="small">
                            <strong>OAuth 2.0 Ready:</strong> Click authorize below to complete 1-Click login. To link live API credentials, configure <code>oauth.properties</code>.
                        </div>
                    </div>

                    <!-- Authorization Form -->
                    <form action="${pageContext.request.contextPath}/auth/oauth/callback" method="get">
                        <input type="hidden" name="state" value="<c:out value='${oauthState}' />" />
                        <input type="hidden" name="simulated" value="true" />
                        <input type="hidden" name="id" value="user-${provider.name().toLowerCase()}-${System.currentTimeMillis()}" />

                        <div class="form-group mb-3">
                            <label for="oauthName" class="ios-form-label">Full Name</label>
                            <input type="text" class="ios-form-control" id="oauthName" name="name" required value="Maaz Pathan" placeholder="Your Name">
                        </div>

                        <div class="form-group mb-4">
                            <label for="oauthEmail" class="ios-form-label">Verified Email Address</label>
                            <input type="email" class="ios-form-control" id="oauthEmail" name="email" required value="maaz.pathan@university.edu" placeholder="name@university.edu">
                        </div>

                        <button type="submit" class="ios-btn-primary btn-block py-3 mb-2" style="font-size: 0.95rem; border-radius: var(--ios-radius-md); box-shadow: 0 8px 20px rgba(0, 113, 227, 0.25);">
                            Authorize &amp; Continue with <c:out value="${provider.displayName}" /> &rarr;
                        </button>
                        
                        <a href="${pageContext.request.contextPath}/login" class="ios-btn-secondary btn-block text-center py-2.5" style="font-size: 0.875rem;">
                            Cancel
                        </a>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jspf" %>
