<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Target Role Skill Gap Analyzer" />
<c:set var="activeNav" value="skill-gap" />
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
                        <span class="ios-badge ios-badge-blue">
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" aria-hidden="true"><circle cx="12" cy="12" r="10"></circle><circle cx="12" cy="12" r="6"></circle><circle cx="12" cy="12" r="2"></circle></svg>
                            Taxonomy Engine
                        </span>
                    </div>
                    <h1 class="h3 font-weight-bold text-gray-800 mb-0" style="letter-spacing: -0.03em;">Target Role Skill Gap Analyzer</h1>
                    <p class="text-muted small mb-0 mt-1">Evaluate your technical profile against industry target role benchmarks to pinpoint exact competency gaps</p>
                </div>
                <div>
                    <a href="${pageContext.request.contextPath}/app/student/skills" class="ios-btn-secondary" style="padding: 0.6rem 1.25rem; font-size: 0.875rem;">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" aria-hidden="true"><polyline points="16 18 22 12 16 6"></polyline><polyline points="8 6 2 12 8 18"></polyline></svg>
                        Manage Skills
                    </a>
                </div>
            </div>

            <!-- Role Selector Card -->
            <div class="ios-card mb-4">
                <div class="ios-card-body p-4">
                    <div class="row align-items-center">
                        <div class="col-lg-6 mb-3 mb-lg-0">
                            <form action="${pageContext.request.contextPath}/app/student/skill-gap" method="get" class="d-flex align-items-center flex-wrap gap-2">
                                <label for="roleId" class="ios-form-label mb-0" style="white-space: nowrap;">Evaluating Role:</label>
                                <select class="ios-form-control flex-grow-1" id="roleId" name="roleId" onchange="this.form.submit()" style="min-width: 220px; font-weight: 600; border-radius: var(--ios-radius-sm);">
                                    <c:forEach items="${targetRoles}" var="role">
                                        <option value="${role.roleId}" ${selectedRoleId == role.roleId ? 'selected' : ''}>
                                            <c:out value="${role.roleTitle}" />
                                        </option>
                                    </c:forEach>
                                </select>
                            </form>
                        </div>
                        <div class="col-lg-6 text-lg-right">
                            <c:if test="${not empty selectedRoleId && selectedRoleId != student.targetRoleId}">
                                <form action="${pageContext.request.contextPath}/app/student/skill-gap" method="post" class="d-inline">
                                    <input type="hidden" name="csrfToken" value="${sessionScope.CSRF_TOKEN}" />
                                    <input type="hidden" name="targetRoleId" value="${selectedRoleId}" />
                                    <button type="submit" class="ios-btn-primary" style="padding: 0.55rem 1.25rem; font-size: 0.85rem; box-shadow: 0 4px 12px rgba(0, 113, 227, 0.25);">
                                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" aria-hidden="true"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"></polygon></svg>
                                        Set as My Primary Target Role
                                    </button>
                                </form>
                            </c:if>
                            <c:if test="${selectedRoleId == student.targetRoleId}">
                                <span class="ios-badge ios-badge-green" style="font-size: 0.85rem; padding: 0.5rem 1rem;">
                                    <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" aria-hidden="true"><polyline points="20 6 9 17 4 12"></polyline></svg>
                                    Primary Target Role
                                </span>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Metric Summary Row -->
            <div class="row mb-4">
                <div class="col-md-3 col-sm-6 mb-3">
                    <div class="ios-metric-card ios-metric-blue">
                        <div class="ios-metric-label" style="color: #005bb5;">Skill Match Index</div>
                        <div class="ios-metric-value"><c:out value="${skillGap.formattedSkillMatch}" default="0.0" />%</div>
                        <div class="ios-progress-thin mt-2" style="height: 6px; border-radius: var(--ios-radius-full); background: #f1f5f9; overflow: hidden;">
                            <div class="ios-progress-bar" style="width: ${skillGap.matchPercentage}%; background: linear-gradient(90deg, #0071e3, #32ade6); height: 100%; border-radius: var(--ios-radius-full); transition: width 0.6s ease;"></div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 mb-3">
                    <div class="ios-metric-card ios-metric-green">
                        <div class="ios-metric-label" style="color: var(--ios-green-dark);">Matched Skills</div>
                        <div class="ios-metric-value" style="color: var(--ios-green-dark);"><c:out value="${skillGap.matchedSkillsCount}" default="0" /></div>
                        <small style="color: #475569;">Meets or exceeds required level</small>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 mb-3">
                    <div class="ios-metric-card ios-metric-orange">
                        <div class="ios-metric-label" style="color: #c2410c;">Needs Improvement</div>
                        <div class="ios-metric-value" style="color: #b45309;"><c:out value="${skillGap.needsImprovementCount}" default="0" /></div>
                        <small style="color: #475569;">Acquired but below target level</small>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 mb-3">
                    <div class="ios-metric-card ios-metric-red">
                        <div class="ios-metric-label" style="color: #b91c1c;">Missing Skills</div>
                        <div class="ios-metric-value" style="color: #b91c1c;"><c:out value="${skillGap.missingCount}" default="0" /></div>
                        <small style="color: #475569;">Not yet recorded on profile</small>
                    </div>
                </div>
            </div>

            <!-- Detailed Gap Matrix Table -->
            <div class="ios-card mb-4">
                <div class="ios-card-header" style="padding: 1.25rem 1.5rem;">
                    <div>
                        <h2 class="h5 font-weight-bold text-dark mb-0" style="font-size: 1.15rem; letter-spacing: -0.02em;">
                            Benchmark Requirements for <c:out value="${skillGap.roleTitle}" />
                        </h2>
                        <small class="text-muted">Direct competency comparison against industry standards</small>
                    </div>
                    <span class="ios-badge ios-badge-blue font-weight-bold">
                        <c:out value="${skillGap.totalRequiredSkills}" default="0" /> Benchmark Skills
                    </span>
                </div>
                <div class="ios-card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0" style="border-collapse: separate;">
                            <thead class="bg-light">
                                <tr style="border-bottom: 1px solid #e2e8f0;">
                                    <th class="border-top-0 font-weight-bold small text-uppercase py-3 px-4" style="color: #334155; letter-spacing: 0.05em;">Required Skill</th>
                                    <th class="border-top-0 font-weight-bold small text-uppercase py-3" style="color: #334155; letter-spacing: 0.05em;">Category</th>
                                    <th class="border-top-0 font-weight-bold small text-uppercase py-3" style="color: #334155; letter-spacing: 0.05em;">Benchmark Level</th>
                                    <th class="border-top-0 font-weight-bold small text-uppercase py-3" style="color: #334155; letter-spacing: 0.05em;">Your Current Level</th>
                                    <th class="border-top-0 font-weight-bold small text-uppercase py-3" style="color: #334155; letter-spacing: 0.05em;">Status</th>
                                    <th class="border-top-0 font-weight-bold small text-uppercase py-3 px-4 text-right" style="color: #334155; letter-spacing: 0.05em;">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${empty skillGap.items}">
                                        <tr>
                                            <td colspan="6" class="text-center py-5" style="color: #64748b;">
                                                <div class="ios-badge ios-badge-gray p-3 mb-2" style="border-radius: var(--ios-radius-full);">
                                                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="8" x2="12" y2="12"></line><line x1="12" y1="16" x2="12.01" y2="16"></line></svg>
                                                </div>
                                                <h3 class="h5 font-weight-bold text-dark mt-2">No benchmark skills configured for this role</h3>
                                                <small class="text-muted">Administrator will seed taxonomy requirements shortly.</small>
                                            </td>
                                        </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach items="${skillGap.items}" var="item">
                                            <tr style="border-bottom: 1px solid #f1f5f9;">
                                                <td class="py-3 px-4" style="vertical-align: middle;">
                                                    <div class="d-flex align-items-center gap-2">
                                                        <span class="font-weight-bold text-dark"><c:out value="${item.skillName}" /></span>
                                                        <c:if test="${item.mandatory}">
                                                            <span class="ios-badge ios-badge-red" style="font-size: 0.7rem; padding: 0.15rem 0.45rem;" title="Mandatory Core Competency">Core</span>
                                                        </c:if>
                                                    </div>
                                                </td>
                                                <td style="vertical-align: middle;">
                                                    <span class="ios-badge ios-badge-gray">
                                                        <c:out value="${item.category.displayName}" />
                                                    </span>
                                                </td>
                                                <td style="vertical-align: middle;">
                                                    <span class="ios-badge ios-badge-blue">
                                                        <c:out value="${item.requiredLevel.displayName}" />
                                                    </span>
                                                </td>
                                                <td style="vertical-align: middle;">
                                                    <c:choose>
                                                        <c:when test="${not empty item.studentLevel}">
                                                            <span class="ios-badge ios-badge-gray font-weight-bold">
                                                                <c:out value="${item.studentLevel.displayName}" />
                                                            </span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="small" style="color: #94a3b8; font-style: italic;">Not Acquired</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td style="vertical-align: middle;">
                                                    <c:choose>
                                                        <c:when test="${item.status == 'MATCHED'}">
                                                            <span class="ios-badge ios-badge-green">
                                                                <svg width="10" height="10" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" aria-hidden="true"><polyline points="20 6 9 17 4 12"></polyline></svg>
                                                                Matched
                                                            </span>
                                                        </c:when>
                                                        <c:when test="${item.status == 'NEEDS_IMPROVEMENT'}">
                                                            <span class="ios-badge ios-badge-orange">
                                                                <svg width="10" height="10" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" aria-hidden="true"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg>
                                                                Needs Improvement
                                                            </span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="ios-badge ios-badge-red">
                                                                <svg width="10" height="10" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" aria-hidden="true"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg>
                                                                Missing
                                                            </span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td class="text-right py-3 px-4" style="vertical-align: middle;">
                                                    <a href="${pageContext.request.contextPath}/app/student/skills" class="btn btn-sm btn-outline-primary d-inline-flex align-items-center" style="border-radius: var(--ios-radius-sm); padding: 0.25rem 0.75rem; font-size: 0.8rem; font-weight: 600;" aria-label="Update skill <c:out value='${item.skillName}' />">
                                                        Update Skill
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jspf" %>
