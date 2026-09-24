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
                            <form action="${pageContext.request.contextPath}/app/student/profile" method="post" class="needs-validation" novalidate>
                                <input type="hidden" name="csrfToken" value="${sessionScope.CSRF_TOKEN}" />

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

                    <!-- Guidance Tip Card -->
                    <div class="ios-card" style="padding: 1.25rem;">
                        <div class="d-flex align-items-center gap-2 mb-2">
                            <div class="ios-badge ios-badge-blue p-1">
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" aria-hidden="true"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="16" x2="12" y2="12"></line><line x1="12" y1="8" x2="12.01" y2="8"></line></svg>
                            </div>
                            <span class="font-weight-bold text-dark" style="font-size: 0.9rem;">Why Keep This Updated?</span>
                        </div>
                        <p class="text-muted small mb-0" style="line-height: 1.6;">
                            Campus placement recruiters and algorithmic filters rank candidate profiles based on target role alignment, verified skills, and academic consistency.
                        </p>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jspf" %>
