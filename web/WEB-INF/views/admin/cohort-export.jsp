<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Cohort Placement Readiness Summary" />
<c:set var="activeNav" value="cohort" />
<%@ include file="/WEB-INF/views/common/header.jspf" %>
<%@ include file="/WEB-INF/views/common/navbar.jspf" %>

<div class="container-fluid">
    <div class="row">
        <div class="no-print col-md-3 col-lg-2 p-0">
            <%@ include file="/WEB-INF/views/common/sidebar.jspf" %>
        </div>

        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4 py-4">
            <!-- Top Controls (Hidden on Print) -->
            <div class="ios-dash-header mb-4 no-print">
                <div>
                    <div class="d-flex align-items-center gap-2 mb-1">
                        <span class="ios-badge ios-badge-blue">
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" aria-hidden="true"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path><polyline points="14 2 14 8 20 8"></polyline><line x1="16" y1="13" x2="8" y2="13"></line><line x1="16" y1="17" x2="8" y2="17"></line><polyline points="10 9 9 9 8 9"></polyline></svg>
                            Institutional Reporting
                        </span>
                    </div>
                    <h1 class="h3 font-weight-bold text-gray-800 mb-0" style="letter-spacing: -0.03em;">Institution Cohort Summary</h1>
                    <p class="text-muted small mb-0 mt-1">Official institutional placement readiness &amp; department analytics summary</p>
                </div>
                <div class="d-flex align-items-center gap-2" style="gap: 0.5rem;">
                    <button type="button" class="ios-btn-primary d-inline-flex align-items-center" onclick="window.print()" style="padding: 0.65rem 1.25rem; font-size: 0.875rem;">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="mr-2" aria-hidden="true"><polyline points="6 9 6 2 18 2 18 9"></polyline><path d="M6 18H4a2 2 0 0 1-2-2v-5a2 2 0 0 1 2-2h16a2 2 0 0 1 2 2v5a2 2 0 0 1-2 2h-2"></path><rect x="6" y="14" width="12" height="8"></rect></svg>
                        Print / Save PDF
                    </button>
                    <a href="${pageContext.request.contextPath}/app/admin/dashboard" class="ios-btn-secondary" style="padding: 0.65rem 1.25rem; font-size: 0.875rem;">Back to Dashboard</a>
                </div>
            </div>

            <!-- Single Page Printable Container -->
            <div class="ios-card p-4 p-md-5 mb-5" style="box-shadow: var(--ios-shadow-glass); border-radius: var(--ios-radius-lg);">
                <!-- Card Header -->
                <div class="d-flex justify-content-between align-items-start pb-4 mb-4 border-bottom" style="border-color: #e2e8f0 !important;">
                    <div>
                        <div class="d-flex align-items-center gap-2 mb-2">
                            <span class="ios-badge ios-badge-blue">Placement Readiness Summary</span>
                        </div>
                        <h2 class="h4 font-weight-bold text-dark mb-1" style="letter-spacing: -0.02em;">SkillTrack — Cohort Placement Readiness Summary</h2>
                        <div class="text-muted small">
                            Institutional Aggregation Report &bull; Generated on: <strong class="text-dark"><c:out value="${generatedTimestamp}" /></strong>
                        </div>
                    </div>
                    <div class="text-right">
                        <span class="ios-badge ios-badge-green font-weight-bold" style="font-size: 0.9rem; padding: 0.5rem 1.25rem;">
                            Total Cohort: <c:out value="${summary.totalStudents}" /> Students
                        </span>
                    </div>
                </div>

                <!-- Key Cohort Metrics Row -->
                <div class="row mb-4">
                    <div class="col-md-4 mb-3 mb-md-0">
                        <div class="p-3" style="background: #f8fafc; border: 1px solid #e2e8f0; border-radius: var(--ios-radius-md);">
                            <small class="text-muted text-uppercase font-weight-bold" style="font-size: 0.72rem; letter-spacing: 0.05em;">Cohort Avg Readiness</small>
                            <div class="font-weight-bold text-success my-1" style="font-size: 1.6rem; letter-spacing: -0.02em;">
                                <c:out value="${summary.formattedAvgReadiness}" />%
                            </div>
                            <small class="text-muted d-block">Target role readiness index</small>
                        </div>
                    </div>
                    <div class="col-md-4 mb-3 mb-md-0">
                        <div class="p-3" style="background: #f8fafc; border: 1px solid #e2e8f0; border-radius: var(--ios-radius-md);">
                            <small class="text-muted text-uppercase font-weight-bold" style="font-size: 0.72rem; letter-spacing: 0.05em;">Cohort Avg CGPA</small>
                            <div class="font-weight-bold my-1" style="font-size: 1.6rem; letter-spacing: -0.02em; color: var(--ios-blue);">
                                <c:out value="${summary.formattedAvgCgpa}" /> <span style="font-size: 0.95rem; color: #64748b; font-weight: 500;">/ 10.00</span>
                            </div>
                            <small class="text-muted d-block">Academic performance benchmark</small>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="p-3" style="background: #f8fafc; border: 1px solid #e2e8f0; border-radius: var(--ios-radius-md);">
                            <small class="text-muted text-uppercase font-weight-bold" style="font-size: 0.72rem; letter-spacing: 0.05em;">Portfolio Benchmarks</small>
                            <div class="font-weight-bold text-dark my-1" style="font-size: 1.15rem;">
                                <span style="color: var(--ios-purple);"><c:out value="${summary.formattedAvgDsa}" /></span> DSA &bull; 
                                <span style="color: var(--ios-teal);"><c:out value="${summary.formattedAvgProjects}" /></span> Projects
                            </div>
                            <small class="text-muted d-block"><c:out value="${summary.formattedAvgCerts}" /> Avg Industry Certifications</small>
                        </div>
                    </div>
                </div>

                <!-- Readiness Distribution Matrix -->
                <div class="row mb-4 text-center">
                    <div class="col-md-4 mb-3 mb-md-0">
                        <div class="p-3" style="background: #f0fdf4; border: 1px solid #bbf7d0; border-radius: var(--ios-radius-md);">
                            <span class="ios-badge ios-badge-green font-weight-bold mb-2">Placement Ready (&ge; 75%)</span>
                            <div class="font-weight-bold text-success my-1" style="font-size: 1.75rem;"><c:out value="${summary.highReadinessCount}" /></div>
                            <small class="text-muted">Qualified candidates ready for drive</small>
                        </div>
                    </div>
                    <div class="col-md-4 mb-3 mb-md-0">
                        <div class="p-3" style="background: #fffbeb; border: 1px solid #fde68a; border-radius: var(--ios-radius-md);">
                            <span class="ios-badge ios-badge-orange font-weight-bold mb-2">In Progress (50% - 74%)</span>
                            <div class="font-weight-bold my-1" style="font-size: 1.75rem; color: #b45309;"><c:out value="${summary.mediumReadinessCount}" /></div>
                            <small class="text-muted">Advancing toward target role benchmarks</small>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="p-3" style="background: #fef2f2; border: 1px solid #fecaca; border-radius: var(--ios-radius-md);">
                            <span class="ios-badge ios-badge-red font-weight-bold mb-2">Needs Attention (&lt; 50%)</span>
                            <div class="font-weight-bold text-danger my-1" style="font-size: 1.75rem;"><c:out value="${summary.lowReadinessCount}" /></div>
                            <small class="text-muted">Requires active mentoring &amp; skill build</small>
                        </div>
                    </div>
                </div>

                <!-- Department Summary Table -->
                <div class="mb-4">
                    <div class="d-flex align-items-center justify-content-between mb-2">
                        <h3 class="h6 font-weight-bold text-dark text-uppercase mb-0" style="font-size: 0.85rem; letter-spacing: 0.05em;">
                            Department Readiness Breakdown
                        </h3>
                    </div>
                    <div class="table-responsive" style="border: 1px solid #e2e8f0; border-radius: var(--ios-radius-md); overflow: hidden;">
                        <table class="table table-hover mb-0" style="border-collapse: separate;">
                            <thead class="bg-light">
                                <tr style="border-bottom: 1px solid #e2e8f0;">
                                    <th class="border-top-0 font-weight-bold small text-uppercase py-3 px-4" style="color: #334155; letter-spacing: 0.05em;">Department</th>
                                    <th class="border-top-0 font-weight-bold small text-uppercase py-3" style="color: #334155; letter-spacing: 0.05em;">Enrolled Students</th>
                                    <th class="border-top-0 font-weight-bold small text-uppercase py-3" style="color: #334155; letter-spacing: 0.05em;">Average CGPA</th>
                                    <th class="border-top-0 font-weight-bold small text-uppercase py-3 px-4 text-right" style="color: #334155; letter-spacing: 0.05em;">Average Readiness</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${summary.departmentSummaries}" var="dept">
                                    <tr style="border-bottom: 1px solid #f1f5f9;">
                                        <td class="font-weight-bold text-dark py-3 px-4" style="vertical-align: middle;"><c:out value="${dept.department}" /></td>
                                        <td style="vertical-align: middle;"><c:out value="${dept.studentCount}" /> Students</td>
                                        <td style="vertical-align: middle;"><c:out value="${dept.formattedAvgCgpa}" /></td>
                                        <td class="text-right py-3 px-4 font-weight-bold" style="vertical-align: middle; color: var(--ios-blue);">
                                            <c:out value="${dept.formattedAvgReadiness}" />%
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Top Ready Candidates -->
                <div class="mb-4">
                    <div class="d-flex align-items-center justify-content-between mb-2">
                        <h3 class="h6 font-weight-bold text-dark text-uppercase mb-0" style="font-size: 0.85rem; letter-spacing: 0.05em;">
                            Top Placement-Ready Candidates (${summary.topReadyStudents.size()})
                        </h3>
                    </div>
                    <div class="table-responsive" style="border: 1px solid #e2e8f0; border-radius: var(--ios-radius-md); overflow: hidden;">
                        <table class="table table-hover mb-0" style="border-collapse: separate;">
                            <thead class="bg-light">
                                <tr style="border-bottom: 1px solid #e2e8f0;">
                                    <th class="border-top-0 font-weight-bold small text-uppercase py-3 px-4" style="color: #334155; letter-spacing: 0.05em;">Candidate Name</th>
                                    <th class="border-top-0 font-weight-bold small text-uppercase py-3" style="color: #334155; letter-spacing: 0.05em;">Roll Number</th>
                                    <th class="border-top-0 font-weight-bold small text-uppercase py-3" style="color: #334155; letter-spacing: 0.05em;">Department</th>
                                    <th class="border-top-0 font-weight-bold small text-uppercase py-3" style="color: #334155; letter-spacing: 0.05em;">CGPA</th>
                                    <th class="border-top-0 font-weight-bold small text-uppercase py-3" style="color: #334155; letter-spacing: 0.05em;">Target Role</th>
                                    <th class="border-top-0 font-weight-bold small text-uppercase py-3 px-4 text-right" style="color: #334155; letter-spacing: 0.05em;">Readiness</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${summary.topReadyStudents}" var="cand">
                                    <tr style="border-bottom: 1px solid #f1f5f9;">
                                        <td class="font-weight-bold text-dark py-3 px-4" style="vertical-align: middle;"><c:out value="${cand.student.fullName}" /></td>
                                        <td class="text-muted small" style="vertical-align: middle;"><c:out value="${cand.student.rollNumber}" /></td>
                                        <td style="vertical-align: middle;"><span class="ios-badge ios-badge-gray"><c:out value="${cand.student.department}" /></span></td>
                                        <td class="font-weight-bold" style="vertical-align: middle; color: #334155;"><c:out value="${cand.student.formattedCgpa}" /></td>
                                        <td class="small" style="vertical-align: middle; color: #475569;"><c:out value="${cand.student.targetRoleTitle}" default="General" /></td>
                                        <td class="text-right py-3 px-4 font-weight-bold text-success" style="vertical-align: middle;">
                                            <span class="ios-badge ios-badge-green font-weight-bold"><c:out value="${cand.readinessScore.formattedOverall}" />%</span>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Mandatory Disclaimer -->
                <div class="p-3" style="background: rgba(0, 113, 227, 0.04); border: 1px solid rgba(0, 113, 227, 0.15); border-radius: var(--ios-radius-md); font-size: 0.825rem; color: #475569; line-height: 1.5;">
                    <div class="d-flex align-items-start">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="mr-2 mt-1 text-primary flex-shrink-0" aria-hidden="true"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="16" x2="12" y2="12"></line><line x1="12" y1="8" x2="12.01" y2="8"></line></svg>
                        <div>
                            <strong class="text-dark">Institutional Disclaimer:</strong> <c:out value="${disclaimer}" />
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jspf" %>
