<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Master Skills Taxonomy" />
<c:set var="activeNav" value="skills" />
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
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" aria-hidden="true"><polygon points="12 2 2 7 12 12 22 7 12 2"></polygon><polyline points="2 17 12 22 22 17"></polyline><polyline points="2 12 12 17 22 12"></polyline></svg>
                            Taxonomy Engine
                        </span>
                    </div>
                    <h1 class="h3 font-weight-bold text-gray-800 mb-0" style="letter-spacing: -0.03em;">Master Skills Taxonomy</h1>
                    <p class="text-muted small mb-0 mt-1">Manage global programming languages, frameworks, databases, and core CS fundamentals</p>
                </div>
                <div>
                    <span class="ios-badge ios-badge-blue font-weight-bold" style="font-size: 0.85rem; padding: 0.5rem 1rem;">
                        ${skills.size()} Skills Defined
                    </span>
                </div>
            </div>

            <div class="row">
                <!-- Skill Form -->
                <div class="col-lg-4 mb-4">
                    <div class="ios-card h-100">
                        <div class="ios-card-header" style="padding: 1.25rem 1.5rem;">
                            <div>
                                <h2 class="h5 font-weight-bold text-dark mb-0" style="font-size: 1.15rem; letter-spacing: -0.02em;">
                                    <c:out value="${not empty editSkill ? 'Edit Master Skill' : 'Create Master Skill'}" />
                                </h2>
                                <small class="text-muted">Define skill parameters and technical classification</small>
                            </div>
                            <c:if test="${not empty editSkill}">
                                <span class="ios-badge ios-badge-purple">Editing ID: ${editSkill.skillId}</span>
                            </c:if>
                        </div>
                        <div class="ios-card-body" style="padding: 1.5rem;">
                            <form action="${pageContext.request.contextPath}/app/admin/skills" method="post" class="needs-validation" novalidate>
                                <input type="hidden" name="csrfToken" value="${sessionScope.CSRF_TOKEN}" />
                                <input type="hidden" name="skillId" value="<c:out value='${editSkill.skillId}' default='0' />" />

                                <div class="form-group mb-3">
                                    <label for="skillName" class="ios-form-label">Skill Name *</label>
                                    <input type="text" class="ios-form-control" id="skillName" name="skillName" value="<c:out value='${editSkill.skillName}' />" required placeholder="e.g. Spring Boot, Docker, Redis">
                                    <div class="invalid-feedback">Skill name is required.</div>
                                </div>

                                <div class="form-group mb-3">
                                    <label for="category" class="ios-form-label">Taxonomy Category *</label>
                                    <select class="ios-form-control" id="category" name="category" required>
                                        <option value="">Select Category...</option>
                                        <c:forEach items="${categories}" var="cat">
                                            <option value="${cat.name()}" ${editSkill.category == cat ? 'selected' : ''}>
                                                <c:out value="${cat.displayName}" />
                                            </option>
                                        </c:forEach>
                                    </select>
                                    <div class="invalid-feedback">Category is required.</div>
                                </div>

                                <div class="form-group mb-3">
                                    <label for="description" class="ios-form-label">Description &amp; Concepts Covered</label>
                                    <textarea class="ios-form-control" id="description" name="description" rows="3" placeholder="Overview of key frameworks, tools, and technical concepts..."><c:out value="${editSkill.description}" /></textarea>
                                </div>

                                <div class="d-flex justify-content-between align-items-center pt-3 border-top">
                                    <button type="submit" class="ios-btn-primary" style="padding: 0.65rem 1.75rem; font-size: 0.875rem; box-shadow: 0 4px 12px rgba(0, 113, 227, 0.25);">
                                        <c:out value="${not empty editSkill ? 'Update Skill' : 'Save Master Skill'}" />
                                    </button>
                                    <c:if test="${not empty editSkill}">
                                        <a href="${pageContext.request.contextPath}/app/admin/skills" class="ios-btn-secondary" style="padding: 0.65rem 1.25rem; font-size: 0.875rem;">Cancel</a>
                                    </c:if>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Skills Table -->
                <div class="col-lg-8 mb-4">
                    <div class="ios-card h-100">
                        <div class="ios-card-header" style="padding: 1.25rem 1.5rem;">
                            <div>
                                <h2 class="h5 font-weight-bold text-dark mb-0" style="font-size: 1.15rem; letter-spacing: -0.02em;">
                                    Registered Master Skills (${skills.size()})
                                </h2>
                                <small class="text-muted">Global skills available across student profiles and role benchmarks</small>
                            </div>
                            <span class="ios-badge ios-badge-purple font-weight-bold">
                                ${skills.size()} Skills Active
                            </span>
                        </div>
                        <div class="ios-card-body p-0">
                            <div class="table-responsive">
                                <table class="table table-hover mb-0" style="border-collapse: separate;">
                                    <thead class="bg-light">
                                        <tr style="border-bottom: 1px solid #e2e8f0;">
                                            <th class="border-top-0 font-weight-bold small text-uppercase py-3 px-4" style="color: #334155; letter-spacing: 0.05em;">Skill Name</th>
                                            <th class="border-top-0 font-weight-bold small text-uppercase py-3" style="color: #334155; letter-spacing: 0.05em;">Category</th>
                                            <th class="border-top-0 font-weight-bold small text-uppercase py-3" style="color: #334155; letter-spacing: 0.05em;">Description</th>
                                            <th class="border-top-0 font-weight-bold small text-uppercase py-3 px-4 text-right" style="color: #334155; letter-spacing: 0.05em;">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${skills}" var="sk">
                                            <tr style="border-bottom: 1px solid #f1f5f9;">
                                                <td class="font-weight-bold text-dark py-3 px-4" style="vertical-align: middle;">
                                                    <div class="d-flex align-items-center">
                                                        <div class="st-avatar-xs mr-2" style="background: rgba(0, 113, 227, 0.1); color: var(--ios-blue); border-radius: var(--ios-radius-sm); width: 28px; height: 28px; display: inline-flex; align-items: center; justify-content: center; font-weight: 700; font-size: 0.75rem;" aria-hidden="true">
                                                            <c:out value="${sk.skillName.substring(0, 1)}" />
                                                        </div>
                                                        <span><c:out value="${sk.skillName}" /></span>
                                                    </div>
                                                </td>
                                                <td style="vertical-align: middle;">
                                                    <span class="ios-badge ios-badge-purple font-weight-bold">
                                                        <c:out value="${sk.category.displayName}" />
                                                    </span>
                                                </td>
                                                <td class="small text-muted py-3" style="vertical-align: middle; max-width: 260px; line-height: 1.4;">
                                                    <c:out value="${sk.description}" />
                                                </td>
                                                <td class="text-right py-3 px-4" style="vertical-align: middle;">
                                                    <div class="d-flex align-items-center justify-content-end gap-2" style="gap: 0.35rem;">
                                                        <a href="${pageContext.request.contextPath}/app/admin/skills?skillId=${sk.skillId}" class="btn btn-sm btn-outline-primary d-inline-flex align-items-center" style="border-radius: var(--ios-radius-sm); padding: 0.3rem 0.75rem; font-size: 0.8rem; font-weight: 600;" aria-label="Edit skill <c:out value='${sk.skillName}' />">
                                                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" class="mr-1" aria-hidden="true"><path d="M12 20h9"></path><path d="M16.5 3.5a2.121 2.121 0 0 1 3 3L7 19l-4 1 1-4L16.5 3.5z"></path></svg>
                                                            Edit
                                                        </a>
                                                        <form action="${pageContext.request.contextPath}/app/admin/skills" method="post" class="d-inline">
                                                            <input type="hidden" name="csrfToken" value="${sessionScope.CSRF_TOKEN}" />
                                                            <input type="hidden" name="action" value="delete" />
                                                            <input type="hidden" name="skillId" value="${sk.skillId}" />
                                                            <button type="submit" class="btn btn-sm btn-outline-danger confirm-delete d-inline-flex align-items-center" style="border-radius: var(--ios-radius-sm); padding: 0.3rem 0.75rem; font-size: 0.8rem; font-weight: 600;" data-confirm="Delete master skill '${sk.skillName}'?" aria-label="Delete skill <c:out value='${sk.skillName}' />">
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
