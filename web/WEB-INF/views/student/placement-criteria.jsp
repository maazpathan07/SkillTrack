<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Placement Criteria Matcher" />
<c:set var="activeNav" value="placement-criteria" />
<%@ include file="/WEB-INF/views/common/header.jspf" %>
<%@ include file="/WEB-INF/views/common/navbar.jspf" %>

<div class="container-fluid">
    <div class="row">
        <%@ include file="/WEB-INF/views/common/sidebar.jspf" %>

        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4 py-4">
            <%@ include file="/WEB-INF/views/common/alerts.jspf" %>

            <!-- Page Header -->
            <div class="ios-dash-header mb-4">
                <div>
                    <div class="d-flex align-items-center gap-2 mb-1">
                        <span class="ios-badge ios-badge-purple">
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" aria-hidden="true"><rect x="2" y="7" width="20" height="14" rx="2" ry="2"></rect><path d="M16 21V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v16"></path></svg>
                            Eligibility Engine
                        </span>
                    </div>
                    <h1 class="h3 font-weight-bold text-gray-800 mb-0" style="letter-spacing: -0.03em;">Company Placement Criteria Matcher</h1>
                    <p class="text-muted small mb-0 mt-1">Deterministic eligibility benchmarking against company-specific placement cutoffs and hiring criteria</p>
                </div>
                <div>
                    <span class="ios-badge ios-badge-blue" style="font-size: 0.85rem; padding: 0.5rem 1rem;">
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" aria-hidden="true"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg>
                        Deterministic Verification
                    </span>
                </div>
            </div>

            <!-- Drive Eligibility Summary Strip -->
            <div class="row mb-4">
                <div class="col-md-4 mb-3 mb-md-0">
                    <div class="ios-metric-card ios-metric-green">
                        <div class="d-flex justify-content-between align-items-center">
                            <div class="ios-metric-label">Eligible Drives</div>
                            <span class="ios-badge ios-badge-green font-weight-bold">Qualified</span>
                        </div>
                        <div class="ios-metric-value" style="color: var(--ios-green-dark);">
                            <c:out value="${eligibleCount}" default="0" /> <span style="font-size: 0.95rem; color: #64748b; font-weight: 500;">/ ${evaluations.size()} Active</span>
                        </div>
                        <small class="text-muted font-weight-semibold">You meet all company cutoffs</small>
                    </div>
                </div>
                <div class="col-md-4 mb-3 mb-md-0">
                    <div class="ios-metric-card ios-metric-orange">
                        <div class="d-flex justify-content-between align-items-center">
                            <div class="ios-metric-label">Marginal (1-2 Gaps)</div>
                            <span class="ios-badge ios-badge-orange font-weight-bold">Almost Ready</span>
                        </div>
                        <div class="ios-metric-value" style="color: #b45309;">
                            <c:out value="${nearCount}" default="0" /> Drives
                        </div>
                        <small class="text-muted font-weight-semibold">Minor skill/DSA milestone needed</small>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="ios-metric-card ios-metric-red">
                        <div class="d-flex justify-content-between align-items-center">
                            <div class="ios-metric-label">Ineligible Drives</div>
                            <span class="ios-badge ios-badge-red font-weight-bold">Attention Needed</span>
                        </div>
                        <div class="ios-metric-value" style="color: var(--ios-red-dark);">
                            <c:out value="${ineligibleCount}" default="0" /> Drives
                        </div>
                        <small class="text-muted font-weight-semibold">Major cutoff gaps to bridge</small>
                    </div>
                </div>
            </div>

            <!-- Filter Toolbar -->
            <div class="d-flex align-items-center justify-content-between flex-wrap gap-2 mb-3">
                <div class="ios-filter-bar-wrap">
                    <button type="button" class="ios-filter-pill active" onclick="filterDrives('ALL', this)">
                        <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" class="mr-1.5"><rect x="2" y="7" width="20" height="14" rx="2" ry="2"></rect><path d="M16 21V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v16"></path></svg>
                        <span>All Drives</span>
                        <span class="ios-pill-count">${evaluations.size()}</span>
                    </button>
                    <button type="button" class="ios-filter-pill ios-pill-green" onclick="filterDrives('ELIGIBLE', this)">
                        <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" class="mr-1.5"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path><polyline points="22 4 12 14.01 9 11.01"></polyline></svg>
                        <span>Eligible</span>
                        <span class="ios-pill-count">${eligibleCount}</span>
                    </button>
                    <button type="button" class="ios-filter-pill ios-pill-orange" onclick="filterDrives('NEAR', this)">
                        <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" class="mr-1.5"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg>
                        <span>Marginal</span>
                        <span class="ios-pill-count">${nearCount}</span>
                    </button>
                    <button type="button" class="ios-filter-pill ios-pill-red" onclick="filterDrives('INELIGIBLE', this)">
                        <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" class="mr-1.5"><circle cx="12" cy="12" r="10"></circle><line x1="15" y1="9" x2="9" y2="15"></line><line x1="9" y1="9" x2="15" y2="15"></line></svg>
                        <span>Ineligible</span>
                        <span class="ios-pill-count">${ineligibleCount}</span>
                    </button>
                </div>
                <span class="text-muted small">Real-time profile sync &bull; Evaluated live</span>
            </div>

            <c:choose>
                <c:when test="${empty evaluations}">
                    <div class="ios-card p-5 text-center text-muted">
                        <div class="ios-badge ios-badge-gray p-3 mb-2" style="border-radius: var(--ios-radius-full);">
                            <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true"><rect x="2" y="7" width="20" height="14" rx="2" ry="2"></rect><path d="M16 21V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v16"></path></svg>
                        </div>
                        <h2 class="h5 font-weight-bold text-dark mt-2">No placement criteria profiles active</h2>
                        <p class="small mb-0" style="color: #475569;">Placement administrator has not published company cutoffs for your batch yet.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="accordion" id="criteriaAccordion">
                        <c:forEach items="${evaluations}" var="eval" varStatus="loop">
                            <c:set var="statusCategory" value="${eval.overallStatus == 'MEETS_REQUIREMENT' ? 'ELIGIBLE' : (eval.overallStatus == 'NEEDS_IMPROVEMENT' ? 'NEAR' : 'INELIGIBLE')}" />
                            <div class="ios-card mb-3.5 drive-card-item" data-status="${statusCategory}" style="border-radius: var(--ios-radius-md); overflow: hidden; border: 1px solid #e2e8f0; transition: var(--ios-ease);">
                                <div class="ios-card-header p-3 p-md-4 d-flex flex-column flex-sm-row justify-content-between align-items-sm-center" id="heading${eval.criteria.criteriaId}" style="background: #ffffff; gap: 1rem;">
                                    <div class="d-flex align-items-start align-items-sm-center" style="gap: 0.9rem;">
                                        <!-- Modern Company Icon Avatar -->
                                        <div class="d-flex align-items-center justify-content-center flex-shrink-0" style="width: 44px; height: 44px; border-radius: 12px; background: rgba(0, 113, 227, 0.08); color: var(--ios-blue); border: 1px solid rgba(0, 113, 227, 0.15);">
                                            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                                                <rect x="2" y="7" width="20" height="14" rx="2" ry="2"></rect>
                                                <path d="M16 21V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v16"></path>
                                            </svg>
                                        </div>
                                        <!-- Title & Meta Information -->
                                        <div class="flex-grow-1">
                                            <div class="d-flex align-items-center flex-wrap" style="gap: 0.4rem;">
                                                <h2 class="h6 font-weight-bold text-dark mb-0" style="font-size: 1.05rem; letter-spacing: -0.02em;">
                                                    <c:out value="${eval.criteria.companyName}" />
                                                </h2>
                                                <span style="color: #94a3b8; font-weight: 300;">&bull;</span>
                                                <span class="font-weight-semibold" style="color: #475569; font-size: 0.925rem;">
                                                    <c:out value="${eval.criteria.roleTitle}" />
                                                </span>
                                            </div>
                                            <div class="d-flex align-items-center flex-wrap mt-1.5" style="gap: 0.45rem;">
                                                <span class="ios-badge ios-badge-gray" style="font-size: 0.75rem; padding: 0.2rem 0.6rem;">
                                                    Eligible: <strong class="ml-1" style="color: var(--ios-text-primary);"><c:out value="${eval.criteria.allowedDepartments}" /></strong>
                                                </span>
                                                <span class="ios-badge ios-badge-blue" style="font-size: 0.75rem; padding: 0.2rem 0.6rem;">
                                                    Checks: <strong class="ml-1"><c:out value="${eval.passedCount}" /> / <c:out value="${eval.totalChecks}" /></strong> (<c:out value="${eval.formattedPassedPercentage}" />%)
                                                </span>
                                                <c:choose>
                                                    <c:when test="${eval.overallStatus == 'MEETS_REQUIREMENT'}">
                                                        <span class="ios-badge ios-badge-green font-weight-bold" style="font-size: 0.75rem;">
                                                            <svg width="10" height="10" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" class="mr-1"><polyline points="20 6 9 17 4 12"></polyline></svg>
                                                            Eligible
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${eval.overallStatus == 'NEEDS_IMPROVEMENT'}">
                                                        <span class="ios-badge ios-badge-orange font-weight-bold" style="font-size: 0.75rem;">
                                                            <svg width="10" height="10" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" class="mr-1"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg>
                                                            Marginal Gap
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="ios-badge ios-badge-red font-weight-bold" style="font-size: 0.75rem;">
                                                            <svg width="10" height="10" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" class="mr-1"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg>
                                                            Ineligible
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Parameter Breakdown Toggle Button -->
                                    <div class="d-flex align-items-center justify-content-end flex-shrink-0">
                                        <button class="ios-btn-secondary collapsed d-inline-flex align-items-center justify-content-center text-nowrap w-100 w-sm-auto" type="button" data-toggle="collapse" data-target="#collapse${eval.criteria.criteriaId}" aria-expanded="false" aria-controls="collapse${eval.criteria.criteriaId}" style="padding: 0.5rem 1.15rem; font-size: 0.825rem; font-weight: 600; border-radius: var(--ios-radius-sm);">
                                            <span>Parameter Breakdown</span>
                                            <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" class="ml-1.5" aria-hidden="true"><polyline points="6 9 12 15 18 9"></polyline></svg>
                                        </button>
                                    </div>
                                </div>

                                <div id="collapse${eval.criteria.criteriaId}" class="collapse" aria-labelledby="heading${eval.criteria.criteriaId}" data-parent="#criteriaAccordion">
                                    <div class="ios-card-body p-0 border-top">
                                        <div class="table-responsive">
                                            <table class="table table-hover mb-0" style="border-collapse: separate;">
                                                <thead class="bg-light">
                                                    <tr style="border-bottom: 1px solid #e2e8f0;">
                                                        <th class="border-top-0 font-weight-bold small text-uppercase py-3 px-3 px-sm-4" style="color: #334155; letter-spacing: 0.05em;">Eligibility Parameter</th>
                                                        <th class="border-top-0 font-weight-bold small text-uppercase py-3" style="color: #334155; letter-spacing: 0.05em;">Required Threshold</th>
                                                        <th class="border-top-0 font-weight-bold small text-uppercase py-3" style="color: #334155; letter-spacing: 0.05em;">Your Current Profile</th>
                                                        <th class="border-top-0 font-weight-bold small text-uppercase py-3" style="color: #334155; letter-spacing: 0.05em;">Status</th>
                                                        <th class="border-top-0 font-weight-bold small text-uppercase py-3 px-3 px-sm-4" style="color: #334155; letter-spacing: 0.05em;">Assessment Remarks</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach items="${eval.resultItems}" var="item">
                                                        <tr style="border-bottom: 1px solid #f1f5f9;">
                                                            <td class="font-weight-bold text-dark py-3 px-4" style="vertical-align: middle;">
                                                                <c:out value="${item.criterionName}" />
                              
                              </td>
                                                            <td style="vertical-align: middle;">
                                                                <code style="background: #f1f5f9; padding: 0.25rem 0.55rem; border-radius: var(--ios-radius-sm); color: #005bb5; font-weight: 700; font-family: 'JetBrains Mono', monospace; font-size: 0.85rem;">
                                                                    <c:out value="${item.requiredValue}" />
                                                                </code>
                                                            </td>
                                                            <td class="font-weight-bold text-dark py-3" style="vertical-align: middle;">
                                                                <c:out value="${item.studentValue}" />
                                                            </td>
                                                            <td style="vertical-align: middle;">
                                                                <c:choose>
                                                                    <c:when test="${item.status.name() == 'MEETS_REQUIREMENT'}">
                                                                        <span class="ios-badge ios-badge-green">
                                                                            <svg width="10" height="10" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" aria-hidden="true"><polyline points="20 6 9 17 4 12"></polyline></svg>
                                                                            Passed
                                                                        </span>
                                                                    </c:when>
                                                                    <c:when test="${item.status.name() == 'NEEDS_IMPROVEMENT'}">
                                                                        <span class="ios-badge ios-badge-orange">
                                                                            <svg width="10" height="10" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" aria-hidden="true"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg>
                                                                            Warning
                                                                        </span>
                                                                    </c:when>
                                                                    <c:when test="${item.status.name() == 'NOT_APPLICABLE'}">
                                                                        <span class="ios-badge ios-badge-gray">
                                                                            N/A
                                                                        </span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="ios-badge ios-badge-red">
                                                                            <svg width="10" height="10" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" aria-hidden="true"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg>
                                                                            Failed
                                                                        </span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                            <td class="small py-3 px-4" style="color: #475569; vertical-align: middle; line-height: 1.5;">
                                                                <c:out value="${item.remarks}" />
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </main>
    </div>
</div>

<script>
function filterDrives(status, btnElement) {
    if (btnElement) {
        document.querySelectorAll('.ios-filter-bar-wrap .ios-filter-pill').forEach(function(b) {
            b.classList.remove('active');
        });
        btnElement.classList.add('active');
    }
    var items = document.querySelectorAll('.drive-card-item');
    items.forEach(function(item) {
        if (status === 'ALL' || item.getAttribute('data-status') === status) {
            item.style.display = '';
        } else {
            item.style.display = 'none';
        }
    });
}
</script>

<%@ include file="/WEB-INF/views/common/footer.jspf" %>
