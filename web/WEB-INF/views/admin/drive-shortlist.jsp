<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="pageTitle" value="Placement Drive Shortlist • ${criteria.companyName}" />
<c:set var="activeNav" value="criteria" />
<%@ include file="/WEB-INF/views/common/header.jspf" %>
<%@ include file="/WEB-INF/views/common/navbar.jspf" %>

<div class="container-fluid">
    <div class="row">
        <%@ include file="/WEB-INF/views/common/sidebar.jspf" %>

        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4 py-4">
            <%@ include file="/WEB-INF/views/common/alerts.jspf" %>

            <!-- Top Dashboard Header (Executive Placement Drive Hero Card) -->
            <div class="ios-drive-hero-card mb-4 no-print">
                <div class="ios-drive-hero-flex">
                    <!-- Left: Avatar + Company Info -->
                    <div class="ios-drive-identity">
                        <!-- Company Avatar Squircle -->
                        <div class="ios-drive-avatar">
                            <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <rect x="2" y="7" width="20" height="14" rx="2" ry="2"></rect>
                                <path d="M16 21V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v16"></path>
                            </svg>
                            <span class="ios-drive-avatar-pulse" title="Active Screening Drive"></span>
                        </div>

                        <!-- Info Block -->
                        <div class="ios-drive-info">
                            <!-- Title Row: Company Name + Verified + Role + Live -->
                            <div class="ios-drive-title-row">
                                <h1 class="ios-drive-title">
                                    <c:out value="${criteria.companyName}" />
                                </h1>
                                <span class="ios-verified-badge" title="Verified Campus Recruiter Criteria">
                                    <svg width="17" height="17" viewBox="0 0 24 24" fill="#0284c7">
                                        <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z"/>
                                    </svg>
                                </span>
                                <span class="ios-drive-role-pill">
                                    <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2">
                                        <rect x="2" y="7" width="20" height="14" rx="2" ry="2"></rect>
                                        <path d="M16 21V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v16"></path>
                                    </svg>
                                    <c:out value="${criteria.roleTitle}" />
                                </span>
                                <span class="ios-drive-live-tag">
                                    <span class="ios-live-dot"></span>
                                    <span>LIVE</span>
                                </span>
                            </div>

                            <!-- Meta Subline -->
                            <p class="ios-drive-subline">
                                <span>Drive #<c:out value="${criteria.criteriaId}" /></span>
                                <span>&bull;</span>
                                <span>Automated student eligibility screening &amp; recruiter export</span>
                            </p>
                        </div>
                    </div>

                    <!-- Right: Action Controls -->
                    <div class="ios-drive-actions">
                        <!-- Drive Selector Dropdown -->
                        <div class="dropdown">
                            <button class="ios-drive-btn dropdown-toggle" type="button" id="driveSelectDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polygon points="12 2 2 7 12 12 22 7 12 2"></polygon><polyline points="2 17 12 22 22 17"></polyline><polyline points="2 12 12 17 22 12"></polyline></svg>
                                <span>Switch Drive</span>
                            </button>
                            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="driveSelectDropdown" style="border-radius: var(--ios-radius-md); box-shadow: 0 12px 32px rgba(15, 23, 42, 0.15); border: 1px solid #e2e8f0; z-index: 1050; max-height: 320px; overflow-y: auto;">
                                <c:forEach items="${allCriteria}" var="c">
                                    <a class="dropdown-item ${c.criteriaId == selectedCriteriaId ? 'active font-weight-bold' : ''}" href="${pageContext.request.contextPath}/app/admin/criteria/shortlist?criteriaId=${c.criteriaId}" style="font-size: 0.85rem; padding: 0.55rem 1rem;">
                                        <c:out value="${c.companyName}" /> (<c:out value="${c.roleTitle}" />)
                                    </a>
                                </c:forEach>
                            </div>
                        </div>

                        <!-- 1-Click CSV Export -->
                        <a href="${pageContext.request.contextPath}/app/admin/criteria/shortlist?criteriaId=${criteria.criteriaId}&export=csv" class="ios-drive-btn ios-drive-btn-primary">
                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2">
                                <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path>
                                <polyline points="7 10 12 15 17 10"></polyline>
                                <line x1="12" y1="15" x2="12" y2="3"></line>
                            </svg>
                            <span>Export CSV</span>
                        </a>

                        <a href="${pageContext.request.contextPath}/app/admin/criteria" class="ios-drive-btn" title="Back to criteria management">
                            &larr; Criteria
                        </a>
                    </div>
                </div>
            </div>

            <!-- Printable Shortlist Document Container -->
            <div id="driveShortlistDoc">

                <!-- 1. Key Shortlisting Metrics (4 KPI Cards) -->
                <div class="row mb-4">
                    <!-- Card 1: Eligible -->
                    <div class="col-xl-3 col-sm-6 mb-3 mb-xl-0">
                        <div class="ios-metric-card ios-metric-green">
                            <div class="d-flex justify-content-between align-items-center">
                                <div class="ios-metric-label">Eligible Candidates</div>
                                <span class="ios-badge ios-badge-green font-weight-bold"><c:out value="${shortlist.formattedEligibilityRate}" />% Pool</span>
                            </div>
                            <div class="ios-metric-value" style="color: var(--ios-green-dark);">
                                <c:out value="${shortlist.eligibleCount}" />
                            </div>
                            <div class="ios-progress-md mb-1.5">
                                <div class="ios-progress-bar" style="width: ${shortlist.eligibilityRate}%; background: linear-gradient(90deg, #34c759, #10b981);"></div>
                            </div>
                            <small class="text-muted font-weight-semibold">100% Meets all drive benchmarks</small>
                        </div>
                    </div>

                    <!-- Card 2: Marginal / Near Eligible -->
                    <div class="col-xl-3 col-sm-6 mb-3 mb-xl-0">
                        <div class="ios-metric-card ios-metric-orange">
                            <div class="d-flex justify-content-between align-items-center">
                                <div class="ios-metric-label">Near Eligible (1-2 Gaps)</div>
                                <span class="ios-badge ios-badge-orange font-weight-bold">Marginal</span>
                            </div>
                            <div class="ios-metric-value" style="color: #b45309;">
                                <c:out value="${shortlist.nearEligibleCount}" />
                            </div>
                            <div class="ios-progress-md mb-1.5">
                                <div class="ios-progress-bar" style="width: ${(shortlist.nearEligibleCount * 100) / (shortlist.totalEvaluated > 0 ? shortlist.totalEvaluated : 1)}%; background: #f59e0b;"></div>
                            </div>
                            <small class="text-muted font-weight-semibold">Requires minor threshold uplift</small>
                        </div>
                    </div>

                    <!-- Card 3: Non Eligible -->
                    <div class="col-xl-3 col-sm-6 mb-3 mb-sm-0">
                        <div class="ios-metric-card ios-metric-red">
                            <div class="d-flex justify-content-between align-items-center">
                                <div class="ios-metric-label">Ineligible Candidates</div>
                                <span class="ios-badge ios-badge-red font-weight-bold">Filtered Out</span>
                            </div>
                            <div class="ios-metric-value" style="color: var(--ios-red-dark);">
                                <c:out value="${shortlist.nonEligibleCount}" />
                            </div>
                            <div class="ios-progress-md mb-1.5">
                                <div class="ios-progress-bar" style="width: ${(shortlist.nonEligibleCount * 100) / (shortlist.totalEvaluated > 0 ? shortlist.totalEvaluated : 1)}%; background: #ef4444;"></div>
                            </div>
                            <small class="text-muted font-weight-semibold">Significant eligibility gaps</small>
                        </div>
                    </div>

                    <!-- Card 4: Quality Benchmark -->
                    <div class="col-xl-3 col-sm-6">
                        <div class="ios-metric-card ios-metric-blue">
                            <div class="d-flex justify-content-between align-items-center">
                                <div class="ios-metric-label">Avg Eligible CGPA</div>
                                <span class="ios-badge ios-badge-blue font-weight-bold">Benchmark</span>
                            </div>
                            <div class="ios-metric-value" style="color: var(--ios-blue);">
                                <c:out value="${shortlist.formattedAvgEligibleCgpa}" /> <span style="font-size: 0.95rem; color: #64748b; font-weight: 500;">/ 10.00</span>
                            </div>
                            <div class="mt-2 text-muted small">
                                Total Screened: <strong><c:out value="${shortlist.totalEvaluated}" /> Candidates</strong>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 2. Active Drive Cutoff Thresholds Strip -->
                <div class="ios-card p-3 p-md-4 mb-4" style="background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%); border: 1px solid #e2e8f0; border-radius: var(--ios-radius-md);">
                    <div class="d-flex flex-column flex-md-row justify-content-between align-items-start align-items-md-center" style="gap: 1rem;">
                        <div class="flex-grow-1">
                            <div class="text-muted text-uppercase font-weight-bold small mb-2" style="letter-spacing: 0.05em; font-size: 0.72rem;">
                                Screened Against Official Benchmarks:
                            </div>
                            <div class="d-flex flex-wrap align-items-center" style="gap: 0.45rem;">
                                <span class="ios-badge ios-badge-blue" style="font-size: 0.8rem; padding: 0.35rem 0.75rem;">
                                    Min CGPA: <strong>&ge; <c:out value="${criteria.formattedMinCgpa}" /></strong>
                                </span>
                                <span class="ios-badge ios-badge-teal" style="font-size: 0.8rem; padding: 0.35rem 0.75rem;">
                                    Min DSA: <strong>&ge; <c:out value="${criteria.minDsaProblems}" /> problems</strong>
                                </span>
                                <span class="ios-badge ios-badge-purple" style="font-size: 0.8rem; padding: 0.35rem 0.75rem;">
                                    Min Projects: <strong>&ge; <c:out value="${criteria.minProjects}" /> apps</strong>
                                </span>
                                <span class="ios-badge ios-badge-orange" style="font-size: 0.8rem; padding: 0.35rem 0.75rem;">
                                    Min Certs: <strong>&ge; <c:out value="${criteria.minCertifications}" /></strong>
                                </span>
                                <span class="ios-badge ios-badge-gray" style="font-size: 0.8rem; padding: 0.35rem 0.75rem;">
                                    Branches: <strong><c:out value="${criteria.allowedDepartments}" /></strong>
                                </span>
                            </div>
                        </div>
                        <c:if test="${not empty criteria.skillRequirements}">
                            <div class="mt-3 mt-md-0 pl-md-3" style="border-left: 1px solid #e2e8f0; min-width: 260px;">
                                <div class="text-muted text-uppercase font-weight-bold small mb-2" style="letter-spacing: 0.05em; font-size: 0.72rem;">
                                    Prerequisite Skills:
                                </div>
                                <div class="d-flex flex-wrap align-items-center" style="gap: 0.35rem;">
                                    <c:forEach items="${criteria.skillRequirements}" var="req">
                                        <span class="ios-badge ios-badge-gray" style="font-size: 0.75rem; padding: 0.28rem 0.65rem; border-radius: 8px;">
                                            <c:out value="${req.skillName}" /> &bull; <strong style="color: #0284c7;"><c:out value="${req.minProficiency.displayName}" /></strong>
                                        </span>
                                    </c:forEach>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </div>

                <!-- 3. Candidate Shortlist Table & Filter Tabs -->
                <div class="candidate-table-card mb-4">
                    <!-- Filter Toolbar (Hidden on Print) -->
                    <div class="p-3 d-flex flex-column flex-md-row justify-content-between align-items-stretch align-items-md-center gap-3 no-print" style="background: #ffffff; border-bottom: 1px solid #e2e8f0;">
                        <!-- Apple iOS Segmented Filter Pill Bar -->
                        <div class="ios-filter-bar-wrap">
                            <button type="button" class="ios-filter-pill active" onclick="filterCandidates('ALL', this)">
                                <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" class="mr-1.5"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path><circle cx="9" cy="7" r="4"></circle><path d="M23 21v-2a4 4 0 0 0-3-3.87"></path><path d="M16 3.13a4 4 0 0 1 0 7.75"></path></svg>
                                <span>All Candidates</span>
                                <span class="ios-pill-count">${shortlist.totalEvaluated}</span>
                            </button>
                            <button type="button" class="ios-filter-pill ios-pill-green" onclick="filterCandidates('ELIGIBLE', this)">
                                <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" class="mr-1.5"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path><polyline points="22 4 12 14.01 9 11.01"></polyline></svg>
                                <span>Eligible Only</span>
                                <span class="ios-pill-count">${shortlist.eligibleCount}</span>
                            </button>
                            <button type="button" class="ios-filter-pill ios-pill-orange" onclick="filterCandidates('NEAR', this)">
                                <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" class="mr-1.5"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="8" x2="12" y2="12"></line><line x1="12" y1="16" x2="12.01" y2="16"></line></svg>
                                <span>Marginal</span>
                                <span class="ios-pill-count">${shortlist.nearEligibleCount}</span>
                            </button>
                            <button type="button" class="ios-filter-pill ios-pill-red" onclick="filterCandidates('INELIGIBLE', this)">
                                <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" class="mr-1.5"><circle cx="12" cy="12" r="10"></circle><line x1="15" y1="9" x2="9" y2="15"></line><line x1="9" y1="9" x2="15" y2="15"></line></svg>
                                <span>Ineligible</span>
                                <span class="ios-pill-count">${shortlist.nonEligibleCount}</span>
                            </button>
                        </div>

                        <!-- Real-time Search Box -->
                        <div style="min-width: 260px;">
                            <div class="input-group input-group-sm">
                                <div class="input-group-prepend">
                                    <span class="input-group-text bg-white border-right-0" style="border-radius: var(--ios-radius-md) 0 0 var(--ios-radius-md);">
                                        <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="#64748b" stroke-width="2.5"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                                    </span>
                                </div>
                                <input type="text" id="candidateSearchInput" class="form-control border-left-0" placeholder="Search by name, roll, dept..." style="border-radius: 0 var(--ios-radius-md) var(--ios-radius-md) 0;" onkeyup="searchCandidatesTable()">
                            </div>
                        </div>
                    </div>

                    <!-- Table Container -->
                    <div class="table-responsive">
                        <table class="table table-hover mb-0" id="shortlistTable" style="border-collapse: separate;">
                            <thead class="bg-light">
                                <tr style="border-bottom: 1px solid #e2e8f0;">
                                    <th class="border-top-0 font-weight-bold small text-uppercase py-3 px-4" style="color: #334155; letter-spacing: 0.05em;">Candidate Profile</th>
                                    <th class="border-top-0 font-weight-bold small text-uppercase py-3" style="color: #334155; letter-spacing: 0.05em;">Department &amp; Batch</th>
                                    <th class="border-top-0 font-weight-bold small text-uppercase py-3" style="color: #334155; letter-spacing: 0.05em;">Academic CGPA</th>
                                    <th class="border-top-0 font-weight-bold small text-uppercase py-3" style="color: #334155; letter-spacing: 0.05em;">DSA &amp; Portfolio</th>
                                    <th class="border-top-0 font-weight-bold small text-uppercase py-3" style="color: #334155; letter-spacing: 0.05em;">Status</th>
                                    <th class="border-top-0 font-weight-bold small text-uppercase py-3 px-4 text-right" style="color: #334155; letter-spacing: 0.05em;">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${empty shortlist.allEvaluations}">
                                        <tr>
                                            <td colspan="6" class="text-center py-5 text-muted">
                                                No candidates registered in cohort.
                                            </td>
                                        </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach items="${shortlist.allEvaluations}" var="eval" varStatus="loop">
                                            <c:set var="statusCategory" value="${eval.overallStatus == 'MEETS_REQUIREMENT' ? 'ELIGIBLE' : (eval.overallStatus == 'NEEDS_IMPROVEMENT' ? 'NEAR' : 'INELIGIBLE')}" />
                                            <tr class="candidate-row" data-status="${statusCategory}" data-search="<c:out value='${eval.student.fullName} ${eval.student.rollNumber} ${eval.student.department}' />" style="border-bottom: 1px solid #f1f5f9;">
                                                <!-- Candidate Info -->
                                                <td class="py-3 px-4" style="vertical-align: middle;">
                                                    <div class="d-flex align-items-center gap-3">
                                                        <div class="candidate-avatar-wrap">
                                                            <c:choose>
                                                                <c:when test="${not empty eval.student.profileImage}">
                                                                    <img src="${eval.student.profileImage}" alt="${eval.student.fullName}" />
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span>${fn:substring(eval.student.fullName, 0, 1)}</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                        <div>
                                                            <a href="${pageContext.request.contextPath}/app/admin/student-detail?studentId=${eval.student.studentId}" class="candidate-name-link">
                                                                <c:out value="${eval.student.fullName}" />
                                                            </a>
                                                            <div class="candidate-meta-line">
                                                                <span class="candidate-roll-badge"><c:out value="${eval.student.rollNumber}" /></span>
                                                                <span>&bull;</span>
                                                                <span class="d-inline-flex align-items-center">
                                                                    <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="mr-1"><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path><polyline points="22,6 12,13 2,6"></polyline></svg>
                                                                    <c:out value="${eval.student.email}" />
                                                                </span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </td>

                                                <!-- Dept & Batch -->
                                                <td style="vertical-align: middle;">
                                                    <span class="ios-badge ios-badge-gray font-weight-bold"><c:out value="${eval.student.department}" /></span>
                                                    <small class="text-muted d-block mt-0.5">Class of <c:out value="${eval.student.graduationYear}" /></small>
                                                </td>

                                                <!-- CGPA -->
                                                <td style="vertical-align: middle;">
                                                    <div class="font-weight-bold" style="font-size: 1rem; color: ${eval.student.cgpa >= criteria.minCgpa ? '#15803d' : '#ef4444'};">
                                                        <c:out value="${eval.student.formattedCgpa}" /> <span style="font-size: 0.75rem; color: #64748b; font-weight: 500;">/ 10</span>
                                                    </div>
                                                    <small class="text-muted">Cutoff &ge; <c:out value="${criteria.formattedMinCgpa}" /></small>
                                                </td>

                                                <!-- DSA & Checks -->
                                                <td style="vertical-align: middle;">
                                                    <div class="d-flex align-items-center gap-1.5 mb-1" style="gap: 0.35rem;">
                                                        <span class="font-weight-bold small text-dark"><c:out value="${eval.passedCount}" /> / <c:out value="${eval.totalChecks}" /></span>
                                                        <span class="badge badge-light border text-muted" style="font-size: 0.7rem;"><c:out value="${eval.formattedPassedPercentage}" />%</span>
                                                    </div>
                                                    <div class="progress" style="height: 4px; width: 90px; border-radius: 999px; background: #e2e8f0;">
                                                        <div class="progress-bar ${eval.passedCount == eval.totalChecks ? 'bg-success' : 'bg-primary'}" role="progressbar" style="width: ${eval.totalChecks > 0 ? (eval.passedCount * 100.0 / eval.totalChecks) : 100}%;"></div>
                                                    </div>
                                                </td>

                                                <!-- Status Badge -->
                                                <td style="vertical-align: middle;">
                                                    <c:choose>
                                                        <c:when test="${eval.overallStatus == 'MEETS_REQUIREMENT'}">
                                                            <span class="ios-badge ios-badge-green font-weight-bold" style="padding: 0.35rem 0.75rem;">
                                                                <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" class="mr-1"><polyline points="20 6 9 17 4 12"></polyline></svg>
                                                                Eligible
                                                            </span>
                                                        </c:when>
                                                        <c:when test="${eval.overallStatus == 'NEEDS_IMPROVEMENT'}">
                                                            <span class="ios-badge ios-badge-orange font-weight-bold" style="padding: 0.35rem 0.75rem;">
                                                                <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" class="mr-1"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg>
                                                                Marginal
                                                            </span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="ios-badge ios-badge-red font-weight-bold" style="padding: 0.35rem 0.75rem;">
                                                                <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" class="mr-1"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg>
                                                                Ineligible
                                                            </span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>

                                                <!-- Action / Quick Audit -->
                                                <td class="text-right py-3 px-4" style="vertical-align: middle;">
                                                    <div class="d-flex align-items-center justify-content-end gap-1.5" style="gap: 0.35rem;">
                                                        <a href="${pageContext.request.contextPath}/passport?id=${eval.student.studentId}" target="_blank" class="btn btn-sm btn-outline-success d-inline-flex align-items-center" style="border-radius: var(--ios-radius-sm); padding: 0.25rem 0.65rem; font-size: 0.785rem; font-weight: 600;" title="Public QR Passport">
                                                            Passport &rarr;
                                                        </a>
                                                        <a href="${pageContext.request.contextPath}/app/admin/student-detail?studentId=${eval.student.studentId}" class="btn btn-sm btn-outline-primary d-inline-flex align-items-center" style="border-radius: var(--ios-radius-sm); padding: 0.25rem 0.65rem; font-size: 0.785rem; font-weight: 600;">
                                                            Profile
                                                        </a>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Mandatory Institutional Disclaimer -->
                <div class="p-3 mb-4 d-flex align-items-center" style="background: #f0f7ff; border: 1px solid #bfdbfe; border-radius: var(--ios-radius-md); font-size: 0.825rem; color: #1e3a8a; gap: 0.75rem;">
                    <div class="d-flex align-items-center justify-content-center flex-shrink-0" style="width: 24px; height: 24px; border-radius: 50%; background: #dbeafe; color: #0284c7;">
                        <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="16" x2="12" y2="12"></line><line x1="12" y1="8" x2="12" y2="8"></line></svg>
                    </div>
                    <div style="line-height: 1.45;">
                        <strong style="color: #0369a1;">TPO Institutional Notice:</strong> Candidate eligibility calculations are automatically evaluated against student verified database records on <strong><c:out value="${generatedTimestamp}" /></strong>.
                    </div>
                </div>

            </div>
        </main>
    </div>
</div>

<script>
// Filter Candidates by Status Tab
function filterCandidates(status, btnElement) {
    if (btnElement) {
        var pills = document.querySelectorAll('.ios-filter-pill');
        pills.forEach(function(pill) {
            pill.classList.remove('active');
        });
        btnElement.classList.add('active');
    }

    var rows = document.querySelectorAll('.candidate-row');
    rows.forEach(function(row) {
        if (status === 'ALL' || row.getAttribute('data-status') === status) {
            row.style.display = '';
        } else {
            row.style.display = 'none';
        }
    });
}

// Search Filter
function searchCandidatesTable() {
    var input = document.getElementById('candidateSearchInput');
    var filter = input.value.toLowerCase().trim();
    var rows = document.querySelectorAll('.candidate-row');

    rows.forEach(function(row) {
        var text = (row.getAttribute('data-search') || '').toLowerCase();
        if (!filter || text.indexOf(filter) > -1) {
            row.style.display = '';
        } else {
            row.style.display = 'none';
        }
    });
}
</script>

<%@ include file="/WEB-INF/views/common/footer.jspf" %>
