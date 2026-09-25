<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Academic Profile" />
<c:set var="activeNav" value="profile" />
<%@ include file="/WEB-INF/views/common/header.jspf" %>
<%@ include file="/WEB-INF/views/common/navbar.jspf" %>

<div class="container-fluid">
    <div class="row">
        <%@ include file="/WEB-INF/views/common/sidebar.jspf" %>

        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4 py-4">
            <%@ include file="/WEB-INF/views/common/alerts.jspf" %>

            <!-- Page Header -->
            <div class="ios-dash-header mb-4">
                <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">
                    <div>
                        <div class="d-flex align-items-center gap-2 mb-1">
                            <span class="ios-badge ios-badge-blue">
                                <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" aria-hidden="true"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
                                Candidate Account
                            </span>
                        </div>
                        <h1 class="h3 font-weight-bold text-gray-800 mb-0" style="letter-spacing: -0.03em;">Academic &amp; Career Profile</h1>
                        <p class="text-muted small mb-0 mt-1">Manage your academic records, technical specialization, and target career pathway</p>
                    </div>
                    <div>
                        <a href="${pageContext.request.contextPath}/app/student/readiness-card" class="ios-btn-secondary" style="padding: 0.6rem 1.25rem; font-size: 0.875rem;">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" aria-hidden="true"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path><polyline points="14 2 14 8 20 8"></polyline><line x1="16" y1="13" x2="8" y2="13"></line><line x1="16" y1="17" x2="8" y2="17"></line></svg>
                            View Readiness Card
                        </a>
                    </div>
                </div>
            </div>

            <div class="row">
                <!-- Profile Edit Form -->
                <div class="col-lg-8 mb-4">
                    <!-- Formal Candidate Passport Photo Card -->
                    <div class="ios-card mb-4" style="background: linear-gradient(135deg, rgba(255, 255, 255, 0.95), rgba(248, 250, 252, 0.98)); border: 1px solid rgba(226, 232, 240, 0.9); box-shadow: 0 4px 20px -2px rgba(0, 0, 0, 0.05);">
                        <div class="ios-card-header d-flex justify-content-between align-items-center flex-wrap gap-2" style="padding: 1.15rem 1.5rem;">
                            <div class="d-flex align-items-center gap-2">
                                <span class="ios-badge ios-badge-purple">
                                    <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" aria-hidden="true"><path d="M23 19a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h4l2-3h6l2 3h4a2 2 0 0 1 2 2z"></path><circle cx="12" cy="13" r="4"></circle></svg>
                                    Official Credential Photo
                                </span>
                                <h2 class="h5 font-weight-bold text-dark mb-0" style="font-size: 1.05rem;">Passport Photograph</h2>
                            </div>
                            <c:choose>
                                <c:when test="${not empty profile.student.profileImage}">
                                    <span class="badge badge-success px-3 py-1.5" style="border-radius: 999px; font-weight: 600; font-size: 0.75rem; letter-spacing: 0.02em;">
                                        <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" style="margin-right: 4px;"><polyline points="20 6 9 17 4 12"></polyline></svg>
                                        Photo Active on Passport
                                    </span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge badge-warning text-dark px-3 py-1.5" style="border-radius: 999px; font-weight: 600; font-size: 0.75rem;">
                                        ⚠ Mandatory for Placement Passport
                                    </span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="ios-card-body" style="padding: 1.5rem;">
                            <div class="d-flex flex-column flex-sm-row align-items-center gap-4">
                                <!-- Avatar Preview Box -->
                                <div class="position-relative text-center flex-shrink-0">
                                    <div id="avatarPreviewContainer" style="width: 120px; height: 120px; border-radius: 20px; border: 3px solid #6366f1; padding: 3px; background: #ffffff; box-shadow: 0 10px 25px -5px rgba(99, 102, 241, 0.25); overflow: hidden; display: flex; align-items: center; justify-content: center; position: relative;">
                                        <c:choose>
                                            <c:when test="${not empty profile.student.profileImage}">
                                                <img id="avatarPreviewImg" src="${profile.student.profileImage}" alt="${profile.student.fullName}" style="width: 100%; height: 100%; object-fit: cover; border-radius: 15px;" />
                                                <div id="avatarFallback" class="w-100 h-100 d-flex flex-column align-items-center justify-content-center text-center bg-light" style="border-radius: 15px; color: #64748b; display: none !important;">
                                                    <svg width="36" height="36" viewBox="0 0 24 24" fill="none" stroke="#94a3b8" stroke-width="1.8"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
                                                    <span style="font-size: 0.7rem; font-weight: 600; margin-top: 4px;">NO PHOTO</span>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div id="avatarFallback" class="w-100 h-100 d-flex flex-column align-items-center justify-content-center text-center bg-light" style="border-radius: 15px; color: #64748b;">
                                                    <svg width="36" height="36" viewBox="0 0 24 24" fill="none" stroke="#94a3b8" stroke-width="1.8"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
                                                    <span style="font-size: 0.7rem; font-weight: 600; margin-top: 4px;">NO PHOTO</span>
                                                </div>
                                                <img id="avatarPreviewImg" src="" alt="Preview" style="width: 100%; height: 100%; object-fit: cover; border-radius: 15px; display: none;" />
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="mt-2 text-muted" style="font-size: 0.75rem; font-weight: 600;">Formal 1:1 Portrait</div>
                                </div>

                                <!-- Photo Actions & Guidelines -->
                                <div class="flex-grow-1 text-center text-sm-left">
                                    <h3 class="h6 font-weight-bold text-dark mb-1" style="font-size: 0.95rem;">Professional Candidate Portrait</h3>
                                    <p class="text-muted small mb-3" style="line-height: 1.55;">
                                        Your photograph is printed directly on your <strong>Official Placement Passport</strong> and presented to campus recruitment panels. Upload a formal, front-facing headshot (JPEG, PNG, or WebP).
                                    </p>
                                    <div class="d-flex flex-wrap align-items-center gap-2 justify-content-center justify-content-sm-start">
                                        <input type="file" id="avatarFileInput" accept="image/jpeg,image/png,image/webp" style="display: none;" onchange="handleAvatarFileSelect(this);" />
                                        <button type="button" class="ios-btn-primary" onclick="document.getElementById('avatarFileInput').click();" style="padding: 0.55rem 1.25rem; font-size: 0.85rem;">
                                            <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" aria-hidden="true"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path><polyline points="17 8 12 3 7 8"></polyline><line x1="12" y1="3" x2="12" y2="15"></line></svg>
                                            ${not empty profile.student.profileImage ? 'Change Photo' : 'Upload Passport Photo'}
                                        </button>
                                        <button type="button" id="saveAvatarBtn" class="ios-btn-primary" style="display: none; padding: 0.55rem 1.25rem; font-size: 0.85rem; background: #10b981; border-color: #059669;" onclick="saveSelectedAvatar();">
                                            <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" aria-hidden="true"><polyline points="20 6 9 17 4 12"></polyline></svg>
                                            Save &amp; Apply Photo
                                        </button>
                                        <c:if test="${not empty profile.student.profileImage}">
                                            <form action="${pageContext.request.contextPath}/app/student/profile" method="post" class="d-inline" onsubmit="return confirm('Are you sure you want to remove your passport profile photo?');">
                                                <input type="hidden" name="csrfToken" value="${sessionScope.CSRF_TOKEN}" />
                                                <input type="hidden" name="action" value="removeAvatar" />
                                                <button type="submit" class="btn btn-sm btn-outline-danger" style="border-radius: 10px; font-weight: 600; padding: 0.5rem 0.9rem; font-size: 0.825rem;">
                                                    Remove Photo
                                                </button>
                                            </form>
                                        </c:if>
                                    </div>
                                    <div id="avatarUploadFeedback" class="small mt-2 font-weight-bold" style="display: none;"></div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="ios-card">
                        <div class="ios-card-header" style="padding: 1.25rem 1.5rem;">
                            <div>
                                <h2 class="h5 font-weight-bold text-dark mb-0" style="font-size: 1.05rem;">Edit Profile &amp; Specialization</h2>
                                <small class="text-muted">Fields marked with an asterisk (*) are required</small>
                            </div>
                            <span class="ios-badge ios-badge-blue d-inline-flex align-items-center" style="gap: 0.35rem;">
                                <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true"><path d="M22 10v6M2 10l10-5 10 5-10 5z"></path></svg>
                                Dept: <c:out value="${profile.student.department}" default="IT" />
                            </span>
                        </div>
                        <div class="ios-card-body" style="padding: 1.5rem;">
                            <form action="${pageContext.request.contextPath}/app/student/profile" method="post" class="needs-validation" novalidate id="profileDetailsForm">
                                <input type="hidden" name="csrfToken" value="${sessionScope.CSRF_TOKEN}" />
                                <input type="hidden" name="profileImage" id="hiddenProfileImageInput" value="<c:out value='${profile.student.profileImage}' />" />

                                <!-- Section 1: Personal Details -->
                                <div class="mb-4">
                                    <h3 class="h6 font-weight-bold text-muted mb-3" style="font-size: 0.8125rem; letter-spacing: -0.01em;">
                                        Candidate Identification
                                    </h3>
                                    <div class="form-row">
                                        <div class="form-group col-md-6 mb-3">
                                            <label for="fullName" class="ios-form-label">Full Name *</label>
                                            <input type="text" class="ios-form-control" id="fullName" name="fullName" value="<c:out value='${profile.student.fullName}' />" required placeholder="Enter full name">
                                            <div class="invalid-feedback">Full Name is required.</div>
                                        </div>
                                        <div class="form-group col-md-6 mb-3">
                                            <label class="ios-form-label">Email Address (Login ID)</label>
                                            <div class="position-relative">
                                                <input type="email" class="ios-form-control bg-light" value="<c:out value='${profile.student.email}' />" readonly disabled style="cursor: not-allowed; color: var(--ios-text-secondary);">
                                                <span class="position-absolute" style="right: 12px; top: 12px; color: var(--ios-text-tertiary);">
                                                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" aria-hidden="true"><rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect><path d="M7 11V7a5 5 0 0 1 10 0v4"></path></svg>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Section 2: Academic Background -->
                                <div class="mb-4">
                                    <h3 class="h6 font-weight-bold text-muted mb-3" style="font-size: 0.8125rem; letter-spacing: -0.01em;">
                                        Academic Records &amp; Department
                                    </h3>
                                    <div class="form-row">
                                        <div class="form-group col-md-6 mb-3">
                                            <label for="rollNumber" class="ios-form-label">Roll / Registration Number *</label>
                                            <input type="text" class="ios-form-control" id="rollNumber" name="rollNumber" value="<c:out value='${profile.student.rollNumber}' />" required placeholder="e.g. 21CS042">
                                            <div class="invalid-feedback">Roll number is required.</div>
                                        </div>
                                        <div class="form-group col-md-6 mb-3">
                                            <label for="department" class="ios-form-label">IT/CS Department &amp; Degree *</label>
                                            <select class="ios-form-control" id="department" name="department" required>
                                                <option value="CSE" ${profile.student.department == 'CSE' ? 'selected' : ''}>Computer Science &amp; Engineering (CSE)</option>
                                                <option value="IT" ${profile.student.department == 'IT' ? 'selected' : ''}>Information Technology (IT)</option>
                                                <option value="AI_ML" ${profile.student.department == 'AI_ML' ? 'selected' : ''}>Artificial Intelligence &amp; Machine Learning (AI &amp; ML)</option>
                                                <option value="AI_DS" ${profile.student.department == 'AI_DS' ? 'selected' : ''}>Artificial Intelligence &amp; Data Science (AI &amp; DS)</option>
                                                <option value="CS_CYBER" ${profile.student.department == 'CS_CYBER' ? 'selected' : ''}>Computer Science (Cyber Security)</option>
                                                <option value="CS_IOT" ${profile.student.department == 'CS_IOT' ? 'selected' : ''}>Computer Science (IoT &amp; Edge Computing)</option>
                                                <option value="CS_CLOUD" ${profile.student.department == 'CS_CLOUD' ? 'selected' : ''}>Computer Science (Cloud &amp; Big Data)</option>
                                                <option value="CSBS" ${profile.student.department == 'CSBS' ? 'selected' : ''}>Computer Science &amp; Business Systems (CSBS)</option>
                                                <option value="SE" ${profile.student.department == 'SE' ? 'selected' : ''}>Software Engineering (SE)</option>
                                                <option value="DATA_SCIENCE" ${profile.student.department == 'DATA_SCIENCE' ? 'selected' : ''}>Data Science &amp; Analytics</option>
                                                <option value="MCA" ${profile.student.department == 'MCA' ? 'selected' : ''}>Master of Computer Applications (MCA)</option>
                                                <option value="BCA" ${profile.student.department == 'BCA' ? 'selected' : ''}>Bachelor of Computer Applications (BCA)</option>
                                                <option value="B_SC_CS_IT" ${profile.student.department == 'B_SC_CS_IT' ? 'selected' : ''}>B.Sc (Computer Science / IT)</option>
                                                <option value="OTHER_IT" ${profile.student.department == 'OTHER_IT' ? 'selected' : ''}>Other Computational Specialization</option>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="form-row">
                                        <div class="form-group col-md-6 mb-3">
                                            <label for="graduationYear" class="ios-form-label">Graduation Year *</label>
                                            <input type="number" class="ios-form-control" id="graduationYear" name="graduationYear" value="<c:out value='${profile.student.graduationYear}' />" min="2000" max="2040" required placeholder="e.g. 2026">
                                            <div class="invalid-feedback">Valid graduation year is required.</div>
                                        </div>
                                        <div class="form-group col-md-6 mb-3">
                                            <label for="cgpa" class="ios-form-label">Current CGPA (0.00 - 10.00) *</label>
                                            <input type="number" step="0.01" class="ios-form-control" id="cgpa" name="cgpa" value="<c:out value='${profile.student.cgpa}' />" min="0" max="10" required placeholder="e.g. 8.75">
                                            <div class="invalid-feedback">CGPA must be between 0.00 and 10.00.</div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Section 3: Target Role -->
                                <div class="mb-4">
                                    <h3 class="h6 font-weight-bold text-muted mb-3" style="font-size: 0.8125rem; letter-spacing: -0.01em;">
                                        Career Focus &amp; Target Role
                                    </h3>
                                    <div class="form-row">
                                        <div class="form-group col-md-6 mb-2">
                                            <label for="targetRoleId" class="ios-form-label">Primary Target Career Role</label>
                                            <select class="ios-form-control" id="targetRoleId" name="targetRoleId">
                                                <option value="">Select Target Role...</option>
                                                <c:forEach items="${targetRoles}" var="role">
                                                    <option value="${role.roleId}" ${profile.student.targetRoleId == role.roleId ? 'selected' : ''}>
                                                        <c:out value="${role.roleTitle}" />
                                                    </option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    <small class="text-muted d-block mt-1">
                                        SkillTrack dynamically recalculates your <strong>Skill Gap Matrix</strong> and <strong>Readiness Score</strong> based on this selected role.
                                    </small>
                                </div>

                                <div class="pt-3 border-top d-flex justify-content-start">
                                    <button type="submit" class="ios-btn-primary" style="padding: 0.75rem 2rem;">
                                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" aria-hidden="true"><polyline points="20 6 9 17 4 12"></polyline></svg>
                                        Save Profile Changes
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Right Sidebar: Portfolio Live Metrics & Info -->
                <div class="col-lg-4">
                    <div class="ios-card mb-4">
                        <div class="ios-card-header" style="padding: 1.25rem 1.25rem;">
                            <h2 class="h5 font-weight-bold text-dark mb-0" style="font-size: 1rem;">Portfolio Activity</h2>
                            <span class="ios-badge ios-badge-blue">Live Sync</span>
                        </div>
                        <div class="ios-card-body p-0">
                            <a href="${pageContext.request.contextPath}/app/student/skills" class="d-flex justify-content-between align-items-center text-decoration-none text-dark border-bottom" style="padding: 1rem 1.25rem; transition: var(--ios-ease);">
                                <div class="d-flex align-items-center" style="gap: 0.75rem;">
                                    <div class="ios-badge ios-badge-blue p-2">
                                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" aria-hidden="true"><polyline points="16 18 22 12 16 6"></polyline><polyline points="8 6 2 12 8 18"></polyline></svg>
                                    </div>
                                    <div>
                                        <div class="font-weight-bold" style="font-size: 0.9rem;">Technical Skills</div>
                                        <div class="text-muted small">Proficiency inventory</div>
                                    </div>
                                </div>
                                <div class="d-flex align-items-center" style="gap: 0.5rem;">
                                    <span class="ios-badge ios-badge-blue font-weight-bold">${profile.skills.size()}</span>
                                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#94a3b8" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><polyline points="9 18 15 12 9 6"></polyline></svg>
                                </div>
                            </a>

                            <a href="${pageContext.request.contextPath}/app/student/projects" class="d-flex justify-content-between align-items-center text-decoration-none text-dark border-bottom" style="padding: 1rem 1.25rem; transition: var(--ios-ease);">
                                <div class="d-flex align-items-center" style="gap: 0.75rem;">
                                    <div class="ios-badge ios-badge-blue p-2">
                                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" aria-hidden="true"><path d="M22 19a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h5l2 3h9a2 2 0 0 1 2 2z"></path></svg>
                                    </div>
                                    <div>
                                        <div class="font-weight-bold" style="font-size: 0.9rem;">Projects Completed</div>
                                        <div class="text-muted small">Software repositories</div>
                                    </div>
                                </div>
                                <div class="d-flex align-items-center" style="gap: 0.5rem;">
                                    <span class="ios-badge ios-badge-blue font-weight-bold">${profile.projects.size()}</span>
                                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#94a3b8" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><polyline points="9 18 15 12 9 6"></polyline></svg>
                                </div>
                            </a>

                            <a href="${pageContext.request.contextPath}/app/student/certifications" class="d-flex justify-content-between align-items-center text-decoration-none text-dark border-bottom" style="padding: 1rem 1.25rem; transition: var(--ios-ease);">
                                <div class="d-flex align-items-center" style="gap: 0.75rem;">
                                    <div class="ios-badge ios-badge-blue p-2">
                                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" aria-hidden="true"><circle cx="12" cy="8" r="7"></circle><polyline points="8.21 13.89 7 23 12 20 17 23 15.79 13.88"></polyline></svg>
                                    </div>
                                    <div>
                                        <div class="font-weight-bold" style="font-size: 0.9rem;">Certifications</div>
                                        <div class="text-muted small">Industry credentials</div>
                                    </div>
                                </div>
                                <div class="d-flex align-items-center" style="gap: 0.5rem;">
                                    <span class="ios-badge ios-badge-blue font-weight-bold">${profile.certifications.size()}</span>
                                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#94a3b8" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><polyline points="9 18 15 12 9 6"></polyline></svg>
                                </div>
                            </a>

                            <a href="${pageContext.request.contextPath}/app/student/dsa-tracker" class="d-flex justify-content-between align-items-center text-decoration-none text-dark" style="padding: 1rem 1.25rem; transition: var(--ios-ease);">
                                <div class="d-flex align-items-center" style="gap: 0.75rem;">
                                    <div class="ios-badge ios-badge-blue p-2">
                                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" aria-hidden="true"><polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"></polyline></svg>
                                    </div>
                                    <div>
                                        <div class="font-weight-bold" style="font-size: 0.9rem;">DSA Problems Solved</div>
                                        <div class="text-muted small">Algorithm practice</div>
                                    </div>
                                </div>
                                <div class="d-flex align-items-center" style="gap: 0.5rem;">
                                    <span class="ios-badge ios-badge-blue font-weight-bold">${profile.totalDsaProblemsSolved}</span>
                                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#94a3b8" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><polyline points="9 18 15 12 9 6"></polyline></svg>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>

<script>
    let pendingAvatarDataUrl = null;

    function handleAvatarFileSelect(input) {
        if (!input.files || !input.files[0]) return;
        const file = input.files[0];

        // Validate type
        if (!file.type.match(/image\/(jpeg|png|webp|jpg)/i)) {
            alert('Please select a valid image file (JPEG, PNG, or WebP).');
            return;
        }

        const reader = new FileReader();
        reader.onload = function(e) {
            const img = new Image();
            img.onload = function() {
                // Compress & resize to max 400x400 square / centered
                const canvas = document.createElement('canvas');
                const MAX_SIZE = 400;
                let width = img.width;
                let height = img.height;

                // Center-crop to 1:1 aspect ratio
                let sourceX = 0, sourceY = 0, sourceSize = Math.min(width, height);
                if (width > height) {
                    sourceX = (width - height) / 2;
                } else {
                    sourceY = (height - width) / 2;
                }

                canvas.width = MAX_SIZE;
                canvas.height = MAX_SIZE;
                const ctx = canvas.getContext('2d');
                ctx.imageSmoothingEnabled = true;
                ctx.imageSmoothingQuality = 'high';
                ctx.drawImage(img, sourceX, sourceY, sourceSize, sourceSize, 0, 0, MAX_SIZE, MAX_SIZE);

                // Export as JPEG with 0.88 quality
                pendingAvatarDataUrl = canvas.toDataURL('image/jpeg', 0.88);

                // Update Preview UI
                const previewImg = document.getElementById('avatarPreviewImg');
                const fallback = document.getElementById('avatarFallback');
                if (fallback) fallback.style.setProperty('display', 'none', 'important');
                previewImg.src = pendingAvatarDataUrl;
                previewImg.style.display = 'block';

                // Update hidden input in profile form
                const hiddenInput = document.getElementById('hiddenProfileImageInput');
                if (hiddenInput) hiddenInput.value = pendingAvatarDataUrl;

                // Show save button & feedback
                const saveBtn = document.getElementById('saveAvatarBtn');
                if (saveBtn) saveBtn.style.display = 'inline-flex';

                const feedback = document.getElementById('avatarUploadFeedback');
                if (feedback) {
                    feedback.style.display = 'block';
                    feedback.className = 'small mt-2 font-weight-bold text-primary';
                    feedback.innerHTML = 'Photo selected! Click "Save & Apply Photo" to update your passport immediately, or save below.';
                }
            };
            img.src = e.target.result;
        };
        reader.readAsDataURL(file);
    }

    function saveSelectedAvatar() {
        if (!pendingAvatarDataUrl) {
            alert('Please select an image first.');
            return;
        }

        const saveBtn = document.getElementById('saveAvatarBtn');
        const feedback = document.getElementById('avatarUploadFeedback');
        if (saveBtn) {
            saveBtn.disabled = true;
            saveBtn.innerHTML = '<span class="spinner-border spinner-border-sm mr-1"></span> Saving...';
        }

        const formData = new URLSearchParams();
        formData.append('action', 'updateAvatar');
        formData.append('profileImage', pendingAvatarDataUrl);
        formData.append('csrfToken', '${sessionScope.CSRF_TOKEN}');

        fetch('${pageContext.request.contextPath}/app/student/profile', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
                'X-Requested-With': 'XMLHttpRequest'
            },
            body: formData.toString()
        })
        .then(res => res.json())
        .then(data => {
            if (data.success) {
                if (feedback) {
                    feedback.className = 'small mt-2 font-weight-bold text-success';
                    feedback.innerHTML = '✓ ' + data.message + ' Reloading...';
                }
                setTimeout(() => {
                    window.location.reload();
                }, 700);
            } else {
                throw new Error(data.message || 'Failed to update photo');
            }
        })
        .catch(err => {
            if (saveBtn) {
                saveBtn.disabled = false;
                saveBtn.innerHTML = '<svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="20 6 9 17 4 12"></polyline></svg> Save & Apply Photo';
            }
            if (feedback) {
                feedback.className = 'small mt-2 font-weight-bold text-danger';
                feedback.innerHTML = 'Error: ' + err.message;
            }
        });
    }
</script>

<%@ include file="/WEB-INF/views/common/footer.jspf" %>
