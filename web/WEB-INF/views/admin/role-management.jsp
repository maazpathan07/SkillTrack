<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Target Role Management" />
<c:set var="activeNav" value="roles" />
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
                        <span class="ios-badge ios-badge-orange">
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" aria-hidden="true"><rect x="2" y="7" width="20" height="14" rx="2" ry="2"></rect><path d="M16 21V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v16"></path></svg>
                            Career Matrix
                        </span>
                    </div>
                    <h1 class="h3 font-weight-bold text-gray-800 mb-0" style="letter-spacing: -0.03em;">Target Role Pathways</h1>
                    <p class="text-muted small mb-0 mt-1">Configure standard CS/IT career pathways and map required core benchmark skills</p>
                </div>
                <div>
                    <span class="ios-badge ios-badge-blue font-weight-bold" style="font-size: 0.85rem; padding: 0.5rem 1rem;">
                        ${roles.size()} Pathways Configured
                    </span>
                </div>
            </div>

            <div class="row">
                <!-- Role Form -->
                <div class="col-lg-5 mb-4">
                    <div class="ios-card h-100">
                        <div class="ios-card-header" style="padding: 1.25rem 1.5rem;">
                            <div>
                                <h2 class="h5 font-weight-bold text-dark mb-0" style="font-size: 1.15rem; letter-spacing: -0.02em;">
                                    <c:out value="${not empty editRole ? 'Edit Target Role' : 'Create Target Role'}" />
                                </h2>
                                <small class="text-muted">Define industry pathway &amp; benchmark taxonomy</small>
                            </div>
                            <c:if test="${not empty editRole}">
                                <span class="ios-badge ios-badge-orange">Editing ID: ${editRole.roleId}</span>
                            </c:if>
                        </div>
                        <div class="ios-card-body" style="padding: 1.5rem 1.5rem 1.75rem 1.5rem;">
                            <form action="${pageContext.request.contextPath}/app/admin/roles" method="post" class="needs-validation" novalidate>
                                <input type="hidden" name="csrfToken" value="${sessionScope.CSRF_TOKEN}" />
                                <input type="hidden" name="roleId" value="<c:out value='${editRole.roleId}' default='0' />" />

                                <div class="form-group mb-3">
                                    <label for="roleTitle" class="ios-form-label">Role Title *</label>
                                    <input type="text" class="ios-form-control" id="roleTitle" name="roleTitle" value="<c:out value='${editRole.roleTitle}' />" required placeholder="e.g. Full Stack Java Developer">
                                    <div class="invalid-feedback">Role title is required.</div>
                                </div>

                                <div class="form-group mb-3">
                                    <label for="description" class="ios-form-label">Role Description</label>
                                    <textarea class="ios-form-control" id="description" name="description" rows="2" placeholder="Overview of industry expectations and core tech stacks..."><c:out value="${editRole.description}" /></textarea>
                                </div>

                                <div class="form-group mb-3">
                                    <div class="custom-control custom-checkbox">
                                        <input type="checkbox" class="custom-control-input" id="isActive" name="isActive" value="1" ${empty editRole || editRole.active ? 'checked' : ''}>
                                        <label class="custom-control-label small font-weight-bold" for="isActive" style="color: var(--ios-text-primary);">Role is Active (Visible to students in target selector)</label>
                                    </div>
                                </div>

                                <div class="pt-2 border-top">
                                    <h3 class="h6 font-weight-bold mb-2" style="font-size: 0.875rem; color: #334155;">
                                        Map Benchmark Competencies
                                    </h3>
                                    <small class="text-muted d-block mb-2">Select skills and minimum required proficiency level</small>

                                    <div style="max-height: 240px; overflow-y: auto; background: #f8fafc; border: 1px solid #e2e8f0; border-radius: var(--ios-radius-md);" class="p-3 mb-3">
                                        <c:forEach items="${allSkills}" var="sk">
                                            <c:set var="isMapped" value="false" />
                                            <c:set var="curProf" value="BEGINNER" />
                                            <c:set var="curMandatory" value="false" />

                                            <c:if test="${not empty editRole}">
                                                <c:forEach items="${editRole.requirements}" var="req">
                                                    <c:if test="${req.skillId == sk.skillId}">
                                                        <c:set var="isMapped" value="true" />
                                                        <c:set var="curProf" value="${req.minProficiency.name()}" />
                                                        <c:set var="curMandatory" value="${req.mandatory}" />
                                                    </c:if>
                                                </c:forEach>
                                            </c:if>

                                            <div class="form-row align-items-center mb-2 pb-2 border-bottom" style="border-color: #f1f5f9 !important;">
                                                <div class="col-md-6 mb-1 mb-md-0">
                                                    <div class="custom-control custom-checkbox">
                                                        <input type="checkbox" class="custom-control-input" id="chk_${sk.skillId}" name="selectedSkills" value="${sk.skillId}" ${isMapped ? 'checked' : ''}>
                                                        <label class="custom-control-label small font-weight-bold" for="chk_${sk.skillId}" style="color: var(--ios-text-primary);">
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
                                        <c:out value="${not empty editRole ? 'Update Role' : 'Save Target Role'}" />
                                    </button>
                                    <c:if test="${not empty editRole}">
                                        <a href="${pageContext.request.contextPath}/app/admin/roles" class="ios-btn-secondary" style="padding: 0.65rem 1.25rem; font-size: 0.875rem;">Cancel</a>
                                    </c:if>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Roles Table -->
                <div class="col-lg-7 mb-4">
                    <div class="ios-card h-100">
                        <div class="ios-card-header" style="padding: 1.25rem 1.5rem;">
                            <div>
                                <h2 class="h5 font-weight-bold text-dark mb-0" style="font-size: 1.15rem; letter-spacing: -0.02em;">
                                    Configured Career Pathways (${roles.size()})
                                </h2>
                                <small class="text-muted">Active pathways available for student goal selection</small>
                            </div>
                            <span class="ios-badge ios-badge-blue font-weight-bold">
                                ${roles.size()} Pathways
                            </span>
                        </div>
                        <div class="ios-card-body p-0">
                            <div class="table-responsive">
                                <table class="table table-hover mb-0" style="border-collapse: separate;">
                                    <thead class="bg-light">
                                        <tr style="border-bottom: 1px solid #e2e8f0;">
                                            <th class="border-top-0 font-weight-bold small text-uppercase py-3 px-4" style="color: #334155; letter-spacing: 0.05em;">Role Title &amp; Description</th>
                                            <th class="border-top-0 font-weight-bold small text-uppercase py-3" style="color: #334155; letter-spacing: 0.05em;">Status</th>
                                            <th class="border-top-0 font-weight-bold small text-uppercase py-3 px-4 text-right" style="color: #334155; letter-spacing: 0.05em;">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${roles}" var="r">
                                            <tr style="border-bottom: 1px solid #f1f5f9;">
                                                <td class="py-3 px-4" style="vertical-align: middle;">
                                                    <div class="font-weight-bold text-dark" style="font-size: 0.95rem;"><c:out value="${r.roleTitle}" /></div>
                                                    <small class="text-muted d-block" style="line-height: 1.4;"><c:out value="${r.description}" /></small>
                                                </td>
                                                <td style="vertical-align: middle;">
                                                    <span class="ios-badge ${r.active ? 'ios-badge-green' : 'ios-badge-gray'} font-weight-bold">
                                                        <c:out value="${r.active ? 'Active' : 'Inactive'}" />
                                                    </span>
                                                </td>
                                                <td class="text-right py-3 px-4" style="vertical-align: middle;">
                                                    <div class="d-flex align-items-center justify-content-end gap-2" style="gap: 0.35rem;">
                                                        <a href="${pageContext.request.contextPath}/app/admin/roles?roleId=${r.roleId}" class="btn btn-sm btn-outline-primary d-inline-flex align-items-center" style="border-radius: var(--ios-radius-sm); padding: 0.3rem 0.75rem; font-size: 0.8rem; font-weight: 600;" aria-label="Edit role <c:out value='${r.roleTitle}' />">
                                                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" class="mr-1" aria-hidden="true"><path d="M12 20h9"></path><path d="M16.5 3.5a2.121 2.121 0 0 1 3 3L7 19l-4 1 1-4L16.5 3.5z"></path></svg>
                                                            Edit
                                                        </a>
                                                        <form action="${pageContext.request.contextPath}/app/admin/roles" method="post" class="d-inline">
                                                            <input type="hidden" name="csrfToken" value="${sessionScope.CSRF_TOKEN}" />
                                                            <input type="hidden" name="action" value="delete" />
                                                            <input type="hidden" name="roleId" value="${r.roleId}" />
                                                            <button type="submit" class="btn btn-sm btn-outline-danger confirm-delete d-inline-flex align-items-center" style="border-radius: var(--ios-radius-sm); padding: 0.3rem 0.75rem; font-size: 0.8rem; font-weight: 600;" data-confirm="Delete target role '${r.roleTitle}'?" aria-label="Delete role <c:out value='${r.roleTitle}' />">
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
