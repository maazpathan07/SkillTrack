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

            <!-- Live GitHub Auto-Sync Engine Card -->
            <div class="ios-card p-4 mb-4" style="background: linear-gradient(135deg, rgba(255, 255, 255, 0.98), rgba(248, 250, 252, 0.95)); border: 1px solid rgba(226, 232, 240, 0.95); box-shadow: 0 4px 20px -2px rgba(0, 0, 0, 0.04);">
                <div class="d-flex flex-column flex-lg-row align-items-lg-center justify-content-between gap-3">
                    <div class="d-flex align-items-start gap-3">
                        <div class="d-flex align-items-center justify-content-center flex-shrink-0" style="width: 48px; height: 48px; border-radius: 14px; background: linear-gradient(135deg, #1e293b, #0f172a); color: #ffffff; box-shadow: 0 8px 16px -4px rgba(15, 23, 42, 0.35);">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true"><path d="M9 19c-5 1.5-5-2.5-7-3m14 6v-3.87a3.37 3.37 0 0 0-.94-2.61c3.14-.35 6.44-1.54 6.44-7A5.44 5.44 0 0 0 20 4.77 5.07 5.07 0 0 0 19.91 1S18.73.65 16 2.48a13.38 13.38 0 0 0-7 0C6.27.65 5.09 1 5.09 1A5.07 5.07 0 0 0 5 4.77a5.44 5.44 0 0 0-1.5 3.78c0 5.42 3.3 6.61 6.44 7A3.37 3.37 0 0 0 9 18.13V22"></path></svg>
                        </div>
                        <div>
                            <div class="d-flex align-items-center flex-wrap gap-2 mb-1">
                                <h2 class="h5 font-weight-bold text-dark mb-0" style="font-size: 1.1rem; letter-spacing: -0.02em;">Live GitHub Portfolio &amp; Repository Sync</h2>
                                <c:choose>
                                    <c:when test="${codingProfile != null && codingProfile.githubSynced}">
                                        <span class="badge badge-success px-2.5 py-1" style="border-radius: 999px; font-weight: 600; font-size: 0.72rem;">
                                            ✓ Live Verified on GitHub (@<c:out value="${codingProfile.githubUsername}" />)
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-secondary px-2.5 py-1" style="border-radius: 999px; font-weight: 600; font-size: 0.72rem; background: #e2e8f0; color: #475569;">
                                            GitHub API &bull; Verified Portfolio
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <p class="text-muted small mb-2" style="max-width: 680px; line-height: 1.45;">
                                Connect your GitHub profile to verify your engineering credentials, public repositories, and showcase open-source contributions.
                            </p>

                            <!-- Live Chips Bar -->
                            <c:if test="${codingProfile != null && codingProfile.githubSynced}">
                                <div class="d-flex align-items-center flex-wrap gap-2 pt-1">
                                    <span class="ios-badge" style="background: rgba(15, 23, 42, 0.08); color: #0f172a; font-weight: 700; font-size: 0.75rem; border: 1px solid rgba(15, 23, 42, 0.15);">
                                        📦 Public Repos: <c:out value="${codingProfile.githubReposCount}" />
                                    </span>
                                    <span class="ios-badge" style="background: rgba(99, 102, 241, 0.1); color: #4338ca; font-weight: 700; font-size: 0.75rem; border: 1px solid rgba(99, 102, 241, 0.2);">
                                        👥 Followers: <c:out value="${codingProfile.githubFollowers}" />
                                    </span>
                                    <c:if test="${not empty codingProfile.githubBio}">
                                        <span class="text-muted small italic" style="font-size: 0.78rem;">
                                            &ldquo;<c:out value="${codingProfile.githubBio}" />&rdquo;
                                        </span>
                                    </c:if>
                                    <a href="https://github.com/<c:out value='${codingProfile.githubUsername}' />" target="_blank" rel="noopener noreferrer" class="small ml-1 font-weight-bold" style="color: #0071e3;">
                                        View Profile &rarr;
                                    </a>
                                </div>
                            </c:if>
                        </div>
                    </div>

                    <div class="d-flex align-items-center flex-wrap gap-2 flex-shrink-0">
                        <button type="button" class="ios-btn-primary d-inline-flex align-items-center justify-content-center" data-toggle="modal" data-target="#syncGithubModal" style="padding: 0.65rem 1.35rem; font-size: 0.875rem; box-shadow: 0 4px 14px rgba(15, 23, 42, 0.25); background: linear-gradient(135deg, #1e293b, #0f172a); border-color: #0f172a;">
                            <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="mr-1.5" aria-hidden="true"><path d="M9 19c-5 1.5-5-2.5-7-3m14 6v-3.87a3.37 3.37 0 0 0-.94-2.61c3.14-.35 6.44-1.54 6.44-7A5.44 5.44 0 0 0 20 4.77 5.07 5.07 0 0 0 19.91 1S18.73.65 16 2.48a13.38 13.38 0 0 0-7 0C6.27.65 5.09 1 5.09 1A5.07 5.07 0 0 0 5 4.77a5.44 5.44 0 0 0-1.5 3.78c0 5.42 3.3 6.61 6.44 7A3.37 3.37 0 0 0 9 18.13V22"></path></svg>
                            ${codingProfile != null && codingProfile.githubSynced ? '⚡ Re-Sync GitHub Stats' : '⚡ Connect &amp; Auto-Sync GitHub'}
                        </button>
                    </div>
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
                                    <label for="githubUrl" class="ios-form-label d-flex justify-content-between align-items-center">
                                        <span>GitHub Repository URL</span>
                                        <c:if test="${codingProfile != null && codingProfile.githubSynced}">
                                            <a href="javascript:void(0);" onclick="document.getElementById('githubUrl').value='https://github.com/${codingProfile.githubUsername}/';" class="small" style="font-size: 0.75rem; color: #0071e3; text-decoration: none;">
                                                + Use @${codingProfile.githubUsername}
                                            </a>
                                        </c:if>
                                    </label>
                                    <div class="ios-input-icon-wrapper">
                                        <input type="url" class="ios-form-control" id="githubUrl" name="githubUrl" value="<c:out value='${editProject.githubUrl}' />" placeholder="https://github.com/user/project">
                                        <span class="ios-input-icon">
                                            <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true"><path d="M9 19c-5 1.5-5-2.5-7-3m14 6v-3.87a3.37 3.37 0 0 0-.94-2.61c3.14-.35 6.44-1.54 6.44-7A5.44 5.44 0 0 0 20 4.77 5.07 5.07 0 0 0 19.91 1S18.73.65 16 2.48a13.38 13.38 0 0 0-7 0C6.27.65 5.09 1 5.09 1A5.07 5.07 0 0 0 5 4.77a5.44 5.44 0 0 0-1.5 3.78c0 5.42 3.3 6.61 6.44 7A3.37 3.37 0 0 0 9 18.13V22"></path></svg>
                                        </span>
                                    </div>
                                </div>

                                <div class="form-group mb-4">
                                    <label for="liveDemoUrl" class="ios-form-label">Live Deployment / Demo URL</label>
                                    <div class="ios-input-icon-wrapper">
                                        <input type="url" class="ios-form-control" id="liveDemoUrl" name="liveDemoUrl" value="<c:out value='${editProject.liveDemoUrl}' />" placeholder="https://project.vercel.app">
                                        <span class="ios-input-icon">
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
                                            <div class="d-flex justify-content-end w-100">
                                                <button type="submit" class="ios-btn-primary" style="padding: 0.65rem 1.75rem; font-size: 0.875rem;">
                                                    <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" aria-hidden="true"><line x1="12" y1="5" x2="12" y2="19"></line><line x1="5" y1="12" x2="19" y2="12"></line></svg>
                                                    Save Project
                                                </button>
                                            </div>
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

            <!-- Modal: Live GitHub Sync -->
            <div class="modal fade" id="syncGithubModal" tabindex="-1" role="dialog" aria-labelledby="syncGithubModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content" style="border-radius: var(--ios-radius-lg); border: none; box-shadow: 0 20px 40px rgba(0,0,0,0.15);">
                        <form id="syncGithubForm" method="POST" action="${pageContext.request.contextPath}/app/student/sync-platforms" onsubmit="return handleGithubSyncSubmit(this);">
                            <input type="hidden" name="csrfToken" value="${sessionScope.CSRF_TOKEN}">
                            <input type="hidden" name="redirectUri" value="/app/student/projects">
                            <div class="modal-header d-flex align-items-center justify-content-between" style="border-bottom: 1px solid #f1f5f9; padding: 1.25rem 1.5rem;">
                                <div class="d-flex align-items-center gap-2">
                                    <div class="d-flex align-items-center justify-content-center" style="width: 32px; height: 32px; border-radius: 8px; background: linear-gradient(135deg, #1e293b, #0f172a); color: #ffffff;">
                                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true"><path d="M9 19c-5 1.5-5-2.5-7-3m14 6v-3.87a3.37 3.37 0 0 0-.94-2.61c3.14-.35 6.44-1.54 6.44-7A5.44 5.44 0 0 0 20 4.77 5.07 5.07 0 0 0 19.91 1S18.73.65 16 2.48a13.38 13.38 0 0 0-7 0C6.27.65 5.09 1 5.09 1A5.07 5.07 0 0 0 5 4.77a5.44 5.44 0 0 0-1.5 3.78c0 5.42 3.3 6.61 6.44 7A3.37 3.37 0 0 0 9 18.13V22"></path></svg>
                                    </div>
                                    <h5 class="modal-title font-weight-bold text-dark mb-0" id="syncGithubModalLabel">Live GitHub Portfolio Sync</h5>
                                </div>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="outline: none;">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body p-4">
                                <!-- GitHub Username -->
                                <div class="form-group mb-3">
                                    <label for="syncGithubUser" class="ios-form-label d-flex justify-content-between">
                                        <span>GitHub Username *</span>
                                        <span class="text-muted font-weight-normal" style="font-size: 0.75rem;">e.g. torvalds or your_handle</span>
                                    </label>
                                    <div class="position-relative">
                                        <input type="text" class="ios-form-control" id="syncGithubUser" name="githubUsername" value="<c:out value='${codingProfile != null ? codingProfile.githubUsername : ""}' />" required placeholder="Enter GitHub username (without @)" style="padding-left: 2.25rem;">
                                        <span class="position-absolute" style="left: 10px; top: 10px; color: #1e293b;" aria-hidden="true">
                                            <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M9 19c-5 1.5-5-2.5-7-3m14 6v-3.87a3.37 3.37 0 0 0-.94-2.61c3.14-.35 6.44-1.54 6.44-7A5.44 5.44 0 0 0 20 4.77 5.07 5.07 0 0 0 19.91 1S18.73.65 16 2.48a13.38 13.38 0 0 0-7 0C6.27.65 5.09 1 5.09 1A5.07 5.07 0 0 0 5 4.77a5.44 5.44 0 0 0-1.5 3.78c0 5.42 3.3 6.61 6.44 7A3.37 3.37 0 0 0 9 18.13V22"></path></svg>
                                        </span>
                                    </div>
                                    <small class="text-muted mt-1 d-block">System will fetch public repository count, bio, avatar, and verify your open source portfolio.</small>
                                </div>

                                <!-- Auto-import Repositories Checkbox -->
                                <div class="custom-control custom-checkbox p-3 mt-3" style="background: rgba(30, 41, 59, 0.04); border: 1px solid rgba(30, 41, 59, 0.15); border-radius: 8px;">
                                    <input type="checkbox" class="custom-control-input" id="autoImportRepos" name="autoDistribute" value="true" checked>
                                    <label class="custom-control-label small font-weight-bold text-dark" for="autoImportRepos">
                                        ⚡ Automatically import public repositories into Project Showcase
                                    </label>
                                    <small class="text-muted d-block mt-1" style="font-size: 0.775rem;">
                                        Creates portfolio projects directly with verified GitHub repository links, tech stack tags, and repository descriptions.
                                    </small>
                                </div>
                            </div>
                            <div class="modal-footer d-flex justify-content-between align-items-center" style="border-top: 1px solid #f1f5f9; padding: 1.25rem 1.5rem;">
                                <button type="button" class="ios-btn-secondary" data-dismiss="modal" style="padding: 0.55rem 1.25rem; font-size: 0.85rem;">Cancel</button>
                                <button type="submit" id="triggerGithubSyncBtn" class="ios-btn-primary" style="padding: 0.55rem 1.5rem; font-size: 0.85rem; background: linear-gradient(135deg, #1e293b, #0f172a); border-color: #0f172a; box-shadow: 0 4px 12px rgba(15, 23, 42, 0.25);">
                                    <span id="githubSyncSpinner" class="spinner-border spinner-border-sm d-none mr-1" role="status" aria-hidden="true"></span>
                                    <span id="githubSyncBtnText">🚀 Fetch &amp; Sync GitHub Profile</span>
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>

<script>
function handleGithubSyncSubmit(form) {
    var githubUser = (form.githubUsername && form.githubUsername.value) ? form.githubUsername.value.trim() : '';

    if (!githubUser) {
        alert('Please enter your GitHub username to sync.');
        return false;
    }

    var btn = document.getElementById('triggerGithubSyncBtn');
    var spinner = document.getElementById('githubSyncSpinner');
    var btnText = document.getElementById('githubSyncBtnText');

    if (btn) {
        btn.disabled = true;
        btn.style.opacity = '0.75';
    }
    if (spinner) spinner.classList.remove('d-none');
    if (btnText) btnText.textContent = 'Querying GitHub API & Syncing...';

    return true;
}
</script>

<%@ include file="/WEB-INF/views/common/footer.jspf" %>
