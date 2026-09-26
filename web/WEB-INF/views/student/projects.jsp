<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="pageTitle" value="Project Portfolio" />
<c:set var="activeNav" value="projects" />
<%@ include file="/WEB-INF/views/common/header.jspf" %>
<%@ include file="/WEB-INF/views/common/navbar.jspf" %>

<style>
    .project-page-wrapper {
        max-width: 1440px;
        margin: 0 auto;
    }

    /* Glassmorphic Page Header */
    .project-header-card {
        background: rgba(255, 255, 255, 0.85);
        backdrop-filter: blur(12px);
        -webkit-backdrop-filter: blur(12px);
        border: 1px solid rgba(226, 232, 240, 0.8);
        border-radius: 16px;
        padding: 1.25rem 1.5rem;
        box-shadow: 0 4px 20px -2px rgba(0, 0, 0, 0.03);
        margin-bottom: 1.5rem;
    }

    /* GitHub Auto-Sync Banner */
    .github-sync-card {
        background: linear-gradient(135deg, rgba(255, 255, 255, 0.98), rgba(248, 250, 252, 0.95));
        border: 1px solid rgba(226, 232, 240, 0.95);
        border-radius: 16px;
        padding: 1.25rem 1.5rem;
        box-shadow: 0 4px 20px -2px rgba(0, 0, 0, 0.03);
        margin-bottom: 1.5rem;
    }

    .github-icon-box {
        width: 46px;
        height: 46px;
        border-radius: 14px;
        background: linear-gradient(135deg, #1e293b, #0f172a);
        color: #ffffff;
        box-shadow: 0 8px 16px -4px rgba(15, 23, 42, 0.35);
        display: flex;
        align-items: center;
        justify-content: center;
        flex-shrink: 0;
    }

    /* Standard Cards */
    .project-card {
        background: #ffffff;
        border: 1px solid rgba(226, 232, 240, 0.85);
        border-radius: 16px;
        box-shadow: 0 4px 20px -2px rgba(0, 0, 0, 0.03);
        margin-bottom: 1.5rem;
        overflow: hidden;
    }

    .project-card-header {
        padding: 1.15rem 1.5rem;
        background: rgba(248, 250, 252, 0.7);
        border-bottom: 1px solid rgba(226, 232, 240, 0.8);
        display: flex;
        align-items: center;
        justify-content: space-between;
        flex-wrap: wrap;
        gap: 0.75rem;
    }

    .project-card-body {
        padding: 1.5rem;
    }

    /* Form Controls */
    .project-form-label {
        font-size: 0.825rem;
        font-weight: 600;
        color: #334155;
        margin-bottom: 0.4rem;
        display: flex;
        align-items: center;
        justify-content: space-between;
    }

    .project-input {
        background: #ffffff;
        border: 1.5px solid #e2e8f0;
        border-radius: 12px;
        padding: 0.65rem 1rem;
        font-size: 0.875rem;
        font-weight: 500;
        color: #1e293b;
        width: 100%;
        transition: all 0.2s ease;
    }

    .project-input:focus {
        border-color: #3b82f6;
        outline: none;
        box-shadow: 0 0 0 3.5px rgba(59, 130, 246, 0.12);
    }

    .project-textarea {
        background: #ffffff;
        border: 1.5px solid #e2e8f0;
        border-radius: 12px;
        padding: 0.75rem 1rem;
        font-size: 0.875rem;
        font-weight: 500;
        color: #1e293b;
        width: 100%;
        line-height: 1.55;
        resize: vertical;
        transition: all 0.2s ease;
    }

    .project-textarea:focus {
        border-color: #3b82f6;
        outline: none;
        box-shadow: 0 0 0 3.5px rgba(59, 130, 246, 0.12);
    }

    .input-icon-wrapper {
        position: relative;
    }

    .input-icon-left {
        position: absolute;
        left: 0.9rem;
        top: 50%;
        transform: translateY(-50%);
        display: flex;
        align-items: center;
        justify-content: center;
        pointer-events: none;
        color: #64748b;
    }

    .input-with-icon-left {
        padding-left: 2.75rem !important;
    }

    /* Badges & Tags */
    .ios-pill-badge {
        display: inline-flex;
        align-items: center;
        gap: 0.35rem;
        padding: 0.3rem 0.75rem;
        border-radius: 999px;
        font-size: 0.75rem;
        font-weight: 600;
        letter-spacing: 0.02em;
    }

    .ios-pill-blue {
        background: rgba(59, 130, 246, 0.1);
        color: #2563eb;
        border: 1px solid rgba(59, 130, 246, 0.2);
    }

    .ios-pill-emerald {
        background: rgba(16, 185, 129, 0.1);
        color: #059669;
        border: 1px solid rgba(16, 185, 129, 0.2);
    }

    .ios-pill-purple {
        background: rgba(139, 92, 246, 0.1);
        color: #7c3aed;
        border: 1px solid rgba(139, 92, 246, 0.2);
    }

    .ios-pill-amber {
        background: rgba(245, 158, 11, 0.1);
        color: #d97706;
        border: 1px solid rgba(245, 158, 11, 0.2);
    }

    .ios-pill-dark {
        background: rgba(15, 23, 42, 0.08);
        color: #0f172a;
        border: 1px solid rgba(15, 23, 42, 0.15);
    }

    .tech-stack-chip {
        display: inline-flex;
        align-items: center;
        padding: 0.25rem 0.65rem;
        border-radius: 8px;
        font-size: 0.75rem;
        font-weight: 600;
        background: #f1f5f9;
        color: #334155;
        border: 1px solid #e2e8f0;
    }

    /* Buttons */
    .btn-project-primary {
        background: linear-gradient(135deg, #3b82f6, #2563eb);
        color: #ffffff;
        border: none;
        border-radius: 12px;
        padding: 0.65rem 1.6rem;
        font-size: 0.875rem;
        font-weight: 600;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 0.5rem;
        box-shadow: 0 4px 14px -2px rgba(37, 99, 235, 0.4);
        transition: all 0.2s ease;
        cursor: pointer;
        text-decoration: none !important;
    }

    .btn-project-primary:hover {
        transform: translateY(-1px);
        box-shadow: 0 6px 18px -2px rgba(37, 99, 235, 0.5);
        color: #ffffff;
    }

    .btn-github-sync {
        background: linear-gradient(135deg, #1e293b, #0f172a);
        color: #ffffff;
        border: none;
        border-radius: 12px;
        padding: 0.65rem 1.35rem;
        font-size: 0.875rem;
        font-weight: 600;
        display: inline-flex;
        align-items: center;
        gap: 0.5rem;
        box-shadow: 0 4px 14px -2px rgba(15, 23, 42, 0.4);
        transition: all 0.2s ease;
        cursor: pointer;
        text-decoration: none !important;
    }

    .btn-github-sync:hover {
        transform: translateY(-1px);
        box-shadow: 0 6px 18px -2px rgba(15, 23, 42, 0.5);
        color: #ffffff;
    }

    .btn-action-light {
        background: #f1f5f9;
        color: #334155;
        border: 1px solid #e2e8f0;
        border-radius: 10px;
        padding: 0.45rem 0.85rem;
        font-size: 0.8rem;
        font-weight: 600;
        display: inline-flex;
        align-items: center;
        gap: 0.35rem;
        transition: all 0.2s ease;
        text-decoration: none !important;
        cursor: pointer;
    }

    .btn-action-light:hover {
        background: #e2e8f0;
        color: #0f172a;
    }

    /* Single Project Item Card */
    .project-item-card {
        background: #ffffff;
        border: 1px solid rgba(226, 232, 240, 0.95);
        border-radius: 14px;
        padding: 1.25rem 1.35rem;
        margin-bottom: 1rem;
        transition: all 0.2s ease;
    }

    .project-item-card:hover {
        box-shadow: 0 6px 20px -4px rgba(0, 0, 0, 0.05);
        border-color: #cbd5e1;
    }
</style>

<div class="container-fluid px-3 px-lg-4 py-4 project-page-wrapper">
    <%@ include file="/WEB-INF/views/common/alerts.jspf" %>

    <!-- Header Banner -->
    <div class="project-header-card">
        <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">
            <div>
                <div class="d-flex align-items-center gap-2 mb-1">
                    <span class="ios-pill-badge ios-pill-blue">
                        <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M22 19a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h5l2 3h9a2 2 0 0 1 2 2z"></path></svg>
                        Engineering Portfolio
                    </span>
                </div>
                <h1 class="h3 font-weight-bold text-gray-900 mb-0" style="letter-spacing: -0.025em;">Software Projects Portfolio</h1>
                <p class="text-muted small mb-0 mt-1">Showcase your real-world software engineering, architecture, and live full-stack deployments</p>
            </div>
            <div>
                <span class="ios-pill-badge ios-pill-emerald" style="font-size: 0.825rem; padding: 0.45rem 0.95rem;">
                    <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg>
                    Benchmark: 3 Projects
                </span>
            </div>
        </div>
    </div>

    <!-- Live GitHub Auto-Sync Engine Card -->
    <div class="github-sync-card">
        <div class="d-flex flex-column flex-lg-row align-items-lg-center justify-content-between gap-3">
            <div class="d-flex align-items-start gap-3">
                <div class="github-icon-box">
                    <!-- Official GitHub Octocat Vector SVG Icon -->
                    <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor">
                        <path fill-rule="evenodd" clip-rule="evenodd" d="M12 2C6.477 2 2 6.484 2 12.017c0 4.425 2.865 8.18 6.839 9.504.5.092.682-.217.682-.483 0-.237-.008-.868-.013-1.703-2.782.605-3.369-1.343-3.369-1.343-.454-1.158-1.11-1.466-1.11-1.466-.908-.62.069-.608.069-.608 1.003.07 1.53 1.032 1.53 1.032.892 1.53 2.341 1.088 2.91.832.092-.647.35-1.088.636-1.338-2.22-.253-4.555-1.113-4.555-4.951 0-1.093.39-1.988 1.029-2.688-.103-.253-.446-1.272.098-2.65 0 0 .84-.27 2.75 1.026A9.564 9.564 0 0112 6.844c.85.004 1.705.115 2.504.337 1.909-1.296 2.747-1.027 2.747-1.027.546 1.379.202 2.398.1 2.651.64.7 1.028 1.595 1.028 2.688 0 3.848-2.339 4.695-4.566 4.943.359.309.678.92.678 1.855 0 1.338-.012 2.419-.012 2.747 0 .268.18.58.688.482A10.019 10.019 0 0022 12.017C22 6.484 17.522 2 12 2z"/>
                    </svg>
                </div>
                <div>
                    <div class="d-flex align-items-center flex-wrap gap-2 mb-1">
                        <h2 class="h5 font-weight-bold text-dark mb-0" style="font-size: 1.05rem; letter-spacing: -0.02em;">Live GitHub Portfolio &amp; Repository Sync</h2>
                        <c:choose>
                            <c:when test="${codingProfile != null && codingProfile.githubSynced}">
                                <span class="ios-pill-badge ios-pill-emerald" style="font-size: 0.72rem; padding: 2px 8px;">
                                    ✓ Live Verified on GitHub (@<c:out value="${codingProfile.githubUsername}" />)
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span class="ios-pill-badge ios-pill-dark" style="font-size: 0.72rem; padding: 2px 8px;">
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
                            <span class="ios-pill-badge ios-pill-dark">
                                📦 Public Repos: <c:out value="${codingProfile.githubReposCount}" />
                            </span>
                            <span class="ios-pill-badge ios-pill-purple">
                                👥 Followers: <c:out value="${codingProfile.githubFollowers}" />
                            </span>
                            <c:if test="${not empty codingProfile.githubBio}">
                                <span class="text-muted small italic" style="font-size: 0.78rem;">
                                    &ldquo;<c:out value="${codingProfile.githubBio}" />&rdquo;
                                </span>
                            </c:if>
                            <a href="https://github.com/<c:out value='${codingProfile.githubUsername}' />" target="_blank" rel="noopener noreferrer" class="small ml-1 font-weight-bold" style="color: #2563eb; text-decoration: none;">
                                View Profile &rarr;
                            </a>
                        </div>
                    </c:if>
                </div>
            </div>

            <div class="d-flex align-items-center flex-wrap gap-2 flex-shrink-0">
                <button type="button" class="btn-github-sync" data-toggle="modal" data-target="#syncGithubModal">
                    <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"></polygon></svg>
                    ${codingProfile != null && codingProfile.githubSynced ? 'Re-Sync GitHub Stats' : 'Connect &amp; Auto-Sync GitHub'}
                </button>
            </div>
        </div>
    </div>

    <div class="row">
        <!-- Project Add/Edit Form (5 Cols) -->
        <div class="col-lg-5 mb-4">
            <div class="project-card h-100">
                <div class="project-card-header">
                    <div>
                        <span class="font-weight-bold text-dark" style="font-size: 0.95rem;">
                            <c:out value="${not empty editProject ? 'Edit Project' : 'Add New Project'}" />
                        </span>
                    </div>
                    <c:choose>
                        <c:when test="${not empty editProject}">
                            <span class="ios-pill-badge ios-pill-amber">Editing ID: ${editProject.projectId}</span>
                        </c:when>
                        <c:otherwise>
                            <span class="ios-pill-badge ios-pill-blue">Publish Work</span>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="project-card-body">
                    <form action="${pageContext.request.contextPath}/app/student/projects" method="post" class="needs-validation" novalidate>
                        <input type="hidden" name="csrfToken" value="${sessionScope.CSRF_TOKEN}" />
                        <input type="hidden" name="projectId" value="<c:out value='${editProject.projectId}' default='0' />" />

                        <!-- Project Title -->
                        <div class="form-group mb-3">
                            <label for="title" class="project-form-label">Project Title *</label>
                            <input type="text" class="project-input" id="title" name="title" value="<c:out value='${editProject.title}' />" required placeholder="e.g. Distributed Payment Gateway & Microservices">
                            <div class="invalid-feedback">Project title is required.</div>
                        </div>

                        <!-- Tech Stack -->
                        <div class="form-group mb-3">
                            <label for="techStack" class="project-form-label">Tech Stack (comma-separated) *</label>
                            <input type="text" class="project-input" id="techStack" name="techStack" value="<c:out value='${editProject.techStack}' />" required placeholder="Java, Spring Boot, MySQL, Docker, Redis">
                            <div class="invalid-feedback">Tech Stack is required.</div>
                        </div>

                        <!-- Description -->
                        <div class="form-group mb-3">
                            <label for="description" class="project-form-label">Description &amp; Architecture Highlights *</label>
                            <textarea class="project-textarea" id="description" name="description" rows="4" required placeholder="Engineered microservices backend handling authentication, asynchronous queue processing, and transaction rollback..."><c:out value="${editProject.description}" /></textarea>
                            <div class="invalid-feedback">Description is required.</div>
                        </div>

                        <!-- GitHub URL -->
                        <div class="form-group mb-3">
                            <label for="githubUrl" class="project-form-label">
                                <span>GitHub Repository URL</span>
                                <c:if test="${codingProfile != null && codingProfile.githubSynced}">
                                    <a href="javascript:void(0);" onclick="document.getElementById('githubUrl').value='https://github.com/${codingProfile.githubUsername}/';" class="small text-primary font-weight-bold" style="font-size: 0.75rem; text-decoration: none;">
                                        + Use @${codingProfile.githubUsername}
                                    </a>
                                </c:if>
                            </label>
                            <div class="input-icon-wrapper">
                                <span class="input-icon-left">
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor">
                                        <path fill-rule="evenodd" clip-rule="evenodd" d="M12 2C6.477 2 2 6.484 2 12.017c0 4.425 2.865 8.18 6.839 9.504.5.092.682-.217.682-.483 0-.237-.008-.868-.013-1.703-2.782.605-3.369-1.343-3.369-1.343-.454-1.158-1.11-1.466-1.11-1.466-.908-.62.069-.608.069-.608 1.003.07 1.53 1.032 1.53 1.032.892 1.53 2.341 1.088 2.91.832.092-.647.35-1.088.636-1.338-2.22-.253-4.555-1.113-4.555-4.951 0-1.093.39-1.988 1.029-2.688-.103-.253-.446-1.272.098-2.65 0 0 .84-.27 2.75 1.026A9.564 9.564 0 0112 6.844c.85.004 1.705.115 2.504.337 1.909-1.296 2.747-1.027 2.747-1.027.546 1.379.202 2.398.1 2.651.64.7 1.028 1.595 1.028 2.688 0 3.848-2.339 4.695-4.566 4.943.359.309.678.92.678 1.855 0 1.338-.012 2.419-.012 2.747 0 .268.18.58.688.482A10.019 10.019 0 0022 12.017C22 6.484 17.522 2 12 2z"/>
                                    </svg>
                                </span>
                                <input type="url" class="project-input input-with-icon-left" id="githubUrl" name="githubUrl" value="<c:out value='${editProject.githubUrl}' />" placeholder="https://github.com/user/project">
                            </div>
                        </div>

                        <!-- Live Demo URL -->
                        <div class="form-group mb-4">
                            <label for="liveDemoUrl" class="project-form-label">Live Deployment / Demo URL</label>
                            <div class="input-icon-wrapper">
                                <span class="input-icon-left">
                                    <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><circle cx="12" cy="12" r="10"></circle><line x1="2" y1="12" x2="22" y2="12"></line><path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"></path></svg>
                                </span>
                                <input type="url" class="project-input input-with-icon-left" id="liveDemoUrl" name="liveDemoUrl" value="<c:out value='${editProject.liveDemoUrl}' />" placeholder="https://project.vercel.app">
                            </div>
                        </div>

                        <!-- Action Buttons -->
                        <div class="d-flex justify-content-between align-items-center pt-3 border-top">
                            <c:choose>
                                <c:when test="${not empty editProject}">
                                    <a href="${pageContext.request.contextPath}/app/student/projects" class="btn-action-light" style="padding: 0.6rem 1.25rem;">Cancel</a>
                                    <button type="submit" class="btn-project-primary">
                                        <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="20 6 9 17 4 12"></polyline></svg>
                                        Update Project
                                    </button>
                                </c:when>
                                <c:otherwise>
                                    <div class="d-flex justify-content-end w-100">
                                        <button type="submit" class="btn-project-primary">
                                            <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><line x1="12" y1="5" x2="12" y2="19"></line><line x1="5" y1="12" x2="19" y2="12"></line></svg>
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

        <!-- Projects Showcase List (7 Cols) -->
        <div class="col-lg-7 mb-4">
            <div class="project-card h-100">
                <div class="project-card-header">
                    <div>
                        <span class="font-weight-bold text-dark" style="font-size: 0.95rem;">
                            Engineering Showcase (${projects.size()})
                        </span>
                    </div>
                    <span class="ios-pill-badge <c:choose><c:when test='${projects.size() >= 3}'>ios-pill-emerald</c:when><c:otherwise>ios-pill-blue</c:otherwise></c:choose> font-weight-bold">
                        ${projects.size()} / 3 Projects
                    </span>
                </div>

                <div class="project-card-body" style="background: rgba(248, 250, 252, 0.4);">
                    <c:choose>
                        <c:when test="${empty projects}">
                            <div class="p-5 text-center text-muted" style="background: #ffffff; border: 1.5px dashed #cbd5e1; border-radius: 16px;">
                                <div class="ios-pill-badge ios-pill-dark p-3 mb-2" style="width: 52px; height: 52px; border-radius: 50%; display: inline-flex; align-items: center; justify-content: center;">
                                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 19a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h5l2 3h9a2 2 0 0 1 2 2z"></path></svg>
                                </div>
                                <h3 class="h6 font-weight-bold text-dark mt-2 mb-1" style="font-size: 1.05rem;">No projects published yet</h3>
                                <p class="small text-muted mb-0" style="max-width: 420px; margin: 0 auto; line-height: 1.5;">
                                    Use the form on the left to add your full-stack applications, APIs, and software engineering projects.
                                </p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${projects}" var="proj">
                                <div class="project-item-card">
                                    <div class="d-flex justify-content-between align-items-start mb-2">
                                        <div>
                                            <h3 class="h6 font-weight-bold text-dark mb-1" style="font-size: 1.05rem;">
                                                <c:out value="${proj.title}" />
                                            </h3>
                                            <div class="d-flex flex-wrap gap-1.5 align-items-center mt-1.5" style="gap: 0.35rem;">
                                                <c:forEach items="${fn:split(proj.techStack, ',')}" var="tech">
                                                    <span class="tech-stack-chip">
                                                        <c:out value="${fn:trim(tech)}" />
                                                    </span>
                                                </c:forEach>
                                            </div>
                                        </div>
                                        <div class="d-flex align-items-center gap-1.5">
                                            <a href="${pageContext.request.contextPath}/app/student/projects?editId=${proj.projectId}" class="btn-action-light" title="Edit Project">
                                                <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M12 20h9"></path><path d="M16.5 3.5a2.121 2.121 0 0 1 3 3L7 19l-4 1 1-4L16.5 3.5z"></path></svg>
                                                Edit
                                            </a>
                                            <form action="${pageContext.request.contextPath}/app/student/projects" method="post" class="d-inline">
                                                <input type="hidden" name="csrfToken" value="${sessionScope.CSRF_TOKEN}" />
                                                <input type="hidden" name="action" value="delete" />
                                                <input type="hidden" name="projectId" value="${proj.projectId}" />
                                                <button type="submit" class="btn-action-light text-danger" onclick="return confirm('Delete project \'${proj.title}\'?');" title="Delete Project">
                                                    <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><polyline points="3 6 5 6 21 6"></polyline><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path></svg>
                                                    Delete
                                                </button>
                                            </form>
                                        </div>
                                    </div>

                                    <p class="small mb-3 mt-2" style="color: #334155; line-height: 1.55;">
                                        <c:out value="${proj.description}" />
                                    </p>

                                    <div class="pt-2.5 border-top d-flex align-items-center gap-2 flex-wrap">
                                        <c:if test="${not empty proj.githubUrl}">
                                            <a href="<c:out value='${proj.githubUrl}' />" target="_blank" rel="noopener noreferrer" class="btn-action-light">
                                                <svg width="13" height="13" viewBox="0 0 24 24" fill="currentColor">
                                                    <path fill-rule="evenodd" clip-rule="evenodd" d="M12 2C6.477 2 2 6.484 2 12.017c0 4.425 2.865 8.18 6.839 9.504.5.092.682-.217.682-.483 0-.237-.008-.868-.013-1.703-2.782.605-3.369-1.343-3.369-1.343-.454-1.158-1.11-1.466-1.11-1.466-.908-.62.069-.608.069-.608 1.003.07 1.53 1.032 1.53 1.032.892 1.53 2.341 1.088 2.91.832.092-.647.35-1.088.636-1.338-2.22-.253-4.555-1.113-4.555-4.951 0-1.093.39-1.988 1.029-2.688-.103-.253-.446-1.272.098-2.65 0 0 .84-.27 2.75 1.026A9.564 9.564 0 0112 6.844c.85.004 1.705.115 2.504.337 1.909-1.296 2.747-1.027 2.747-1.027.546 1.379.202 2.398.1 2.651.64.7 1.028 1.595 1.028 2.688 0 3.848-2.339 4.695-4.566 4.943.359.309.678.92.678 1.855 0 1.338-.012 2.419-.012 2.747 0 .268.18.58.688.482A10.019 10.019 0 0022 12.017C22 6.484 17.522 2 12 2z"/>
                                                </svg>
                                                GitHub Repository
                                            </a>
                                        </c:if>
                                        <c:if test="${not empty proj.liveDemoUrl}">
                                            <a href="<c:out value='${proj.liveDemoUrl}' />" target="_blank" rel="noopener noreferrer" class="btn-action-light" style="color: #059669; border-color: rgba(16, 185, 129, 0.3);">
                                                <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><circle cx="12" cy="12" r="10"></circle><line x1="2" y1="12" x2="22" y2="12"></line><path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"></path></svg>
                                                Live Deployment
                                            </a>
                                        </c:if>
                                        <c:if test="${empty proj.githubUrl && empty proj.liveDemoUrl}">
                                            <span class="small text-muted">No external URLs linked</span>
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

    <!-- Modal: Live GitHub Sync -->
    <div class="modal fade" id="syncGithubModal" tabindex="-1" role="dialog" aria-labelledby="syncGithubModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content" style="border-radius: 16px; border: 1px solid #e2e8f0; box-shadow: 0 20px 40px rgba(0,0,0,0.15);">
                <form id="syncGithubForm" method="POST" action="${pageContext.request.contextPath}/app/student/sync-platforms" onsubmit="return handleGithubSyncSubmit(this);">
                    <input type="hidden" name="csrfToken" value="${sessionScope.CSRF_TOKEN}">
                    <input type="hidden" name="redirectUri" value="/app/student/projects">
                    
                    <div class="modal-header d-flex align-items-center justify-content-between" style="border-bottom: 1px solid #f1f5f9; padding: 1.25rem 1.5rem;">
                        <div class="d-flex align-items-center gap-2">
                            <div class="d-flex align-items-center justify-content-center" style="width: 34px; height: 34px; border-radius: 10px; background: linear-gradient(135deg, #1e293b, #0f172a); color: #ffffff;">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="currentColor">
                                    <path fill-rule="evenodd" clip-rule="evenodd" d="M12 2C6.477 2 2 6.484 2 12.017c0 4.425 2.865 8.18 6.839 9.504.5.092.682-.217.682-.483 0-.237-.008-.868-.013-1.703-2.782.605-3.369-1.343-3.369-1.343-.454-1.158-1.11-1.466-1.11-1.466-.908-.62.069-.608.069-.608 1.003.07 1.53 1.032 1.53 1.032.892 1.53 2.341 1.088 2.91.832.092-.647.35-1.088.636-1.338-2.22-.253-4.555-1.113-4.555-4.951 0-1.093.39-1.988 1.029-2.688-.103-.253-.446-1.272.098-2.65 0 0 .84-.27 2.75 1.026A9.564 9.564 0 0112 6.844c.85.004 1.705.115 2.504.337 1.909-1.296 2.747-1.027 2.747-1.027.546 1.379.202 2.398.1 2.651.64.7 1.028 1.595 1.028 2.688 0 3.848-2.339 4.695-4.566 4.943.359.309.678.92.678 1.855 0 1.338-.012 2.419-.012 2.747 0 .268.18.58.688.482A10.019 10.019 0 0022 12.017C22 6.484 17.522 2 12 2z"/>
                                </svg>
                            </div>
                            <h5 class="modal-title font-weight-bold text-dark mb-0" id="syncGithubModalLabel" style="font-size: 1.1rem;">Live GitHub Portfolio Sync</h5>
                        </div>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                    <div class="modal-body p-4">
                        <!-- GitHub Username -->
                        <div class="form-group mb-3">
                            <label for="syncGithubUser" class="project-form-label">
                                <span>GitHub Username *</span>
                                <span class="text-muted font-weight-normal" style="font-size: 0.75rem;">e.g. octocat or your_handle</span>
                            </label>
                            <div class="input-icon-wrapper">
                                <span class="input-icon-left">
                                    <svg width="15" height="15" viewBox="0 0 24 24" fill="currentColor">
                                        <path fill-rule="evenodd" clip-rule="evenodd" d="M12 2C6.477 2 2 6.484 2 12.017c0 4.425 2.865 8.18 6.839 9.504.5.092.682-.217.682-.483 0-.237-.008-.868-.013-1.703-2.782.605-3.369-1.343-3.369-1.343-.454-1.158-1.11-1.466-1.11-1.466-.908-.62.069-.608.069-.608 1.003.07 1.53 1.032 1.53 1.032.892 1.53 2.341 1.088 2.91.832.092-.647.35-1.088.636-1.338-2.22-.253-4.555-1.113-4.555-4.951 0-1.093.39-1.988 1.029-2.688-.103-.253-.446-1.272.098-2.65 0 0 .84-.27 2.75 1.026A9.564 9.564 0 0112 6.844c.85.004 1.705.115 2.504.337 1.909-1.296 2.747-1.027 2.747-1.027.546 1.379.202 2.398.1 2.651.64.7 1.028 1.595 1.028 2.688 0 3.848-2.339 4.695-4.566 4.943.359.309.678.92.678 1.855 0 1.338-.012 2.419-.012 2.747 0 .268.18.58.688.482A10.019 10.019 0 0022 12.017C22 6.484 17.522 2 12 2z"/>
                                    </svg>
                                </span>
                                <input type="text" class="project-input input-with-icon-left" id="syncGithubUser" name="githubUsername" value="<c:out value='${codingProfile != null ? codingProfile.githubUsername : ""}' />" required placeholder="Enter GitHub username (without @)">
                            </div>
                            <small class="text-muted mt-1 d-block">System will fetch public repository count, bio, avatar, and verify your open source portfolio.</small>
                        </div>

                        <!-- Auto-import Repositories Checkbox -->
                        <div class="custom-control custom-checkbox p-3 mt-3" style="background: rgba(30, 41, 59, 0.04); border: 1px solid rgba(30, 41, 59, 0.12); border-radius: 12px;">
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
                        <button type="button" class="btn-action-light" data-dismiss="modal">Cancel</button>
                        <button type="submit" id="triggerGithubSyncBtn" class="btn-github-sync">
                            <span id="githubSyncSpinner" class="spinner-border spinner-border-sm d-none mr-1" role="status" aria-hidden="true"></span>
                            <span id="githubSyncBtnText">🚀 Fetch &amp; Sync GitHub Profile</span>
                        </button>
                    </div>
                </form>
            </div>
        </div>
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
