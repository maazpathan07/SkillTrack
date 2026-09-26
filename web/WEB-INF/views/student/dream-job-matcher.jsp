<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="pageTitle" value="Dream Job Matcher" />
<c:set var="activeNav" value="dream-job" />
<%@ include file="/WEB-INF/views/common/header.jspf" %>
<%@ include file="/WEB-INF/views/common/navbar.jspf" %>

<div class="container-fluid">
    <div class="row">
        <%@ include file="/WEB-INF/views/common/sidebar.jspf" %>

        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4 py-4">
            <%@ include file="/WEB-INF/views/common/alerts.jspf" %>

            <!-- Page Hero Header -->
            <div class="ios-dash-header mb-4">
                <div>
                    <div class="d-flex align-items-center gap-2 mb-1 flex-wrap">
                        <span class="ios-badge ios-badge-purple">
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" class="mr-1"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"></polygon></svg>
                            Live Job Market Intelligence
                        </span>
                        <span class="ios-badge ios-badge-blue">
                            Zero-Hardcoded Multi-Pillar Matcher
                        </span>
                    </div>
                    <h1 class="h3 font-weight-bold text-gray-800 mb-0" style="letter-spacing: -0.03em;">
                        Company-Specific Dream Job Matcher
                    </h1>
                    <p class="text-muted small mb-0 mt-1">
                        Evaluate your real LeetCode solve metrics, verified GitHub projects, and credentials dynamically against top tier companies or paste ANY live job description.
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

            <!-- SECTION 1: Dynamic Company Presets & Campus Drives Carousel/Grid -->
            <div class="mb-4">
                <div class="d-flex align-items-center justify-content-between mb-2">
                    <h2 class="h6 font-weight-bold text-muted text-uppercase mb-0" style="letter-spacing: 0.05em; font-size: 0.78rem;">
                        Target Company Profiles &amp; Campus Drives
                    </h2>
                    <small class="text-muted">Click any preset to calculate live match</small>
                </div>

                <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-xl-4 g-3">
                    <c:forEach items="${companyPresets}" var="c">
                        <div class="col mb-3">
                            <a href="${pageContext.request.contextPath}/app/student/dream-job?criteriaId=${c.criteriaId}" class="text-decoration-none">
                                <div class="ios-card h-100 p-3 transition-all hover-lift ${matchResult.criteriaId == c.criteriaId ? 'border-primary shadow-sm' : ''}" style="cursor: pointer; ${matchResult.criteriaId == c.criteriaId ? 'background: rgba(0, 113, 227, 0.04); border: 1.5px solid var(--ios-blue);' : ''}">
                                    <div class="d-flex align-items-center justify-content-between mb-2">
                                        <div class="d-flex align-items-center">
                                            <div class="rounded-circle d-flex align-items-center justify-content-center font-weight-bold mr-2.5 text-white" style="width: 34px; height: 34px; background: linear-gradient(135deg, #0071e3, #5856d6); font-size: 0.85rem;">
                                                <c:choose>
                                                    <c:when test="${not empty c.companyName}">
                                                        <c:out value="${fn:substring(c.companyName, 0, 1)}" />
                                                    </c:when>
                                                    <c:otherwise>C</c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div>
                                                <h3 class="font-weight-bold text-dark mb-0" style="font-size: 0.95rem; line-height: 1.2;"><c:out value="${c.companyName}" /></h3>
                                                <small class="text-muted d-block text-truncate" style="max-width: 140px;"><c:out value="${c.roleTitle}" /></small>
                                            </div>
                                        </div>
                                        <c:if test="${matchResult.criteriaId == c.criteriaId}">
                                            <span class="badge badge-pill badge-primary px-2 py-1" style="font-size: 0.7rem;">Active</span>
                                        </c:if>
                                    </div>
                                    <div class="d-flex align-items-center justify-content-between small text-muted pt-2 border-top mt-2">
                                        <span><svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="mr-1"><polyline points="22 12 18 12 15 21 9 3 6 12 2 12"></polyline></svg>DSA: ${c.minDsaProblems}+</span>
                                        <span><svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="mr-1"><polyline points="16 18 22 12 16 6"></polyline><polyline points="8 6 2 12 8 18"></polyline></svg>Proj: ${c.minProjects}+</span>
                                        <span><svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="mr-1"><circle cx="12" cy="8" r="7"></circle></svg>CGPA: ${c.minCgpa}</span>
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
                    <div class="ios-card h-100">
                        <div class="ios-card-header" style="padding: 1.25rem 1.5rem;">
                            <div class="d-flex align-items-center justify-content-between">
                                <div>
                                    <h2 class="h5 font-weight-bold text-dark mb-0" style="font-size: 1.1rem; letter-spacing: -0.02em;">
                                        Paste Any Job Description
                                    </h2>
                                    <small class="text-muted">Zero-hardcoded dynamic evaluation against any real JD</small>
                                </div>
                                <span class="ios-badge ios-badge-green" style="font-size: 0.7rem;">100% Dynamic</span>
                            </div>
                        </div>

                        <div class="ios-card-body" style="padding: 1.5rem;">
                            <form action="${pageContext.request.contextPath}/app/student/dream-job" method="post" id="customJdForm">
                                <input type="hidden" name="csrfToken" value="${sessionScope.CSRF_TOKEN}" />
                                <input type="hidden" name="action" value="evaluate-custom-jd" />

                                <div class="row">
                                    <div class="col-sm-6 form-group mb-3">
                                        <label class="ios-form-label font-weight-semibold">Target Company</label>
                                        <input type="text" class="ios-form-control" name="targetCompany" id="targetCompany" placeholder="e.g. Google, Uber, Swiggy, Startup" value="${matchResult.targetCompany != 'Target Company' ? matchResult.targetCompany : ''}" required />
                                    </div>
                                    <div class="col-sm-6 form-group mb-3">
                                        <label class="ios-form-label font-weight-semibold">Target Role</label>
                                        <input type="text" class="ios-form-control" name="targetRole" id="targetRole" placeholder="e.g. Software Engineer / SDE-1" value="${matchResult.targetRole != 'Software Engineer' ? matchResult.targetRole : ''}" required />
                                    </div>
                                </div>

                                <div class="form-group mb-3">
                                    <label class="ios-form-label font-weight-semibold">Job Listing Web URL (Optional)</label>
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text bg-light border-right-0" style="border-radius: var(--ios-radius-sm) 0 0 var(--ios-radius-sm);"><svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M10 13a5 5 0 0 0 7.54.54l3-3a5 5 0 0 0-7.07-7.07l-1.72 1.71"></path><path d="M14 11a5 5 0 0 0-7.54-.54l-3 3a5 5 0 0 0 7.07 7.07l1.71-1.71"></path></svg></span>
                                        </div>
                                        <input type="url" class="ios-form-control border-left-0" name="sourceUrl" id="sourceUrl" placeholder="https://careers.google.com/jobs/results/..." value="${matchResult.sourceUrl}" style="border-radius: 0 var(--ios-radius-sm) var(--ios-radius-sm) 0;" />
                                    </div>
                                    <small class="text-muted">SkillTrack will automatically fetch and extract requirements live from the URL.</small>
                                </div>

                                <div class="form-group mb-3">
                                    <div class="d-flex justify-content-between align-items-center mb-1">
                                        <label class="ios-form-label font-weight-semibold mb-0">Job Description (JD) Text</label>
                                        <button type="button" class="btn btn-sm btn-link p-0 text-primary font-weight-bold" id="sampleJdBtn" style="font-size: 0.8rem;">
                                            &circlearrowright; Load Sample JD
                                        </button>
                                    </div>
                                    <textarea class="ios-form-control" name="rawJdText" id="rawJdText" rows="9" placeholder="Paste the job description, required skills, DSA expectations, responsibilities, or minimum qualification text here..." style="font-size: 0.85rem; line-height: 1.5;"><c:out value="${matchResult.rawJdText}" /></textarea>
                                </div>

                                <div class="pt-2">
                                    <button type="submit" class="ios-btn-primary w-100 d-flex align-items-center justify-content-center" style="padding: 0.75rem 1.5rem; font-size: 0.95rem; font-weight: 700; box-shadow: 0 4px 14px rgba(0, 113, 227, 0.3);">
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
                            <div class="ios-card mb-4" style="border-left: 4px solid <c:choose><c:when test='${matchResult.overallScore >= 80}'>#34c759</c:when><c:when test='${matchResult.overallScore >= 55}'>#ff9500</c:when><c:otherwise>#ff3b30</c:otherwise></c:choose>;">
                                <div class="ios-card-body p-4">
                                    <div class="d-flex flex-column flex-sm-row align-items-sm-center justify-content-between gap-3">
                                        <div>
                                            <div class="d-flex align-items-center gap-2 mb-1.5 flex-wrap">
                                                <span class="ios-badge <c:choose><c:when test='${matchResult.statusBadge == \"READY\" || matchResult.statusBadge == \"READY\"}'>ios-badge-green</c:when><c:when test='${matchResult.statusBadge == \"NEAR_READY\"}'>ios-badge-orange</c:when><c:otherwise>ios-badge-red</c:otherwise></c:choose> font-weight-bold">
                                                    <c:out value="${matchResult.statusTitle}" />
                                                </span>
                                                <span class="badge badge-light border text-muted px-2 py-1" style="font-size: 0.72rem;">
                                                    <c:out value="${matchResult.sourceType}" />
                                                </span>
                                            </div>
                                            <h2 class="h4 font-weight-bold text-dark mb-1" style="letter-spacing: -0.02em;">
                                                <c:out value="${matchResult.targetCompany}" /> &bull; <c:out value="${matchResult.targetRole}" />
                                            </h2>
                                            <p class="text-muted small mb-0 mt-1" style="max-width: 480px;">
                                                <c:out value="${matchResult.statusDescription}" />
                                            </p>
                                        </div>

                                        <!-- Circular Apple-style Animated Gauge -->
                                        <div class="text-center flex-shrink-0 mt-3 mt-sm-0">
                                            <div style="position: relative; width: 100px; height: 100px; margin: 0 auto;">
                                                <svg width="100" height="100" viewBox="0 0 100 100">
                                                    <circle cx="50" cy="50" r="42" stroke="rgba(0,0,0,0.06)" stroke-width="9" fill="none" />
                                                    <circle cx="50" cy="50" r="42"
                                                            stroke="<c:choose><c:when test='${matchResult.overallScore >= 80}'>#34c759</c:when><c:when test='${matchResult.overallScore >= 55}'>#ff9500</c:when><c:otherwise>#ff3b30</c:otherwise></c:choose>"
                                                            stroke-width="9" fill="none"
                                                            stroke-dasharray="264"
                                                            stroke-dashoffset="${264 - (264 * matchResult.overallScore / 100)}"
                                                            stroke-linecap="round"
                                                            transform="rotate(-90 50 50)"
                                                            style="transition: stroke-dashoffset 1s ease;" />
                                                </svg>
                                                <div style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; display: flex; flex-direction: column; align-items: center; justify-content: center;">
                                                    <span style="font-size: 1.45rem; font-weight: 800; color: var(--ios-text-primary); line-height: 1;"><c:out value="${matchResult.overallScore}" />%</span>
                                                    <span style="font-size: 0.65rem; color: #8e8e93; font-weight: 600; text-transform: uppercase;">Match</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- 5 Pillars Breakdown Cards -->
                            <div class="row row-cols-1 row-cols-sm-2 g-3 mb-4">
                                <!-- Pillar 1: DSA Mastery -->
                                <div class="col mb-3">
                                    <div class="ios-card p-3 h-100">
                                        <div class="d-flex justify-content-between align-items-center mb-1.5">
                                            <div class="d-flex align-items-center font-weight-bold text-dark" style="font-size: 0.88rem;">
                                                <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" class="mr-1.5 text-primary"><polyline points="22 12 18 12 15 21 9 3 6 12 2 12"></polyline></svg>
                                                DSA &amp; Problem Solving
                                            </div>
                                            <span class="font-weight-bold ${matchResult.dsaScore >= 75 ? 'text-success' : 'text-primary'}" style="font-size: 0.95rem;">
                                                <c:out value="${matchResult.dsaScore}" />%
                                            </span>
                                        </div>
                                        <div class="progress mb-2" style="height: 6px; border-radius: 4px; background: rgba(0,0,0,0.05);">
                                            <div class="progress-bar ${matchResult.dsaScore >= 80 ? 'bg-success' : matchResult.dsaScore >= 50 ? 'bg-warning' : 'bg-danger'}" role="progressbar" style="width: ${matchResult.dsaScore}%;"></div>
                                        </div>
                                        <small class="text-muted d-block font-weight-500 mb-0.5"><c:out value="${matchResult.studentDsaSummary}" /></small>
                                        <small class="text-secondary font-italic" style="font-size: 0.75rem;"><c:out value="${matchResult.dsaBenchmarkDescription}" /></small>
                                    </div>
                                </div>

                                <!-- Pillar 2: Systems & Projects -->
                                <div class="col mb-3">
                                    <div class="ios-card p-3 h-100">
                                        <div class="d-flex justify-content-between align-items-center mb-1.5">
                                            <div class="d-flex align-items-center font-weight-bold text-dark" style="font-size: 0.88rem;">
                                                <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" class="mr-1.5 text-info"><polyline points="16 18 22 12 16 6"></polyline><polyline points="8 6 2 12 8 18"></polyline></svg>
                                                System Projects &amp; GitHub
                                            </div>
                                            <span class="font-weight-bold ${matchResult.projectScore >= 75 ? 'text-success' : 'text-info'}" style="font-size: 0.95rem;">
                                                <c:out value="${matchResult.projectScore}" />%
                                            </span>
                                        </div>
                                        <div class="progress mb-2" style="height: 6px; border-radius: 4px; background: rgba(0,0,0,0.05);">
                                            <div class="progress-bar ${matchResult.projectScore >= 80 ? 'bg-success' : matchResult.projectScore >= 50 ? 'bg-warning' : 'bg-danger'}" role="progressbar" style="width: ${matchResult.projectScore}%;"></div>
                                        </div>
                                        <small class="text-muted d-block font-weight-500 mb-0.5"><c:out value="${matchResult.studentProjectSummary}" /></small>
                                        <small class="text-secondary font-italic" style="font-size: 0.75rem;"><c:out value="${matchResult.projectBenchmarkDescription}" /></small>
                                    </div>
                                </div>

                                <!-- Pillar 3: Verified Industry Certifications -->
                                <div class="col mb-3">
                                    <div class="ios-card p-3 h-100">
                                        <div class="d-flex justify-content-between align-items-center mb-1.5">
                                            <div class="d-flex align-items-center font-weight-bold text-dark" style="font-size: 0.88rem;">
                                                <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" class="mr-1.5 text-warning"><circle cx="12" cy="8" r="7"></circle><polyline points="8.21 13.89 7 23 12 20 17 23 15.79 13.88"></polyline></svg>
                                                Verified Certifications
                                            </div>
                                            <span class="font-weight-bold ${matchResult.certScore >= 75 ? 'text-success' : 'text-warning'}" style="font-size: 0.95rem;">
                                                <c:out value="${matchResult.certScore}" />%
                                            </span>
                                        </div>
                                        <div class="progress mb-2" style="height: 6px; border-radius: 4px; background: rgba(0,0,0,0.05);">
                                            <div class="progress-bar ${matchResult.certScore >= 80 ? 'bg-success' : matchResult.certScore >= 50 ? 'bg-warning' : 'bg-danger'}" role="progressbar" style="width: ${matchResult.certScore}%;"></div>
                                        </div>
                                        <small class="text-muted d-block font-weight-500 mb-0.5"><c:out value="${matchResult.studentCertSummary}" /></small>
                                        <small class="text-secondary font-italic" style="font-size: 0.75rem;"><c:out value="${matchResult.certBenchmarkDescription}" /></small>
                                    </div>
                                </div>

                                <!-- Pillar 4: Tech Stack Match -->
                                <div class="col mb-3">
                                    <div class="ios-card p-3 h-100">
                                        <div class="d-flex justify-content-between align-items-center mb-1.5">
                                            <div class="d-flex align-items-center font-weight-bold text-dark" style="font-size: 0.88rem;">
                                                <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" class="mr-1.5 text-purple" style="color: #8b5cf6;"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"></polygon></svg>
                                                Tech Stack &amp; Skill Depth
                                            </div>
                                            <span class="font-weight-bold ${matchResult.skillScore >= 75 ? 'text-success' : 'text-primary'}" style="font-size: 0.95rem;">
                                                <c:out value="${matchResult.skillScore}" />%
                                            </span>
                                        </div>
                                        <div class="progress mb-2" style="height: 6px; border-radius: 4px; background: rgba(0,0,0,0.05);">
                                            <div class="progress-bar ${matchResult.skillScore >= 80 ? 'bg-success' : matchResult.skillScore >= 50 ? 'bg-warning' : 'bg-danger'}" role="progressbar" style="width: ${matchResult.skillScore}%;"></div>
                                        </div>
                                        <small class="text-muted d-block font-weight-500 mb-0.5">${fn:length(matchResult.matchedSkills)} of ${fn:length(matchResult.requiredSkills)} Tech Skills Matched</small>
                                        <small class="text-secondary font-italic" style="font-size: 0.75rem;"><c:out value="${matchResult.studentAcademicSummary}" /></small>
                                    </div>
                                </div>
                            </div>

                            <!-- Skills Matched vs Missing Matrix -->
                            <div class="ios-card mb-4 p-3.5">
                                <h3 class="h6 font-weight-bold text-dark mb-2.5 d-flex align-items-center" style="font-size: 0.95rem;">
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="mr-2 text-primary"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="8" x2="12" y2="12"></line><line x1="12" y1="16" x2="12.01" y2="16"></line></svg>
                                    Technical Competency Alignment
                                </h3>

                                <div class="mb-3">
                                    <div class="small font-weight-bold text-success mb-1.5">&check; Matched Competencies (${fn:length(matchResult.matchedSkills)})</div>
                                    <div class="d-flex flex-wrap gap-1.5" style="gap: 0.4rem;">
                                        <c:forEach items="${matchResult.matchedSkills}" var="s">
                                            <span class="badge badge-success-soft text-success px-2.5 py-1 font-weight-semibold" style="background: rgba(52, 199, 89, 0.1); border: 1px solid rgba(52, 199, 89, 0.25); border-radius: 20px; font-size: 0.78rem;">
                                                &check; <c:out value="${s}" />
                                            </span>
                                        </c:forEach>
                                        <c:if test="${empty matchResult.matchedSkills}">
                                            <span class="text-muted small">No verified skills matched yet.</span>
                                        </c:if>
                                    </div>
                                </div>

                                <c:if test="${not empty matchResult.missingSkills}">
                                    <div>
                                        <div class="small font-weight-bold text-danger mb-1.5">&times; Missing Required Skills (${fn:length(matchResult.missingSkills)})</div>
                                        <div class="d-flex flex-wrap gap-1.5" style="gap: 0.4rem;">
                                            <c:forEach items="${matchResult.missingSkills}" var="ms">
                                                <span class="badge badge-danger-soft text-danger px-2.5 py-1 font-weight-semibold" style="background: rgba(239, 68, 68, 0.1); border: 1px solid rgba(239, 68, 68, 0.25); border-radius: 20px; font-size: 0.78rem;">
                                                    &plus; <c:out value="${ms}" />
                                                </span>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </c:if>
                            </div>

                            <!-- Personalized Dynamic Gap Roadmap -->
                            <div class="ios-card mb-4">
                                <div class="ios-card-header p-3 d-flex justify-content-between align-items-center">
                                    <div>
                                        <h3 class="h6 font-weight-bold text-dark mb-0" style="font-size: 1rem;">
                                            Personalized Gap-Bridging Action Roadmap
                                        </h3>
                                        <small class="text-muted">Exact milestones required to reach 100% readiness for this role</small>
                                    </div>
                                    <span class="ios-badge ios-badge-blue" style="font-size: 0.72rem;">${fn:length(matchResult.roadmapItems)} Actions</span>
                                </div>

                                <div class="list-group list-group-flush">
                                    <c:forEach items="${matchResult.roadmapItems}" var="item" varStatus="loop">
                                        <div class="list-group-item p-3 d-flex flex-column flex-sm-row justify-content-between align-items-sm-center gap-3">
                                            <div class="d-flex align-items-start mr-sm-3">
                                                <div class="rounded-circle d-flex align-items-center justify-content-center font-weight-bold mr-3 flex-shrink-0 mt-0.5" style="width: 28px; height: 28px; background: rgba(0, 113, 227, 0.1); color: var(--ios-blue); font-size: 0.8rem;">
                                                    ${loop.count}
                                                </div>
                                                <div>
                                                    <div class="d-flex align-items-center gap-2 mb-0.5 flex-wrap">
                                                        <span class="font-weight-bold text-dark" style="font-size: 0.92rem;"><c:out value="${item.title}" /></span>
                                                        <span class="badge badge-primary-soft text-primary font-weight-bold px-2 py-0.5" style="background: rgba(0,113,227,0.1); border-radius: 12px; font-size: 0.7rem;">+${item.impactWeight}% Score</span>
                                                        <span class="badge ${item.priority == 'HIGH' ? 'badge-danger' : 'badge-secondary'} px-2 py-0.5" style="border-radius: 12px; font-size: 0.68rem;"><c:out value="${item.priority}" /></span>
                                                    </div>
                                                    <p class="text-muted small mb-0"><c:out value="${item.description}" /></p>
                                                </div>
                                            </div>

                                            <div class="d-flex align-items-center gap-2 flex-shrink-0 mt-2 mt-sm-0">
                                                <button type="button" class="btn btn-sm btn-outline-primary add-task-btn font-weight-semibold d-inline-flex align-items-center"
                                                        data-title="${item.title}"
                                                        data-desc="${item.description}"
                                                        style="border-radius: 20px; font-size: 0.78rem; padding: 0.35rem 0.85rem;">
                                                    <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" class="mr-1"><line x1="12" y1="5" x2="12" y2="19"></line><line x1="5" y1="12" x2="19" y2="12"></line></svg>
                                                    Add to Checklist
                                                </button>
                                                <a href="${pageContext.request.contextPath}${item.actionLink}" class="btn btn-sm btn-light border font-weight-semibold" style="border-radius: 20px; font-size: 0.78rem; padding: 0.35rem 0.85rem;">
                                                    Take Action &rarr;
                                                </a>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="ios-card p-5 text-center">
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

            <!-- SECTION 3: Recent Scans History -->
            <c:if test="${not empty recentScans}">
                <div class="ios-card mt-2 mb-4">
                    <div class="ios-card-header p-3 d-flex justify-content-between align-items-center">
                        <div>
                            <h3 class="h6 font-weight-bold text-dark mb-0" style="font-size: 0.95rem;">
                                Recent Scanned Job Descriptions
                            </h3>
                            <small class="text-muted">Your past evaluations and match trajectories</small>
                        </div>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0" style="font-size: 0.85rem;">
                            <thead class="bg-light">
                                <tr>
                                    <th>Target Company</th>
                                    <th>Role Title</th>
                                    <th>Source Type</th>
                                    <th>Match Score</th>
                                    <th>DSA</th>
                                    <th>Projects</th>
                                    <th>Certs</th>
                                    <th>Evaluated Date</th>
                                    <th class="text-right">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${recentScans}" var="scan">
                                    <tr>
                                        <td class="font-weight-bold text-dark"><c:out value="${scan.targetCompany}" /></td>
                                        <td><c:out value="${scan.targetRole}" /></td>
                                        <td><span class="badge badge-light border"><c:out value="${scan.sourceType}" /></span></td>
                                        <td>
                                            <span class="badge ${scan.overallMatchScore >= 80 ? 'badge-success' : scan.overallMatchScore >= 55 ? 'badge-warning' : 'badge-danger'} px-2 py-1 font-weight-bold">
                                                ${scan.overallMatchScore}%
                                            </span>
                                        </td>
                                        <td>${scan.dsaScore}%</td>
                                        <td>${scan.projectScore}%</td>
                                        <td>${scan.certScore}%</td>
                                        <td class="text-muted">${scan.evaluatedAt}</td>
                                        <td class="text-right">
                                            <a href="${pageContext.request.contextPath}/app/student/dream-job?evalId=${scan.evalId}" class="btn btn-sm btn-primary py-1 px-2 font-weight-bold" style="font-size: 0.75rem;">
                                                View Match
                                            </a>
                                            <form action="${pageContext.request.contextPath}/app/student/dream-job" method="post" class="d-inline ml-1">
                                                <input type="hidden" name="csrfToken" value="${sessionScope.CSRF_TOKEN}" />
                                                <input type="hidden" name="action" value="delete-eval" />
                                                <input type="hidden" name="evalId" value="${scan.evalId}" />
                                                <button type="submit" class="btn btn-sm btn-outline-danger py-1 px-2" style="font-size: 0.75rem;" onclick="return confirm('Remove this evaluation record from history?');">
                                                    &times;
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </c:if>
        </main>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // Sample JD Auto-loader
    var sampleBtn = document.getElementById('sampleJdBtn');
    if (sampleBtn) {
        sampleBtn.addEventListener('click', function() {
            document.getElementById('targetCompany').value = 'Google';
            document.getElementById('targetRole').value = 'Software Development Engineer (SDE-1)';
            document.getElementById('rawJdText').value = 
                "Role: Software Development Engineer (SDE-1)\n" +
                "Location: Mountain View / Bengaluru\n\n" +
                "Minimum Qualifications:\n" +
                "- Bachelor's degree in Computer Science or related technical field with minimum 7.5 CGPA.\n" +
                "- Solid foundations in Data Structures and Algorithms (Dynamic Programming, Trees, Graphs, Hash Tables, System Scalability).\n" +
                "- Proficiency in Java, Python, C++, or Go.\n" +
                "- Experience building full-stack web applications, RESTful APIs, and relational databases (SQL / MySQL / PostgreSQL).\n" +
                "- Familiarity with Cloud Computing (GCP, AWS) and containerization tools (Docker, Kubernetes).\n" +
                "- Preferred: Industry recognized certifications or open-source GitHub contributions.";
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
