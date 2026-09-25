<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Sign In" />
<%@ include file="/WEB-INF/views/common/header.jspf" %>
<%@ include file="/WEB-INF/views/common/navbar.jspf" %>

<div class="ios-ambient-canvas py-5">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-xl-5 col-lg-6 col-md-8">
                <div class="ios-auth-card mx-auto">
                    <!-- Apple Vector Lock Mark -->
                    <div class="text-center mb-4">
                        <div class="ios-brand-icon mx-auto mb-3" style="width: 52px; height: 52px;">
                            <svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                                <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
                                <path d="M7 11V7a5 5 0 0 1 10 0v4"></path>
                            </svg>
                        </div>
                        <h2 class="font-weight-bold mb-2" style="font-size: 1.85rem; letter-spacing: -0.035em; color: var(--ios-text-primary);">
                            Welcome Back
                        </h2>
                        <p class="text-muted small mb-0" style="font-size: 0.925rem;">
                            Sign in to your SkillTrack placement readiness portal
                        </p>
                    </div>

                    <%@ include file="/WEB-INF/views/common/alerts.jspf" %>

                    <!-- Social 1-Click OAuth Logins (Compact 1-Row) -->
                    <div class="ios-oauth-row">
                        <a href="${pageContext.request.contextPath}/auth/oauth/login?provider=google" class="ios-oauth-pill ios-oauth-pill-google" title="Sign in with Google">
                            <svg width="17" height="17" viewBox="0 0 24 24">
                                <path fill="#4285F4" d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z"/>
                                <path fill="#34A853" d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z"/>
                                <path fill="#FBBC05" d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.06H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.94l2.85-2.22.81-.63z"/>
                                <path fill="#EA4335" d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.06l3.66 2.84c.87-2.6 3.3-4.52 6.16-4.52z"/>
                            </svg>
                            <span>Google</span>
                        </a>
                        <a href="${pageContext.request.contextPath}/auth/oauth/login?provider=github" class="ios-oauth-pill ios-oauth-pill-github" title="Sign in with GitHub">
                            <svg width="17" height="17" viewBox="0 0 24 24" fill="currentColor">
                                <path fill-rule="evenodd" clip-rule="evenodd" d="M12 2C6.477 2 2 6.484 2 12.017c0 4.425 2.865 8.18 6.839 9.504.5.092.682-.217.682-.483 0-.237-.008-.868-.013-1.703-2.782.605-3.369-1.343-3.369-1.343-.454-1.158-1.11-1.466-1.11-1.466-.908-.62.069-.608.069-.608 1.003.07 1.53 1.032 1.53 1.032.892 1.53 2.341 1.088 2.91.832.092-.647.35-1.088.636-1.338-2.22-.253-4.555-1.113-4.555-4.951 0-1.093.39-1.988 1.029-2.688-.103-.253-.446-1.272.098-2.65 0 0 .84-.27 2.75 1.026A9.564 9.564 0 0112 6.844c.85.004 1.705.115 2.504.337 1.909-1.296 2.747-1.027 2.747-1.027.546 1.379.202 2.398.1 2.651.64.7 1.028 1.595 1.028 2.688 0 3.848-2.339 4.695-4.566 4.943.359.309.678.92.678 1.855 0 1.338-.012 2.419-.012 2.747 0 .268.18.58.688.482A10.019 10.019 0 0022 12.017C22 6.484 17.522 2 12 2z"/>
                            </svg>
                            <span>GitHub</span>
                        </a>
                        <a href="${pageContext.request.contextPath}/auth/oauth/login?provider=linkedin" class="ios-oauth-pill ios-oauth-pill-linkedin" title="Sign in with LinkedIn">
                            <svg width="17" height="17" viewBox="0 0 24 24" fill="#0a66c2">
                                <path d="M19 3a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h14m-.5 15.5v-5.3a3.26 3.26 0 0 0-3.26-3.26c-.85 0-1.84.52-2.28 1.3v-1.11h-2.79v8.37h2.79v-4.93c0-.77.62-1.4 1.39-1.4a1.4 1.4 0 0 1 1.4 1.4v4.93h2.75M6.88 8.56a1.68 1.68 0 0 0 1.68-1.68c0-.93-.75-1.69-1.68-1.69a1.69 1.69 0 0 0-1.69 1.69c0 .93.76 1.68 1.69 1.68m1.39 9.94v-8.37H5.5v8.37h2.77z"/>
                            </svg>
                            <span>LinkedIn</span>
                        </a>
                    </div>

                    <div class="ios-auth-divider">
                        <span>or sign in with email</span>
                    </div>

                    <!-- Streamlined Login Form -->
                    <form action="${pageContext.request.contextPath}/login" method="post" class="needs-validation" novalidate id="loginForm" autocomplete="off">
                        <input type="hidden" name="csrfToken" value="${sessionScope.CSRF_TOKEN}" />

                        <!-- Email Input -->
                        <div class="form-group mb-3">
                            <label for="email" class="ios-form-label">College / Work Email <span class="text-danger">*</span></label>
                            <input type="email" class="ios-form-control" id="email" name="email" value="<c:out value='${email}' />" required autocomplete="off" placeholder="name@university.edu">
                            <div class="invalid-feedback small mt-1">Please enter your email address.</div>
                        </div>

                        <!-- Password Input with SVG Eye Toggle -->
                        <div class="form-group mb-4">
                            <div class="d-flex justify-content-between align-items-center mb-1">
                                <label for="password" class="ios-form-label mb-0">Password <span class="text-danger">*</span></label>
                            </div>
                            <div class="ios-input-wrapper">
                                <input type="password" class="ios-form-control" id="password" name="password" required autocomplete="new-password" placeholder="••••••••">
                                <button type="button" class="ios-input-toggle" id="togglePasswordBtn" aria-label="Toggle password visibility">
                                    <svg id="eyeIcon" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                        <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path>
                                        <circle cx="12" cy="12" r="3"></circle>
                                    </svg>
                                    <svg id="eyeOffIcon" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="display: none;">
                                        <path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24"></path>
                                        <line x1="1" y1="1" x2="23" y2="23"></line>
                                    </svg>
                                </button>
                            </div>
                            <div class="invalid-feedback small mt-1">Please enter your password.</div>
                        </div>

                        <!-- Submit Button -->
                        <button type="submit" class="ios-btn-primary btn-block py-3" style="font-size: 1rem; border-radius: var(--ios-radius-md); box-shadow: 0 10px 25px rgba(0, 113, 227, 0.3);">
                            Sign In to Portal &rarr;
                        </button>
                    </form>

                    <!-- Clean Footer Switch -->
                    <div class="text-center mt-4 pt-3 border-top">
                        <span class="text-muted small">New to SkillTrack?</span>
                        <a href="${pageContext.request.contextPath}/register" class="small font-weight-bold ml-1 text-nowrap" style="color: var(--ios-blue);">
                            Create Student Account &rarr;
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    var toggleBtn = document.getElementById('togglePasswordBtn');
    var passwordInput = document.getElementById('password');
    var eyeIcon = document.getElementById('eyeIcon');
    var eyeOffIcon = document.getElementById('eyeOffIcon');

    if (toggleBtn && passwordInput && eyeIcon && eyeOffIcon) {
        toggleBtn.addEventListener('click', function(e) {
            e.preventDefault();
            var isPassword = passwordInput.getAttribute('type') === 'password';
            passwordInput.setAttribute('type', isPassword ? 'text' : 'password');
            eyeIcon.style.display = isPassword ? 'none' : 'inline';
            eyeOffIcon.style.display = isPassword ? 'inline' : 'none';
        });
    }

    // Clear any browser-cached / autofilled values on fresh initial page load
    <c:if test="${empty error}">
    function resetAutoFill() {
        var emailEl = document.getElementById('email');
        var passEl = document.getElementById('password');
        if (emailEl && !emailEl.getAttribute('data-user-typed')) emailEl.value = '';
        if (passEl && !passEl.getAttribute('data-user-typed')) passEl.value = '';
    }
    resetAutoFill();
    setTimeout(resetAutoFill, 50);
    setTimeout(resetAutoFill, 200);
    </c:if>

    // Bootstrap validation trigger
    var form = document.getElementById('loginForm');
    if (form) {
        form.addEventListener('submit', function(event) {
            if (form.checkValidity() === false) {
                event.preventDefault();
                event.stopPropagation();
            }
            form.classList.add('was-validated');
        }, false);
    }
});

window.addEventListener('pageshow', function() {
    <c:if test="${empty error}">
    var emailEl = document.getElementById('email');
    var passEl = document.getElementById('password');
    if (emailEl) emailEl.value = '';
    if (passEl) passEl.value = '';
    </c:if>
});
</script>

<%@ include file="/WEB-INF/views/common/footer.jspf" %>
