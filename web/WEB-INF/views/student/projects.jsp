<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Project Portfolio" />
<c:set var="activeNav" value="projects" />
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
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" aria-hidden="true"><path d="M22 19a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h5l2 3h9a2 2 0 0 1 2 2z"></path></svg>
                            Engineering Portfolio
                        </span>
                    </div>
                    <h1 class="h3 font-weight-bold text-gray-800 mb-0" style="letter-spacing: -0.03em;">Software Projects Portfolio</h1>
                    <p class="text-muted small mb-0 mt-1">Showcase your real-world software engineering, architecture, and live full-stack deployments</p>
                </div>
                <div>
                    <span class="ios-badge ios-badge-green" style="font-size: 0.85rem; padding: 0.5rem 1rem;">
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" aria-hidden="true"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg>
                        Benchmark: 3 Projects
                    </span>
                </div>
            </div>

            <div class="row">
                <!-- Project Add/Edit Form -->
                <div class="col-lg-5 mb-4">
                    <div class="ios-card h-100">
                        <div class="ios-card-header" style="padding: 1.25rem 1.5rem;">
                            <div>
                                <h2 class="h5 font-weight-bold text-dark mb-0" style="font-size: 1.15rem; letter-spacing: -0.02em;">
                                    <c:out value="${not empty editProject ? 'Edit Project' : 'Add New Project'}" />
                                </h2>
                                <small class="text-muted">
                                    <c:out value="${not empty editProject ? 'Update repository & deployment specs' : 'Publish software engineering work'}" />
                                </small>
                            </div>
                            <c:if test="${not empty editProject}">
                                <span class="ios-badge ios-badge-orange">Editing ID: ${editProject.projectId}</span>
                            </c:if>
                        </div>
                        <div class="ios-card-body" style="padding: 1.5rem 1.5rem 1.75rem 1.5rem;">
                            <form action="${pageContext.request.contextPath}/app/student/projects" method="post" class="needs-validation" novalidate>
                                <input type="hidden" name="csrfToken" value="${sessionScope.CSRF_TOKEN}" />
                                <input type="hidden" name="projectId" value="<c:out value='${editProject.projectId}' default='0' />" />

                                <div class="form-group mb-3">
                                    <label for="title" class="ios-form-label">Project Title *</label>
                                    <input type="text" class="ios-form-control" id="title" name="title" value="<c:out value='${editProject.title}' />" required placeholder="e.g. Distributed Payment Gateway & Microservices">
                                    <div class="invalid-feedback">Project title is required.</div>
                                </div>

                                <div class="form-group mb-3">
                                    <label for="techStack" class="ios-form-label">Tech Stack (comma-separated) *</label>
                                    <input type="text" class="ios-form-control" id="techStack" name="techStack" value="<c:out value='${editProject.techStack}' />" required placeholder="Java, Spring Boot, MySQL, Docker, Redis">
                                    <div class="invalid-feedback">Tech Stack is required.</div>
                                </div>

                                <div class="form-group mb-3">
                                    <label for="description" class="ios-form-label">Description & Architecture Highlights *</label>
                                    <textarea class="ios-form-control" id="description" name="description" rows="4" required placeholder="Engineered microservices backend handling authentication, asynchronous queue processing, and transaction rollback..."><c:out value="${editProject.description}" /></textarea>
                                    <div class="invalid-feedback">Description is required.</div>
                                </div>

                                <div class="form-group mb-3">
                                    <label for="githubUrl" class="ios-form-label">GitHub Repository URL</label>
                                    <div class="position-relative">
                                        <input type="url" class="ios-form-control" id="githubUrl" name="githubUrl" value="<c:out value='${editProject.githubUrl}' />" placeholder="https://github.com/username/project">
                                        <span class="position-absolute" style="right: 12px; top: 12px; color: var(--ios-text-tertiary);">
                                            <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true"><path d="M9 19c-5 1.5-5-2.5-7-3m14 6v-3.87a3.37 3.37 0 0 0-.94-2.61c3.14-.35 6.44-1.54 6.44-7A5.44 5.44 0 0 0 20 4.77 5.07 5.07 0 0 0 19.91 1S18.73.65 16 2.48a13.38 13.38 0 0 0-7 0C6.27.65 5.09 1 5.09 1A5.07 5.07 0 0 0 5 4.77a5.44 5.44 0 0 0-1.5 3.78c0 5.42 3.3 6.61 6.44 7A3.37 3.37 0 0 0 9 18.13V22"></path></svg>
                                        </span>
                                    </div>
                                </div>

                                <div class="form-group mb-4">
                                    <label for="liveDemoUrl" class="ios-form-label">Live Deployment / Demo URL</label>
                                    <div class="position-relative">
                                        <input type="url" class="ios-form-control" id="liveDemoUrl" name="liveDemoUrl" value="<c:out value='${editProject.liveDemoUrl}' />" placeholder="https://project.vercel.app">
                                        <span class="position-absolute" style="right: 12px; top: 12px; color: var(--ios-text-tertiary);">
                                            <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true"><circle cx="12" cy="12" r="10"></circle><line x1="2" y1="12" x2="22" y2="12"></line><path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"></path></svg>
                                        </span>
                                    </div>
                                </div>

                                <div class="d-flex justify-content-between align-items-center pt-3 mt-2 border-top">
                                    <c:choose>
                                        <c:when test="${not empty editProject}">
                                            <a href="${pageContext.request.contextPath}/app/student/projects" class="ios-btn-secondary" style="padding: 0.65rem 1.25rem; font-size: 0.875rem;">Cancel</a>
                                            <button type="submit" class="ios-btn-primary" style="padding: 0.65rem 1.5rem; font-size: 0.875rem;">
                                                <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" aria-hidden="true"><polyline points="20 6 9 17 4 12"></polyline></svg>
                                                Update Project
                                            </button>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="small" style="color: #475569; font-weight: 600;">20% of Placement Score</div>
                                            <button type="submit" class="ios-btn-primary" style="padding: 0.65rem 1.75rem; font-size: 0.875rem;">
                                                <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" aria-hidden="true"><line x1="12" y1="5" x2="12" y2="19"></line><line x1="5" y1="12" x2="19" y2="12"></line></svg>
                                                Save Project
                                            </button>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Projects Showcase List -->
                <div class="col-lg-7 mb-4">
                    <div class="ios-card h-100">
                        <div class="ios-card-header" style="padding: 1.25rem 1.5rem;">
                            <div>
                                <h2 class="h5 font-weight-bold text-dark mb-0" style="font-size: 1.15rem; letter-spacing: -0.02em;">
                                    Engineering Showcase (${projects.size()})
                                </h2>
                                <small class="text-muted">
                                    <c:choose>
                                        <c:when test="${projects.size() >= 3}">
                                            Target benchmark achieved
                                        </c:when>
                                        <c:otherwise>
                                            Add ${3 - projects.size()} more to reach 100%
                                        </c:otherwise>
                                    </c:choose>
                                </small>
                            </div>
                            <span class="ios-badge <c:choose><c:when test='${projects.size() >= 3}'>ios-badge-green</c:when><c:otherwise>ios-badge-blue</c:otherwise></c:choose> font-weight-bold">
                                ${projects.size()} / 3 Projects
                            </span>
                        </div>

                        <div class="ios-card-body" style="padding: 1.5rem; background: rgba(248, 250, 252, 0.4);">
                            <c:choose>
                                <c:when test="${empty projects}">
                                    <div class="p-5 text-center text-muted" style="background: #ffffff; border: 1px dashed rgba(0,0,0,0.1); border-radius: var(--ios-radius-md);">
                                        <div class="ios-badge ios-badge-gray p-3 mb-2" style="border-radius: var(--ios-radius-full);">
                                            <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true"><path d="M22 19a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h5l2 3h9a2 2 0 0 1 2 2z"></path></svg>
                                        </div>
                                        <h3 class="h5 font-weight-bold text-dark mt-2">No projects published yet</h3>
                                        <p class="small mb-0" style="color: #475569;">Use the form on the left to add your full-stack applications, APIs, and software engineering projects.</p>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach items="${projects}" var="proj">
                                        <div class="ios-card mb-3" style="border: 1px solid rgba(226, 232, 240, 0.9); box-shadow: var(--ios-shadow-sm);">
                                            <div class="ios-card-body p-4">
                                                <div class="d-flex justify-content-between align-items-start mb-2">
                                                    <div>
                                                        <h3 class="h6 font-weight-bold text-dark mb-1" style="font-size: 1.1rem;">
                                                            <c:out value="${proj.title}" />
                                                        </h3>
                                                        <div class="small" style="color: #475569;">
                                                            <span class="font-weight-bold" style="color: #005bb5;">Stack:</span> <c:out value="${proj.techStack}" />
                                                        </div>
                                                    </div>
                                                    <div class="d-flex align-items-center gap-2">
                                                        <a href="${pageContext.request.contextPath}/app/student/projects?editId=${proj.projectId}" class="btn btn-sm btn-outline-secondary d-inline-flex align-items-center" style="border-radius: var(--ios-radius-sm); padding: 0.3rem 0.75rem; font-size: 0.8rem; font-weight: 600;" title="Edit Project" aria-label="Edit project <c:out value='${proj.title}' />">
                                                            <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" class="mr-1" aria-hidden="true"><path d="M12 20h9"></path><path d="M16.5 3.5a2.121 2.121 0 0 1 3 3L7 19l-4 1 1-4L16.5 3.5z"></path></svg>
                                                            Edit
                                                        </a>
                                                        <form action="${pageContext.request.contextPath}/app/student/projects" method="post" class="d-inline">
                                                            <input type="hidden" name="csrfToken" value="${sessionScope.CSRF_TOKEN}" />
                                                            <input type="hidden" name="action" value="delete" />
                                                            <input type="hidden" name="projectId" value="${proj.projectId}" />
                                                            <button type="submit" class="btn btn-sm btn-outline-danger confirm-delete d-inline-flex align-items-center" style="border-radius: var(--ios-radius-sm); padding: 0.3rem 0.75rem; font-size: 0.8rem; font-weight: 600;" data-confirm="Delete project '${proj.title}'?" aria-label="Delete project <c:out value='${proj.title}' />">
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
                                                </div>

                                                <p class="small mb-3" style="color: #334155; line-height: 1.6;">
                                                    <c:out value="${proj.description}" />
                                                </p>

                                                <div class="pt-3 border-top d-flex align-items-center gap-3">
                                                    <c:if test="${not empty proj.githubUrl}">
                                                        <a href="<c:out value='${proj.githubUrl}' />" target="_blank" rel="noopener noreferrer" class="ios-btn-secondary" style="padding: 0.4rem 0.95rem; font-size: 0.8rem;">
                                                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true"><path d="M9 19c-5 1.5-5-2.5-7-3m14 6v-3.87a3.37 3.37 0 0 0-.94-2.61c3.14-.35 6.44-1.54 6.44-7A5.44 5.44 0 0 0 20 4.77 5.07 5.07 0 0 0 19.91 1S18.73.65 16 2.48a13.38 13.38 0 0 0-7 0C6.27.65 5.09 1 5.09 1A5.07 5.07 0 0 0 5 4.77a5.44 5.44 0 0 0-1.5 3.78c0 5.42 3.3 6.61 6.44 7A3.37 3.37 0 0 0 9 18.13V22"></path></svg>
                                                            GitHub Repository
                                                        </a>
                                                    </c:if>
                                                    <c:if test="${not empty proj.liveDemoUrl}">
                                                        <a href="<c:out value='${proj.liveDemoUrl}' />" target="_blank" rel="noopener noreferrer" class="ios-btn-secondary" style="padding: 0.4rem 0.95rem; font-size: 0.8rem; color: var(--ios-green-dark) !important; border-color: rgba(52, 199, 89, 0.3);">
                                                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true"><circle cx="12" cy="12" r="10"></circle><line x1="2" y1="12" x2="22" y2="12"></line><path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"></path></svg>
                                                            Live Deployment
                                                        </a>
                                                    </c:if>
                                                    <c:if test="${empty proj.githubUrl && empty proj.liveDemoUrl}">
                                                        <span class="small" style="color: #64748b;">No external URLs linked</span>
                                                    </c:if>
                                                </div>
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
