<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Student Directory" />
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
                    <div class="d-flex align-items-center gap-2 mb-1">
                        <span class="ios-badge ios-badge-blue">
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" aria-hidden="true"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path><circle cx="9" cy="7" r="4"></circle><path d="M23 21v-2a4 4 0 0 0-3-3.87"></path><path d="M16 3.13a4 4 0 0 1 0 7.75"></path></svg>
                            Talent Intelligence
                        </span>
                    </div>
                    <h1 class="h3 font-weight-bold text-gray-800 mb-0" style="letter-spacing: -0.03em;">Student Placement Directory</h1>
                    <p class="text-muted small mb-0 mt-1">Search, filter, and inspect verified CS & IT talent across skills, CGPA, graduation batch, and readiness benchmarks</p>
                </div>
                <div>
                    <a href="${pageContext.request.contextPath}/app/admin/cohort-summary" class="ios-btn-secondary" style="padding: 0.6rem 1.25rem; font-size: 0.875rem;">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" aria-hidden="true"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path><polyline points="14 2 14 8 20 8"></polyline><line x1="16" y1="13" x2="8" y2="13"></line><line x1="16" y1="17" x2="8" y2="17"></line></svg>
                        Cohort Summary
                    </a>
                </div>
            </div>

            <!-- Filter Panel -->
            <div class="ios-card p-4 mb-4">
                <form action="${pageContext.request.contextPath}/app/admin/students" method="get">
                    <div class="form-row">
                        <div class="form-group col-md-3 mb-3">
                            <label class="ios-form-label">Search Keyword</label>
                            <input type="text" class="ios-form-control" name="search" value="<c:out value='${directory.searchKeyword}' />" placeholder="Name, Roll No, Email...">
                        </div>
                        <div class="form-group col-md-3 mb-3">
                            <label class="ios-form-label">Department &amp; Degree</label>
                            <select class="ios-form-control" name="department">
                                <option value="">All IT / CS Departments</option>
                                <option value="CSE" ${directory.departmentFilter == 'CSE' ? 'selected' : ''}>Computer Science &amp; Eng (CSE)</option>
                                <option value="IT" ${directory.departmentFilter == 'IT' ? 'selected' : ''}>Information Technology (IT)</option>
                                <option value="AI_ML" ${directory.departmentFilter == 'AI_ML' ? 'selected' : ''}>AI &amp; Machine Learning</option>
                                <option value="AI_DS" ${directory.departmentFilter == 'AI_DS' ? 'selected' : ''}>AI &amp; Data Science</option>
                                <option value="CS_CYBER" ${directory.departmentFilter == 'CS_CYBER' ? 'selected' : ''}>Cyber Security</option>
                                <option value="CS_IOT" ${directory.departmentFilter == 'CS_IOT' ? 'selected' : ''}>IoT &amp; Edge Computing</option>
                                <option value="CS_CLOUD" ${directory.departmentFilter == 'CS_CLOUD' ? 'selected' : ''}>Cloud &amp; Big Data</option>
                                <option value="CSBS" ${directory.departmentFilter == 'CSBS' ? 'selected' : ''}>CS &amp; Business Systems</option>
                                <option value="SE" ${directory.departmentFilter == 'SE' ? 'selected' : ''}>Software Engineering</option>
                                <option value="DATA_SCIENCE" ${directory.departmentFilter == 'DATA_SCIENCE' ? 'selected' : ''}>Data Science &amp; Analytics</option>
                                <option value="MCA" ${directory.departmentFilter == 'MCA' ? 'selected' : ''}>Master of Computer Applications (MCA)</option>
                                <option value="BCA" ${directory.departmentFilter == 'BCA' ? 'selected' : ''}>Bachelor of Computer Applications (BCA)</option>
                                <option value="B_SC_CS_IT" ${directory.departmentFilter == 'B_SC_CS_IT' ? 'selected' : ''}>B.Sc (CS / IT)</option>
                                <option value="OTHER_IT" ${directory.departmentFilter == 'OTHER_IT' ? 'selected' : ''}>Other IT Specialization</option>
                            </select>
                        </div>
                        <div class="form-group col-md-3 mb-3">
                            <label class="ios-form-label">Graduation Batch</label>
                            <input type="number" class="ios-form-control" name="graduationYear" value="<c:out value='${directory.gradYearFilter}' />" placeholder="e.g. 2026">
                        </div>
                        <div class="form-group col-md-3 mb-3">
                            <label class="ios-form-label">Target Career Role</label>
                            <select class="ios-form-control" name="targetRoleId">
                                <option value="">All Target Roles</option>
                                <c:forEach items="${targetRoles}" var="r">
                                    <option value="${r.roleId}" ${directory.targetRoleIdFilter == r.roleId ? 'selected' : ''}>
                                        <c:out value="${r.roleTitle}" />
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group col-md-3 mb-3">
                            <label class="ios-form-label">Minimum CGPA (0 - 10)</label>
                            <input type="number" step="0.1" class="ios-form-control" name="minCgpa" value="<c:out value='${directory.minCgpaFilter}' />" placeholder="e.g. 7.5">
                        </div>
                        <div class="form-group col-md-3 mb-3">
                            <label class="ios-form-label">Min Readiness Index (%)</label>
                            <input type="number" step="1" class="ios-form-control" name="minReadiness" value="<c:out value='${directory.minReadinessFilter}' />" placeholder="e.g. 75">
                        </div>
                        <div class="form-group col-md-3 mb-3">
                            <label class="ios-form-label">Specific Technical Skill</label>
                            <select class="ios-form-control" name="skillId">
                                <option value="">Any Technical Skill</option>
                                <c:forEach items="${skills}" var="sk">
                                    <option value="${sk.skillId}" ${directory.skillIdFilter == sk.skillId ? 'selected' : ''}>
                                        <c:out value="${sk.skillName}" /> (<c:out value="${sk.category.displayName}" />)
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group col-md-3 mb-3">
                            <label class="ios-form-label">Min Proficiency Level</label>
                            <select class="ios-form-control" name="skillLevel">
                                <option value="">Any Level</option>
                                <c:forEach items="${skillLevels}" var="lvl">
                                    <option value="${lvl.name()}" ${directory.skillLevelFilter == lvl.name() ? 'selected' : ''}>
                                        <c:out value="${lvl.displayName}" />
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="d-flex justify-content-between align-items-center pt-3 mt-1 border-top flex-wrap gap-2">
                        <span class="small" style="color: #475569;">
                            Showing <strong><c:out value="${directory.items.size()}" /></strong> of <strong><c:out value="${directory.totalRecords}" /></strong> matching candidates
                        </span>
                        <div class="d-flex gap-2">
                            <a href="${pageContext.request.contextPath}/app/admin/students" class="ios-btn-secondary mr-2" style="padding: 0.5rem 1.15rem; font-size: 0.85rem;">Reset Filters</a>
                            <button type="submit" class="ios-btn-primary" style="padding: 0.5rem 1.35rem; font-size: 0.85rem; box-shadow: 0 4px 12px rgba(0, 113, 227, 0.25);">Apply Filters</button>
                        </div>
                    </div>
                </form>
            </div>

            <!-- Student Directory Table Card -->
            <div class="ios-card mb-4">
                <div class="ios-card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0" style="border-collapse: separate;">
                            <thead class="bg-light">
                                <tr style="border-bottom: 1px solid #e2e8f0;">
                                    <th class="border-top-0 font-weight-bold small text-uppercase py-3 px-4" style="color: #334155; letter-spacing: 0.05em;">Candidate</th>
                                    <th class="border-top-0 font-weight-bold small text-uppercase py-3" style="color: #334155; letter-spacing: 0.05em;">Roll Number</th>
                                    <th class="border-top-0 font-weight-bold small text-uppercase py-3" style="color: #334155; letter-spacing: 0.05em;">Dept &amp; Batch</th>
                                    <th class="border-top-0 font-weight-bold small text-uppercase py-3" style="color: #334155; letter-spacing: 0.05em;">CGPA</th>
                                    <th class="border-top-0 font-weight-bold small text-uppercase py-3" style="color: #334155; letter-spacing: 0.05em;">Target Role</th>
                                    <th class="border-top-0 font-weight-bold small text-uppercase py-3" style="color: #334155; letter-spacing: 0.05em;">Readiness Score</th>
                                    <th class="border-top-0 font-weight-bold small text-uppercase py-3" style="color: #334155; letter-spacing: 0.05em;">Portfolio Assets</th>
                                    <th class="border-top-0 font-weight-bold small text-uppercase py-3 px-4 text-right" style="color: #334155; letter-spacing: 0.05em;">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${empty directory.items}">
                                        <tr>
                                            <td colspan="8" class="text-center py-5" style="color: #64748b;">
                                                <div class="ios-badge ios-badge-gray p-3 mb-2" style="border-radius: var(--ios-radius-full);">
                                                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                                                </div>
                                                <h3 class="h5 font-weight-bold text-dark mt-2">No candidates match the filter criteria</h3>
                                                <small class="text-muted">Try broadening your search parameters or resetting filters.</small>
                                            </td>
                                        </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach items="${directory.items}" var="item">
                                            <tr style="border-bottom: 1px solid #f1f5f9;">
                                                <td class="py-3 px-4" style="vertical-align: middle;">
                                                    <div class="font-weight-bold text-dark"><c:out value="${item.student.fullName}" /></div>
                                                    <small class="text-muted"><c:out value="${item.student.email}" /></small>
                                                </td>
                                                <td style="vertical-align: middle;">
                                                    <code style="background: #f1f5f9; padding: 0.2rem 0.5rem; border-radius: var(--ios-radius-sm); color: var(--ios-text-primary); font-weight: 700; font-family: 'JetBrains Mono', monospace; font-size: 0.85rem;">
                                                        <c:out value="${item.student.rollNumber}" />
                                                    </code>
                                                </td>
                                                <td style="vertical-align: middle;">
                                                    <span class="font-weight-bold text-dark"><c:out value="${item.student.department}" /></span>
                                                    <small class="text-muted d-block">Batch '<c:out value="${item.student.graduationYear % 100}" /></small>
                                                </td>
                                                <td class="font-weight-bold py-3" style="vertical-align: middle; color: var(--ios-text-primary);">
                                                    <c:out value="${item.student.formattedCgpa}" />
                                                </td>
                                                <td style="vertical-align: middle;">
                                                    <span class="ios-badge ios-badge-blue">
                                                        <c:out value="${item.student.targetRoleTitle}" default="Unassigned" />
                                                    </span>
                                                </td>
                                                <td style="min-width: 140px; vertical-align: middle;">
                                                    <div class="d-flex justify-content-between small font-weight-bold mb-1">
                                                        <span style="color: var(--ios-text-primary);"><c:out value="${item.readinessScore.formattedOverall}" />%</span>
                                                        <c:choose>
                                                            <c:when test="${item.readinessScore.overallReadiness >= 75}">
                                                                <span class="ios-badge ios-badge-green" style="font-size: 0.7rem; padding: 0.15rem 0.45rem;">Ready</span>
                                                            </c:when>
                                                            <c:when test="${item.readinessScore.overallReadiness >= 50}">
                                                                <span class="ios-badge ios-badge-orange" style="font-size: 0.7rem; padding: 0.15rem 0.45rem;">In Progress</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="ios-badge ios-badge-red" style="font-size: 0.7rem; padding: 0.15rem 0.45rem;">Early</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                    <div class="ios-progress-thin" style="height: 6px; border-radius: var(--ios-radius-full); background: #f1f5f9; overflow: hidden;">
                                                        <div class="ios-progress-bar" style="width: ${item.readinessScore.overallReadiness}%; background: <c:choose><c:when test='${item.readinessScore.overallReadiness >= 75}'>var(--ios-green)</c:when><c:when test='${item.readinessScore.overallReadiness >= 50}'>var(--ios-orange)</c:when><c:otherwise>var(--ios-red)</c:otherwise></c:choose>; height: 100%; border-radius: var(--ios-radius-full);"></div>
                                                    </div>
                                                </td>
                                                <td class="small" style="color: #475569; vertical-align: middle;">
                                                    <span title="Technical Skills" class="mr-2"><strong>${item.skillsCount}</strong> Skills</span>
                                                    <span title="Projects" class="mr-2">&bull; <strong>${item.projectsCount}</strong> Proj</span>
                                                    <span title="Certifications" class="mr-2">&bull; <strong>${item.certsCount}</strong> Certs</span>
                                                    <span title="DSA Solved">&bull; <strong>${item.dsaSolved}</strong> DSA</span>
                                                </td>
                                                <td class="text-right py-3 px-4" style="vertical-align: middle;">
                                                    <div class="d-flex align-items-center justify-content-end gap-1" style="gap: 0.35rem;">
                                                        <a href="${pageContext.request.contextPath}/app/admin/student-detail?studentId=${item.student.studentId}" class="btn btn-sm btn-outline-primary d-inline-flex align-items-center" style="border-radius: var(--ios-radius-sm); padding: 0.25rem 0.65rem; font-size: 0.8rem; font-weight: 600;" title="Inspect Profile" aria-label="Inspect profile for ${item.student.fullName}">
                                                            Inspect
                                                        </a>
                                                        <a href="${pageContext.request.contextPath}/app/admin/readiness-card?studentId=${item.student.studentId}" class="btn btn-sm btn-outline-secondary d-inline-flex align-items-center" style="border-radius: var(--ios-radius-sm); padding: 0.25rem 0.65rem; font-size: 0.8rem; font-weight: 600;" title="View Official Readiness Card" aria-label="View official card for ${item.student.fullName}">
                                                            Card
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
            </div>

            <%@ include file="/WEB-INF/views/common/pagination.jspf" %>
        </main>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jspf" %>
