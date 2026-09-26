<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="DSA Progress Tracker" />
<c:set var="activeNav" value="dsa" />
<%@ include file="/WEB-INF/views/common/header.jspf" %>
<%@ include file="/WEB-INF/views/common/navbar.jspf" %>

<style>
    .dsa-page-wrapper {
        max-width: 1440px;
        margin: 0 auto;
    }

    /* Glassmorphic Page Header */
    .dsa-header-card {
        background: rgba(255, 255, 255, 0.85);
        backdrop-filter: blur(12px);
        -webkit-backdrop-filter: blur(12px);
        border: 1px solid rgba(226, 232, 240, 0.8);
        border-radius: 16px;
        padding: 1.25rem 1.5rem;
        box-shadow: 0 4px 20px -2px rgba(0, 0, 0, 0.03);
        margin-bottom: 1.5rem;
    }

    /* LeetCode Auto-Sync Banner */
    .leetcode-sync-card {
        background: linear-gradient(135deg, rgba(255, 255, 255, 0.98), rgba(248, 250, 252, 0.95));
        border: 1px solid rgba(226, 232, 240, 0.95);
        border-radius: 16px;
        padding: 1.25rem 1.5rem;
        box-shadow: 0 4px 20px -2px rgba(0, 0, 0, 0.03);
        margin-bottom: 1.5rem;
    }

    .leetcode-icon-box {
        width: 48px;
        height: 48px;
        border-radius: 14px;
        background: linear-gradient(135deg, #fffbeb, #fef3c7);
        border: 1.5px solid rgba(245, 158, 11, 0.3);
        box-shadow: 0 8px 16px -4px rgba(245, 158, 11, 0.25);
        display: flex;
        align-items: center;
        justify-content: center;
        flex-shrink: 0;
    }

    /* Standard Cards */
    .dsa-card {
        background: #ffffff;
        border: 1px solid rgba(226, 232, 240, 0.85);
        border-radius: 16px;
        box-shadow: 0 4px 20px -2px rgba(0, 0, 0, 0.03);
        margin-bottom: 1.5rem;
        overflow: hidden;
    }

    .dsa-card-header {
        padding: 1.15rem 1.5rem;
        background: rgba(248, 250, 252, 0.7);
        border-bottom: 1px solid rgba(226, 232, 240, 0.8);
        display: flex;
        align-items: center;
        justify-content: space-between;
        flex-wrap: wrap;
        gap: 0.75rem;
    }

    .dsa-card-body {
        padding: 1.5rem;
    }

    /* Metric Cards */
    .dsa-metric-card {
        background: #ffffff;
        border: 1px solid rgba(226, 232, 240, 0.85);
        border-radius: 16px;
        padding: 1.25rem 1.5rem;
        box-shadow: 0 4px 20px -2px rgba(0, 0, 0, 0.03);
        height: 100%;
        display: flex;
        flex-column;
        justify-content: space-between;
        transition: all 0.2s ease;
    }

    .dsa-metric-card:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 24px -4px rgba(0, 0, 0, 0.06);
    }

    .dsa-metric-label {
        font-size: 0.75rem;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 0.05em;
        margin-bottom: 0.35rem;
    }

    .dsa-metric-value {
        font-size: 2.25rem;
        font-weight: 800;
        line-height: 1.1;
        letter-spacing: -0.03em;
        color: #0f172a;
        margin-bottom: 0.5rem;
    }

    /* Form Controls */
    .dsa-form-label {
        font-size: 0.825rem;
        font-weight: 600;
        color: #334155;
        margin-bottom: 0.4rem;
        display: flex;
        align-items: center;
        justify-content: space-between;
    }

    .dsa-input {
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

    .dsa-input:focus {
        border-color: #3b82f6;
        outline: none;
        box-shadow: 0 0 0 3.5px rgba(59, 130, 246, 0.12);
    }

    .dsa-textarea {
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

    .dsa-textarea:focus {
        border-color: #3b82f6;
        outline: none;
        box-shadow: 0 0 0 3.5px rgba(59, 130, 246, 0.12);
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

    .ios-pill-amber {
        background: rgba(245, 158, 11, 0.1);
        color: #d97706;
        border: 1px solid rgba(245, 158, 11, 0.2);
    }

    .ios-pill-rose {
        background: rgba(239, 68, 68, 0.1);
        color: #dc2626;
        border: 1px solid rgba(239, 68, 68, 0.2);
    }

    .ios-pill-purple {
        background: rgba(139, 92, 246, 0.1);
        color: #7c3aed;
        border: 1px solid rgba(139, 92, 246, 0.2);
    }

    .ios-pill-gray {
        background: #f1f5f9;
        color: #475569;
        border: 1px solid #e2e8f0;
    }

    /* Segmented Control Buttons */
    .segmented-control-wrapper {
        display: inline-flex;
        background: #f1f5f9;
        padding: 3px;
        border-radius: 12px;
        border: 1px solid #e2e8f0;
        gap: 2px;
    }

    .segmented-control-btn {
        padding: 0.4rem 0.85rem;
        font-size: 0.8rem;
        font-weight: 600;
        border: none;
        background: transparent;
        color: #64748b;
        border-radius: 9px;
        transition: all 0.2s ease;
        cursor: pointer;
        outline: none !important;
        white-space: nowrap;
    }

    .segmented-control-btn.active {
        background: #ffffff;
        color: #0f172a;
        box-shadow: 0 2px 6px rgba(0, 0, 0, 0.08);
    }

    /* Search Box */
    .dsa-search-wrapper {
        position: relative;
        min-width: 220px;
    }

    .dsa-search-input {
        background: #ffffff;
        border: 1.5px solid #e2e8f0;
        border-radius: 12px;
        padding: 0.45rem 1rem 0.45rem 2.25rem;
        font-size: 0.85rem;
        font-weight: 500;
        color: #1e293b;
        width: 100%;
        transition: all 0.2s ease;
    }

    .dsa-search-input:focus {
        border-color: #3b82f6;
        outline: none;
        box-shadow: 0 0 0 3.5px rgba(59, 130, 246, 0.12);
    }

    .dsa-search-icon {
        position: absolute;
        left: 0.8rem;
        top: 50%;
        transform: translateY(-50%);
        color: #94a3b8;
        pointer-events: none;
    }

    /* Buttons */
    .btn-dsa-sync {
        background: linear-gradient(135deg, #f59e0b, #d97706);
        color: #ffffff;
        border: none;
        border-radius: 12px;
        padding: 0.65rem 1.35rem;
        font-size: 0.875rem;
        font-weight: 600;
        display: inline-flex;
        align-items: center;
        gap: 0.5rem;
        box-shadow: 0 4px 14px -2px rgba(245, 158, 11, 0.4);
        transition: all 0.2s ease;
        cursor: pointer;
        text-decoration: none !important;
    }

    .btn-dsa-sync:hover {
        transform: translateY(-1px);
        box-shadow: 0 6px 18px -2px rgba(245, 158, 11, 0.5);
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

    .btn-quick-add {
        background: #f1f5f9;
        border: 1px solid #e2e8f0;
        border-radius: 8px;
        font-size: 0.75rem;
        font-weight: 700;
        color: #334155;
        padding: 0.25rem 0.65rem;
        transition: all 0.2s ease;
        cursor: pointer;
    }

    .btn-quick-add:hover {
        background: #e2e8f0;
        color: #0f172a;
    }

    /* Modal Checkbox Card */
    .modal-checkbox-card {
        display: flex;
        align-items: flex-start;
        gap: 0.75rem;
        padding: 1rem;
        background: #f8fafc;
        border: 1.5px solid #e2e8f0;
        border-radius: 12px;
        margin-top: 1rem;
        cursor: pointer;
        transition: all 0.2s ease;
    }

    .modal-checkbox-card:hover {
        border-color: #cbd5e1;
        background: #f1f5f9;
    }

    .modal-checkbox-input {
        width: 18px;
        height: 18px;
        accent-color: #f59e0b;
        margin-top: 2px;
        cursor: pointer;
        flex-shrink: 0;
    }
</style>

<div class="container-fluid px-3 px-lg-4 py-4 dsa-page-wrapper">
    <%@ include file="/WEB-INF/views/common/alerts.jspf" %>

    <!-- Header Banner -->
    <div class="dsa-header-card">
        <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">
            <div>
                <div class="d-flex align-items-center gap-2 mb-1">
                    <span class="ios-pill-badge ios-pill-amber">
                        <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"></polygon></svg>
                        Algorithms Engine
                    </span>
                </div>
                <h1 class="h3 font-weight-bold text-gray-900 mb-0" style="letter-spacing: -0.025em;">Data Structures &amp; Algorithms Tracker</h1>
                <p class="text-muted small mb-0 mt-1">Systematically track your topic-wise problem solving progress across 18 core DSA topics</p>
            </div>
            <div class="d-flex align-items-center gap-2 flex-wrap">
                <a href="${pageContext.request.contextPath}/app/student/code-playground" class="btn-action-light" style="background: linear-gradient(135deg, #3b82f6, #2563eb); color: #ffffff; border: none; padding: 0.6rem 1.15rem; font-size: 0.85rem; box-shadow: 0 4px 12px rgba(37, 99, 235, 0.3);">
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><polyline points="16 18 22 12 16 6"></polyline><polyline points="8 6 2 12 8 18"></polyline></svg>
                    <span>⚡ Code Playground</span>
                </a>
                <span class="ios-pill-badge ios-pill-emerald" style="font-size: 0.825rem; padding: 0.45rem 0.95rem;">
                    <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg>
                    150 Problems Benchmark
                </span>
            </div>
        </div>
    </div>

    <!-- Live LeetCode Auto-Sync Engine Card -->
    <div class="leetcode-sync-card">
        <div class="d-flex flex-column flex-lg-row align-items-lg-center justify-content-between gap-3">
            <div class="d-flex align-items-start gap-3">
                <div class="leetcode-icon-box">
                    <!-- Official LeetCode Vector SVG Icon -->
                    <svg width="26" height="26" viewBox="0 0 24 24" fill="#FFA116" xmlns="http://www.w3.org/2000/svg">
                        <path d="M13.483 0a1.374 1.374 0 0 0-.961.438L7.116 6.226l-3.854 4.126a5.266 5.266 0 0 0-1.209 2.104 5.35 5.35 0 0 0-.125.513 5.527 5.527 0 0 0 .062 2.362 5.83 5.83 0 0 0 .349 1.017 5.938 5.938 0 0 0 1.271 1.818l4.277 4.193.039.038c2.248 2.165 5.852 2.133 8.063-.074l2.396-2.392c.54-.54.54-1.414.003-1.955a1.378 1.378 0 0 0-1.951-.003l-2.396 2.392a3.021 3.021 0 0 1-4.205.038l-.02-.019-4.276-4.193c-.652-.64-.972-1.469-.948-2.263a2.68 2.68 0 0 1 .666-1.607L9.4 7.64l4.083-4.371A1.38 1.38 0 0 0 13.483 0zm-2.88 7.218a1.38 1.38 0 0 0-.979.405l-4.54 4.54a1.38 1.38 0 0 0 0 1.952l4.54 4.54a1.38 1.38 0 0 0 1.952-1.952L7.962 13.11l3.614-3.614a1.38 1.38 0 0 0-.973-2.278z"/>
                    </svg>
                </div>
                <div>
                    <div class="d-flex align-items-center flex-wrap gap-2 mb-1">
                        <h2 class="h5 font-weight-bold text-dark mb-0" style="font-size: 1.05rem; letter-spacing: -0.02em;">Live LeetCode Auto-Sync Engine</h2>
                        <c:choose>
                            <c:when test="${codingProfile != null && codingProfile.leetCodeSynced}">
                                <span class="ios-pill-badge ios-pill-emerald" style="font-size: 0.72rem; padding: 2px 8px;">
                                    ✓ Live Verified on LeetCode (@<c:out value="${codingProfile.leetcodeUsername}" />)
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span class="ios-pill-badge ios-pill-amber" style="font-size: 0.72rem; padding: 2px 8px;">
                                    LeetCode API &bull; No Manual Entry Needed
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <p class="text-muted small mb-2" style="max-width: 680px; line-height: 1.45;">
                        Connect your LeetCode handle to automatically fetch real-time solved problems (Easy, Medium, Hard breakdown), global ranking, and verified contest ratings.
                    </p>

                    <!-- Live Chips Bar -->
                    <c:if test="${codingProfile != null && codingProfile.leetCodeSynced}">
                        <div class="d-flex align-items-center flex-wrap gap-2 pt-1">
                            <span class="ios-pill-badge ios-pill-emerald">
                                🟢 Easy: <c:out value="${codingProfile.leetcodeEasySolved}" />
                            </span>
                            <span class="ios-pill-badge ios-pill-amber">
                                🟡 Medium: <c:out value="${codingProfile.leetcodeMediumSolved}" />
                            </span>
                            <span class="ios-pill-badge ios-pill-rose">
                                🔴 Hard: <c:out value="${codingProfile.leetcodeHardSolved}" />
                            </span>
                            <c:if test="${codingProfile.leetcodeRanking > 0}">
                                <span class="ios-pill-badge ios-pill-purple">
                                    🏆 Global Rank: #<c:out value="${codingProfile.leetcodeRanking}" />
                                </span>
                            </c:if>
                        </div>
                    </c:if>
                </div>
            </div>

            <div class="d-flex align-items-center flex-wrap gap-2 flex-shrink-0">
                <button type="button" class="btn-dsa-sync" data-toggle="modal" data-target="#syncPlatformsModal">
                    <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"></polygon></svg>
                    ${codingProfile != null && codingProfile.leetCodeSynced ? 'Re-Sync LeetCode Stats' : 'Connect &amp; Auto-Sync LeetCode'}
                </button>
            </div>
        </div>
    </div>

    <!-- 3 Top Metric Cards -->
    <div class="row mb-4">
        <!-- Total Solved -->
        <div class="col-md-4 mb-3">
            <div class="dsa-metric-card" style="border-top: 4px solid #f59e0b;">
                <div>
                    <div class="dsa-metric-label" style="color: #d97706;">Total Problems Solved</div>
                    <div class="dsa-metric-value"><c:out value="${totalSolved}" default="0" /></div>
                </div>
                <div class="d-flex justify-content-between align-items-center small pt-2 border-top" style="color: #64748b;">
                    <span>Target Benchmark</span>
                    <strong class="text-dark">150 Problems</strong>
                </div>
            </div>
        </div>

        <!-- Topic Coverage -->
        <div class="col-md-4 mb-3">
            <div class="dsa-metric-card" style="border-top: 4px solid #10b981;">
                <div>
                    <div class="dsa-metric-label" style="color: #059669;">Topic Coverage</div>
                    <div class="dsa-metric-value">
                        <c:out value="${completedTopics}" default="0" /> 
                        <span style="font-size: 1.15rem; font-weight: 600; color: #64748b;">/ <c:out value="${totalTopics}" default="18" /> topics</span>
                    </div>
                </div>
                <div class="d-flex justify-content-between align-items-center small pt-2 border-top" style="color: #64748b;">
                    <span>In Progress</span>
                    <strong style="color: #d97706;"><c:out value="${inProgressTopics}" default="0" /> active topics</strong>
                </div>
            </div>
        </div>

        <!-- Readiness Index -->
        <div class="col-md-4 mb-3">
            <div class="dsa-metric-card" style="border-top: 4px solid #3b82f6;">
                <div>
                    <div class="dsa-metric-label" style="color: #2563eb;">DSA Readiness Index</div>
                    <div class="dsa-metric-value">
                        <fmt:formatNumber value="${totalSolved >= 150 ? 100 : (totalSolved * 100.0 / 150)}" maxFractionDigits="1" minFractionDigits="1" />%
                    </div>
                </div>
                <div>
                    <div class="w-100" style="height: 6px; border-radius: 999px; background: #f1f5f9; overflow: hidden;">
                        <div style="width: ${totalSolved >= 150 ? 100 : (totalSolved * 100.0 / 150)}%; background: linear-gradient(90deg, #3b82f6, #06b6d4); height: 100%; border-radius: 999px; transition: width 0.6s ease;"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Topic Progress Matrix Card -->
    <div class="dsa-card">
        <div class="dsa-card-header flex-column flex-md-row align-items-md-center justify-content-between gap-3">
            <div>
                <span class="font-weight-bold text-dark" style="font-size: 1rem;">Topic Progress Matrix</span>
                <small class="text-muted d-block">Search topics and filter by completion status in real-time</small>
            </div>

            <!-- Search & Filter Controls -->
            <div class="d-flex flex-column flex-md-row align-items-stretch align-items-md-center gap-2 w-100 w-md-auto">
                <!-- Search Box -->
                <div class="dsa-search-wrapper">
                    <span class="dsa-search-icon">
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </span>
                    <input type="text" id="topicSearchInput" class="dsa-search-input" placeholder="Search DSA topics..." aria-label="Search DSA topics">
                </div>

                <!-- Status Filter Segmented Control -->
                <div class="segmented-control-wrapper">
                    <button type="button" class="segmented-control-btn active filter-status-btn" data-status="ALL">All (18)</button>
                    <button type="button" class="segmented-control-btn filter-status-btn" data-status="COMPLETED">Completed (${completedTopics})</button>
                    <button type="button" class="segmented-control-btn filter-status-btn" data-status="IN_PROGRESS">In Progress (${inProgressTopics})</button>
                    <button type="button" class="segmented-control-btn filter-status-btn" data-status="NOT_STARTED">Not Started</button>
                </div>
            </div>
        </div>

        <div class="p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0" id="dsaTopicsTable" style="border-collapse: separate;">
                    <thead style="background: rgba(248, 250, 252, 0.9);">
                        <tr style="border-bottom: 1px solid #e2e8f0;">
                            <th class="border-top-0 font-weight-bold small text-uppercase py-3 px-4" style="color: #475569; letter-spacing: 0.05em; width: 60px;">#</th>
                            <th class="border-top-0 font-weight-bold small text-uppercase py-3" style="color: #475569; letter-spacing: 0.05em;">DSA Topic</th>
                            <th class="border-top-0 font-weight-bold small text-uppercase py-3" style="color: #475569; letter-spacing: 0.05em;">Category</th>
                            <th class="border-top-0 font-weight-bold small text-uppercase py-3" style="color: #475569; letter-spacing: 0.05em;">Status</th>
                            <th class="border-top-0 font-weight-bold small text-uppercase py-3" style="color: #475569; letter-spacing: 0.05em;">Problems Solved</th>
                            <th class="border-top-0 font-weight-bold small text-uppercase py-3" style="color: #475569; letter-spacing: 0.05em;">Study Notes / Patterns</th>
                            <th class="border-top-0 font-weight-bold small text-uppercase py-3 px-4 text-right" style="color: #475569; letter-spacing: 0.05em; width: 110px;">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${progressList}" var="p" varStatus="loop">
                            <tr class="dsa-topic-row" 
                                data-topic-name="${p.topicName.toLowerCase()}" 
                                data-status="${p.status}"
                                style="border-bottom: 1px solid #f1f5f9; transition: background 0.15s ease;">
                                <td class="small py-3 px-4 font-weight-bold" style="color: #64748b; vertical-align: middle;">
                                    <c:out value="${loop.count}" />
                                </td>
                                <td class="py-3" style="vertical-align: middle;">
                                    <div class="font-weight-bold text-dark" style="font-size: 0.95rem;"><c:out value="${p.topicName}" /></div>
                                </td>
                                <td style="vertical-align: middle;">
                                    <span class="ios-pill-badge ios-pill-gray">
                                        <c:out value="${p.topicCategory.displayName}" />
                                    </span>
                                </td>
                                <td style="vertical-align: middle;">
                                    <c:choose>
                                        <c:when test="${p.status == 'COMPLETED'}">
                                            <span class="ios-pill-badge ios-pill-emerald">
                                                <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3"><polyline points="20 6 9 17 4 12"></polyline></svg>
                                                Completed
                                            </span>
                                        </c:when>
                                        <c:when test="${p.status == 'IN_PROGRESS'}">
                                            <span class="ios-pill-badge ios-pill-amber">
                                                <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg>
                                                In Progress
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="ios-pill-badge ios-pill-gray">
                                                Not Started
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td style="vertical-align: middle;">
                                    <div class="d-flex align-items-center gap-1.5">
                                        <span class="font-weight-bold text-dark" style="font-size: 0.95rem;"><c:out value="${p.problemsSolved}" /></span>
                                        <span class="small text-muted">solved</span>
                                    </div>
                                </td>
                                <td class="small py-3" style="color: #475569; max-width: 260px; vertical-align: middle;">
                                    <c:choose>
                                        <c:when test="${not empty p.notes}">
                                            <div class="text-dark" style="display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; line-height: 1.4;">
                                                <c:out value="${p.notes}" />
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <span style="color: #94a3b8; font-style: italic;">No notes recorded</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-right py-3 px-4" style="vertical-align: middle;">
                                    <button type="button" class="btn-action-light edit-topic-btn" 
                                        data-topic-id="${p.topicId}"
                                        data-topic-name="<c:out value='${p.topicName}' />"
                                        data-category="<c:out value='${p.topicCategory.displayName}' />"
                                        data-status="${p.status}"
                                        data-problems="<c:out value='${p.problemsSolved}' />"
                                        data-notes="<c:out value='${p.notes}' />"
                                        aria-label="Update progress for ${p.topicName}">
                                        <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M12 20h9"></path><path d="M16.5 3.5a2.121 2.121 0 0 1 3 3L7 19l-4 1 1-4L16.5 3.5z"></path></svg>
                                        Update
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <!-- Empty Filter State -->
                <div id="noMatchMessage" class="text-center py-5 d-none" style="color: #64748b;">
                    <div class="ios-pill-badge ios-pill-gray p-3 mb-2" style="width: 48px; height: 48px; border-radius: 50%; display: inline-flex; align-items: center; justify-content: center;">
                        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    </div>
                    <div class="font-weight-bold text-dark mt-1">No matching DSA topics found</div>
                    <small class="text-muted">Try adjusting your search query or status filter.</small>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal: Update DSA Topic (Apple Sheet Style) -->
    <div class="modal fade" id="editDsaModal" tabindex="-1" role="dialog" aria-labelledby="editDsaModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content" style="border-radius: 18px; border: 1px solid #e2e8f0; box-shadow: 0 20px 40px rgba(0,0,0,0.15); overflow: hidden;">
                <div class="modal-header d-flex align-items-center justify-content-between" style="padding: 1.25rem 1.5rem; border-bottom: 1px solid #f1f5f9; background: #ffffff;">
                    <div class="d-flex align-items-center gap-2.5" style="gap: 0.75rem;">
                        <div class="d-flex align-items-center justify-content-center" style="width: 36px; height: 36px; border-radius: 10px; background: rgba(245, 158, 11, 0.12); color: #d97706;">
                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"></polygon></svg>
                        </div>
                        <div>
                            <h5 class="modal-title font-weight-bold text-dark mb-0" id="editDsaModalLabel" style="font-size: 1.05rem;">
                                Update DSA Topic
                            </h5>
                            <small class="text-muted" id="modalTopicCategory">Core DSA</small>
                        </div>
                    </div>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="width: 32px; height: 32px; border-radius: 8px; display: flex; align-items: center; justify-content: center; background: #f1f5f9; border: none; font-size: 1.25rem; color: #64748b; line-height: 1; padding: 0; outline: none;">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <form action="${pageContext.request.contextPath}/app/student/dsa" method="post">
                    <input type="hidden" name="csrfToken" value="${sessionScope.CSRF_TOKEN}" />
                    <input type="hidden" id="modalTopicId" name="topicId" value="" />
                    <div class="modal-body p-4" style="background: #ffffff;">
                        <div class="form-group mb-3">
                            <label for="modalStatus" class="dsa-form-label">Topic Preparation Status</label>
                            <select class="dsa-input" id="modalStatus" name="status">
                                <option value="NOT_STARTED">Not Started</option>
                                <option value="IN_PROGRESS">In Progress</option>
                                <option value="COMPLETED">Completed</option>
                            </select>
                        </div>

                        <div class="form-group mb-3">
                            <div class="d-flex justify-content-between align-items-center mb-1">
                                <label for="modalProblems" class="dsa-form-label mb-0">Problems Solved</label>
                                <div class="d-flex gap-1" style="gap: 0.35rem;">
                                    <button type="button" class="btn-quick-add quick-add-btn" data-add="1">+1</button>
                                    <button type="button" class="btn-quick-add quick-add-btn" data-add="5">+5</button>
                                    <button type="button" class="btn-quick-add quick-add-btn" data-add="10">+10</button>
                                </div>
                            </div>
                            <input type="number" class="dsa-input" id="modalProblems" name="problemsSolved" min="0" required placeholder="Number of problems solved">
                        </div>

                        <div class="form-group mb-0">
                            <label for="modalNotes" class="dsa-form-label">Key Patterns &amp; Interview Notes</label>
                            <textarea class="dsa-textarea" id="modalNotes" name="notes" rows="3" placeholder="e.g. Mastered fast/slow pointer, two-pointer convergence, prefix sums, binary search on answer space..."></textarea>
                        </div>
                    </div>
                    <div class="modal-footer d-flex justify-content-end gap-2" style="border-top: 1px solid #f1f5f9; padding: 1.15rem 1.5rem; background: #ffffff;">
                        <button type="button" class="btn-action-light" data-dismiss="modal" style="padding: 0.55rem 1.25rem;">Cancel</button>
                        <button type="submit" class="btn-dsa-sync" style="padding: 0.55rem 1.5rem;">Save Progress</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Modal: Live LeetCode Auto-Sync -->
    <div class="modal fade" id="syncPlatformsModal" tabindex="-1" role="dialog" aria-labelledby="syncPlatformsModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content" style="border-radius: 18px; border: 1px solid #e2e8f0; box-shadow: 0 20px 40px rgba(0,0,0,0.15); overflow: hidden;">
                <form id="syncPlatformForm" method="POST" action="${pageContext.request.contextPath}/app/student/sync-platforms" onsubmit="return handleSyncFormSubmit(this);">
                    <input type="hidden" name="csrfToken" value="${sessionScope.CSRF_TOKEN}">
                    <input type="hidden" name="redirectUri" value="/app/student/dsa">
                    
                    <div class="modal-header d-flex align-items-center justify-content-between" style="border-bottom: 1px solid #f1f5f9; padding: 1.25rem 1.5rem; background: #ffffff;">
                        <div class="d-flex align-items-center gap-2.5" style="gap: 0.75rem;">
                            <div class="d-flex align-items-center justify-content-center" style="width: 36px; height: 36px; border-radius: 10px; background: linear-gradient(135deg, #fffbeb, #fef3c7); border: 1.5px solid rgba(245, 158, 11, 0.3);">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="#FFA116">
                                    <path d="M13.483 0a1.374 1.374 0 0 0-.961.438L7.116 6.226l-3.854 4.126a5.266 5.266 0 0 0-1.209 2.104 5.35 5.35 0 0 0-.125.513 5.527 5.527 0 0 0 .062 2.362 5.83 5.83 0 0 0 .349 1.017 5.938 5.938 0 0 0 1.271 1.818l4.277 4.193.039.038c2.248 2.165 5.852 2.133 8.063-.074l2.396-2.392c.54-.54.54-1.414.003-1.955a1.378 1.378 0 0 0-1.951-.003l-2.396 2.392a3.021 3.021 0 0 1-4.205.038l-.02-.019-4.276-4.193c-.652-.64-.972-1.469-.948-2.263a2.68 2.68 0 0 1 .666-1.607L9.4 7.64l4.083-4.371A1.38 1.38 0 0 0 13.483 0zm-2.88 7.218a1.38 1.38 0 0 0-.979.405l-4.54 4.54a1.38 1.38 0 0 0 0 1.952l4.54 4.54a1.38 1.38 0 0 0 1.952-1.952L7.962 13.11l3.614-3.614a1.38 1.38 0 0 0-.973-2.278z"/>
                                </svg>
                            </div>
                            <h5 class="modal-title font-weight-bold text-dark mb-0" id="syncPlatformsModalLabel" style="font-size: 1.05rem;">Live LeetCode Auto-Sync</h5>
                        </div>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="width: 32px; height: 32px; border-radius: 8px; display: flex; align-items: center; justify-content: center; background: #f1f5f9; border: none; font-size: 1.25rem; color: #64748b; line-height: 1; padding: 0; outline: none;">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                    <div class="modal-body p-4" style="background: #ffffff;">
                        <!-- LeetCode Username -->
                        <div class="form-group mb-3">
                            <label for="syncLeetcodeUser" class="dsa-form-label">
                                <span>LeetCode Username *</span>
                                <span class="text-muted font-weight-normal" style="font-size: 0.75rem;">e.g. tourist or your_handle</span>
                            </label>
                            <div class="position-relative">
                                <span class="position-absolute" style="left: 12px; top: 50%; transform: translateY(-50%); display: flex; align-items: center; pointer-events: none;">
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="#FFA116">
                                        <path d="M13.483 0a1.374 1.374 0 0 0-.961.438L7.116 6.226l-3.854 4.126a5.266 5.266 0 0 0-1.209 2.104 5.35 5.35 0 0 0-.125.513 5.527 5.527 0 0 0 .062 2.362 5.83 5.83 0 0 0 .349 1.017 5.938 5.938 0 0 0 1.271 1.818l4.277 4.193.039.038c2.248 2.165 5.852 2.133 8.063-.074l2.396-2.392c.54-.54.54-1.414.003-1.955a1.378 1.378 0 0 0-1.951-.003l-2.396 2.392a3.021 3.021 0 0 1-4.205.038l-.02-.019-4.276-4.193c-.652-.64-.972-1.469-.948-2.263a2.68 2.68 0 0 1 .666-1.607L9.4 7.64l4.083-4.371A1.38 1.38 0 0 0 13.483 0zm-2.88 7.218a1.38 1.38 0 0 0-.979.405l-4.54 4.54a1.38 1.38 0 0 0 0 1.952l4.54 4.54a1.38 1.38 0 0 0 1.952-1.952L7.962 13.11l3.614-3.614a1.38 1.38 0 0 0-.973-2.278z"/>
                                    </svg>
                                </span>
                                <input type="text" class="dsa-input" id="syncLeetcodeUser" name="leetcodeUsername" value="<c:out value='${codingProfile != null ? codingProfile.leetcodeUsername : ""}' />" required placeholder="Enter LeetCode username" style="padding-left: 2.5rem;">
                            </div>
                            <small class="text-muted mt-1.5 d-block" style="font-size: 0.775rem;">System will fetch Easy, Medium, Hard problem counts &amp; global rank in real-time.</small>
                        </div>

                        <!-- Auto-distribute Checkbox Card -->
                        <div class="modal-checkbox-card" onclick="var cb = document.getElementById('autoDistributeDsa'); if(event.target !== cb) cb.checked = !cb.checked;">
                            <input type="checkbox" class="modal-checkbox-input" id="autoDistributeDsa" name="autoDistribute" value="true" checked>
                            <div>
                                <label for="autoDistributeDsa" class="font-weight-bold text-dark small mb-0" style="cursor: pointer; font-size: 0.825rem; line-height: 1.4; display: block;">
                                    ⚡ Auto-allocate solved count across 18 DSA topic matrices
                                </label>
                                <p class="text-muted small mb-0 mt-1" style="font-size: 0.75rem; line-height: 1.45;">
                                    Automatically updates topic completion status, boosts your Readiness Score, and updates your Placement Passport.
                                </p>
                            </div>
                        </div>
                    </div>

                    <div class="modal-footer d-flex justify-content-between align-items-center" style="border-top: 1px solid #f1f5f9; padding: 1.15rem 1.5rem; background: #ffffff;">
                        <button type="button" class="btn-action-light" data-dismiss="modal" style="padding: 0.55rem 1.25rem;">Cancel</button>
                        <button type="submit" id="triggerLiveSyncBtn" class="btn-dsa-sync">
                            <span id="syncBtnSpinner" class="spinner-border spinner-border-sm d-none mr-1" role="status" aria-hidden="true"></span>
                            <span id="syncBtnText">🚀 Fetch &amp; Sync LeetCode Stats</span>
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // 1. Dynamic modal population for DSA Topic update
    $('.edit-topic-btn').on('click', function() {
        var btn = $(this);
        var topicId = btn.data('topic-id');
        var topicName = btn.data('topic-name');
        var category = btn.data('category');
        var status = btn.data('status');
        var problems = btn.data('problems');
        var notes = btn.data('notes');

        $('#modalTopicId').val(topicId);
        $('#editDsaModalLabel').text(topicName);
        $('#modalTopicCategory').text(category || 'Core DSA');
        $('#modalStatus').val(status || 'NOT_STARTED');
        $('#modalProblems').val(problems !== undefined ? problems : '0');
        $('#modalNotes').val(notes || '');

        $('#editDsaModal').modal('show');
    });

    // 2. Quick Increment Buttons in Modal (+1, +5, +10)
    $('.quick-add-btn').on('click', function() {
        var addVal = parseInt($(this).data('add'), 10) || 0;
        var current = parseInt($('#modalProblems').val(), 10) || 0;
        $('#modalProblems').val(current + addVal);
    });

    // 3. Real-time Search and Status Filter
    var currentStatusFilter = 'ALL';

    function filterTopics() {
        var searchQuery = $('#topicSearchInput').val().toLowerCase().trim();
        var visibleCount = 0;

        $('.dsa-topic-row').each(function() {
            var row = $(this);
            var topicName = row.data('topic-name') || '';
            var status = row.data('status') || '';

            var matchesSearch = (searchQuery === '' || topicName.indexOf(searchQuery) !== -1);
            var matchesStatus = (currentStatusFilter === 'ALL' || status === currentStatusFilter);

            if (matchesSearch && matchesStatus) {
                row.show();
                visibleCount++;
            } else {
                row.hide();
            }
        });

        if (visibleCount === 0) {
            $('#noMatchMessage').removeClass('d-none');
        } else {
            $('#noMatchMessage').addClass('d-none');
        }
    }

    $('#topicSearchInput').on('input', filterTopics);

    $('.filter-status-btn').on('click', function() {
        $('.filter-status-btn').removeClass('active');
        $(this).addClass('active');
        currentStatusFilter = $(this).data('status');
        filterTopics();
    });
});

function handleSyncFormSubmit(form) {
    var leetcodeUser = (form.leetcodeUsername && form.leetcodeUsername.value) ? form.leetcodeUsername.value.trim() : '';

    if (!leetcodeUser) {
        alert('Please enter your LeetCode username to sync.');
        return false;
    }

    var btn = document.getElementById('triggerLiveSyncBtn');
    var spinner = document.getElementById('syncBtnSpinner');
    var btnText = document.getElementById('syncBtnText');

    if (btn) {
        btn.disabled = true;
        btn.style.opacity = '0.75';
    }
    if (spinner) spinner.classList.remove('d-none');
    if (btnText) btnText.textContent = 'Querying LeetCode API & Syncing...';

    return true;
}
</script>

<%@ include file="/WEB-INF/views/common/footer.jspf" %>
