<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="pageTitle" value="Dream Job Matcher" />
<c:set var="activeNav" value="dream-job" />
<%@ include file="/WEB-INF/views/common/header.jspf" %>
<%@ include file="/WEB-INF/views/common/navbar.jspf" %>

<style>
    /* Premium Apple Glassmorphism Styles for Dream Job Matcher */
    .company-preset-card {
        border-radius: var(--ios-radius-md, 16px);
        background: #ffffff;
        border: 1.5px solid rgba(0, 0, 0, 0.08);
        transition: all 0.25s cubic-bezier(0.16, 1, 0.3, 1);
        cursor: pointer;
        position: relative;
        overflow: hidden;
    }
    .company-preset-card:hover {
        transform: translateY(-3px);
        box-shadow: 0 12px 28px -6px rgba(0, 0, 0, 0.09), 0 8px 12px -6px rgba(0, 0, 0, 0.04);
        border-color: rgba(0, 113, 227, 0.35);
    }
    .company-preset-card.active-preset {
        background: linear-gradient(180deg, rgba(0, 113, 227, 0.04) 0%, rgba(255, 255, 255, 1) 100%);
        border: 2px solid #0071e3 !important;
        box-shadow: 0 8px 22px rgba(0, 113, 227, 0.16) !important;
    }
    .company-logo-badge {
        width: 44px;
        height: 44px;
        border-radius: 12px;
        background: #ffffff;
        border: 1px solid rgba(0, 0, 0, 0.08);
        box-shadow: 0 2px 6px rgba(0, 0, 0, 0.04);
        display: flex;
        align-items: center;
        justify-content: center;
        flex-shrink: 0;
    }
    .sample-chip {
        font-size: 0.75rem;
        font-weight: 600;
        padding: 0.35rem 0.8rem;
        border-radius: 20px;
        border: 1px solid rgba(0, 0, 0, 0.1);
        background: #f8f9fa;
        color: #495057;
        transition: all 0.2s ease;
        cursor: pointer;
        display: inline-flex;
        align-items: center;
        gap: 0.3rem;
    }
    .sample-chip:hover {
        background: #e9ecef;
        color: #212529;
        transform: translateY(-1px);
    }
    .sample-chip.chip-sde:hover { background: rgba(0, 113, 227, 0.1); color: #0071e3; border-color: rgba(0, 113, 227, 0.3); }
    .sample-chip.chip-ai:hover { background: rgba(139, 92, 246, 0.1); color: #7c3aed; border-color: rgba(139, 92, 246, 0.3); }
    .sample-chip.chip-mern:hover { background: rgba(16, 185, 129, 0.1); color: #059669; border-color: rgba(16, 185, 129, 0.3); }
    
    .pillar-stat-card {
        border-radius: var(--ios-radius-md, 14px);
        background: #ffffff;
        border: 1px solid rgba(0, 0, 0, 0.06);
        padding: 1.15rem;
        height: 100%;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        box-shadow: 0 1px 3px rgba(0,0,0,0.03);
    }
    .pillar-icon-box {
        width: 32px;
        height: 32px;
        border-radius: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        flex-shrink: 0;
    }
    
    /* Studio Competency Dual Split Cards */
    .competency-box-matched {
        background: #fbfdfb;
        border: 1.5px solid rgba(52, 199, 89, 0.3);
        border-radius: var(--ios-radius-md, 14px);
        padding: 1.15rem;
        height: 100%;
        box-shadow: 0 2px 8px rgba(52, 199, 89, 0.04);
    }
    .competency-box-missing {
        background: #fdfbfb;
        border: 1.5px solid rgba(239, 68, 68, 0.25);
        border-radius: var(--ios-radius-md, 14px);
        padding: 1.15rem;
        height: 100%;
        box-shadow: 0 2px 8px rgba(239, 68, 68, 0.04);
    }
    .skill-card-matched {
        background: #ffffff;
        border: 1px solid rgba(52, 199, 89, 0.25);
        border-radius: 10px;
        padding: 0.5rem 0.8rem;
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.02);
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 0.5rem;
        transition: transform 0.15s ease;
    }
    .skill-card-missing {
        background: #ffffff;
        border: 1px solid rgba(239, 68, 68, 0.22);
        border-radius: 10px;
        padding: 0.5rem 0.8rem;
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.02);
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 0.5rem;
        transition: transform 0.15s ease;
    }
</style>

<div class="container-fluid">
    <div class="row">
        <%@ include file="/WEB-INF/views/common/sidebar.jspf" %>

        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4 py-4">
            <%@ include file="/WEB-INF/views/common/alerts.jspf" %>

            <!-- Page Hero Header -->
            <div class="ios-dash-header mb-4">
                <div>
                    <div class="d-flex align-items-center gap-2 mb-1.5 flex-wrap">
                        <span class="ios-badge ios-badge-purple">
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" class="mr-1"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"></polygon></svg>
                            Market Intelligence
                        </span>
                        <span class="ios-badge ios-badge-blue">
                            Zero-Hardcoded 5-Pillar Matching
                        </span>
                    </div>
                    <h1 class="h3 font-weight-bold text-gray-800 mb-1" style="letter-spacing: -0.03em;">
                        Company-Specific Dream Job Matcher
                    </h1>
                    <p class="text-muted small mb-0" style="max-width: 720px; line-height: 1.5;">
                        Dynamically match your real LeetCode solve counts, verified GitHub projects, credentials, and technical proficiencies against top tier companies or any custom job posting.
                    </p>
                </div>
                <div class="d-flex align-items-center flex-wrap gap-2 mt-3 mt-lg-0">
                    <a href="${pageContext.request.contextPath}/app/student/ats-scanner" class="ios-btn-secondary d-inline-flex align-items-center" style="padding: 0.55rem 1.1rem; font-size: 0.85rem;">
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="mr-1.5"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                        ATS Resume Scanner
                    </a>
                    <a href="${pageContext.request.contextPath}/app/student/placement-criteria" class="ios-btn-primary d-inline-flex align-items-center" style="padding: 0.55rem 1.1rem; font-size: 0.85rem;">
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="mr-1.5"><rect x="2" y="7" width="20" height="14" rx="2" ry="2"></rect><path d="M16 21V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v16"></path></svg>
                        Campus Cutoffs
                    </a>
                </div>
            </div>

            <!-- SECTION 1: Dynamic Company Presets & Campus Drives Grid -->
            <div class="mb-4">
                <div class="d-flex align-items-center justify-content-between mb-2.5">
                    <h2 class="h6 font-weight-bold text-muted text-uppercase mb-0" style="letter-spacing: 0.05em; font-size: 0.78rem;">
                        Target Placement Drives &amp; Company Presets
                    </h2>
                    <small class="text-muted font-weight-500">Click any company to calculate real-time readiness</small>
                </div>

                <div class="row g-3">
                    <c:forEach items="${companyPresets}" var="c">
                        <c:url var="cardToggleUrl" value="/app/student/dream-job">
                            <c:if test="${matchResult.criteriaId != c.criteriaId}">
                                <c:param name="criteriaId" value="${c.criteriaId}" />
                            </c:if>
                        </c:url>
                        <div class="col-xl-4 col-md-6 col-12 mb-3">
                            <a href="${cardToggleUrl}" class="text-decoration-none text-dark" title="${matchResult.criteriaId == c.criteriaId ? 'Click to deselect' : 'Click to select'}">
                                <div class="company-preset-card p-3 h-100 ${matchResult.criteriaId == c.criteriaId ? 'active-preset' : ''}">
                                    <div class="d-flex align-items-center justify-content-between mb-2.5">
                                        <div class="d-flex align-items-center" style="gap: 0.75rem;">
                                            <!-- Official High-Resolution Vector Company Logos -->
                                            <div class="company-logo-badge">
                                                <c:choose>
                                                    <c:when test="${fn:containsIgnoreCase(c.companyName, 'Google')}">
                                                        <svg width="24" height="24" viewBox="0 0 24 24">
                                                            <path fill="#4285F4" d="M23.745 12.27c0-.7-.06-1.4-.19-2.07H12v4.51h6.6c-.29 1.52-1.14 2.82-2.4 3.68v3.05h3.88c2.27-2.09 3.665-5.17 3.665-9.17z"/>
                                                            <path fill="#34A853" d="M12 24c3.24 0 5.95-1.08 7.93-2.91l-3.88-3.05c-1.08.72-2.45 1.16-4.05 1.16-3.12 0-5.77-2.1-6.72-4.93H1.25v3.15C3.26 21.36 7.33 24 12 24z"/>
                                                            <path fill="#FBBC05" d="M5.28 14.27c-.25-.72-.38-1.49-.38-2.27s.13-1.55.38-2.27V6.58H1.25C.45 8.18 0 10.04 0 12s.45 3.82 1.25 5.42l4.03-3.15z"/>
                                                            <path fill="#EA4335" d="M12 4.75c1.77 0 3.35.61 4.6 1.8l3.42-3.42C17.95 1.19 15.24 0 12 0 7.33 0 3.26 2.64 1.25 6.58l4.03 3.15c.95-2.83 3.6-4.98 6.72-4.98z"/>
                                                        </svg>
                                                    </c:when>
                                                    <c:when test="${fn:containsIgnoreCase(c.companyName, 'Amazon')}">
                                                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
                                                            <path d="M13.9 14.8c-2.4 1.8-5.9 2.7-8.9 2.7-4.2 0-8-1.5-10.9-4-.2-.2 0-.5.3-.3 3.2 1.8 7.1 2.9 11.1 2.9 2.7 0 5.7-.6 8.5-1.9.4-.2.7.2.4.6z" fill="#FF9900"/>
                                                            <path d="M15.1 13.5c-.3-.4-2-.2-2.7-.1-.2 0-.3-.2-.1-.3 1.2-.9 3.2-.6 3.5-.2.3.4-.1 2.4-1.2 3.4-.2.1-.3 0-.2-.2.4-.7.9-2.2.7-2.6z" fill="#FF9900"/>
                                                            <path d="M12.8 4.2c-2.9 0-4.9 1.6-4.9 3.9 0 2.4 1.6 3.4 3.7 3.4 1.6 0 2.8-.7 3.4-1.8v1.5c0 .2.1.3.3.3h1.8c.2 0 .3-.1.3-.3V6.8c0-1.8-1.4-2.6-4.6-2.6zm.5 5c-.6.7-1.4 1.1-2.2 1.1-1.1 0-1.8-.6-1.8-1.7 0-1.3.8-2 2.3-2 .7 0 1.3.1 1.7.3v2.3z" fill="#232F3E"/>
                                                        </svg>
                                                    </c:when>
                                                    <c:when test="${fn:containsIgnoreCase(c.companyName, 'Microsoft')}">
                                                        <svg width="22" height="22" viewBox="0 0 23 23">
                                                            <path fill="#f25022" d="M1 1h10v10H1z"/>
                                                            <path fill="#00a4ef" d="M1 12h10v10H1z"/>
                                                            <path fill="#7fba00" d="M12 1h10v10H12z"/>
                                                            <path fill="#ffb900" d="M12 12h10v10H12z"/>
                                                        </svg>
                                                    </c:when>
                                                    <c:when test="${fn:containsIgnoreCase(c.companyName, 'Deloitte')}">
                                                        <svg width="26" height="26" viewBox="0 0 24 24" fill="none">
                                                            <rect x="2" y="2" width="20" height="20" rx="6" fill="#111827"/>
                                                            <text x="5.5" y="16.5" fill="#ffffff" font-family="Arial, sans-serif" font-weight="900" font-size="14">D</text>
                                                            <circle cx="17" cy="15.5" r="2.2" fill="#86BC25"/>
                                                        </svg>
                                                    </c:when>
                                                    <c:when test="${fn:containsIgnoreCase(c.companyName, 'Swiggy')}">
                                                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
                                                            <path d="M12 2C7.58 2 4 5.58 4 10c0 5.25 7.13 11.45 7.43 11.71.34.29.8.29 1.14 0C12.87 21.45 20 15.25 20 10c0-4.42-3.58-8-8-8zm0 16.55C9.77 16.2 6 12.44 6 10c0-3.31 2.69-6 6-6s6 2.69 6 6c0 2.44-3.77 6.2-6 8.55z" fill="#FC8019"/>
                                                            <path d="M12 7c-1.66 0-3 1.34-3 3 0 .7.24 1.34.64 1.85L12 14.5l2.36-2.65c.4-.51.64-1.15.64-1.85 0-1.66-1.34-3-3-3z" fill="#FC8019"/>
                                                        </svg>
                                                    </c:when>
                                                    <c:when test="${fn:containsIgnoreCase(c.companyName, 'TCS')}">
                                                        <svg width="26" height="26" viewBox="0 0 24 24" fill="none">
                                                            <rect x="2" y="2" width="20" height="20" rx="6" fill="#004B87"/>
                                                            <text x="3.5" y="16" fill="#ffffff" font-family="Arial, sans-serif" font-weight="900" font-size="9.5" letter-spacing="0.5">TCS</text>
                                                        </svg>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#0071e3" stroke-width="2.2"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"></polygon></svg>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>

                                            <div>
                                                <h3 class="font-weight-bold text-dark mb-0" style="font-size: 0.98rem; line-height: 1.2;">
                                                    <c:out value="${c.companyName}" />
                                                </h3>
                                                <span class="text-muted d-block mt-0.5" style="font-size: 0.78rem; line-height: 1.25;">
                                                    <c:out value="${c.roleTitle}" />
                                                </span>
                                            </div>
                                        </div>

                                        <c:if test="${matchResult.criteriaId == c.criteriaId}">
                                            <span class="badge badge-primary px-2 py-1 font-weight-semibold" style="font-size: 0.7rem; border-radius: 10px; background: #0071e3; box-shadow: 0 2px 6px rgba(0, 113, 227, 0.3);">&check; Active</span>
                                        </c:if>
                                    </div>

                                    <!-- Technical Cutoffs Pill Row -->
                                    <div class="d-flex align-items-center justify-content-between pt-2.5 border-top mt-2" style="font-size: 0.78rem; color: #6e6e73;">
                                        <span class="d-inline-flex align-items-center">
                                            <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="#0071e3" stroke-width="2.2" class="mr-1.5"><polyline points="22 12 18 12 15 21 9 3 6 12 2 12"></polyline></svg>
                                            DSA: <strong class="ml-1 text-dark">${c.minDsaProblems}+</strong>
                                        </span>
                                        <span class="d-inline-flex align-items-center">
                                            <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="#8b5cf6" stroke-width="2.2" class="mr-1.5"><polyline points="16 18 22 12 16 6"></polyline><polyline points="8 6 2 12 8 18"></polyline></svg>
                                            Projects: <strong class="ml-1 text-dark">${c.minProjects}+</strong>
                                        </span>
                                        <span class="d-inline-flex align-items-center">
                                            <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="#10b981" stroke-width="2.2" class="mr-1.5"><path d="M22 10v6M2 10l10-5 10 5-10 5z"></path><path d="M6 12v5c3 3 9 3 12 0v-5"></path></svg>
                                            CGPA: <strong class="ml-1 text-dark">${c.minCgpa}</strong>
                                        </span>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <!-- SECTION 2: Dynamic Custom JD Scanner Form & Live Match Results -->
            <div class="row">
                <!-- Left: Paste Any Custom Job Description / URL Form -->
                <div class="col-lg-5 mb-4">
                    <div class="ios-card h-100 shadow-sm">
                        <div class="ios-card-header p-3.5 border-bottom bg-white">
                            <div class="d-flex align-items-center justify-content-between">
                                <div>
                                    <h2 class="h6 font-weight-bold text-dark mb-0" style="font-size: 1.05rem; letter-spacing: -0.02em;">
                                        Paste Any Job Description
                                    </h2>
                                    <small class="text-muted">Zero-hardcoded dynamic evaluation against any real JD</small>
                                </div>
                                <span class="ios-badge ios-badge-green" style="font-size: 0.7rem;">100% Dynamic</span>
                            </div>
                        </div>

                        <div class="ios-card-body p-3.5">
                            <form action="${pageContext.request.contextPath}/app/student/dream-job" method="post" id="customJdForm">
                                <input type="hidden" name="csrfToken" value="${sessionScope.CSRF_TOKEN}" />
                                <input type="hidden" name="action" value="evaluate-custom-jd" />

                                <div class="row">
                                    <div class="col-sm-6 form-group mb-3">
                                        <label class="ios-form-label font-weight-semibold" style="font-size: 0.82rem;">Target Company</label>
                                        <input type="text" class="ios-form-control" name="targetCompany" id="targetCompany" placeholder="e.g. Google, Uber, Swiggy" value="${matchResult.targetCompany != 'Target Company' ? matchResult.targetCompany : ''}" required style="font-size: 0.88rem;" />
                                    </div>
                                    <div class="col-sm-6 form-group mb-3">
                                        <label class="ios-form-label font-weight-semibold" style="font-size: 0.82rem;">Target Role</label>
                                        <input type="text" class="ios-form-control" name="targetRole" id="targetRole" placeholder="e.g. Software Engineer / SDE-1" value="${matchResult.targetRole != 'Software Engineer' ? matchResult.targetRole : ''}" required style="font-size: 0.88rem;" />
                                    </div>
                                </div>

                                <div class="form-group mb-3">
                                    <label class="ios-form-label font-weight-semibold" style="font-size: 0.82rem;">Job Listing Web URL (Optional)</label>
                                    <div class="position-relative">
                                        <svg class="position-absolute text-muted" style="left: 12px; top: 12px; z-index: 5;" width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M10 13a5 5 0 0 0 7.54.54l3-3a5 5 0 0 0-7.07-7.07l-1.72 1.71"></path><path d="M14 11a5 5 0 0 0-7.54-.54l-3 3a5 5 0 0 0 7.07 7.07l1.71-1.71"></path></svg>
                                        <input type="url" class="ios-form-control" name="sourceUrl" id="sourceUrl" placeholder="https://careers.google.com/jobs/results/..." value="${matchResult.sourceUrl}" style="padding-left: 36px; font-size: 0.85rem;" />
                                    </div>
                                    <small class="text-muted d-block mt-1" style="font-size: 0.74rem;">SkillTrack will automatically fetch and extract requirements live from the URL.</small>
                                </div>

                                <div class="form-group mb-3">
                                    <label class="ios-form-label font-weight-semibold mb-1" style="font-size: 0.82rem;">Job Description (JD) Text</label>
                                    <textarea class="ios-form-control" name="rawJdText" id="rawJdText" rows="9" placeholder="Paste the job description, required skills, DSA expectations, responsibilities, or minimum qualification text here..." style="font-size: 0.85rem; line-height: 1.55;"><c:out value="${matchResult.rawJdText}" /></textarea>
                                </div>

                                <div class="pt-1 d-flex align-items-center" style="gap: 0.75rem;">
                                    <button type="submit" class="ios-btn-primary flex-grow-1 d-flex align-items-center justify-content-center shadow-sm" style="padding: 0.75rem 1.5rem; font-size: 0.95rem; font-weight: 700; background: linear-gradient(135deg, #0071e3, #5856d6);">
                                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" class="mr-2"><circle cx="12" cy="12" r="10"></circle><polygon points="10 8 16 12 10 16 10 8"></polygon></svg>
                                        Scan &amp; Compute Live Match
                                    </button>
                                    <button type="button" class="btn btn-light border font-weight-semibold text-muted d-flex align-items-center justify-content-center" id="clearJdBtn" style="padding: 0.75rem 1.25rem; border-radius: var(--ios-radius-sm, 12px); font-size: 0.88rem; transition: all 0.2s ease;" title="Clear Form Fields">
                                        <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="mr-1.5"><polyline points="3 6 5 6 21 6"></polyline><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path></svg>
                                        Clear
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Right: Dynamic Multi-Pillar Match Results Dashboard -->
                <div class="col-lg-7 mb-4">
                    <c:choose>
                        <c:when test="${not empty matchResult}">
                            <!-- Overall Score Gauge Card -->
                            <c:set var="gaugeColor" value="${matchResult.overallScore >= 80 ? '#34c759' : (matchResult.overallScore >= 55 ? '#ff9500' : '#ff3b30')}" />
                            <c:set var="statusBadgeClass" value="${matchResult.statusBadge == 'READY' ? 'ios-badge-green' : (matchResult.statusBadge == 'NEAR_READY' ? 'ios-badge-orange' : 'ios-badge-red')}" />
                            <div class="ios-card mb-4 shadow-sm" style="border-left: 4.5px solid ${gaugeColor};">
                                <div class="ios-card-body p-4">
                                    <div class="d-flex flex-column flex-sm-row align-items-sm-center justify-content-between gap-3">
                                        <div>
                                            <div class="d-flex align-items-center gap-2 mb-1.5 flex-wrap">
                                                <span class="ios-badge ${statusBadgeClass} font-weight-bold">
                                                    <c:out value="${matchResult.statusTitle}" />
                                                </span>
                                                <span class="badge badge-light border text-muted px-2 py-1" style="font-size: 0.72rem; border-radius: 8px;">
                                                    <c:out value="${matchResult.sourceType}" />
                                                </span>
                                            </div>
                                            <h2 class="h4 font-weight-bold text-dark mb-1" style="letter-spacing: -0.02em;">
                                                <c:out value="${matchResult.targetCompany}" /> &bull; <c:out value="${matchResult.targetRole}" />
                                            </h2>
                                            <p class="text-muted small mb-0 mt-1" style="max-width: 460px; line-height: 1.45;">
                                                <c:out value="${matchResult.statusDescription}" />
                                            </p>
                                        </div>

                                        <!-- Circular Apple-style Animated Gauge -->
                                        <div class="text-center flex-shrink-0 mt-3 mt-sm-0">
                                            <div style="position: relative; width: 104px; height: 104px; margin: 0 auto;">
                                                <svg width="104" height="104" viewBox="0 0 100 100">
                                                    <circle cx="50" cy="50" r="42" stroke="rgba(0,0,0,0.06)" stroke-width="9" fill="none" />
                                                    <circle cx="50" cy="50" r="42"
                                                            stroke="${gaugeColor}"
                                                            stroke-width="9" fill="none"
                                                            stroke-dasharray="264"
                                                            stroke-dashoffset="${264 - (264 * matchResult.overallScore / 100)}"
                                                            stroke-linecap="round"
                                                            transform="rotate(-90 50 50)"
                                                            style="transition: stroke-dashoffset 1s ease;" />
                                                </svg>
                                                <div style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; display: flex; flex-direction: column; align-items: center; justify-content: center;">
                                                    <span style="font-size: 1.55rem; font-weight: 800; color: #1c1c1e; line-height: 1;"><c:out value="${matchResult.overallScore}" />%</span>
                                                    <span style="font-size: 0.65rem; color: #8e8e93; font-weight: 700; letter-spacing: 0.05em; text-transform: uppercase; margin-top: 2px;">Match</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- 5 Pillars Breakdown Cards -->
                            <div class="row g-3 mb-4">
                                <!-- Pillar 1: DSA Mastery -->
                                <div class="col-sm-6 mb-3">
                                    <div class="pillar-stat-card">
                                        <div>
                                            <div class="d-flex justify-content-between align-items-center mb-2">
                                                <div class="d-flex align-items-center">
                                                    <div class="pillar-icon-box mr-2" style="background: rgba(0, 113, 227, 0.1); color: #0071e3;">
                                                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><polyline points="22 12 18 12 15 21 9 3 6 12 2 12"></polyline></svg>
                                                    </div>
                                                    <span class="font-weight-bold text-dark" style="font-size: 0.88rem;">DSA Mastery</span>
                                                </div>
                                                <span class="font-weight-bold ${matchResult.dsaScore >= 75 ? 'text-success' : 'text-primary'}" style="font-size: 1rem;">
                                                    <c:out value="${matchResult.dsaScore}" />%
                                                </span>
                                            </div>
                                            <div class="progress mb-2" style="height: 7px; border-radius: 5px; background: rgba(0,0,0,0.06);">
                                                <div class="progress-bar ${matchResult.dsaScore >= 80 ? 'bg-success' : matchResult.dsaScore >= 50 ? 'bg-warning' : 'bg-danger'}" role="progressbar" style="width: ${matchResult.dsaScore}%;"></div>
                                            </div>
                                        </div>
                                        <div>
                                            <small class="text-dark d-block font-weight-600 mb-0.5" style="font-size: 0.8rem;"><c:out value="${matchResult.studentDsaSummary}" /></small>
                                            <small class="text-muted d-block" style="font-size: 0.73rem; line-height: 1.3;"><c:out value="${matchResult.dsaBenchmarkDescription}" /></small>
                                        </div>
                                    </div>
                                </div>

                                <!-- Pillar 2: Systems & Projects -->
                                <div class="col-sm-6 mb-3">
                                    <div class="pillar-stat-card">
                                        <div>
                                            <div class="d-flex justify-content-between align-items-center mb-2">
                                                <div class="d-flex align-items-center">
                                                    <div class="pillar-icon-box mr-2" style="background: rgba(139, 92, 246, 0.1); color: #8b5cf6;">
                                                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><polyline points="16 18 22 12 16 6"></polyline><polyline points="8 6 2 12 8 18"></polyline></svg>
                                                    </div>
                                                    <span class="font-weight-bold text-dark" style="font-size: 0.88rem;">System Projects</span>
                                                </div>
                                                <span class="font-weight-bold ${matchResult.projectScore >= 75 ? 'text-success' : 'text-info'}" style="font-size: 1rem;">
                                                    <c:out value="${matchResult.projectScore}" />%
                                                </span>
                                            </div>
                                            <div class="progress mb-2" style="height: 7px; border-radius: 5px; background: rgba(0,0,0,0.06);">
                                                <div class="progress-bar ${matchResult.projectScore >= 80 ? 'bg-success' : matchResult.projectScore >= 50 ? 'bg-warning' : 'bg-danger'}" role="progressbar" style="width: ${matchResult.projectScore}%;"></div>
                                            </div>
                                        </div>
                                        <div>
                                            <small class="text-dark d-block font-weight-600 mb-0.5" style="font-size: 0.8rem;"><c:out value="${matchResult.studentProjectSummary}" /></small>
                                            <small class="text-muted d-block" style="font-size: 0.73rem; line-height: 1.3;"><c:out value="${matchResult.projectBenchmarkDescription}" /></small>
                                        </div>
                                    </div>
                                </div>

                                <!-- Pillar 3: Verified Industry Certifications -->
                                <div class="col-sm-6 mb-3">
                                    <div class="pillar-stat-card">
                                        <div>
                                            <div class="d-flex justify-content-between align-items-center mb-2">
                                                <div class="d-flex align-items-center">
                                                    <div class="pillar-icon-box mr-2" style="background: rgba(245, 158, 11, 0.1); color: #d97706;">
                                                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><circle cx="12" cy="8" r="7"></circle><polyline points="8.21 13.89 7 23 12 20 17 23 15.79 13.88"></polyline></svg>
                                                    </div>
                                                    <span class="font-weight-bold text-dark" style="font-size: 0.88rem;">Certifications</span>
                                                </div>
                                                <span class="font-weight-bold ${matchResult.certScore >= 75 ? 'text-success' : 'text-warning'}" style="font-size: 1rem;">
                                                    <c:out value="${matchResult.certScore}" />%
                                                </span>
                                            </div>
                                            <div class="progress mb-2" style="height: 7px; border-radius: 5px; background: rgba(0,0,0,0.06);">
                                                <div class="progress-bar ${matchResult.certScore >= 80 ? 'bg-success' : matchResult.certScore >= 50 ? 'bg-warning' : 'bg-danger'}" role="progressbar" style="width: ${matchResult.certScore}%;"></div>
                                            </div>
                                        </div>
                                        <div>
                                            <small class="text-dark d-block font-weight-600 mb-0.5" style="font-size: 0.8rem;"><c:out value="${matchResult.studentCertSummary}" /></small>
                                            <small class="text-muted d-block" style="font-size: 0.73rem; line-height: 1.3;"><c:out value="${matchResult.certBenchmarkDescription}" /></small>
                                        </div>
                                    </div>
                                </div>

                                <!-- Pillar 4: Tech Stack Match -->
                                <div class="col-sm-6 mb-3">
                                    <div class="pillar-stat-card">
                                        <div>
                                            <div class="d-flex justify-content-between align-items-center mb-2">
                                                <div class="d-flex align-items-center">
                                                    <div class="pillar-icon-box mr-2" style="background: rgba(16, 185, 129, 0.1); color: #059669;">
                                                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"></polygon></svg>
                                                    </div>
                                                    <span class="font-weight-bold text-dark" style="font-size: 0.88rem;">Tech Skill Depth</span>
                                                </div>
                                                <span class="font-weight-bold ${matchResult.skillScore >= 75 ? 'text-success' : 'text-primary'}" style="font-size: 1rem;">
                                                    <c:out value="${matchResult.skillScore}" />%
                                                </span>
                                            </div>
                                            <div class="progress mb-2" style="height: 7px; border-radius: 5px; background: rgba(0,0,0,0.06);">
                                                <div class="progress-bar ${matchResult.skillScore >= 80 ? 'bg-success' : matchResult.skillScore >= 50 ? 'bg-warning' : 'bg-danger'}" role="progressbar" style="width: ${matchResult.skillScore}%;"></div>
                                            </div>
                                        </div>
                                        <div>
                                            <small class="text-dark d-block font-weight-600 mb-0.5" style="font-size: 0.8rem;">${fn:length(matchResult.matchedSkills)} of ${fn:length(matchResult.requiredSkills)} Required Skills Matched</small>
                                            <small class="text-muted d-block" style="font-size: 0.73rem; line-height: 1.3;"><c:out value="${matchResult.studentAcademicSummary}" /></small>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- SECTION: High-End Dual Split Technical Competency Alignment Matrix -->
                            <div class="ios-card mb-4 shadow-sm p-4">
                                <div class="d-flex align-items-center justify-content-between pb-3 mb-4 border-bottom flex-wrap gap-2">
                                    <div>
                                        <h3 class="h6 font-weight-bold text-dark mb-1 d-flex align-items-center" style="font-size: 1.05rem;">
                                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#0071e3" stroke-width="2.2" class="mr-2"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg>
                                            Technical Competency Alignment
                                        </h3>
                                        <small class="text-muted">Direct comparison between candidate profile proficiencies and job requirements</small>
                                    </div>
                                    <div class="d-flex align-items-center" style="gap: 0.5rem;">
                                        <span class="badge font-weight-bold px-2.5 py-1 text-success d-inline-flex align-items-center" style="background: rgba(52, 199, 89, 0.12); border-radius: 12px; font-size: 0.78rem; gap: 0.35rem;">
                                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3"><polyline points="20 6 9 17 4 12"></polyline></svg>
                                            ${fn:length(matchResult.matchedSkills)} Matched
                                        </span>
                                        <span class="badge font-weight-bold px-2.5 py-1 text-danger d-inline-flex align-items-center" style="background: rgba(239, 68, 68, 0.1); border-radius: 12px; font-size: 0.78rem; gap: 0.35rem;">
                                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3"><circle cx="12" cy="12" r="10"></circle><line x1="15" y1="9" x2="9" y2="15"></line><line x1="9" y1="9" x2="15" y2="15"></line></svg>
                                            ${fn:length(matchResult.missingSkills)} Gaps
                                        </span>
                                    </div>
                                </div>

                                <div class="row g-3">
                                    <!-- Left Column: Matched Competencies -->
                                    <div class="col-md-6 mb-3">
                                        <div class="competency-box-matched">
                                            <div class="d-flex align-items-center justify-content-between mb-3 pb-2 border-bottom" style="border-color: rgba(52, 199, 89, 0.25) !important;">
                                                <div class="d-flex align-items-center" style="gap: 0.5rem;">
                                                    <span class="d-inline-flex align-items-center justify-content-center rounded-circle" style="width: 22px; height: 22px; background: rgba(52, 199, 89, 0.15); color: #34c759; flex-shrink: 0;">
                                                        <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3"><polyline points="20 6 9 17 4 12"></polyline></svg>
                                                    </span>
                                                    <span class="font-weight-bold text-success" style="font-size: 0.88rem; letter-spacing: -0.01em;">
                                                        Matched Competencies (${fn:length(matchResult.matchedSkills)})
                                                    </span>
                                                </div>
                                                <span class="badge badge-light border text-muted font-weight-semibold px-2 py-0.5" style="font-size: 0.7rem; border-radius: 8px;">Verified</span>
                                            </div>

                                            <div class="d-flex flex-column" style="gap: 0.5rem;">
                                                <c:forEach items="${matchResult.matchedSkills}" var="s">
                                                    <div class="skill-card-matched">
                                                        <div class="d-flex align-items-center" style="gap: 0.55rem;">
                                                            <span class="rounded-circle d-inline-flex align-items-center justify-content-center text-white flex-shrink-0" style="width: 19px; height: 19px; background: #34c759;">
                                                                <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3.5"><polyline points="20 6 9 17 4 12"></polyline></svg>
                                                            </span>
                                                            <span class="font-weight-semibold text-dark" style="font-size: 0.85rem;">
                                                                <c:out value="${s}" />
                                                            </span>
                                                        </div>
                                                        <span class="badge font-weight-semibold py-1 px-2" style="font-size: 0.68rem; border-radius: 8px; background: rgba(52, 199, 89, 0.12); color: #248a3d;">Ready</span>
                                                    </div>
                                                </c:forEach>
                                                <c:if test="${empty matchResult.matchedSkills}">
                                                    <div class="text-center py-4 text-muted small">
                                                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#8e8e93" stroke-width="1.5" class="mb-1"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="8" x2="12" y2="12"></line><line x1="12" y1="16" x2="12.01" y2="16"></line></svg>
                                                        <div class="font-weight-500">No verified skills matched yet.</div>
                                                    </div>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Right Column: Missing Required Skills -->
                                    <div class="col-md-6 mb-3">
                                        <div class="competency-box-missing">
                                            <div class="d-flex align-items-center justify-content-between mb-3 pb-2 border-bottom" style="border-color: rgba(239, 68, 68, 0.25) !important;">
                                                <div class="d-flex align-items-center" style="gap: 0.5rem;">
                                                    <span class="d-inline-flex align-items-center justify-content-center rounded-circle" style="width: 22px; height: 22px; background: rgba(239, 68, 68, 0.15); color: #ef4444; flex-shrink: 0;">
                                                        <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><circle cx="12" cy="12" r="10"></circle><line x1="15" y1="9" x2="9" y2="15"></line><line x1="9" y1="9" x2="15" y2="15"></line></svg>
                                                    </span>
                                                    <span class="font-weight-bold text-danger" style="font-size: 0.88rem; letter-spacing: -0.01em;">
                                                        Missing Required Skills (${fn:length(matchResult.missingSkills)})
                                                    </span>
                                                </div>
                                                <span class="badge badge-light border text-danger font-weight-semibold px-2 py-0.5" style="font-size: 0.7rem; border-radius: 8px;">Action Needed</span>
                                            </div>

                                            <div class="d-flex flex-column" style="gap: 0.5rem;">
                                                <c:forEach items="${matchResult.missingSkills}" var="ms">
                                                    <div class="skill-card-missing">
                                                        <div class="d-flex align-items-center" style="gap: 0.55rem;">
                                                            <span class="rounded-circle d-inline-flex align-items-center justify-content-center text-white flex-shrink-0" style="width: 19px; height: 19px; background: #ef4444;">
                                                                <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3"><line x1="12" y1="5" x2="12" y2="19"></line><line x1="5" y1="12" x2="19" y2="12"></line></svg>
                                                            </span>
                                                            <span class="font-weight-semibold text-dark" style="font-size: 0.85rem;">
                                                                <c:out value="${ms}" />
                                                            </span>
                                                        </div>
                                                        <span class="badge font-weight-semibold py-1 px-2" style="font-size: 0.68rem; border-radius: 8px; background: rgba(239, 68, 68, 0.1); color: #dc2626;">Target Gap</span>
                                                    </div>
                                                </c:forEach>
                                                <c:if test="${empty matchResult.missingSkills}">
                                                    <div class="text-center py-4 text-success small font-weight-bold">
                                                        &check; Zero skill gaps! You match all requirements.
                                                    </div>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Personalized Dynamic Gap Roadmap -->
                            <div class="ios-card mb-4 shadow-sm">
                                <div class="ios-card-header p-3.5 d-flex justify-content-between align-items-center border-bottom bg-white">
                                    <div>
                                        <h3 class="h6 font-weight-bold text-dark mb-0" style="font-size: 1rem;">
                                            Personalized Gap-Bridging Action Roadmap
                                        </h3>
                                        <small class="text-muted">Exact milestones required to reach 100% readiness for this role</small>
                                    </div>
                                    <span class="ios-badge ios-badge-blue font-weight-bold" style="font-size: 0.72rem;">${fn:length(matchResult.roadmapItems)} Actions</span>
                                </div>

                                <div class="list-group list-group-flush">
                                    <c:forEach items="${matchResult.roadmapItems}" var="item" varStatus="loop">
                                        <div class="list-group-item p-3.5 d-flex flex-column flex-sm-row justify-content-between align-items-sm-center gap-3">
                                            <div class="d-flex align-items-start mr-sm-3">
                                                <div class="rounded-circle d-flex align-items-center justify-content-center font-weight-bold mr-3 flex-shrink-0 mt-0.5 shadow-sm" style="width: 32px; height: 32px; background: rgba(0, 113, 227, 0.1); color: #0071e3; font-size: 0.85rem;">
                                                    ${loop.count}
                                                </div>
                                                <div>
                                                    <div class="d-flex align-items-center gap-2 mb-1 flex-wrap">
                                                        <span class="font-weight-bold text-dark" style="font-size: 0.92rem;"><c:out value="${item.title}" /></span>
                                                        <span class="badge badge-primary-soft text-primary font-weight-bold px-2 py-0.5" style="background: rgba(0,113,227,0.1); border-radius: 12px; font-size: 0.7rem;">+${item.impactWeight}% Score</span>
                                                        <span class="badge ${item.priority == 'HIGH' ? 'badge-danger' : 'badge-secondary'} px-2 py-0.5" style="border-radius: 12px; font-size: 0.68rem;"><c:out value="${item.priority}" /></span>
                                                    </div>
                                                    <p class="text-muted small mb-0" style="line-height: 1.45;"><c:out value="${item.description}" /></p>
                                                </div>
                                            </div>

                                            <div class="d-flex align-items-center gap-2 flex-shrink-0 mt-2 mt-sm-0">
                                                <button type="button" class="btn btn-sm btn-outline-primary add-task-btn font-weight-semibold d-inline-flex align-items-center"
                                                        data-title="${item.title}"
                                                        data-desc="${item.description}"
                                                        style="border-radius: 20px; font-size: 0.78rem; padding: 0.4rem 0.95rem;">
                                                    <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" class="mr-1.5"><line x1="12" y1="5" x2="12" y2="19"></line><line x1="5" y1="12" x2="19" y2="12"></line></svg>
                                                    Add to Checklist
                                                </button>
                                                <a href="${pageContext.request.contextPath}${item.actionLink}" class="btn btn-sm btn-light border font-weight-semibold" style="border-radius: 20px; font-size: 0.78rem; padding: 0.4rem 0.95rem;">
                                                    Take Action &rarr;
                                                </a>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="ios-card p-5 text-center shadow-sm" style="background: #ffffff; border-radius: var(--ios-radius-md, 16px); min-height: 480px; display: flex; flex-direction: column; align-items: center; justify-content: center;">
                                <div class="mb-3.5 d-inline-flex align-items-center justify-content-center rounded-circle" style="width: 72px; height: 72px; background: rgba(0, 113, 227, 0.08); color: #0071e3;">
                                    <svg width="34" height="34" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><polygon points="10 8 16 12 10 16 10 8"></polygon></svg>
                                </div>
                                <h3 class="h5 font-weight-bold text-dark mb-1.5" style="letter-spacing: -0.02em;">Ready for Job Matching</h3>
                                <p class="text-muted small mx-auto mb-4" style="max-width: 440px; line-height: 1.55;">
                                    Click on any top company preset above or enter a custom Job Description on the left to calculate your live readiness match.
                                </p>
                                <div class="d-flex align-items-center gap-2 flex-wrap justify-content-center">
                                    <span class="badge badge-light border text-muted px-3 py-1.5 font-weight-semibold" style="border-radius: 12px; font-size: 0.78rem;">
                                        &bull; 5-Pillar Dynamic Matching
                                    </span>
                                    <span class="badge badge-light border text-muted px-3 py-1.5 font-weight-semibold" style="border-radius: 12px; font-size: 0.78rem;">
                                        &bull; Live LeetCode &amp; GitHub Sync
                                    </span>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

        </main>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // Clear Job Details button handler with user confirmation
    var clearBtn = document.getElementById('clearJdBtn');
    if (clearBtn) {
        clearBtn.addEventListener('click', function(e) {
            e.preventDefault();
            if (confirm('Are you sure you want to clear all entered job fields and description?')) {
                document.getElementById('targetCompany').value = '';
                document.getElementById('targetRole').value = '';
                document.getElementById('rawJdText').value = '';
                var urlInput = document.getElementById('sourceUrl');
                if (urlInput) urlInput.value = '';
            }
        });
    }

    // Interactive "Add to Preparation Checklist" AJAX handler
    var addTaskButtons = document.querySelectorAll('.add-task-btn');
    addTaskButtons.forEach(function(btn) {
        btn.addEventListener('click', function(e) {
            e.preventDefault();
            var title = this.getAttribute('data-title');
            var desc = this.getAttribute('data-desc');
            var buttonEl = this;

            var formData = new URLSearchParams();
            formData.append('csrfToken', '${sessionScope.CSRF_TOKEN}');
            formData.append('action', 'add-roadmap-task');
            formData.append('taskTitle', title);
            formData.append('taskDescription', desc);
            formData.append('isAjax', 'true');

            buttonEl.disabled = true;
            buttonEl.innerHTML = '<span class="spinner-border spinner-border-sm mr-1"></span> Adding...';

            fetch('${pageContext.request.contextPath}/app/student/dream-job', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
                },
                body: formData.toString()
            })
            .then(function(res) { return res.json(); })
            .then(function(data) {
                if (data.status === 'success') {
                    buttonEl.className = 'btn btn-sm btn-success font-weight-semibold d-inline-flex align-items-center';
                    buttonEl.innerHTML = '&check; Added to Checklist';
                } else {
                    buttonEl.disabled = false;
                    buttonEl.innerHTML = 'Retry Add';
                }
            })
            .catch(function(err) {
                buttonEl.disabled = false;
                buttonEl.innerHTML = 'Retry Add';
            });
        });
    });
});
</script>

<%@ include file="/WEB-INF/views/common/footer.jspf" %>
