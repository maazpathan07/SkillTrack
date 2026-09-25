<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Student Candidate Profile" />
<c:set var="activeNav" value="students" />
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
                    <div class="d-flex align-items-center gap-2 mb-2">
                        <span class="ios-badge ios-badge-blue">
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" aria-hidden="true"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
                            Candidate Profile
                        </span>
                    </div>
                    <h1 class="h3 font-weight-bold text-gray-900 mb-2.5" style="letter-spacing: -0.03em;">
                        <c:out value="${student.fullName}" />
                    </h1>
                    <div class="d-flex align-items-center flex-wrap" style="gap: 0.5rem;">
                        <span class="d-inline-flex align-items-center px-2.5 py-1 rounded-pill" style="background: rgba(241, 245, 249, 0.9); border: 1px solid #e2e8f0; font-size: 0.8125rem;">
                            <span class="text-muted mr-1.5" style="font-weight: 500;">Roll:</span>
                            <strong style="color: var(--ios-text-primary); font-family: 'JetBrains Mono', monospace;"><c:out value="${student.rollNumber}" /></strong>
                        </span>
                        <span class="d-inline-flex align-items-center px-2.5 py-1 rounded-pill" style="background: rgba(241, 245, 249, 0.9); border: 1px solid #e2e8f0; font-size: 0.8125rem;">
                            <span class="text-muted mr-1.5" style="font-weight: 500;">Dept:</span>
                            <strong style="color: var(--ios-text-primary);"><c:out value="${student.department}" /></strong>
                            <span class="text-muted ml-1" style="font-weight: 400;">(Batch '<c:out value="${student.graduationYear % 100}" />)</span>
                        </span>
                        <span class="d-inline-flex align-items-center px-2.5 py-1 rounded-pill" style="background: rgba(0, 113, 227, 0.08); border: 1px solid rgba(0, 113, 227, 0.2); font-size: 0.8125rem;">
                            <span class="mr-1.5" style="color: #0071e3; font-weight: 600;">Target:</span>
                            <strong style="color: #0071e3;"><c:out value="${student.targetRoleTitle}" default="Unassigned" /></strong>
                        </span>
                    </div>
                </div>
                <div class="d-flex align-items-center flex-wrap flex-sm-nowrap gap-2 mt-3 mt-lg-0 w-100 w-lg-auto" style="gap: 0.5rem;">
                    <a href="${pageContext.request.contextPath}/app/admin/readiness-card?studentId=${student.studentId}" class="ios-btn-primary d-inline-flex align-items-center justify-content-center flex-grow-1 flex-sm-grow-0" style="padding: 0.6rem 1.25rem; font-size: 0.875rem; box-shadow: 0 4px 12px rgba(0, 113, 227, 0.25); white-space: nowrap;">
                        <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" class="mr-1.5" aria-hidden="true"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path><polyline points="14 2 14 8 20 8"></polyline><line x1="16" y1="13" x2="8" y2="13"></line><line x1="16" y1="17" x2="8" y2="17"></line></svg>
                        Readiness Card
                    </a>
                    <a href="${pageContext.request.contextPath}/app/admin/students" class="ios-btn-secondary d-inline-flex align-items-center justify-content-center flex-grow-1 flex-sm-grow-0" style="padding: 0.6rem 1.15rem; font-size: 0.875rem; white-space: nowrap;">
                        Back to Directory
                    </a>
                </div>
            </div>

            <!-- Readiness Overview Metric Cards -->
            <div class="row mb-4">
                <div class="col-xl-3 col-md-6 mb-3">
                    <div class="ios-metric-card ios-metric-green h-100">
                        <div class="ios-metric-label" style="color: var(--ios-green-dark);">Overall Readiness</div>
                        <div class="ios-metric-value" style="color: var(--ios-green-dark);"><c:out value="${readiness.formattedOverall}" default="0.0" />%</div>
                        <div class="ios-progress-thin mt-2" style="height: 6px; border-radius: var(--ios-radius-full); background: #f1f5f9; overflow: hidden;">
                            <div class="ios-progress-bar" style="width: ${readiness.overallReadiness}%; background: var(--ios-green); height: 100%; border-radius: var(--ios-radius-full);"></div>
                        </div>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6 mb-3">
                    <div class="ios-metric-card ios-metric-blue h-100">
                        <div class="ios-metric-label" style="color: #005bb5;">Role Skill Match</div>
                        <div class="ios-metric-value" style="color: var(--ios-text-primary);"><c:out value="${readiness.formattedSkill}" default="0.0" />%</div>
                        <small style="color: #475569;"><c:out value="${skillGap.matchedSkillsCount}" default="0" /> / <c:out value="${skillGap.totalRequiredSkills}" default="0" /> benchmark skills</small>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6 mb-3">
                    <div class="ios-metric-card ios-metric-orange h-100">
                        <div class="ios-metric-label" style="color: #c2410c;">DSA Milestones</div>
                        <div class="ios-metric-value" style="color: var(--ios-text-primary);"><c:out value="${readiness.dsaSolved}" default="0" /></div>
                        <small style="color: #475569;"><c:out value="${readiness.formattedDsa}" default="0.0" />% of 150 benchmark</small>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6 mb-3">
                    <div class="ios-metric-card ios-metric-purple h-100">
                        <div class="ios-metric-label" style="color: #7e22ce;">Portfolio Assets</div>
                        <div class="ios-metric-value" style="color: var(--ios-text-primary);"><c:out value="${readiness.projectsCompleted}" default="0" /> Proj / <c:out value="${readiness.certsCompleted}" default="0" /> Certs</div>
                        <small style="color: #475569;">Verified Projects &amp; Credentials</small>
                    </div>
                </div>
            </div>

            <!-- Skills & Skill Gap Breakdown -->
            <div class="row mb-4">
                <div class="col-lg-6 mb-4">
                    <div class="ios-card h-100">
                        <div class="ios-card-header" style="padding: 1.25rem 1.5rem;">
                            <div>
                                <h2 class="h5 font-weight-bold text-dark mb-0" style="font-size: 1.15rem; letter-spacing: -0.02em;">
                                    Acquired Technical Skills (${profile.skills.size()})
                                </h2>
                                <small class="text-muted">Recorded skills &amp; self-assessed proficiency</small>
                            </div>
                            <span class="ios-badge ios-badge-blue font-weight-bold">
                                ${profile.skills.size()} Skills
                            </span>
                        </div>
                        <div class="ios-card-body p-0">
                            <div class="table-responsive">
                                <table class="table table-hover mb-0" style="border-collapse: separate;">
                                    <thead class="bg-light">
                                        <tr style="border-bottom: 1px solid #e2e8f0;">
                                            <th class="border-top-0 font-weight-bold small text-uppercase py-3 px-4" style="color: #334155; letter-spacing: 0.05em;">Skill Name</th>
                                            <th class="border-top-0 font-weight-bold small text-uppercase py-3" style="color: #334155; letter-spacing: 0.05em;">Category</th>
                                            <th class="border-top-0 font-weight-bold small text-uppercase py-3 px-4 text-right" style="color: #334155; letter-spacing: 0.05em;">Proficiency</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:choose>
                                            <c:when test="${empty profile.skills}">
                                                <tr><td colspan="3" class="text-center py-4" style="color: #64748b;">No skills recorded on candidate profile.</td></tr>
                                            </c:when>
                                            <c:otherwise>
                                                <c:forEach items="${profile.skills}" var="sk">
                                                    <tr style="border-bottom: 1px solid #f1f5f9;">
                                                        <td class="font-weight-bold text-dark py-3 px-4" style="vertical-align: middle;"><c:out value="${sk.skillName}" /></td>
                                                        <td style="vertical-align: middle;"><span class="ios-badge ios-badge-gray"><c:out value="${sk.skillCategory.displayName}" /></span></td>
                                                        <td class="text-right py-3 px-4" style="vertical-align: middle;"><span class="ios-badge ios-badge-blue font-weight-bold"><c:out value="${sk.proficiencyLevel.displayName}" /></span></td>
                                                    </tr>
                                                </c:forEach>
                                            </c:otherwise>
                                        </c:choose>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6 mb-4">
                    <div class="ios-card h-100">
                        <div class="ios-card-header" style="padding: 1.25rem 1.5rem;">
                            <div>
                                <h2 class="h5 font-weight-bold text-dark mb-0" style="font-size: 1.15rem; letter-spacing: -0.02em;">
                                    Role Gap vs <c:out value="${skillGap.roleTitle}" default="Target Role" />
                                </h2>
                                <small class="text-muted">Target role competency requirements match</small>
                            </div>
                            <span class="ios-badge ios-badge-blue font-weight-bold">
                                ${skillGap.matchedSkillsCount} / ${skillGap.totalRequiredSkills} Matched
                            </span>
                        </div>
                        <div class="ios-card-body p-0">
                            <div class="table-responsive">
                                <table class="table table-hover mb-0" style="border-collapse: separate;">
                                    <thead class="bg-light">
                                        <tr style="border-bottom: 1px solid #e2e8f0;">
                                            <th class="border-top-0 font-weight-bold small text-uppercase py-3 px-4" style="color: #334155; letter-spacing: 0.05em;">Required Skill</th>
                                            <th class="border-top-0 font-weight-bold small text-uppercase py-3" style="color: #334155; letter-spacing: 0.05em;">Benchmark</th>
                                            <th class="border-top-0 font-weight-bold small text-uppercase py-3 px-4 text-right" style="color: #334155; letter-spacing: 0.05em;">Status</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:choose>
                                            <c:when test="${empty skillGap.items}">
                                                <tr><td colspan="3" class="text-center py-4" style="color: #64748b;">No target role requirements configured.</td></tr>
                                            </c:when>
                                            <c:otherwise>
                                                <c:forEach items="${skillGap.items}" var="item">
                                                    <tr style="border-bottom: 1px solid #f1f5f9;">
                                                        <td class="font-weight-bold text-dark py-3 px-4" style="vertical-align: middle;"><c:out value="${item.skillName}" /></td>
                                                        <td style="vertical-align: middle;"><span class="ios-badge ios-badge-gray"><c:out value="${item.requiredLevel.displayName}" /></span></td>
                                                        <td class="text-right py-3 px-4" style="vertical-align: middle;">
                                                            <c:choose>
                                                                <c:when test="${item.status == 'MATCHED'}">
                                                                    <span class="ios-badge ios-badge-green font-weight-bold">Matched</span>
                                                                </c:when>
                                                                <c:when test="${item.status == 'NEEDS_IMPROVEMENT'}">
                                                                    <span class="ios-badge ios-badge-orange font-weight-bold">Needs Level</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="ios-badge ios-badge-red font-weight-bold">Missing</span>
                                                                </c:otherwise>
                                                            </c:choose>
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
                </div>
            </div>

            <!-- Projects & Certifications Lists -->
            <div class="row">
                <div class="col-lg-6 mb-4">
                    <div class="ios-card h-100">
                        <div class="ios-card-header" style="padding: 1.25rem 1.5rem;">
                            <div>
                                <h2 class="h5 font-weight-bold text-dark mb-0" style="font-size: 1.15rem; letter-spacing: -0.02em;">
                                    Projects Portfolio (${profile.projects.size()})
                                </h2>
                                <small class="text-muted">Software repositories &amp; applications</small>
                            </div>
                            <span class="ios-badge ios-badge-blue font-weight-bold">
                                ${profile.projects.size()} Projects
                            </span>
                        </div>
                        <div class="ios-card-body" style="padding: 1.5rem;">
                            <c:choose>
                                <c:when test="${empty profile.projects}">
                                    <div class="p-4 text-center" style="color: #64748b; background: #f8fafc; border-radius: var(--ios-radius-md);">
                                        No projects added by candidate.
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach items="${profile.projects}" var="p">
                                        <div class="p-3 mb-3" style="background: #f8fafc; border: 1px solid rgba(0,0,0,0.06); border-radius: var(--ios-radius-md);">
                                            <h3 class="h6 font-weight-bold text-dark mb-1" style="font-size: 1rem;"><c:out value="${p.title}" /></h3>
                                            <div class="small mb-2" style="color: #475569;">
                                                <span class="font-weight-bold" style="color: #005bb5;">Stack:</span> <c:out value="${p.techStack}" />
                                            </div>
                                            <p class="small mb-2" style="color: #334155; line-height: 1.5;"><c:out value="${p.description}" /></p>
                                            <div class="d-flex align-items-center gap-2" style="gap: 0.5rem;">
                                                <c:if test="${not empty p.githubUrl}">
                                                    <a href="<c:out value='${p.githubUrl}' />" target="_blank" rel="noopener noreferrer" class="ios-btn-secondary" style="padding: 0.35rem 0.85rem; font-size: 0.775rem;">
                                                        <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="mr-1" aria-hidden="true"><path d="M9 19c-5 1.5-5-2.5-7-3m14 6v-3.87a3.37 3.37 0 0 0-.94-2.61c3.14-.35 6.44-1.54 6.44-7A5.44 5.44 0 0 0 20 4.77 5.07 5.07 0 0 0 19.91 1S18.73.65 16 2.48a13.38 13.38 0 0 0-7 0C6.27.65 5.09 1 5.09 1A5.07 5.07 0 0 0 5 4.77a5.44 5.44 0 0 0-1.5 3.78c0 5.42 3.3 6.61 6.44 7A3.37 3.37 0 0 0 9 18.13V22"></path></svg>
                                                        GitHub
                                                    </a>
                                                </c:if>
                                                <c:if test="${not empty p.liveDemoUrl}">
                                                    <a href="<c:out value='${p.liveDemoUrl}' />" target="_blank" rel="noopener noreferrer" class="ios-btn-secondary" style="padding: 0.35rem 0.85rem; font-size: 0.775rem; color: var(--ios-green-dark) !important;">
                                                        <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="mr-1" aria-hidden="true"><circle cx="12" cy="12" r="10"></circle><line x1="2" y1="12" x2="22" y2="12"></line><path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"></path></svg>
                                                        Live Demo
                                                    </a>
                                                </c:if>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6 mb-4">
                    <div class="ios-card h-100">
                        <div class="ios-card-header" style="padding: 1.25rem 1.5rem;">
                            <div>
                                <h2 class="h5 font-weight-bold text-dark mb-0" style="font-size: 1.15rem; letter-spacing: -0.02em;">
                                    Verified Certifications (${profile.certifications.size()})
                                </h2>
                                <small class="text-muted">Industry recognized credentials</small>
                            </div>
                            <span class="ios-badge ios-badge-green font-weight-bold">
                                ${profile.certifications.size()} Credentials
                            </span>
                        </div>
                        <div class="ios-card-body" style="padding: 1.5rem;">
                            <c:choose>
                                <c:when test="${empty profile.certifications}">
                                    <div class="p-4 text-center" style="color: #64748b; background: #f8fafc; border-radius: var(--ios-radius-md);">
                                        No certifications recorded.
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach items="${profile.certifications}" var="c">
                                        <div class="p-3 mb-3" style="background: #f8fafc; border: 1px solid rgba(0,0,0,0.06); border-radius: var(--ios-radius-md);">
                                            <div class="d-flex justify-content-between align-items-start">
                                                <div>
                                                    <h3 class="h6 font-weight-bold text-dark mb-1" style="font-size: 1rem;"><c:out value="${c.title}" /></h3>
                                                    <div class="small" style="color: #475569;">
                                                        Issuer: <strong style="color: var(--ios-text-primary);"><c:out value="${c.issuingOrg}" /></strong> &bull; Date: <c:out value="${c.formattedIssueDate}" />
                                                    </div>
                                                </div>
                                                <c:if test="${not empty c.credentialUrl}">
                                                    <a href="<c:out value='${c.credentialUrl}' />" target="_blank" rel="noopener noreferrer" class="ios-btn-secondary" style="padding: 0.35rem 0.75rem; font-size: 0.775rem;">
                                                        Verify Link
                                                    </a>
                                                </c:if>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jspf" %>
