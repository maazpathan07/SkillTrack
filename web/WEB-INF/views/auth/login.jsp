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

                    <!-- Streamlined Login Form -->
                    <form action="${pageContext.request.contextPath}/login" method="post" class="needs-validation" novalidate id="loginForm">
                        <input type="hidden" name="csrfToken" value="${sessionScope.CSRF_TOKEN}" />

                        <!-- Email Input -->
                        <div class="form-group mb-3">
                            <label for="email" class="ios-form-label">College / Work Email <span class="text-danger">*</span></label>
                            <input type="email" class="ios-form-control" id="email" name="email" value="<c:out value='${email}' />" required autofocus placeholder="name@university.edu">
                            <div class="invalid-feedback small mt-1">Please enter your email address.</div>
                        </div>

                        <!-- Password Input with SVG Eye Toggle -->
                        <div class="form-group mb-4">
                            <div class="d-flex justify-content-between align-items-center mb-1">
                                <label for="password" class="ios-form-label mb-0">Password <span class="text-danger">*</span></label>
                            </div>
                            <div class="ios-input-wrapper">
                                <input type="password" class="ios-form-control" id="password" name="password" required placeholder="••••••••">
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
                        <a href="${pageContext.request.contextPath}/register" class="small font-weight-bold ml-1" style="color: var(--ios-blue);">
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
</script>

<%@ include file="/WEB-INF/views/common/footer.jspf" %>
