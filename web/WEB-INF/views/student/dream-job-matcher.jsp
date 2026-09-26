<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="pageTitle" value="Dream Job Matcher" />
<c:set var="activeNav" value="dream-job" />
<%@ include file="/WEB-INF/views/common/header.jspf" %>
<%@ include file="/WEB-INF/views/common/navbar.jspf" %>

<style>
    /* Premium iOS Glassmorphic Styles for Dream Job Matcher */
    .company-preset-card {
        border-radius: var(--ios-radius-md, 16px);
        background: #ffffff;
        border: 1px solid rgba(0, 0, 0, 0.07);
        transition: all 0.25s cubic-bezier(0.16, 1, 0.3, 1);
        cursor: pointer;
        position: relative;
        overflow: hidden;
    }
    .company-preset-card:hover {
        transform: translateY(-3px);
        box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.08), 0 8px 10px -6px rgba(0, 0, 0, 0.04);
        border-color: rgba(0, 113, 227, 0.3);
    }
    .company-preset-card.active-preset {
        background: linear-gradient(180deg, rgba(0, 113, 227, 0.04) 0%, rgba(255, 255, 255, 1) 100%);
        border: 2px solid #0071e3 !important;
        box-shadow: 0 8px 20px rgba(0, 113, 227, 0.15) !important;
    }
    .sample-chip {
        font-size: 0.75rem;
        font-weight: 600;
        padding: 0.3rem 0.75rem;
        border-radius: 20px;
        border: 1px solid rgba(0, 0, 0, 0.1);
        background: #f8f9fa;
        color: #495057;
        transition: all 0.2s ease;
        cursor: pointer;
        display: inline-flex;
        align-items: center;
        gap: 0.25rem;
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
    .skill-pill-matched {
        background: rgba(52, 199, 89, 0.1);
        color: #248a3d;
        border: 1px solid rgba(52, 199, 89, 0.25);
        border-radius: 20px;
        padding: 0.35rem 0.85rem;
        font-size: 0.8rem;
        font-weight: 600;
        display: inline-flex;
        align-items: center;
        gap: 0.35rem;
    }
    .skill-pill-missing {
        background: rgba(239, 68, 68, 0.08);
        color: #dc2626;
        border: 1px solid rgba(239, 68, 68, 0.25);
        border-radius: 20px;
        padding: 0.35rem 0.85rem;
        font-size: 0.8rem;
        font-weight: 600;
        display: inline-flex;
        align-items: center;
        gap: 0.35rem;
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
                        Dynamically match your real LeetCode stats, verified GitHub repositories, certifications, and technical proficiencies against top tier companies or any custom job posting.
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
                        <div class="col-xl-4 col-md-6 col-12 mb-3">
                            <a href="${pageContext.request.contextPath}/app/student/dream-job?criteriaId=${c.criteriaId}" class="text-decoration-none text-dark">
                                <div class="company-preset-card p-3 h-100 ${matchResult.criteriaId == c.criteriaId ? 'active-preset' : ''}">
                                    <div class="d-flex align-items-center justify-content-between mb-2.5">
                                        <div class="d-flex align-items-center">
                                            <!-- Dynamic Brand Colored Avatar -->
                                            <div class="rounded-circle d-flex align-items-center justify-content-center font-weight-bold mr-2.5 text-white shadow-sm"
                                                 style="width: 38px; height: 38px; font-size: 0.95rem; 
                                                 background: <c:choose>
                                                     <c:when test="${fn:containsIgnoreCase(c.companyName, 'Google')}">linear-gradient(135deg, #4285F4, #34A853)</c:when>
                                                     <c:when test="${fn:containsIgnoreCase(c.companyName, 'Amazon')}">linear-gradient(135deg, #FF9900, #232F3E)</c:when>
                                                     <c:when test="${fn:containsIgnoreCase(c.companyName, 'Microsoft')}">linear-gradient(135deg, #00A4EF, #7FBA00)</c:when>
                                                     <c:when test="${fn:containsIgnoreCase(c.companyName, 'Deloitte')}">linear-gradient(135deg, #86BC25, #111827)</c:when>
                                                     <c:when test="${fn:containsIgnoreCase(c.companyName, 'Swiggy')}">linear-gradient(135deg, #FC8019, #E23744)</c:when>
                                                     <c:when test="${fn:containsIgnoreCase(c.companyName, 'TCS')}">linear-gradient(135deg, #004B87, #00A3E0)</c:when>
                                                     <c:otherwise>linear-gradient(135deg, #0071e3, #5856d6)</c:otherwise>
                                                 </c:choose>;">
                                                <c:choose>
                                                    <c:when test="${not empty c.companyName}"><c:out value="${fn:substring(c.companyName, 0, 1)}" /></c:when>
                                                    <c:otherwise>C</c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div>
                                                <h3 class="font-weight-bold text-dark mb-0" style="font-size: 0.95rem; line-height: 1.2;">
                                                    <c:out value="${c.companyName}" />
                                                </h3>
                                                <span class="text-muted d-block" style="font-size: 0.78rem; line-height: 1.3;">
                                                    <c:out value="${c.roleTitle}" />
                                                </span>
                                            </div>
                                        </div>
                                        <c:if test="${matchResult.criteriaId == c.criteriaId}">
                                            <span class="badge badge-primary px-2 py-1" style="font-size: 0.68rem; border-radius: 10px;">&check; Active</span>
                                        </c:if>
                                    </div>

                                    <!-- Technical Cutoffs Pill Row -->
                                    <div class="d-flex align-items-center justify-content-between pt-2 border-top mt-2" style="font-size: 0.76rem; color: #6e6e73;">
                                        <span class="d-inline-flex align-items-center">
                                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="#0071e3" stroke-width="2.2" class="mr-1"><polyline points="22 12 18 12 15 21 9 3 6 12 2 12"></polyline></svg>
                                            DSA: <strong class="ml-0.5 text-dark">${c.minDsaProblems}+</strong>
                                        </span>
                                        <span class="d-inline-flex align-items-center">
                                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="#8b5cf6" stroke-width="2.2" class="mr-1"><polyline points="16 18 22 12 16 6"></polyline><polyline points="8 6 2 12 8 18"></polyline></svg>
                                            Projects: <strong class="ml-0.5 text-dark">${c.minProjects}+</strong>
                                        </span>
                                        <span class="d-inline-flex align-items-center">
                                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="#10b981" stroke-width="2.2" class="mr-1"><path d="M22 10v6M2 10l10-5 10 5-10 5z"></path><path d="M6 12v5c3 3 9 3 12 0v-5"></path></svg>
                                            CGPA: <strong class="ml-0.5 text-dark">${c.minCgpa}</strong>
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
                                    <div class="d-flex justify-content-between align-items-center mb-1.5 flex-wrap">
                                        <label class="ios-form-label font-weight-semibold mb-0" style="font-size: 0.82rem;">Job Description (JD) Text</label>
                                        <div class="d-flex align-items-center flex-wrap" style="gap: 0.35rem;">
                                            <button type="button" class="sample-chip chip-sde" id="sampleSdeBtn">&plus; SDE</button>
                                            <button type="button" class="sample-chip chip-ai" id="sampleAiBtn">&plus; AI/ML</button>
                                            <button type="button" class="sample-chip chip-mern" id="sampleFullstackBtn">&plus; MERN</button>
                                            <button type="button" class="sample-chip" id="clearJdBtn">&times; Clear</button>
                                        </div>
                                    </div>
                                    <textarea class="ios-form-control" name="rawJdText" id="rawJdText" rows="9" placeholder="Paste the job description, required skills, DSA expectations, responsibilities, or minimum qualification text here..." style="font-size: 0.85rem; line-height: 1.55;"><c:out value="${matchResult.rawJdText}" /></textarea>
                                </div>

                                <div class="pt-1">
                                    <button type="submit" class="ios-btn-primary w-100 d-flex align-items-center justify-content-center shadow-sm" style="padding: 0.75rem 1.5rem; font-size: 0.95rem; font-weight: 700; background: linear-gradient(135deg, #0071e3, #5856d6);">
                                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" class="mr-2"><circle cx="12" cy="12" r="10"></circle><polygon points="10 8 16 12 10 16 10 8"></polygon></svg>
                                        Scan &amp; Compute Live Match
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

                            <!-- Skills Matched vs Missing Matrix -->
                            <div class="ios-card mb-4 p-3.5 shadow-sm">
                                <h3 class="h6 font-weight-bold text-dark mb-3 d-flex align-items-center" style="font-size: 0.95rem;">
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="mr-2 text-primary"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg>
                                    Technical Competency Alignment
                                </h3>

                                <div class="mb-3">
                                    <div class="small font-weight-bold text-success mb-2 d-flex align-items-center">
                                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" class="mr-1.5"><polyline points="20 6 9 17 4 12"></polyline></svg>
                                        Matched Competencies (${fn:length(matchResult.matchedSkills)})
                                    </div>
                                    <div class="d-flex flex-wrap" style="gap: 0.5rem;">
                                        <c:forEach items="${matchResult.matchedSkills}" var="s">
                                            <span class="skill-pill-matched">
                                                &check; <c:out value="${s}" />
                                            </span>
                                        </c:forEach>
                                        <c:if test="${empty matchResult.matchedSkills}">
                                            <span class="text-muted small font-italic py-1">No verified skills matched yet for this target role.</span>
                                        </c:if>
                                    </div>
                                </div>

                                <c:if test="${not empty matchResult.missingSkills}">
                                    <div class="pt-2 border-top mt-3">
                                        <div class="small font-weight-bold text-danger mb-2 d-flex align-items-center">
                                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" class="mr-1.5"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg>
                                            Missing Required Skills (${fn:length(matchResult.missingSkills)})
                                        </div>
                                        <div class="d-flex flex-wrap" style="gap: 0.5rem;">
                                            <c:forEach items="${matchResult.missingSkills}" var="ms">
                                                <span class="skill-pill-missing">
                                                    &plus; <c:out value="${ms}" />
                                                </span>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </c:if>
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
                            <div class="ios-card p-5 text-center shadow-sm">
                                <div class="text-muted mb-3">
                                    <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"></polygon></svg>
                                </div>
                                <h3 class="h5 font-weight-bold text-dark">No Job Selected Yet</h3>
                                <p class="text-muted small">Select any company preset above or paste a custom Job Description to run real-time multi-pillar matching.</p>
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
    // Sample JD Auto-loaders
    var sdeBtn = document.getElementById('sampleSdeBtn');
    if (sdeBtn) {
        sdeBtn.addEventListener('click', function() {
            document.getElementById('targetCompany').value = 'Google';
            document.getElementById('targetRole').value = 'Software Development Engineer (SDE-1)';
            document.getElementById('rawJdText').value = 
                "Role: Software Development Engineer (SDE-1)\n" +
                "Minimum Qualifications:\n" +
                "- Bachelor's degree with minimum 7.5 CGPA.\n" +
                "- Strong in Data Structures and Algorithms (Dynamic Programming, Trees, Graphs, System Scalability).\n" +
                "- Proficiency in Java, C++, or Go.\n" +
                "- Experience with cloud backends and distributed systems.";
        });
    }

    var aiBtn = document.getElementById('sampleAiBtn');
    if (aiBtn) {
        aiBtn.addEventListener('click', function() {
            document.getElementById('targetCompany').value = 'OpenAI';
            document.getElementById('targetRole').value = 'Machine Learning Engineer';
            document.getElementById('rawJdText').value = 
                "Role: Machine Learning Engineer\n" +
                "Requirements:\n" +
                "- Strong fundamentals in Python, Machine Learning, Deep Learning, and Math.\n" +
                "- Hands-on experience with PyTorch or TensorFlow, Pandas, and NumPy.\n" +
                "- Experience developing API endpoints (FastAPI / Flask) and Docker.";
        });
    }

    var fullstackBtn = document.getElementById('sampleFullstackBtn');
    if (fullstackBtn) {
        fullstackBtn.addEventListener('click', function() {
            document.getElementById('targetCompany').value = 'Swiggy';
            document.getElementById('targetRole').value = 'MERN Stack Developer';
            document.getElementById('rawJdText').value = 
                "Role: MERN Full-Stack Developer\n" +
                "Requirements:\n" +
                "- Proficiency in React.js, Node.js, Express.js, and MongoDB.\n" +
                "- Solid experience building RESTful APIs, Git version control, and clean state management.\n" +
                "- Familiarity with responsive UI using Tailwind CSS.";
        });
    }

    var clearBtn = document.getElementById('clearJdBtn');
    if (clearBtn) {
        clearBtn.addEventListener('click', function() {
            document.getElementById('targetCompany').value = '';
            document.getElementById('targetRole').value = '';
            document.getElementById('rawJdText').value = '';
            if (document.getElementById('sourceUrl')) document.getElementById('sourceUrl').value = '';
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
