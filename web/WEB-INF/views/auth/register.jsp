<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Student Registration" />
<%@ include file="/WEB-INF/views/common/header.jspf" %>
<%@ include file="/WEB-INF/views/common/navbar.jspf" %>

<div class="ios-ambient-canvas py-5">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-xl-7 col-lg-8 col-md-10">
                <div class="ios-auth-card ios-auth-card-wide mx-auto">
                    <!-- Clean Minimalist Header -->
                    <div class="text-center mb-4">
                        <div class="ios-brand-icon mx-auto mb-3" style="width: 52px; height: 52px;">
                            <svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M22 10v6M2 10l10-5 10 5-10 5z"></path>
                                <path d="M6 12v5c3 3 9 3 12 0v-5"></path>
                            </svg>
                        </div>
                        <h2 class="font-weight-bold mb-2" style="font-size: 1.85rem; letter-spacing: -0.035em; color: var(--ios-text-primary);">
                            Create Student Account
                        </h2>
                        <p class="text-muted small mb-0" style="font-size: 0.925rem;">
                            Benchmark your tech skills, track DSA milestones, and calculate placement readiness
                        </p>
                    </div>

                    <%@ include file="/WEB-INF/views/common/alerts.jspf" %>

                    <!-- Streamlined Clean Registration Form -->
                    <form action="${pageContext.request.contextPath}/register" method="post" class="needs-validation" novalidate id="registerForm" autocomplete="off">
                        <input type="hidden" name="csrfToken" value="${sessionScope.CSRF_TOKEN}" />

                        <!-- Row 1: Full Name -->
                        <div class="form-group mb-3">
                            <label for="fullName" class="ios-form-label">Full Legal Name <span class="text-danger">*</span></label>
                            <input type="text" class="ios-form-control" id="fullName" name="fullName" value="<c:out value='${fullName}' />" required placeholder="e.g. Alex Johnson">
                            <div class="invalid-feedback small mt-1">Please enter your full name.</div>
                        </div>

                        <!-- Row 2: Email & Password -->
                        <div class="form-row">
                            <div class="form-group col-md-6 mb-3">
                                <label for="email" class="ios-form-label">College / Personal Email <span class="text-danger">*</span></label>
                                <input type="email" class="ios-form-control" id="email" name="email" value="<c:out value='${email}' />" required placeholder="alex@university.edu" autocomplete="off">
                                <div class="invalid-feedback small mt-1">Please enter a valid email address.</div>
                            </div>
                            <div class="form-group col-md-6 mb-3">
                                <label for="password" class="ios-form-label">Password <span class="text-danger">*</span></label>
                                <div class="ios-input-wrapper">
                                    <input type="password" class="ios-form-control" id="password" name="password" required minlength="6" placeholder="Min. 6 characters" autocomplete="new-password">
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
                                <div class="invalid-feedback small mt-1">Password must be at least 6 characters.</div>
                            </div>
                        </div>

                        <!-- Row 3: Roll Number & IT Department -->
                        <div class="form-row">
                            <div class="form-group col-md-6 mb-3">
                                <label for="rollNumber" class="ios-form-label">Roll / University Registration No. <span class="text-danger">*</span></label>
                                <input type="text" class="ios-form-control" id="rollNumber" name="rollNumber" value="<c:out value='${rollNumber}' />" required placeholder="e.g. 2026-CS-104">
                                <div class="invalid-feedback small mt-1">Roll Number is required.</div>
                            </div>
                            <div class="form-group col-md-6 mb-3">
                                <label for="department" class="ios-form-label">Academic Department / Degree <span class="text-danger">*</span></label>
                                <select class="ios-form-control" id="department" name="department" required>
                                    <option value="" disabled ${empty department ? 'selected' : ''}>Select your IT / CS branch...</option>
                                    <option value="CSE" ${department == 'CSE' ? 'selected' : ''}>Computer Science & Engineering (CSE)</option>
                                    <option value="IT" ${department == 'IT' ? 'selected' : ''}>Information Technology (IT)</option>
                                    <option value="AI_ML" ${department == 'AI_ML' ? 'selected' : ''}>Artificial Intelligence & Machine Learning (AI & ML)</option>
                                    <option value="AI_DS" ${department == 'AI_DS' ? 'selected' : ''}>Artificial Intelligence & Data Science (AI & DS)</option>
                                    <option value="CS_CYBER" ${department == 'CS_CYBER' ? 'selected' : ''}>Computer Science (Cyber Security)</option>
                                    <option value="CS_IOT" ${department == 'CS_IOT' ? 'selected' : ''}>Computer Science (IoT & Edge Computing)</option>
                                    <option value="CS_CLOUD" ${department == 'CS_CLOUD' ? 'selected' : ''}>Computer Science (Cloud & Big Data)</option>
                                    <option value="CSBS" ${department == 'CSBS' ? 'selected' : ''}>Computer Science & Business Systems (CSBS)</option>
                                    <option value="SE" ${department == 'SE' ? 'selected' : ''}>Software Engineering (SE)</option>
                                    <option value="DATA_SCIENCE" ${department == 'DATA_SCIENCE' ? 'selected' : ''}>Data Science & Analytics</option>
                                    <option value="MCA" ${department == 'MCA' ? 'selected' : ''}>Master of Computer Applications (MCA)</option>
                                    <option value="BCA" ${department == 'BCA' ? 'selected' : ''}>Bachelor of Computer Applications (BCA)</option>
                                    <option value="B_SC_CS_IT" ${department == 'B_SC_CS_IT' ? 'selected' : ''}>B.Sc (Computer Science / IT)</option>
                                    <option value="OTHER_IT" ${department == 'OTHER_IT' ? 'selected' : ''}>Other Computational Specialization</option>
                                </select>
                                <div class="invalid-feedback small mt-1">Please select your department.</div>
                            </div>
                        </div>

                        <!-- Row 4: Graduation Year & CGPA -->
                        <div class="form-row">
                            <div class="form-group col-md-6 mb-3">
                                <label for="graduationYear" class="ios-form-label">Graduation Year <span class="text-danger">*</span></label>
                                <input type="number" class="ios-form-control" id="graduationYear" name="graduationYear" value="<c:out value='${graduationYear}' />" min="2000" max="2040" required placeholder="e.g. 2026">
                                <div class="invalid-feedback small mt-1">Valid year (2000-2040) is required.</div>
                            </div>
                            <div class="form-group col-md-6 mb-3">
                                <label for="cgpa" class="ios-form-label">Cumulative CGPA (0.00 - 10.00) <span class="text-danger">*</span></label>
                                <input type="number" step="0.01" class="ios-form-control" id="cgpa" name="cgpa" value="<c:out value='${cgpa}' />" min="0" max="10" required placeholder="e.g. 8.50">
                                <div class="invalid-feedback small mt-1">CGPA must be between 0.00 and 10.00.</div>
                            </div>
                        </div>

                        <!-- Row 5: Target Role (Optional) -->
                        <div class="form-group mb-4">
                            <label for="targetRoleId" class="ios-form-label">Target Career Role <span class="text-muted font-weight-normal">(Optional)</span></label>
                            <select class="ios-form-control" id="targetRoleId" name="targetRoleId">
                                <option value="">Select Target Tech Role (You can change this anytime)...</option>
                                <c:forEach items="${targetRoles}" var="role">
                                    <option value="${role.roleId}" ${targetRoleId == role.roleId ? 'selected' : ''}>
                                        <c:out value="${role.roleTitle}" />
                                    </option>
                                </c:forEach>
                            </select>
                            <small class="text-muted mt-1 d-block" style="font-size: 0.8rem;">
                                Your Skill Gap analysis and readiness score will automatically benchmark against this role.
                            </small>
                        </div>

                        <!-- Submit Button -->
                        <button type="submit" class="ios-btn-primary btn-block py-3 mt-4" style="font-size: 1rem; border-radius: var(--ios-radius-md); box-shadow: 0 10px 25px rgba(0, 113, 227, 0.3);">
                            Create Student Account &rarr;
                        </button>
                    </form>

                    <!-- Login Redirect Link -->
                    <div class="text-center mt-4 pt-3 border-top">
                        <span class="text-muted small">Already have an account?</span>
                        <a href="${pageContext.request.contextPath}/login" class="small font-weight-bold ml-1" style="color: var(--ios-blue);">
                            Sign In to Portal &rarr;
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

    // Form validation
    var form = document.getElementById('registerForm');
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
