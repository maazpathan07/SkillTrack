<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Placement Criteria Profiles" />
<c:set var="activeNav" value="criteria" />
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
                        <span class="ios-badge ios-badge-teal">
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" aria-hidden="true"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path><polyline points="22 4 12 14.01 9 11.01"></polyline></svg>
                            Eligibility Engine
                        </span>
                    </div>
                    <h1 class="h3 font-weight-bold text-gray-800 mb-0" style="letter-spacing: -0.03em;">Placement Criteria Profiles</h1>
                    <p class="text-muted small mb-0 mt-1">Define company &amp; tier-specific eligibility criteria and benchmark skill sets</p>
                </div>
                <div>
                    <span class="ios-badge ios-badge-blue font-weight-bold" style="font-size: 0.85rem; padding: 0.5rem 1rem;">
                        ${criteriaList.size()} Profiles Active
                    </span>
                </div>
            </div>

            <div class="row">
                <!-- Criteria Form -->
                <div class="col-lg-5 mb-4">
                    <div class="ios-card h-100">
                        <div class="ios-card-header" style="padding: 1.25rem 1.5rem;">
                            <div>
                                <h2 class="h5 font-weight-bold text-dark mb-0" style="font-size: 1.15rem; letter-spacing: -0.02em;">
                                    <c:out value="${not empty editCriteria ? 'Edit Criteria Profile' : 'Create Criteria Profile'}" />
                                </h2>
                                <small class="text-muted">Configure eligibility cutoffs and mapped technical prerequisites</small>
                            </div>
                            <c:if test="${not empty editCriteria}">
                                <span class="ios-badge ios-badge-teal">Editing ID: ${editCriteria.criteriaId}</span>
                            </c:if>
                        </div>
                        <div class="ios-card-body" style="padding: 1.5rem;">
                            <form action="${pageContext.request.contextPath}/app/admin/criteria" method="post" class="needs-validation" novalidate>
                                <input type="hidden" name="csrfToken" value="${sessionScope.CSRF_TOKEN}" />
                                <input type="hidden" name="criteriaId" value="<c:out value='${editCriteria.criteriaId}' default='0' />" />

                                <div class="form-group mb-3">
                                    <label for="companyName" class="ios-form-label">Company / Tier Name *</label>
                                    <input type="text" class="ios-form-control" id="companyName" name="companyName" value="<c:out value='${editCriteria.companyName}' />" required placeholder="e.g. Google, Amazon, Tier-1 Product Co.">
                                    <div class="invalid-feedback">Company Name is required.</div>
                                </div>

                                <div class="form-group mb-3">
                                    <label for="roleTitle" class="ios-form-label">Role Title *</label>
                                    <input type="text" class="ios-form-control" id="roleTitle" name="roleTitle" value="<c:out value='${editCriteria.roleTitle}' />" required placeholder="e.g. Software Development Engineer (SDE-1)">
                                    <div class="invalid-feedback">Role Title is required.</div>
                                </div>

                                <div class="form-row mb-3">
                                    <div class="col-md-6 mb-3 mb-md-0">
                                        <label for="minCgpa" class="ios-form-label">Min CGPA</label>
                                        <input type="number" step="0.1" class="ios-form-control" id="minCgpa" name="minCgpa" value="<c:out value='${editCriteria.minCgpa}' default='7.0' />" min="0" max="10">
                                    </div>
                                    <div class="col-md-6">
                                        <label for="minDsaProblems" class="ios-form-label">Min DSA Solved</label>
                                        <input type="number" class="ios-form-control" id="minDsaProblems" name="minDsaProblems" value="<c:out value='${editCriteria.minDsaProblems}' default='100' />" min="0">
                                    </div>
                                </div>

                                <div class="form-row mb-3">
                                    <div class="col-md-6 mb-3 mb-md-0">
                                        <label for="minProjects" class="ios-form-label">Min Projects</label>
                                        <input type="number" class="ios-form-control" id="minProjects" name="minProjects" value="<c:out value='${editCriteria.minProjects}' default='2' />" min="0">
                                    </div>
                                    <div class="col-md-6">
                                        <label for="minCertifications" class="ios-form-label">Min Certifications</label>
                                        <input type="number" class="ios-form-control" id="minCertifications" name="minCertifications" value="<c:out value='${editCriteria.minCertifications}' default='1' />" min="0">
                                    </div>
                                </div>

                                <div class="form-group mb-3">
                                    <label class="ios-form-label">Eligible Departments</label>
                                    <div class="p-3" style="background: #f8fafc; border: 1px solid #e2e8f0; border-radius: var(--ios-radius-md);">
                                        <div class="d-flex flex-wrap gap-2" style="gap: 0.75rem;">
                                            <c:forEach items="${departments}" var="d">
                                                <div class="custom-control custom-checkbox custom-control-inline mr-2 mb-1">
                                                    <input type="checkbox" class="custom-control-input" id="dept_${d.name()}" name="allowedDepartments" value="${d.name()}" 
                                                           ${empty editCriteria || editCriteria.allowedDepartments == 'ALL' || editCriteria.isDepartmentAllowed(d.name()) ? 'checked' : ''}>
                                                    <label class="custom-control-label small font-weight-bold" for="dept_${d.name()}" style="color: var(--ios-text-primary);"><c:out value="${d.name()}" /></label>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group mb-3">
                                    <div class="custom-control custom-checkbox">
                                        <input type="checkbox" class="custom-control-input" id="isActive" name="isActive" value="1" ${empty editCriteria || editCriteria.active ? 'checked' : ''}>
                                        <label class="custom-control-label small font-weight-bold" for="isActive" style="color: var(--ios-text-primary);">Profile is Active (Visible to students in eligibility criteria)</label>
                                    </div>
                                </div>

                                <div class="pt-2 border-top">
                                    <h3 class="h6 font-weight-bold mb-1" style="font-size: 0.875rem; color: #334155;">
                                        Map Required Technical Skills
                                    </h3>
                                    <small class="text-muted d-block mb-2">Configure mandatory skills and minimum proficiency levels</small>

                                    <div style="max-height: 220px; overflow-y: auto; background: #f8fafc; border: 1px solid #e2e8f0; border-radius: var(--ios-radius-md);" class="p-3 mb-3">
                                        <c:forEach items="${allSkills}" var="sk">
                                            <c:set var="isMapped" value="false" />
                                            <c:set var="curProf" value="BEGINNER" />

                                            <c:if test="${not empty editCriteria}">
                                                <c:forEach items="${editCriteria.skillRequirements}" var="req">
                                                    <c:if test="${req.skillId == sk.skillId}">
                                                        <c:set var="isMapped" value="true" />
                                                        <c:set var="curProf" value="${req.minProficiency.name()}" />
                                                    </c:if>
                                                </c:forEach>
                                            </c:if>

                                            <div class="form-row align-items-center mb-2 pb-2 border-bottom" style="border-color: #f1f5f9 !important;">
                                                <div class="col-md-6 mb-1 mb-md-0">
                                                    <div class="custom-control custom-checkbox">
                                                        <input type="checkbox" class="custom-control-input" id="crit_sk_${sk.skillId}" name="selectedSkills" value="${sk.skillId}" ${isMapped ? 'checked' : ''}>
                                                        <label class="custom-control-label small font-weight-bold" for="crit_sk_${sk.skillId}" style="color: var(--ios-text-primary);">
                                                            <c:out value="${sk.skillName}" />
                                                        </label>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <select class="ios-form-control py-1 px-2" name="minProficiency_${sk.skillId}" style="font-size: 0.8rem; height: 32px; border-radius: var(--ios-radius-sm);">
                                                        <c:forEach items="${skillLevels}" var="lvl">
                                                            <option value="${lvl.name()}" ${curProf == lvl.name() ? 'selected' : ''}>
                                                                <c:out value="${lvl.displayName}" />
                                                            </option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>

                                <div class="d-flex justify-content-between align-items-center pt-3 border-top">
                                    <button type="submit" class="ios-btn-primary" style="padding: 0.65rem 1.75rem; font-size: 0.875rem; box-shadow: 0 4px 12px rgba(0, 113, 227, 0.25);">
                                        <c:out value="${not empty editCriteria ? 'Update Criteria' : 'Save Criteria Profile'}" />
                                    </button>
                                    <c:if test="${not empty editCriteria}">
                                        <a href="${pageContext.request.contextPath}/app/admin/criteria" class="ios-btn-secondary" style="padding: 0.65rem 1.25rem; font-size: 0.875rem;">Cancel</a>
                                    </c:if>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Criteria List Table -->
                <div class="col-lg-7 mb-4">
                    <div class="ios-card h-100">
                        <div class="ios-card-header" style="padding: 1.25rem 1.5rem;">
                            <div>
                                <h2 class="h5 font-weight-bold text-dark mb-0" style="font-size: 1.15rem; letter-spacing: -0.02em;">
                                    Configured Placement Criteria (${criteriaList.size()})
                                </h2>
                                <small class="text-muted">Active evaluation benchmarks used by automated placement eligibility checks</small>
                            </div>
                            <span class="ios-badge ios-badge-teal font-weight-bold">
                                ${criteriaList.size()} Profiles
                            </span>
                        </div>
                        <div class="ios-card-body p-0">
                            <div class="table-responsive">
                                <table class="table table-hover mb-0" style="border-collapse: separate;">
                                    <thead class="bg-light">
                                        <tr style="border-bottom: 1px solid #e2e8f0;">
                                            <th class="border-top-0 font-weight-bold small text-uppercase py-3 px-4" style="color: #334155; letter-spacing: 0.05em;">Company &amp; Role</th>
                                            <th class="border-top-0 font-weight-bold small text-uppercase py-3" style="color: #334155; letter-spacing: 0.05em;">Eligibility Benchmarks</th>
                                            <th class="border-top-0 font-weight-bold small text-uppercase py-3" style="color: #334155; letter-spacing: 0.05em;">Status</th>
                                            <th class="border-top-0 font-weight-bold small text-uppercase py-3 px-4 text-right" style="color: #334155; letter-spacing: 0.05em;">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${criteriaList}" var="c">
                                            <tr style="border-bottom: 1px solid #f1f5f9;">
                                                <td class="py-3 px-4" style="vertical-align: middle;">
                                                    <div class="font-weight-bold text-dark" style="font-size: 0.95rem;"><c:out value="${c.companyName}" /></div>
                                                    <div class="text-muted small" style="line-height: 1.4;"><c:out value="${c.roleTitle}" /></div>
                                                </td>
                                                <td class="small text-muted py-3" style="vertical-align: middle; line-height: 1.5;">
                                                    <div class="d-flex flex-wrap align-items-center gap-1" style="gap: 0.35rem;">
                                                        <span class="ios-badge ios-badge-blue" style="font-size: 0.72rem; padding: 0.2rem 0.5rem;">CGPA &ge; <c:out value="${c.formattedMinCgpa}" /></span>
                                                        <span class="ios-badge ios-badge-teal" style="font-size: 0.72rem; padding: 0.2rem 0.5rem;">DSA &ge; <c:out value="${c.minDsaProblems}" /></span>
                                                        <span class="ios-badge ios-badge-purple" style="font-size: 0.72rem; padding: 0.2rem 0.5rem;">Proj &ge; <c:out value="${c.minProjects}" /></span>
                                                    </div>
                                                    <div class="mt-1 small" style="color: #475569;">
                                                        <span class="font-weight-bold">Depts:</span> <code><c:out value="${c.allowedDepartments}" /></code>
                                                    </div>
                                                </td>
                                                <td style="vertical-align: middle;">
                                                    <span class="ios-badge ${c.active ? 'ios-badge-green' : 'ios-badge-gray'} font-weight-bold">
                                                        <c:out value="${c.active ? 'Active' : 'Inactive'}" />
                                                    </span>
                                                </td>
                                                <td class="text-right py-3 px-4" style="vertical-align: middle;">
                                                    <div class="d-flex align-items-center justify-content-end gap-2" style="gap: 0.35rem;">
                                                        <a href="${pageContext.request.contextPath}/app/admin/criteria?criteriaId=${c.criteriaId}" class="btn btn-sm btn-outline-primary d-inline-flex align-items-center" style="border-radius: var(--ios-radius-sm); padding: 0.3rem 0.75rem; font-size: 0.8rem; font-weight: 600;" aria-label="Edit criteria <c:out value='${c.companyName}' />">
                                                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" class="mr-1" aria-hidden="true"><path d="M12 20h9"></path><path d="M16.5 3.5a2.121 2.121 0 0 1 3 3L7 19l-4 1 1-4L16.5 3.5z"></path></svg>
                                                            Edit
                                                        </a>
                                                        <form action="${pageContext.request.contextPath}/app/admin/criteria" method="post" class="d-inline">
                                                            <input type="hidden" name="csrfToken" value="${sessionScope.CSRF_TOKEN}" />
                                                            <input type="hidden" name="action" value="delete" />
                                                            <input type="hidden" name="criteriaId" value="${c.criteriaId}" />
                                                            <button type="submit" class="btn btn-sm btn-outline-danger confirm-delete d-inline-flex align-items-center" style="border-radius: var(--ios-radius-sm); padding: 0.3rem 0.75rem; font-size: 0.8rem; font-weight: 600;" data-confirm="Delete criteria '${c.companyName}'?" aria-label="Delete criteria <c:out value='${c.companyName}' />">
                                                                <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="mr-1" aria-hidden="true">
                                                                    <polyline points="3 6 5 6 21 6"></polyline>
                                                                    <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
                                                                    <line x1="10" y1="11" x2="10" y2="17"></line>
                                                                    <line x1="14" y1="11" x2="14" y2="17"></line>
                                                                </svg>
                                                                Delete
                                                            </button>
                                                        </form>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jspf" %>
