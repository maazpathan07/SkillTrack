<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Admin Dashboard" />
<c:set var="activeNav" value="admin-dashboard" />
<%@ include file="/WEB-INF/views/common/header.jspf" %>
<%@ include file="/WEB-INF/views/common/navbar.jspf" %>

<div class="container-fluid">
    <div class="row">
        <%@ include file="/WEB-INF/views/common/sidebar.jspf" %>

        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4 py-4">
            <%@ include file="/WEB-INF/views/common/alerts.jspf" %>

            <!-- Apple Glass Header -->
            <div class="ios-dash-header d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center mb-4">
                <div>
                    <h1 class="h3 font-weight-bold mb-1" style="color: var(--ios-text-primary); letter-spacing: -0.03em;">Institution Placement Intelligence</h1>
                    <p class="text-muted mb-0" style="font-size: 0.9375rem;">Real-time cohort readiness distribution, departmental talent health, and career pathway analytics</p>
                </div>
                <div class="d-flex align-items-center flex-wrap gap-2 mt-3 mt-md-0" style="gap: 0.75rem;">
                    <a href="${pageContext.request.contextPath}/app/admin/cohort-summary" class="btn btn-outline-secondary d-inline-flex align-items-center" style="border-radius: var(--ios-radius-full); font-weight: 600; font-size: 0.875rem; padding: 0.5rem 1.125rem; border-color: rgba(0,0,0,0.15);">
                        <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="mr-2" aria-hidden="true">
                            <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
                            <polyline points="14 2 14 8 20 8"></polyline>
                            <line x1="16" y1="13" x2="8" y2="13"></line>
                            <line x1="16" y1="17" x2="8" y2="17"></line>
                            <polyline points="10 9 9 9 8 9"></polyline>
                        </svg>
                        Cohort Summary
                    </a>
                    <a href="${pageContext.request.contextPath}/app/admin/students" class="btn btn-primary d-inline-flex align-items-center" style="border-radius: var(--ios-radius-full); font-weight: 600; font-size: 0.875rem; padding: 0.5rem 1.125rem; background: var(--ios-blue); border: none; box-shadow: var(--ios-shadow-btn-blue);">
                        <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="mr-2" aria-hidden="true">
                            <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
                            <circle cx="9" cy="7" r="4"></circle>
                            <path d="M23 21v-2a4 4 0 0 0-3-3.87"></path>
                            <path d="M16 3.13a4 4 0 0 1 0 7.75"></path>
                        </svg>
                        Filter Directory
                    </a>
                </div>
            </div>

            <!-- Top 4 Liquid Glass KPI Metric Cards -->
            <div class="row mb-4">
                <div class="col-xl-3 col-md-6 mb-4">
                    <div class="ios-metric-card h-100 p-4" style="background: rgba(255, 255, 255, 0.88); border: 1px solid var(--ios-border-card); border-radius: var(--ios-radius-lg); box-shadow: var(--ios-shadow-glass); position: relative; overflow: hidden;">
                        <div class="d-flex align-items-center justify-content-between mb-3">
                            <span style="font-size: 0.8125rem; font-weight: 700; text-transform: uppercase; letter-spacing: 0.05em; color: var(--ios-blue);">Enrolled Candidates</span>
                            <div style="width: 38px; height: 38px; border-radius: var(--ios-radius-sm); background: var(--ios-blue-light); color: var(--ios-blue); display: flex; align-items: center; justify-content: center;">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                    <path d="M22 10v6M2 10l10-5 10 5-10 5z"></path>
                                    <path d="M6 12v5c3 3 9 3 12 0v-5"></path>
                                </svg>
                            </div>
                        </div>
                        <div class="h2 font-weight-bold mb-1" style="color: var(--ios-text-primary); letter-spacing: -0.03em;">
                            <c:out value="${stats.totalStudents}" default="0" />
                        </div>
                        <div class="text-muted" style="font-size: 0.8125rem; font-weight: 500;">
                            Verified CS & IT talent pool
                        </div>
                    </div>
                </div>

                <div class="col-xl-3 col-md-6 mb-4">
                    <div class="ios-metric-card h-100 p-4" style="background: rgba(255, 255, 255, 0.88); border: 1px solid var(--ios-border-card); border-radius: var(--ios-radius-lg); box-shadow: var(--ios-shadow-glass); position: relative; overflow: hidden;">
                        <div class="d-flex align-items-center justify-content-between mb-3">
                            <span style="font-size: 0.8125rem; font-weight: 700; text-transform: uppercase; letter-spacing: 0.05em; color: var(--ios-green-dark);">Cohort Avg Readiness</span>
                            <div style="width: 38px; height: 38px; border-radius: var(--ios-radius-sm); background: var(--ios-green-light); color: var(--ios-green-dark); display: flex; align-items: center; justify-content: center;">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                    <circle cx="12" cy="12" r="10"></circle>
                                    <polyline points="12 6 12 12 16 14"></polyline>
                                </svg>
                            </div>
                        </div>
                        <div class="h2 font-weight-bold mb-1" style="color: var(--ios-green-dark); letter-spacing: -0.03em;">
                            <c:out value="${stats.formattedAvgReadiness}" default="0.0" />%
                        </div>
                        <div class="text-muted" style="font-size: 0.8125rem; font-weight: 500;">
                            Benchmark across all 5 pillars
                        </div>
                    </div>
                </div>

                <div class="col-xl-3 col-md-6 mb-4">
                    <div class="ios-metric-card h-100 p-4" style="background: rgba(255, 255, 255, 0.88); border: 1px solid var(--ios-border-card); border-radius: var(--ios-radius-lg); box-shadow: var(--ios-shadow-glass); position: relative; overflow: hidden;">
                        <div class="d-flex align-items-center justify-content-between mb-3">
                            <span style="font-size: 0.8125rem; font-weight: 700; text-transform: uppercase; letter-spacing: 0.05em; color: var(--ios-orange);">Career Pathways</span>
                            <div style="width: 38px; height: 38px; border-radius: var(--ios-radius-sm); background: var(--ios-orange-light); color: var(--ios-orange); display: flex; align-items: center; justify-content: center;">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                    <rect x="2" y="7" width="20" height="14" rx="2" ry="2"></rect>
                                    <path d="M16 21V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v16"></path>
                                </svg>
                            </div>
                        </div>
                        <div class="h2 font-weight-bold mb-1" style="color: var(--ios-text-primary); letter-spacing: -0.03em;">
                            <c:out value="${stats.totalRoles}" default="0" />
                        </div>
                        <div class="text-muted" style="font-size: 0.8125rem; font-weight: 500;">
                            Target roles configured
                        </div>
                    </div>
                </div>

                <div class="col-xl-3 col-md-6 mb-4">
                    <div class="ios-metric-card h-100 p-4" style="background: rgba(255, 255, 255, 0.88); border: 1px solid var(--ios-border-card); border-radius: var(--ios-radius-lg); box-shadow: var(--ios-shadow-glass); position: relative; overflow: hidden;">
                        <div class="d-flex align-items-center justify-content-between mb-3">
                            <span style="font-size: 0.8125rem; font-weight: 700; text-transform: uppercase; letter-spacing: 0.05em; color: var(--ios-indigo);">Company Criteria</span>
                            <div style="width: 38px; height: 38px; border-radius: var(--ios-radius-sm); background: var(--ios-indigo-light); color: var(--ios-indigo); display: flex; align-items: center; justify-content: center;">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                    <line x1="4" y1="21" x2="4" y2="14"></line>
                                    <line x1="4" y1="10" x2="4" y2="3"></line>
                                    <line x1="12" y1="21" x2="12" y2="12"></line>
                                    <line x1="12" y1="8" x2="12" y2="3"></line>
                                    <line x1="20" y1="21" x2="20" y2="16"></line>
                                    <line x1="20" y1="12" x2="20" y2="3"></line>
                                    <line x1="1" y1="14" x2="7" y2="14"></line>
                                    <line x1="9" y1="8" x2="15" y2="8"></line>
                                    <line x1="17" y1="16" x2="23" y2="16"></line>
                                </svg>
                            </div>
                        </div>
                        <div class="h2 font-weight-bold mb-1" style="color: var(--ios-text-primary); letter-spacing: -0.03em;">
                            <c:out value="${stats.totalCriteria}" default="0" />
                        </div>
                        <div class="text-muted" style="font-size: 0.8125rem; font-weight: 500;">
                            Placement cutoff profiles
                        </div>
                    </div>
                </div>
            </div>

            <!-- Readiness Status Breakdown Cards -->
            <div class="row mb-4">
                <div class="col-md-4 mb-3">
                    <div class="ios-card p-4 h-100" style="background: rgba(255, 255, 255, 0.9); border: 1px solid rgba(52, 199, 89, 0.3); border-radius: var(--ios-radius-lg); box-shadow: var(--ios-shadow-glass);">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <span class="badge" style="background: var(--ios-green-light); color: var(--ios-green-dark); font-weight: 700; font-size: 0.75rem; border-radius: var(--ios-radius-full); padding: 0.35rem 0.75rem;">
                                Placement Ready (&ge; 75%)
                            </span>
                            <div style="width: 28px; height: 28px; border-radius: var(--ios-radius-full); background: var(--ios-green-light); color: var(--ios-green-dark); display: flex; align-items: center; justify-content: center;">
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                    <polyline points="20 6 9 17 4 12"></polyline>
                                </svg>
                            </div>
                        </div>
                        <div class="d-flex align-items-baseline mb-2">
                            <div class="h2 font-weight-bold mb-0 mr-2" style="color: var(--ios-text-primary);"><c:out value="${stats.readyStudentsCount}" default="0" /></div>
                            <span class="text-muted" style="font-size: 0.875rem;">candidates</span>
                        </div>
                        <div class="ios-progress-md bg-light" style="height: 8px; border-radius: var(--ios-radius-full); overflow: hidden; background: #f1f5f9;">
                            <div class="h-100" style="width: <c:choose><c:when test="${stats.totalStudents > 0}">${(stats.readyStudentsCount * 100) / stats.totalStudents}</c:when><c:otherwise>0</c:otherwise></c:choose>%; background: var(--ios-green); border-radius: var(--ios-radius-full); transition: width 0.6s ease;"></div>
                        </div>
                    </div>
                </div>

                <div class="col-md-4 mb-3">
                    <div class="ios-card p-4 h-100" style="background: rgba(255, 255, 255, 0.9); border: 1px solid rgba(255, 149, 0, 0.3); border-radius: var(--ios-radius-lg); box-shadow: var(--ios-shadow-glass);">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <span class="badge" style="background: var(--ios-orange-light); color: #b45309; font-weight: 700; font-size: 0.75rem; border-radius: var(--ios-radius-full); padding: 0.35rem 0.75rem;">
                                In Progress (50% – 74%)
                            </span>
                            <div style="width: 28px; height: 28px; border-radius: var(--ios-radius-full); background: var(--ios-orange-light); color: var(--ios-orange); display: flex; align-items: center; justify-content: center;">
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                    <circle cx="12" cy="12" r="10"></circle>
                                    <line x1="12" y1="8" x2="12" y2="12"></line>
                                    <line x1="12" y1="16" x2="12.01" y2="16"></line>
                                </svg>
                            </div>
                        </div>
                        <div class="d-flex align-items-baseline mb-2">
                            <div class="h2 font-weight-bold mb-0 mr-2" style="color: var(--ios-text-primary);"><c:out value="${stats.inProgressStudentsCount}" default="0" /></div>
                            <span class="text-muted" style="font-size: 0.875rem;">candidates</span>
                        </div>
                        <div class="ios-progress-md bg-light" style="height: 8px; border-radius: var(--ios-radius-full); overflow: hidden; background: #f1f5f9;">
                            <div class="h-100" style="width: <c:choose><c:when test="${stats.totalStudents > 0}">${(stats.inProgressStudentsCount * 100) / stats.totalStudents}</c:when><c:otherwise>0</c:otherwise></c:choose>%; background: var(--ios-orange); border-radius: var(--ios-radius-full); transition: width 0.6s ease;"></div>
                        </div>
                    </div>
                </div>

                <div class="col-md-4 mb-3">
                    <div class="ios-card p-4 h-100" style="background: rgba(255, 255, 255, 0.9); border: 1px solid rgba(255, 59, 48, 0.3); border-radius: var(--ios-radius-lg); box-shadow: var(--ios-shadow-glass);">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <span class="badge" style="background: var(--ios-red-light); color: var(--ios-red); font-weight: 700; font-size: 0.75rem; border-radius: var(--ios-radius-full); padding: 0.35rem 0.75rem;">
                                Needs Attention (&lt; 50%)
                            </span>
                            <div style="width: 28px; height: 28px; border-radius: var(--ios-radius-full); background: var(--ios-red-light); color: var(--ios-red); display: flex; align-items: center; justify-content: center;">
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                    <polygon points="7.86 2 16.14 2 22 7.86 22 16.14 16.14 22 7.86 22 2 16.14 2 7.86 7.86 2"></polygon>
                                    <line x1="12" y1="8" x2="12" y2="12"></line>
                                    <line x1="12" y1="16" x2="12.01" y2="16"></line>
                                </svg>
                            </div>
                        </div>
                        <div class="d-flex align-items-baseline mb-2">
                            <div class="h2 font-weight-bold mb-0 mr-2" style="color: var(--ios-text-primary);"><c:out value="${stats.needsAttentionCount}" default="0" /></div>
                            <span class="text-muted" style="font-size: 0.875rem;">candidates</span>
                        </div>
                        <div class="ios-progress-md bg-light" style="height: 8px; border-radius: var(--ios-radius-full); overflow: hidden; background: #f1f5f9;">
                            <div class="h-100" style="width: <c:choose><c:when test="${stats.totalStudents > 0}">${(stats.needsAttentionCount * 100) / stats.totalStudents}</c:when><c:otherwise>0</c:otherwise></c:choose>%; background: var(--ios-red); border-radius: var(--ios-radius-full); transition: width 0.6s ease;"></div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Charts Row -->
            <div class="row mb-4">
                <div class="col-lg-6 mb-4">
                    <div class="ios-card h-100 p-4" style="background: rgba(255, 255, 255, 0.9); border: 1px solid var(--ios-border-card); border-radius: var(--ios-radius-lg); box-shadow: var(--ios-shadow-glass);">
                        <div class="d-flex align-items-center justify-content-between mb-3 pb-2 border-bottom">
                            <div>
                                <h2 class="h6 font-weight-bold mb-0" style="color: var(--ios-text-primary);">Department Talent Distribution</h2>
                                <span class="text-muted" style="font-size: 0.8125rem;">Candidate headcount across IT/CS specializations</span>
                            </div>
                            <div style="width: 32px; height: 32px; border-radius: var(--ios-radius-sm); background: var(--ios-blue-light); color: var(--ios-blue); display: flex; align-items: center; justify-content: center;">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                    <line x1="18" y1="20" x2="18" y2="10"></line>
                                    <line x1="12" y1="20" x2="12" y2="4"></line>
                                    <line x1="6" y1="20" x2="6" y2="14"></line>
                                </svg>
                            </div>
                        </div>
                        <div style="height: 260px; position: relative;">
                            <canvas id="deptChart"></canvas>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6 mb-4">
                    <div class="ios-card h-100 p-4" style="background: rgba(255, 255, 255, 0.9); border: 1px solid var(--ios-border-card); border-radius: var(--ios-radius-lg); box-shadow: var(--ios-shadow-glass);">
                        <div class="d-flex align-items-center justify-content-between mb-3 pb-2 border-bottom">
                            <div>
                                <h2 class="h6 font-weight-bold mb-0" style="color: var(--ios-text-primary);">Target Career Role Allocation</h2>
                                <span class="text-muted" style="font-size: 0.8125rem;">Student specialization goals by technical domain</span>
                            </div>
                            <div style="width: 32px; height: 32px; border-radius: var(--ios-radius-sm); background: var(--ios-indigo-light); color: var(--ios-indigo); display: flex; align-items: center; justify-content: center;">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                    <path d="M21.21 15.89A10 10 0 1 1 8 2.83"></path>
                                    <path d="M22 12A10 10 0 0 0 12 2v10z"></path>
                                </svg>
                            </div>
                        </div>
                        <div style="height: 260px; position: relative;">
                            <canvas id="roleChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Fast Admin Operations Grid -->
            <div class="row">
                <div class="col-12">
                    <div class="ios-card p-4" style="background: rgba(255, 255, 255, 0.9); border: 1px solid var(--ios-border-card); border-radius: var(--ios-radius-lg); box-shadow: var(--ios-shadow-glass);">
                        <h2 class="h6 font-weight-bold mb-3" style="color: var(--ios-text-primary);">Placement Administration Hub</h2>
                        <div class="row">
                            <div class="col-md-3 col-sm-6 mb-3 mb-md-0">
                                <a href="${pageContext.request.contextPath}/app/admin/students" class="d-block p-3 text-decoration-none h-100" style="background: var(--ios-bg-base); border: 1px solid rgba(0,0,0,0.06); border-radius: var(--ios-radius-md); transition: var(--ios-ease);">
                                    <div class="d-flex align-items-center mb-2">
                                        <div style="width: 32px; height: 32px; border-radius: var(--ios-radius-sm); background: var(--ios-blue-light); color: var(--ios-blue); display: flex; align-items: center; justify-content: center;" class="mr-2">
                                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                                <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
                                                <circle cx="9" cy="7" r="4"></circle>
                                            </svg>
                                        </div>
                                        <span class="font-weight-bold" style="color: var(--ios-text-primary); font-size: 0.9375rem;">Student Directory</span>
                                    </div>
                                    <p class="text-muted mb-0" style="font-size: 0.8125rem;">Multi-filter search, CGPA cutoffs &amp; candidate profiles</p>
                                </a>
                            </div>

                            <div class="col-md-3 col-sm-6 mb-3 mb-md-0">
                                <a href="${pageContext.request.contextPath}/app/admin/roles" class="d-block p-3 text-decoration-none h-100" style="background: var(--ios-bg-base); border: 1px solid rgba(0,0,0,0.06); border-radius: var(--ios-radius-md); transition: var(--ios-ease);">
                                    <div class="d-flex align-items-center mb-2">
                                        <div style="width: 32px; height: 32px; border-radius: var(--ios-radius-sm); background: var(--ios-orange-light); color: var(--ios-orange); display: flex; align-items: center; justify-content: center;" class="mr-2">
                                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                                <rect x="2" y="7" width="20" height="14" rx="2" ry="2"></rect>
                                                <path d="M16 21V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v16"></path>
                                            </svg>
                                        </div>
                                        <span class="font-weight-bold" style="color: var(--ios-text-primary); font-size: 0.9375rem;">Role Pathways</span>
                                    </div>
                                    <p class="text-muted mb-0" style="font-size: 0.8125rem;">Define target roles & required core competencies</p>
                                </a>
                            </div>

                            <div class="col-md-3 col-sm-6 mb-3 mb-md-0">
                                <a href="${pageContext.request.contextPath}/app/admin/skills" class="d-block p-3 text-decoration-none h-100" style="background: var(--ios-bg-base); border: 1px solid rgba(0,0,0,0.06); border-radius: var(--ios-radius-md); transition: var(--ios-ease);">
                                    <div class="d-flex align-items-center mb-2">
                                        <div style="width: 32px; height: 32px; border-radius: var(--ios-radius-sm); background: var(--ios-green-light); color: var(--ios-green-dark); display: flex; align-items: center; justify-content: center;" class="mr-2">
                                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                                <polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"></polygon>
                                            </svg>
                                        </div>
                                        <span class="font-weight-bold" style="color: var(--ios-text-primary); font-size: 0.9375rem;">Skills Taxonomy</span>
                                    </div>
                                    <p class="text-muted mb-0" style="font-size: 0.8125rem;">Categorized skill bank & proficiency weights</p>
                                </a>
                            </div>

                            <div class="col-md-3 col-sm-6 mb-3 mb-md-0">
                                <a href="${pageContext.request.contextPath}/app/admin/criteria" class="d-block p-3 text-decoration-none h-100" style="background: var(--ios-bg-base); border: 1px solid rgba(0,0,0,0.06); border-radius: var(--ios-radius-md); transition: var(--ios-ease);">
                                    <div class="d-flex align-items-center mb-2">
                                        <div style="width: 32px; height: 32px; border-radius: var(--ios-radius-sm); background: var(--ios-purple-light); color: var(--ios-purple); display: flex; align-items: center; justify-content: center;" class="mr-2">
                                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                                <line x1="4" y1="21" x2="4" y2="14"></line>
                                                <line x1="4" y1="10" x2="4" y2="3"></line>
                                                <line x1="12" y1="21" x2="12" y2="12"></line>
                                                <line x1="12" y1="8" x2="12" y2="3"></line>
                                                <line x1="20" y1="21" x2="20" y2="16"></line>
                                                <line x1="20" y1="12" x2="20" y2="3"></line>
                                            </svg>
                                        </div>
                                        <span class="font-weight-bold" style="color: var(--ios-text-primary); font-size: 0.9375rem;">Eligibility Criteria</span>
                                    </div>
                                    <p class="text-muted mb-0" style="font-size: 0.8125rem;">Manage enterprise cutoffs & company requirements</p>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>

<script>
document.addEventListener("DOMContentLoaded", function() {
    // Department Distribution Bar Chart
    var deptCanvas = document.getElementById('deptChart');
    if (deptCanvas) {
        var deptCtx = deptCanvas.getContext('2d');
        var deptLabels = [];
        var deptData = [];
        <c:forEach items="${stats.departmentDistribution}" var="entry">
            deptLabels.push('<c:out value="${entry.key}" />');
            deptData.push(${entry.value});
        </c:forEach>

        if (deptLabels.length === 0) {
            deptLabels = ['Computer Science', 'Information Technology', 'AI & Data Science', 'Software Eng'];
            deptData = [0, 0, 0, 0];
        }

        new Chart(deptCtx, {
            type: 'bar',
            data: {
                labels: deptLabels,
                datasets: [{
                    label: 'Students Enrolled',
                    data: deptData,
                    backgroundColor: 'rgba(0, 113, 227, 0.82)',
                    borderColor: '#0071e3',
                    borderWidth: 1.5,
                    borderRadius: 6
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    yAxes: [{
                        ticks: { 
                            beginAtZero: true, 
                            stepSize: 1,
                            fontColor: '#94a3b8',
                            fontSize: 11
                        },
                        gridLines: {
                            color: 'rgba(226, 232, 240, 0.6)',
                            zeroLineColor: 'rgba(203, 213, 225, 0.8)',
                            drawBorder: false
                        }
                    }],
                    xAxes: [{
                        ticks: {
                            fontColor: '#475569',
                            fontSize: 11,
                            fontFamily: "'Plus Jakarta Sans', sans-serif",
                            fontStyle: '600'
                        },
                        gridLines: {
                            display: false
                        }
                    }]
                },
                legend: { display: false },
                tooltips: {
                    backgroundColor: 'rgba(15, 23, 42, 0.9)',
                    titleFontFamily: "'Plus Jakarta Sans', sans-serif",
                    bodyFontFamily: "'Plus Jakarta Sans', sans-serif",
                    cornerRadius: 8,
                    xPadding: 10,
                    yPadding: 10
                }
            }
        });
    }

    // Role Distribution Doughnut Chart
    var roleCanvas = document.getElementById('roleChart');
    if (roleCanvas) {
        var roleCtx = roleCanvas.getContext('2d');
        var roleLabels = [];
        var roleData = [];
        <c:forEach items="${stats.roleDistribution}" var="entry">
            roleLabels.push('<c:out value="${entry.key}" />');
            roleData.push(${entry.value});
        </c:forEach>

        if (roleLabels.length === 0) {
            roleLabels = ['Full Stack Developer', 'Cloud Engineer', 'Data Engineer', 'DevOps Specialist'];
            roleData = [1, 1, 1, 1];
        }

        new Chart(roleCtx, {
            type: 'doughnut',
            data: {
                labels: roleLabels,
                datasets: [{
                    data: roleData,
                    backgroundColor: [
                        '#0071e3',
                        '#5856d6',
                        '#34c759',
                        '#ff9500',
                        '#32ade6',
                        '#af52de',
                        '#ff3b30'
                    ],
                    borderColor: '#ffffff',
                    borderWidth: 2
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                cutoutPercentage: 65,
                legend: { 
                    position: 'bottom',
                    labels: {
                        boxWidth: 10,
                        fontColor: '#475569',
                        fontFamily: "'Plus Jakarta Sans', sans-serif",
                        fontSize: 11,
                        padding: 12
                    }
                },
                tooltips: {
                    backgroundColor: 'rgba(15, 23, 42, 0.9)',
                    titleFontFamily: "'Plus Jakarta Sans', sans-serif",
                    bodyFontFamily: "'Plus Jakarta Sans', sans-serif",
                    cornerRadius: 8,
                    xPadding: 10,
                    yPadding: 10
                }
            }
        });
    }
});
</script>

<%@ include file="/WEB-INF/views/common/footer.jspf" %>
