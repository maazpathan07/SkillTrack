<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Application Error (500) | SkillTrack" />
<%@ include file="/WEB-INF/views/common/header.jspf" %>
<%@ include file="/WEB-INF/views/common/navbar.jspf" %>

<main role="main" class="container my-5 py-4">
    <div class="row justify-content-center">
        <div class="col-lg-6 col-md-8 text-center">
            <div class="ios-card p-5" style="box-shadow: var(--ios-shadow-glass); border-radius: var(--ios-radius-lg);">
                <div class="mb-4">
                    <div class="d-inline-flex align-items-center justify-content-center p-3 rounded-circle mb-3" style="background: rgba(255, 59, 48, 0.08); width: 88px; height: 88px;" aria-hidden="true">
                        <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="var(--ios-red)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z"></path>
                            <line x1="12" y1="9" x2="12" y2="13"></line>
                            <line x1="12" y1="17" x2="12.01" y2="17"></line>
                        </svg>
                    </div>
                    <div class="d-block">
                        <span class="ios-badge ios-badge-red font-weight-bold mb-2" style="font-size: 0.85rem; padding: 0.35rem 1rem;">
                            Error 500 &bull; Server Exception
                        </span>
                    </div>
                </div>

                <h1 class="h3 font-weight-bold text-dark mb-2" style="letter-spacing: -0.03em;">
                    Application Error Encountered
                </h1>
                <p class="text-muted mb-4" style="line-height: 1.5; font-size: 0.95rem;">
                    An unexpected issue occurred while processing your request. The system has safely logged this event. Please try again or return to the main dashboard.
                </p>

                <div class="d-flex align-items-center justify-content-center gap-3" style="gap: 0.75rem;">
                    <a href="${pageContext.request.contextPath}/" class="ios-btn-primary d-inline-flex align-items-center" style="padding: 0.65rem 1.5rem; font-size: 0.875rem;">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="mr-2" aria-hidden="true"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path><polyline points="9 22 9 12 15 12 15 22"></polyline></svg>
                        Return to Dashboard
                    </a>
                    <a href="javascript:location.reload()" class="ios-btn-secondary d-inline-flex align-items-center" style="padding: 0.65rem 1.25rem; font-size: 0.875rem;">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="mr-1" aria-hidden="true"><polyline points="23 4 23 10 17 10"></polyline><polyline points="1 20 1 14 7 14"></polyline><path d="M3.51 9a9 9 0 0 1 14.85-3.36L23 10M1 14l4.64 4.36A9 9 0 0 0 20.49 15"></path></svg>
                        Reload Page
                    </a>
                </div>
            </div>
        </div>
    </div>
</main>

<%@ include file="/WEB-INF/views/common/footer.jspf" %>
