<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Academic Profile" />
<c:set var="activeNav" value="profile" />
<%@ include file="/WEB-INF/views/common/header.jspf" %>
<%@ include file="/WEB-INF/views/common/navbar.jspf" %>

<style>
    .profile-page-wrapper {
        max-width: 1440px;
        margin: 0 auto;
    }

    /* Glassmorphic Page Header */
    .profile-header-card {
        background: rgba(255, 255, 255, 0.85);
        backdrop-filter: blur(12px);
        -webkit-backdrop-filter: blur(12px);
        border: 1px solid rgba(226, 232, 240, 0.8);
        border-radius: 16px;
        padding: 1.25rem 1.5rem;
        box-shadow: 0 4px 20px -2px rgba(0, 0, 0, 0.03);
        margin-bottom: 1.5rem;
    }

    /* Profile Container Cards */
    .profile-card {
        background: #ffffff;
        border: 1px solid rgba(226, 232, 240, 0.85);
        border-radius: 16px;
        box-shadow: 0 4px 20px -2px rgba(0, 0, 0, 0.03);
        margin-bottom: 1.5rem;
        overflow: hidden;
    }

    .profile-card-header {
        padding: 1.15rem 1.5rem;
        background: rgba(248, 250, 252, 0.7);
        border-bottom: 1px solid rgba(226, 232, 240, 0.8);
        display: flex;
        align-items: center;
        justify-content: space-between;
        flex-wrap: wrap;
        gap: 0.75rem;
    }

    .profile-card-body {
        padding: 1.5rem;
    }

    /* Section Subheaders */
    .profile-section-divider {
        font-size: 0.8rem;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 0.05em;
        color: #64748b;
        display: flex;
        align-items: center;
        gap: 0.5rem;
        margin-bottom: 1.1rem;
        padding-bottom: 0.5rem;
        border-bottom: 1px solid rgba(241, 245, 249, 1);
    }

    /* Form Controls */
    .profile-form-label {
        font-size: 0.825rem;
        font-weight: 600;
        color: #334155;
        margin-bottom: 0.4rem;
        display: flex;
        align-items: center;
        justify-content: space-between;
    }

    .profile-input {
        background: #ffffff;
        border: 1.5px solid #e2e8f0;
        border-radius: 12px;
        padding: 0.65rem 1rem;
        font-size: 0.875rem;
        font-weight: 500;
        color: #1e293b;
        width: 100%;
        transition: all 0.2s ease;
    }

    .profile-input:focus {
        border-color: #3b82f6;
        outline: none;
        box-shadow: 0 0 0 3.5px rgba(59, 130, 246, 0.12);
        background: #ffffff;
    }

    .profile-input:disabled, .profile-input[readonly] {
        background: #f8fafc;
        border-color: #e2e8f0;
        color: #64748b;
        cursor: not-allowed;
    }

    .input-icon-wrapper {
        position: relative;
    }

    .input-icon-left {
        position: absolute;
        left: 0.9rem;
        top: 50%;
        transform: translateY(-50%);
        display: flex;
        align-items: center;
        justify-content: center;
        pointer-events: none;
        z-index: 2;
    }

    .input-with-icon-left {
        padding-left: 2.75rem !important;
    }

    .input-icon-right {
        position: absolute;
        right: 0.9rem;
        top: 50%;
        transform: translateY(-50%);
        display: flex;
        align-items: center;
        justify-content: center;
        pointer-events: none;
        color: #94a3b8;
    }

    /* Photo Avatar */
    .avatar-frame {
        width: 110px;
        height: 110px;
        border-radius: 20px;
        border: 3px solid #3b82f6;
        padding: 3px;
        background: #ffffff;
        box-shadow: 0 8px 20px -4px rgba(59, 130, 246, 0.25);
        overflow: hidden;
        display: flex;
        align-items: center;
        justify-content: center;
        position: relative;
        flex-shrink: 0;
    }

    .avatar-img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        border-radius: 15px;
    }

    /* Portfolio Sidebar Navigation List */
    .portfolio-nav-item {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 1rem 1.25rem;
        border-bottom: 1px solid rgba(241, 245, 249, 0.9);
        text-decoration: none !important;
        color: #1e293b;
        transition: all 0.2s ease;
    }

    .portfolio-nav-item:last-child {
        border-bottom: none;
    }

    .portfolio-nav-item:hover {
        background: rgba(248, 250, 252, 0.9);
        transform: translateX(3px);
    }

    .portfolio-icon-badge {
        width: 38px;
        height: 38px;
        border-radius: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        flex-shrink: 0;
    }

    /* Badges */
    .ios-pill-badge {
        display: inline-flex;
        align-items: center;
        gap: 0.35rem;
        padding: 0.3rem 0.75rem;
        border-radius: 999px;
        font-size: 0.75rem;
        font-weight: 600;
        letter-spacing: 0.02em;
    }

    .ios-pill-blue {
        background: rgba(59, 130, 246, 0.1);
        color: #2563eb;
        border: 1px solid rgba(59, 130, 246, 0.2);
    }

    .ios-pill-emerald {
        background: rgba(16, 185, 129, 0.1);
        color: #059669;
        border: 1px solid rgba(16, 185, 129, 0.2);
    }

    .ios-pill-amber {
        background: rgba(245, 158, 11, 0.1);
        color: #d97706;
        border: 1px solid rgba(245, 158, 11, 0.2);
    }

    .ios-pill-purple {
        background: rgba(139, 92, 246, 0.1);
        color: #7c3aed;
        border: 1px solid rgba(139, 92, 246, 0.2);
    }

    /* Buttons */
    .btn-save-profile {
        background: linear-gradient(135deg, #3b82f6, #2563eb);
        color: #ffffff;
        border: none;
        border-radius: 12px;
        padding: 0.75rem 1.75rem;
        font-size: 0.9rem;
        font-weight: 600;
        display: inline-flex;
        align-items: center;
        gap: 0.5rem;
        box-shadow: 0 4px 14px -2px rgba(37, 99, 235, 0.4);
        transition: all 0.2s ease;
        cursor: pointer;
    }

    .btn-save-profile:hover {
        transform: translateY(-1px);
        box-shadow: 0 6px 18px -2px rgba(37, 99, 235, 0.5);
        color: #ffffff;
    }

    .btn-action-light {
        background: #f1f5f9;
        color: #334155;
        border: 1px solid #e2e8f0;
        border-radius: 10px;
        padding: 0.5rem 1rem;
        font-size: 0.825rem;
        font-weight: 600;
        display: inline-flex;
        align-items: center;
        gap: 0.4rem;
        transition: all 0.2s ease;
        text-decoration: none !important;
        cursor: pointer;
    }

    .btn-action-light:hover {
        background: #e2e8f0;
        color: #0f172a;
    }
</style>

<div class="container-fluid px-3 px-lg-4 py-4 profile-page-wrapper">
    <%@ include file="/WEB-INF/views/common/alerts.jspf" %>

    <!-- Header Banner -->
    <div class="profile-header-card">
        <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">
            <div>
                <div class="d-flex align-items-center gap-2 mb-1">
                    <span class="ios-pill-badge ios-pill-blue">
                        <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
                        Candidate Profile
                    </span>
                </div>
                <h1 class="h3 font-weight-bold text-gray-900 mb-0" style="letter-spacing: -0.025em;">Academic &amp; Career Profile</h1>
                <p class="text-muted small mb-0 mt-1">Manage personal details, academic records, and coding profiles</p>
            </div>
            <div>
                <a href="${pageContext.request.contextPath}/app/student/readiness-card" class="btn-action-light" style="padding: 0.6rem 1.25rem; font-size: 0.85rem;">
                    <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path><polyline points="14 2 14 8 20 8"></polyline><line x1="16" y1="13" x2="8" y2="13"></line><line x1="16" y1="17" x2="8" y2="17"></line></svg>
                    View Readiness Card
                </a>
            </div>
        </div>
    </div>

    <div class="row">
        <!-- Main Form Column (Left 8 Cols) -->
        <div class="col-lg-8">
            <!-- Candidate Passport Photo Card -->
            <div class="profile-card">
                <div class="profile-card-header">
                    <div class="d-flex align-items-center gap-2">
                        <span class="ios-pill-badge ios-pill-purple">
                            <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M23 19a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h4l2-3h6l2 3h4a2 2 0 0 1 2 2z"></path><circle cx="12" cy="13" r="4"></circle></svg>
                            Passport Photograph
                        </span>
                        <span class="font-weight-bold text-dark" style="font-size: 0.95rem;">Profile Headshot</span>
                    </div>
                    <div>
                        <c:choose>
                            <c:when test="${not empty profile.student.profileImage}">
                                <span class="ios-pill-badge ios-pill-emerald">
                                    <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3"><polyline points="20 6 9 17 4 12"></polyline></svg>
                                    Photo Active
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span class="ios-pill-badge ios-pill-amber">
                                    Photo Required
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="profile-card-body">
                    <div class="d-flex flex-column flex-sm-row align-items-center gap-4">
                        <!-- Avatar Preview Frame -->
                        <div class="avatar-frame">
                            <c:choose>
                                <c:when test="${not empty profile.student.profileImage}">
                                    <img id="avatarPreviewImg" src="${profile.student.profileImage}" alt="${profile.student.fullName}" class="avatar-img" />
                                    <div id="avatarFallback" class="w-100 h-100 d-flex flex-column align-items-center justify-content-center text-center bg-light" style="border-radius: 15px; color: #94a3b8; display: none !important;">
                                        <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
                                        <span style="font-size: 0.65rem; font-weight: 700; margin-top: 2px;">NO PHOTO</span>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div id="avatarFallback" class="w-100 h-100 d-flex flex-column align-items-center justify-content-center text-center bg-light" style="border-radius: 15px; color: #94a3b8;">
                                        <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
                                        <span style="font-size: 0.65rem; font-weight: 700; margin-top: 2px;">NO PHOTO</span>
                                    </div>
                                    <img id="avatarPreviewImg" src="" alt="Preview" class="avatar-img" style="display: none;" />
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <!-- Photo Controls -->
                        <div class="flex-grow-1 text-center text-sm-left">
                            <div class="font-weight-bold text-gray-900 mb-1" style="font-size: 0.95rem;">Placement Passport Photo</div>
                            <p class="text-muted small mb-3">
                                Recommended: Formal front-facing portrait (JPG, PNG, WebP) for placement drives.
                            </p>
                            <div class="d-flex flex-wrap align-items-center gap-2 justify-content-center justify-content-sm-start">
                                <input type="file" id="avatarFileInput" accept="image/jpeg,image/png,image/webp" style="display: none;" onchange="handleAvatarFileSelect(this);" />
                                <button type="button" class="btn-action-light" onclick="document.getElementById('avatarFileInput').click();">
                                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path><polyline points="17 8 12 3 7 8"></polyline><line x1="12" y1="3" x2="12" y2="15"></line></svg>
                                    ${not empty profile.student.profileImage ? 'Change Photo' : 'Upload Photo'}
                                </button>
                                <button type="button" id="saveAvatarBtn" class="btn-save-profile" style="display: none; padding: 0.5rem 1.15rem; font-size: 0.825rem; background: linear-gradient(135deg, #10b981, #059669); box-shadow: 0 4px 14px -2px rgba(16, 185, 129, 0.4);" onclick="saveSelectedAvatar();">
                                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="20 6 9 17 4 12"></polyline></svg>
                                    Save Photo
                                </button>
                                <c:if test="${not empty profile.student.profileImage}">
                                    <form action="${pageContext.request.contextPath}/app/student/profile" method="post" class="d-inline" onsubmit="return confirm('Are you sure you want to remove your profile photo?');">
                                        <input type="hidden" name="csrfToken" value="${sessionScope.CSRF_TOKEN}" />
                                        <input type="hidden" name="action" value="removeAvatar" />
                                        <button type="submit" class="btn btn-sm btn-outline-danger" style="border-radius: 10px; font-weight: 600; padding: 0.45rem 0.85rem; font-size: 0.825rem;">
                                            Remove
                                        </button>
                                    </form>
                                </c:if>
                            </div>
                            <div id="avatarUploadFeedback" class="small mt-2 font-weight-bold" style="display: none;"></div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Profile Details Form Card -->
            <div class="profile-card">
                <div class="profile-card-header">
                    <div>
                        <span class="font-weight-bold text-dark" style="font-size: 0.95rem;">Academic &amp; Profile Details</span>
                    </div>
                    <span class="ios-pill-badge ios-pill-blue">
                        <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 10v6M2 10l10-5 10 5-10 5z"></path></svg>
                        Dept: <c:out value="${profile.student.department}" default="IT" />
                    </span>
                </div>
                <div class="profile-card-body">
                    <form action="${pageContext.request.contextPath}/app/student/profile" method="post" class="needs-validation" novalidate id="profileDetailsForm">
                        <input type="hidden" name="csrfToken" value="${sessionScope.CSRF_TOKEN}" />
                        <input type="hidden" name="profileImage" id="hiddenProfileImageInput" value="<c:out value='${profile.student.profileImage}' />" />

                        <!-- Section 1: Personal Details -->
                        <div class="mb-4">
                            <div class="profile-section-divider">
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#6366f1" stroke-width="2.5"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
                                Candidate Identification
                            </div>
                            <div class="form-row">
                                <div class="form-group col-md-6 mb-3">
                                    <label for="fullName" class="profile-form-label">Full Name *</label>
                                    <input type="text" class="profile-input" id="fullName" name="fullName" value="<c:out value='${profile.student.fullName}' />" required placeholder="Enter full name">
                                    <div class="invalid-feedback">Full Name is required.</div>
                                </div>
                                <div class="form-group col-md-6 mb-3">
                                    <label class="profile-form-label">Email Address (Login ID)</label>
                                    <div class="input-icon-wrapper">
                                        <input type="email" class="profile-input" value="<c:out value='${profile.student.email}' />" readonly disabled>
                                        <span class="input-icon-right">
                                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect><path d="M7 11V7a5 5 0 0 1 10 0v4"></path></svg>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Section 2: Academic Background -->
                        <div class="mb-4">
                            <div class="profile-section-divider">
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#3b82f6" stroke-width="2.5"><path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"></path><path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z"></path></svg>
                                Academic Records &amp; Department
                            </div>
                            <div class="form-row">
                                <div class="form-group col-md-6 mb-3">
                                    <label for="rollNumber" class="profile-form-label">Roll / Registration Number *</label>
                                    <input type="text" class="profile-input" id="rollNumber" name="rollNumber" value="<c:out value='${profile.student.rollNumber}' />" required placeholder="e.g. 21CS042">
                                    <div class="invalid-feedback">Roll number is required.</div>
                                </div>
                                <div class="form-group col-md-6 mb-3">
                                    <label for="department" class="profile-form-label">Department &amp; Degree *</label>
                                    <select class="profile-input" id="department" name="department" required>
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
                                    <label for="graduationYear" class="profile-form-label">Graduation Year *</label>
                                    <input type="number" class="profile-input" id="graduationYear" name="graduationYear" value="<c:out value='${profile.student.graduationYear}' />" min="2000" max="2040" required placeholder="e.g. 2026">
                                    <div class="invalid-feedback">Valid graduation year is required.</div>
                                </div>
                                <div class="form-group col-md-6 mb-3">
                                    <label for="cgpa" class="profile-form-label">Current CGPA (0.00 - 10.00) *</label>
                                    <input type="number" step="0.01" class="profile-input" id="cgpa" name="cgpa" value="<c:out value='${profile.student.cgpa}' />" min="0" max="10" required placeholder="e.g. 8.75">
                                    <div class="invalid-feedback">CGPA must be between 0.00 and 10.00.</div>
                                </div>
                            </div>
                        </div>

                        <!-- Section 3: Career Focus & Target Role -->
                        <div class="mb-4">
                            <div class="profile-section-divider">
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#8b5cf6" stroke-width="2.5"><circle cx="12" cy="12" r="10"></circle><circle cx="12" cy="12" r="6"></circle><circle cx="12" cy="12" r="2"></circle></svg>
                                Career Focus &amp; Target Role
                            </div>
                            <div class="form-row">
                                <div class="form-group col-md-12 mb-2">
                                    <label for="targetRoleId" class="profile-form-label">Primary Target Career Role</label>
                                    <select class="profile-input" id="targetRoleId" name="targetRoleId">
                                        <option value="">Select Target Role...</option>
                                        <c:forEach items="${targetRoles}" var="role">
                                            <option value="${role.roleId}" ${profile.student.targetRoleId == role.roleId ? 'selected' : ''}>
                                                <c:out value="${role.roleTitle}" />
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <small class="text-muted d-block mt-1">SkillTrack dynamically recalculates your <strong>Skill Gap Matrix</strong> and <strong>Readiness Score</strong> based on this role.</small>
                        </div>

                        <!-- Section 4: Verified Coding Platforms (LeetCode & GitHub) -->
                        <div class="mb-4">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <div class="profile-section-divider mb-0 border-bottom-0 pb-0">
                                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#f59e0b" stroke-width="2.5"><polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"></polygon></svg>
                                    Verified Coding Profiles &amp; API Sync
                                </div>
                                <a href="${pageContext.request.contextPath}/app/student/dsa" class="small text-primary font-weight-bold text-decoration-none">
                                    Open DSA Tracker &rarr;
                                </a>
                            </div>

                            <div class="form-row mt-2">
                                <!-- LeetCode Input with Official Vector Icon -->
                                <div class="form-group col-md-6 mb-3">
                                    <label for="leetcodeUsername" class="profile-form-label">
                                        <span>LeetCode Username</span>
                                        <c:if test="${profile.codingProfile != null && profile.codingProfile.leetCodeSynced}">
                                            <span class="ios-pill-badge ios-pill-amber" style="font-size: 0.7rem; padding: 2px 8px;">
                                                ✓ <c:out value="${profile.codingProfile.leetcodeTotalSolved}" /> Solved
                                            </span>
                                        </c:if>
                                    </label>
                                    <div class="input-icon-wrapper">
                                        <span class="input-icon-left">
                                            <!-- Official LeetCode Vector Icon -->
                                            <svg width="18" height="18" viewBox="0 0 24 24" fill="#FFA116" xmlns="http://www.w3.org/2000/svg">
                                                <path d="M13.483 0a1.374 1.374 0 0 0-.961.438L7.116 6.226l-3.854 4.126a5.266 5.266 0 0 0-1.209 2.104 5.35 5.35 0 0 0-.125.513 5.527 5.527 0 0 0 .062 2.362 5.83 5.83 0 0 0 .349 1.017 5.938 5.938 0 0 0 1.271 1.818l4.277 4.193.039.038c2.248 2.165 5.852 2.133 8.063-.074l2.396-2.392c.54-.54.54-1.414.003-1.955a1.378 1.378 0 0 0-1.951-.003l-2.396 2.392a3.021 3.021 0 0 1-4.205.038l-.02-.019-4.276-4.193c-.652-.64-.972-1.469-.948-2.263a2.68 2.68 0 0 1 .666-1.607L9.4 7.64l4.083-4.371A1.38 1.38 0 0 0 13.483 0zm-2.88 7.218a1.38 1.38 0 0 0-.979.405l-4.54 4.54a1.38 1.38 0 0 0 0 1.952l4.54 4.54a1.38 1.38 0 0 0 1.952-1.952L7.962 13.11l3.614-3.614a1.38 1.38 0 0 0-.973-2.278z"/>
                                            </svg>
                                        </span>
                                        <input type="text" class="profile-input input-with-icon-left" id="leetcodeUsername" name="leetcodeUsername" value="<c:out value='${profile.codingProfile != null ? profile.codingProfile.leetcodeUsername : ""}' />" placeholder="e.g. maaz_code">
                                    </div>
                                    <small class="text-muted d-block mt-1">Live auto-syncs Easy, Medium, Hard problem stats.</small>
                                </div>

                                <!-- GitHub Input with Official Vector Icon -->
                                <div class="form-group col-md-6 mb-3">
                                    <label for="githubUsername" class="profile-form-label">
                                        <span>GitHub Username</span>
                                        <c:if test="${profile.codingProfile != null && profile.codingProfile.gitHubSynced}">
                                            <span class="ios-pill-badge ios-pill-blue" style="font-size: 0.7rem; padding: 2px 8px;">
                                                ✓ <c:out value="${profile.codingProfile.githubReposCount}" /> Repos
                                            </span>
                                        </c:if>
                                    </label>
                                    <div class="input-icon-wrapper">
                                        <span class="input-icon-left" style="color: #24292e;">
                                            <!-- Official GitHub Octocat Vector Icon -->
                                            <svg width="18" height="18" viewBox="0 0 24 24" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                                <path fill-rule="evenodd" clip-rule="evenodd" d="M12 2C6.477 2 2 6.484 2 12.017c0 4.425 2.865 8.18 6.839 9.504.5.092.682-.217.682-.483 0-.237-.008-.868-.013-1.703-2.782.605-3.369-1.343-3.369-1.343-.454-1.158-1.11-1.466-1.11-1.466-.908-.62.069-.608.069-.608 1.003.07 1.53 1.032 1.53 1.032.892 1.53 2.341 1.088 2.91.832.092-.647.35-1.088.636-1.338-2.22-.253-4.555-1.113-4.555-4.951 0-1.093.39-1.988 1.029-2.688-.103-.253-.446-1.272.098-2.65 0 0 .84-.27 2.75 1.026A9.564 9.564 0 0112 6.844c.85.004 1.705.115 2.504.337 1.909-1.296 2.747-1.027 2.747-1.027.546 1.379.202 2.398.1 2.651.64.7 1.028 1.595 1.028 2.688 0 3.848-2.339 4.695-4.566 4.943.359.309.678.92.678 1.855 0 1.338-.012 2.419-.012 2.747 0 .268.18.58.688.482A10.019 10.019 0 0022 12.017C22 6.484 17.522 2 12 2z"/>
                                            </svg>
                                        </span>
                                        <input type="text" class="profile-input input-with-icon-left" id="githubUsername" name="githubUsername" value="<c:out value='${profile.codingProfile != null ? profile.codingProfile.githubUsername : ""}' />" placeholder="e.g. octocat">
                                    </div>
                                    <small class="text-muted d-block mt-1">Live auto-syncs repositories and public activity.</small>
                                </div>
                            </div>
                        </div>

                        <!-- Submit Button -->
                        <div class="pt-3 border-top d-flex justify-content-start">
                            <button type="submit" class="btn-save-profile">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="20 6 9 17 4 12"></polyline></svg>
                                Save &amp; Auto-Sync Profile
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Sidebar Activity Column (Right 4 Cols) -->
        <div class="col-lg-4">
            <!-- Portfolio Activity Card -->
            <div class="profile-card">
                <div class="profile-card-header">
                    <span class="font-weight-bold text-dark" style="font-size: 0.95rem;">Portfolio Activity</span>
                    <span class="ios-pill-badge ios-pill-blue">Live Sync</span>
                </div>
                <div class="p-0">
                    <a href="${pageContext.request.contextPath}/app/student/skills" class="portfolio-nav-item">
                        <div class="d-flex align-items-center" style="gap: 0.75rem;">
                            <div class="portfolio-icon-badge" style="background: rgba(99, 102, 241, 0.1); color: #6366f1;">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="16 18 22 12 16 6"></polyline><polyline points="8 6 2 12 8 18"></polyline></svg>
                            </div>
                            <div>
                                <div class="font-weight-bold" style="font-size: 0.875rem;">Technical Skills</div>
                                <div class="text-muted small" style="font-size: 0.75rem;">Proficiency inventory</div>
                            </div>
                        </div>
                        <div class="d-flex align-items-center" style="gap: 0.5rem;">
                            <span class="ios-pill-badge ios-pill-blue">${profile.skills.size()}</span>
                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#94a3b8" stroke-width="2.5"><polyline points="9 18 15 12 9 6"></polyline></svg>
                        </div>
                    </a>

                    <a href="${pageContext.request.contextPath}/app/student/projects" class="portfolio-nav-item">
                        <div class="d-flex align-items-center" style="gap: 0.75rem;">
                            <div class="portfolio-icon-badge" style="background: rgba(139, 92, 246, 0.1); color: #8b5cf6;">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M22 19a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h5l2 3h9a2 2 0 0 1 2 2z"></path></svg>
                            </div>
                            <div>
                                <div class="font-weight-bold" style="font-size: 0.875rem;">Projects Completed</div>
                                <div class="text-muted small" style="font-size: 0.75rem;">Software repositories</div>
                            </div>
                        </div>
                        <div class="d-flex align-items-center" style="gap: 0.5rem;">
                            <span class="ios-pill-badge ios-pill-purple">${profile.projects.size()}</span>
                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#94a3b8" stroke-width="2.5"><polyline points="9 18 15 12 9 6"></polyline></svg>
                        </div>
                    </a>

                    <a href="${pageContext.request.contextPath}/app/student/certifications" class="portfolio-nav-item">
                        <div class="d-flex align-items-center" style="gap: 0.75rem;">
                            <div class="portfolio-icon-badge" style="background: rgba(16, 185, 129, 0.1); color: #10b981;">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><circle cx="12" cy="8" r="7"></circle><polyline points="8.21 13.89 7 23 12 20 17 23 15.79 13.88"></polyline></svg>
                            </div>
                            <div>
                                <div class="font-weight-bold" style="font-size: 0.875rem;">Certifications</div>
                                <div class="text-muted small" style="font-size: 0.75rem;">Industry credentials</div>
                            </div>
                        </div>
                        <div class="d-flex align-items-center" style="gap: 0.5rem;">
                            <span class="ios-pill-badge ios-pill-emerald">${profile.certifications.size()}</span>
                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#94a3b8" stroke-width="2.5"><polyline points="9 18 15 12 9 6"></polyline></svg>
                        </div>
                    </a>

                    <a href="${pageContext.request.contextPath}/app/student/dsa" class="portfolio-nav-item">
                        <div class="d-flex align-items-center" style="gap: 0.75rem;">
                            <div class="portfolio-icon-badge" style="background: rgba(245, 158, 11, 0.1); color: #f59e0b;">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"></polygon></svg>
                            </div>
                            <div>
                                <div class="font-weight-bold" style="font-size: 0.875rem;">DSA Problems Solved</div>
                                <div class="text-muted small" style="font-size: 0.75rem;">Algorithm practice</div>
                            </div>
                        </div>
                        <div class="d-flex align-items-center" style="gap: 0.5rem;">
                            <span class="ios-pill-badge ios-pill-amber">${profile.totalDsaProblemsSolved}</span>
                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#94a3b8" stroke-width="2.5"><polyline points="9 18 15 12 9 6"></polyline></svg>
                        </div>
                    </a>
                </div>
            </div>

            <!-- Profile Summary Card -->
            <div class="profile-card">
                <div class="profile-card-header">
                    <span class="font-weight-bold text-dark" style="font-size: 0.95rem;">Profile Summary</span>
                    <span class="ios-pill-badge ios-pill-emerald">Verified</span>
                </div>
                <div class="profile-card-body">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <span class="text-muted small font-weight-500">Academic CGPA</span>
                        <span class="font-weight-bold text-dark" style="font-size: 0.95rem;"><c:out value="${profile.student.cgpa}" default="0.00" /> / 10.0</span>
                    </div>
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <span class="text-muted small font-weight-500">Graduation Class</span>
                        <span class="font-weight-bold text-dark" style="font-size: 0.95rem;"><c:out value="${profile.student.graduationYear}" default="2026" /></span>
                    </div>
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <span class="text-muted small font-weight-500">LeetCode Sync</span>
                        <span class="ios-pill-badge ${profile.codingProfile != null && profile.codingProfile.leetCodeSynced ? 'ios-pill-emerald' : 'ios-pill-amber'}">
                            ${profile.codingProfile != null && profile.codingProfile.leetCodeSynced ? 'Connected' : 'Pending'}
                        </span>
                    </div>
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <span class="text-muted small font-weight-500">GitHub Sync</span>
                        <span class="ios-pill-badge ${profile.codingProfile != null && profile.codingProfile.gitHubSynced ? 'ios-pill-emerald' : 'ios-pill-amber'}">
                            ${profile.codingProfile != null && profile.codingProfile.gitHubSynced ? 'Connected' : 'Pending'}
                        </span>
                    </div>
                    <div class="pt-2 border-top mt-3 text-center">
                        <a href="${pageContext.request.contextPath}/app/student/readiness-card" class="btn-action-light w-100 justify-content-center">
                            <span>Open Placement Passport</span>
                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="9 18 15 12 9 6"></polyline></svg>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    let pendingAvatarDataUrl = null;

    function handleAvatarFileSelect(input) {
        if (!input.files || !input.files[0]) return;
        const file = input.files[0];

        // Validate image file type
        if (!file.type.match(/image\/(jpeg|png|webp|jpg)/i)) {
            alert('Please select a valid image file (JPEG, PNG, or WebP).');
            return;
        }

        const reader = new FileReader();
        reader.onload = function(e) {
            const img = new Image();
            img.onload = function() {
                // Compress & square-crop to 400x400
                const canvas = document.createElement('canvas');
                const MAX_SIZE = 400;
                let width = img.width;
                let height = img.height;

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

                pendingAvatarDataUrl = canvas.toDataURL('image/jpeg', 0.88);

                // Update Preview UI
                const previewImg = document.getElementById('avatarPreviewImg');
                const fallback = document.getElementById('avatarFallback');
                if (fallback) fallback.style.setProperty('display', 'none', 'important');
                previewImg.src = pendingAvatarDataUrl;
                previewImg.style.display = 'block';

                // Update hidden input in form
                const hiddenInput = document.getElementById('hiddenProfileImageInput');
                if (hiddenInput) hiddenInput.value = pendingAvatarDataUrl;

                // Show save button
                const saveBtn = document.getElementById('saveAvatarBtn');
                if (saveBtn) saveBtn.style.display = 'inline-flex';

                const feedback = document.getElementById('avatarUploadFeedback');
                if (feedback) {
                    feedback.style.display = 'block';
                    feedback.className = 'small mt-2 font-weight-bold text-primary';
                    feedback.innerHTML = 'Photo selected. Click "Save Photo" or submit the form below.';
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
                }, 600);
            } else {
                throw new Error(data.message || 'Failed to update photo');
            }
        })
        .catch(err => {
            if (saveBtn) {
                saveBtn.disabled = false;
                saveBtn.innerHTML = '<svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="20 6 9 17 4 12"></polyline></svg> Save Photo';
            }
            if (feedback) {
                feedback.className = 'small mt-2 font-weight-bold text-danger';
                feedback.innerHTML = 'Error: ' + err.message;
            }
        });
    }
</script>

<%@ include file="/WEB-INF/views/common/footer.jspf" %>
