<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Placement Readiness Profile Card" />
<c:set var="activeNav" value="readiness-card" />
<%@ include file="/WEB-INF/views/common/header.jspf" %>
<%@ include file="/WEB-INF/views/common/navbar.jspf" %>

<div class="container-fluid">
    <div class="row">
        <div class="no-print col-md-3 col-lg-2 p-0">
            <%@ include file="/WEB-INF/views/common/sidebar.jspf" %>
        </div>

        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4 py-4">
            <!-- Top Controls (Hidden on Print) -->
            <div class="ios-dash-header no-print">
                <div>
                    <div class="d-flex align-items-center gap-2 mb-1">
                        <span class="ios-badge ios-badge-blue">
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path><polyline points="14 2 14 8 20 8"></polyline><line x1="16" y1="13" x2="8" y2="13"></line><line x1="16" y1="17" x2="8" y2="17"></line><polyline points="10 9 9 9 8 9"></polyline></svg>
                            Placement Readiness Card
                        </span>
                    </div>
                    <h2 class="h3 font-weight-bold text-gray-800 mb-0">Placement Readiness Profile Card</h2>
                    <p class="text-muted small mb-0 mt-1">Verified candidate placement readiness card and multi-pillar benchmark audit</p>
                </div>
                <div class="d-flex align-items-center flex-wrap flex-sm-nowrap gap-2 mt-3 mt-lg-0 w-100 w-lg-auto" style="gap: 0.5rem;">
                    <c:choose>
                        <c:when test="${sessionScope.SESSION_USER_ROLE == 'ADMIN'}">
                            <a href="${pageContext.request.contextPath}/app/admin/students" class="ios-btn-secondary d-inline-flex align-items-center justify-content-center flex-grow-1 flex-sm-grow-0" style="padding: 0.6rem 1.15rem; font-size: 0.875rem; white-space: nowrap;">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" class="mr-1.5"><polyline points="15 18 9 12 15 6"></polyline></svg>
                                Back to Directory
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/app/student/dashboard" class="ios-btn-secondary d-inline-flex align-items-center justify-content-center flex-grow-1 flex-sm-grow-0" style="padding: 0.6rem 1.15rem; font-size: 0.875rem; white-space: nowrap;">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" class="mr-1.5"><polyline points="15 18 9 12 15 6"></polyline></svg>
                                Back to Dashboard
                            </a>
                        </c:otherwise>
                    </c:choose>
                    <button type="button" class="ios-btn-primary d-inline-flex align-items-center justify-content-center flex-grow-1 flex-sm-grow-0" style="padding: 0.6rem 1.25rem; font-size: 0.875rem; white-space: nowrap;" onclick="window.print()">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" class="mr-1.5"><polyline points="6 9 6 2 18 2 18 9"></polyline><path d="M6 18H4a2 2 0 0 1-2-2v-5a2 2 0 0 1 2-2h16a2 2 0 0 1 2 2v5a2 2 0 0 1-2 2h-2"></path><rect x="6" y="14" width="12" height="8"></rect></svg>
                        Print / Save as PDF
                    </button>
                </div>
            </div>

            <!-- Single Page Printable Dossier Card -->
            <div class="ios-dossier-card">
                <!-- Dossier Card Header -->
                <div class="ios-dossier-header">
                    <div>
                        <div class="ios-dossier-brand-title">
                            <div class="ios-brand-icon flex-shrink-0" style="width: 32px; height: 32px; border-radius: 8px;">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M12 2L2 7l10 5 10-5-10-5zM2 17l10 5 10-5M2 12l10 5 10-5"/></svg>
                            </div>
                            <span>SkillTrack — Placement Readiness Profile</span>
                        </div>
                        <div class="text-muted small mt-1">
                            Candidate Assessment Report &bull; Generated: <strong><c:out value="${generatedTimestamp}" /></strong>
                        </div>
                    </div>
                    <div class="dossier-role-target">
                        <span class="ios-badge ios-badge-blue" style="font-size: 0.875rem; padding: 0.45rem 0.9rem;">
                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" class="mr-1 flex-shrink-0"><circle cx="12" cy="12" r="10"></circle><circle cx="12" cy="12" r="6"></circle><circle cx="12" cy="12" r="2"></circle></svg>
                            <c:out value="${student.targetRoleTitle}" default="General Software Engineering" />
                        </span>
                    </div>
                </div>

                <!-- Student Identity & Academic Profile Grid -->
                <div class="ios-dossier-meta-grid">
                    <div class="ios-dossier-meta-item">
                        <small>Candidate Identity</small>
                        <div class="meta-value"><c:out value="${student.fullName}" /></div>
                        <div class="meta-sub"><c:out value="${student.email}" /></div>
                    </div>
                    <div class="ios-dossier-meta-item">
                        <small>Roll / Registration No.</small>
                        <div class="meta-value"><c:out value="${student.rollNumber}" /></div>
                        <div class="meta-sub">Graduation Batch: <strong>Class of <c:out value="${student.graduationYear}" /></strong></div>
                    </div>
                    <div class="ios-dossier-meta-item">
                        <small>Degree & Department</small>
                        <div class="meta-value"><c:out value="${student.department}" /></div>
                        <div class="meta-sub">Field: <strong>Information Technology</strong></div>
                    </div>
                    <div class="ios-dossier-meta-item">
                        <small>Academic Performance</small>
                        <div class="meta-value" style="color: var(--ios-blue);"><c:out value="${student.formattedCgpa}" /> / 10.00</div>
                        <div class="meta-sub">Cumulative Grade Point</div>
                    </div>
                </div>

                <!-- Readiness Gauge & 5-Pillar Matrix -->
                <div class="row align-items-stretch mb-4">
                    <div class="col-lg-4 col-md-5 mb-3 mb-md-0">
                        <div class="ios-dossier-gauge-card">
                            <div class="ios-dossier-score-ring" style="--score-pct: ${readiness.overallReadiness};">
                                <span class="ios-dossier-score-val"><c:out value="${readiness.formattedOverall}" />%</span>
                            </div>
                            <h5 class="font-weight-bold mb-1" style="font-size: 1.05rem;">Overall Readiness Index</h5>
                            <p class="text-muted small mb-2">Deterministic 5-Pillar Weighted Score</p>
                            <div>
                                <c:choose>
                                    <c:when test="${readiness.overallReadiness >= 75.0}">
                                        <span class="ios-badge ios-badge-green" style="font-size: 0.825rem; padding: 0.4rem 0.9rem;">
                                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="20 6 9 17 4 12"></polyline></svg>
                                            Placement Ready
                                        </span>
                                    </c:when>
                                    <c:when test="${readiness.overallReadiness >= 50.0}">
                                        <span class="ios-badge ios-badge-orange" style="font-size: 0.825rem; padding: 0.4rem 0.9rem;">
                                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg>
                                            Intermediate Preparation
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="ios-badge ios-badge-blue" style="font-size: 0.825rem; padding: 0.4rem 0.9rem;">
                                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="16" x2="12" y2="12"></line><line x1="12" y1="8" x2="12.01" y2="8"></line></svg>
                                            Early Stage Preparation
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-8 col-md-7">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <h6 class="font-weight-bold text-muted text-uppercase mb-0" style="font-size: 0.775rem; letter-spacing: 0.06em;">
                                Deterministic Benchmark Breakdown
                            </h6>
                            <span class="text-muted small">Standard Target Formula</span>
                        </div>
                        <div class="table-responsive">
                            <table class="ios-dossier-table">
                                <thead>
                                    <tr>
                                        <th>Metric Pillar</th>
                                        <th>Candidate Value</th>
                                        <th>Target Benchmark</th>
                                        <th>Weight</th>
                                        <th class="text-right">Score</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>
                                            <div class="d-flex align-items-center gap-2">
                                                <div class="ios-badge ios-badge-blue p-1"><svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="16 18 22 12 16 6"></polyline><polyline points="8 6 2 12 8 18"></polyline></svg></div>
                                                <span class="font-weight-bold">Role Skill Match</span>
                                            </div>
                                        </td>
                                        <td><c:out value="${skillGap.matchedSkillsCount}" /> / <c:out value="${skillGap.totalRequiredSkills}" /> skills</td>
                                        <td>100% Taxonomy</td>
                                        <td><c:out value="${readiness.weightSkills * 100}" />%</td>
                                        <td class="text-right font-weight-bold text-primary"><c:out value="${readiness.formattedSkill}" />%</td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="d-flex align-items-center gap-2">
                                                <div class="ios-badge ios-badge-orange p-1"><svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"></polyline></svg></div>
                                                <span class="font-weight-bold">DSA Problem Solving</span>
                                            </div>
                                        </td>
                                        <td><c:out value="${readiness.dsaSolved}" /> problems</td>
                                        <td><c:out value="${readiness.dsaBenchmark}" /> problems</td>
                                        <td><c:out value="${readiness.weightDsa * 100}" />%</td>
                                        <td class="text-right font-weight-bold text-warning"><c:out value="${readiness.formattedDsa}" />%</td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="d-flex align-items-center gap-2">
                                                <div class="ios-badge ios-badge-blue p-1"><svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M22 19a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h5l2 3h9a2 2 0 0 1 2 2z"></path></svg></div>
                                                <span class="font-weight-bold">Portfolio Projects</span>
                                            </div>
                                        </td>
                                        <td><c:out value="${readiness.projectsCompleted}" /> projects</td>
                                        <td><c:out value="${readiness.projectBenchmark}" /> full-stack apps</td>
                                        <td><c:out value="${readiness.weightProjects * 100}" />%</td>
                                        <td class="text-right font-weight-bold text-info"><c:out value="${readiness.formattedProject}" />%</td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="d-flex align-items-center gap-2">
                                                <div class="ios-badge ios-badge-green p-1"><svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><circle cx="12" cy="8" r="7"></circle><polyline points="8.21 13.89 7 23 12 20 17 23 15.79 13.88"></polyline></svg></div>
                                                <span class="font-weight-bold">Verified Certifications</span>
                                            </div>
                                        </td>
                                        <td><c:out value="${readiness.certsCompleted}" /> certifications</td>
                                        <td><c:out value="${readiness.certBenchmark}" /> credentials</td>
                                        <td><c:out value="${readiness.weightCerts * 100}" />%</td>
                                        <td class="text-right font-weight-bold text-success"><c:out value="${readiness.formattedCert}" />%</td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="d-flex align-items-center gap-2">
                                                <div class="ios-badge ios-badge-gray p-1"><svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="9 11 12 14 22 4"></polyline><path d="M21 12v7a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11"></path></svg></div>
                                                <span class="font-weight-bold">Action Tasks Roadmap</span>
                                            </div>
                                        </td>
                                        <td><c:out value="${readiness.tasksCompleted}" /> / <c:out value="${readiness.totalTasks}" /> completed</td>
                                        <td>All Assigned Tasks</td>
                                        <td><c:out value="${readiness.weightTasks * 100}" />%</td>
                                        <td class="text-right font-weight-bold text-secondary"><c:out value="${readiness.formattedTask}" />%</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <!-- Verified Technical Skills Taxonomy -->
                <div class="mb-4">
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <h6 class="font-weight-bold text-muted text-uppercase mb-0" style="font-size: 0.775rem; letter-spacing: 0.06em;">
                            Verified Technical Skills & Competencies (${profile.skills.size()})
                        </h6>
                        <span class="text-muted small">Validated Inventory</span>
                    </div>
                    <div class="p-3 bg-light rounded" style="border: 1px solid #e2e8f0;">
                        <c:choose>
                            <c:when test="${empty profile.skills}">
                                <span class="text-muted small">No technical skills recorded.</span>
                            </c:when>
                            <c:otherwise>
                                <div class="d-flex flex-wrap gap-1">
                                    <c:forEach items="${profile.skills}" var="sk">
                                        <div class="ios-dossier-skill-badge">
                                            <span><c:out value="${sk.skillName}" /></span>
                                            <span class="prof-level"><c:out value="${sk.proficiencyLevel.displayName}" /></span>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Projects & Certifications Side-by-Side -->
                <div class="row mb-3">
                    <div class="col-md-6 mb-3 mb-md-0">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <h6 class="font-weight-bold text-muted text-uppercase mb-0" style="font-size: 0.775rem; letter-spacing: 0.06em;">
                                Portfolio Projects (${profile.projects.size()})
                            </h6>
                        </div>
                        <c:choose>
                            <c:when test="${empty profile.projects}">
                                <div class="p-3 text-muted small bg-light rounded border">No projects listed.</div>
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${profile.projects}" var="pj">
                                    <div class="ios-dossier-item">
                                        <div class="d-flex justify-content-between align-items-start">
                                            <strong class="text-dark font-weight-bold"><c:out value="${pj.title}" /></strong>
                                            <c:if test="${not empty pj.githubUrl}">
                                                <a href="<c:out value='${pj.githubUrl}' />" target="_blank" rel="noopener noreferrer" class="text-muted" title="View Source">
                                                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M18 13v6a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h6"></path><polyline points="15 3 21 3 21 9"></polyline><line x1="10" y1="14" x2="21" y2="3"></line></svg>
                                                </a>
                                            </c:if>
                                        </div>
                                        <div class="text-muted small mt-1"><c:out value="${pj.techStack}" /></div>
                                        <c:if test="${not empty pj.description}">
                                            <div class="text-secondary small mt-1" style="font-size: 0.785rem;"><c:out value="${pj.description}" /></div>
                                        </c:if>
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="col-md-6">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <h6 class="font-weight-bold text-muted text-uppercase mb-0" style="font-size: 0.775rem; letter-spacing: 0.06em;">
                                Industry Certifications (${profile.certifications.size()})
                            </h6>
                        </div>
                        <c:choose>
                            <c:when test="${empty profile.certifications}">
                                <div class="p-3 text-muted small bg-light rounded border">No certifications recorded.</div>
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${profile.certifications}" var="ct">
                                    <div class="ios-dossier-item">
                                        <strong class="text-dark font-weight-bold"><c:out value="${ct.title}" /></strong>
                                        <div class="text-muted small mt-1">
                                            <c:out value="${ct.issuingOrg}" /> &bull; Issued: <c:out value="${ct.formattedIssueDate}" />
                                        </div>
                                        <c:if test="${not empty ct.credentialId}">
                                            <div class="text-secondary small mt-1 font-monospace" style="font-size: 0.75rem;">
                                                Credential ID: <c:out value="${ct.credentialId}" />
                                            </div>
                                        </c:if>
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Official Footer & Verification Seal -->
                <div class="ios-dossier-footer">
                    <div class="ios-dossier-disclaimer flex-grow-1 mr-3">
                        <strong>Official Notice:</strong> <c:out value="${disclaimer}" />
                    </div>
                    <div class="ios-dossier-seal">
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path><polyline points="9 12 11 14 15 10"></polyline></svg>
                        <span>Verified by SkillTrack Engine</span>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jspf" %>
