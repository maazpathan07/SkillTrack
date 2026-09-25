<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Student Dashboard" />
<c:set var="activeNav" value="dashboard" />
<%@ include file="/WEB-INF/views/common/header.jspf" %>
<%@ include file="/WEB-INF/views/common/navbar.jspf" %>

<div class="container-fluid">
    <div class="row">
        <%@ include file="/WEB-INF/views/common/sidebar.jspf" %>

        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4 py-4">
            <%@ include file="/WEB-INF/views/common/alerts.jspf" %>

            <!-- 1. APPLE GLASS HERO WELCOME HEADER & ACTION CONTROLS -->
            <div class="ios-dash-header">
                <div>
                    <!-- Usability Fix 9: Non-clickable clear category label -->
                    <div class="text-uppercase text-muted font-weight-bold mb-1" style="font-size: 0.725rem; letter-spacing: 0.08em;">
                        Student Intelligence Hub
                    </div>
                    <!-- Usability Fix 3: Proper H1 heading -->
                    <h1 class="font-weight-bold mb-1" style="font-size: 1.85rem; letter-spacing: -0.035em; color: var(--ios-text-primary);">
                        Welcome back, <c:out value="${dashboard.student.fullName}" />
                    </h1>
                    <div class="d-flex align-items-center flex-wrap gap-2 mt-2">
                        <span class="ios-badge ios-badge-gray">
                            Roll: <c:out value="${dashboard.student.rollNumber}" />
                        </span>
                        <span class="ios-badge ios-badge-gray">
                            Dept: <c:out value="${dashboard.student.department}" />
                        </span>
                        <span class="ios-badge ios-badge-blue">
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" class="mr-1"><circle cx="12" cy="12" r="10"></circle><circle cx="12" cy="12" r="6"></circle><circle cx="12" cy="12" r="2"></circle></svg>
                            <c:out value="${dashboard.student.targetRoleTitle}" default="Target Role Not Selected" />
                        </span>
                    </div>
                </div>

                <!-- Quick Action Buttons -->
                <div class="d-flex flex-column flex-sm-row align-items-stretch align-items-sm-center mt-3 mt-md-0 w-100 w-md-auto" style="gap: 0.5rem;">
                    <!-- Usability Fix 7: Standardized Document Dossier Icon -->
                    <a href="${pageContext.request.contextPath}/app/student/readiness-card" class="ios-btn-secondary text-nowrap" style="padding: 0.6rem 1.25rem; font-size: 0.875rem;">
                        <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" class="mr-1.5">
                            <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
                            <polyline points="14 2 14 8 20 8"></polyline>
                            <line x1="16" y1="13" x2="8" y2="13"></line>
                            <line x1="16" y1="17" x2="8" y2="17"></line>
                        </svg>
                        Readiness Card
                    </a>
                    <a href="${pageContext.request.contextPath}/app/student/skill-gap" class="ios-btn-primary text-nowrap" style="padding: 0.6rem 1.25rem; font-size: 0.875rem;">
                        <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="mr-1.5"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 14 14"></polyline></svg>
                        Skill Gap Radar &rarr;
                    </a>
                </div>
            </div>

            <!-- 2. FOUR APPLE LIQUID GLASS KPI METRIC CARDS -->
            <!-- Usability Fix 8 & Fix 1: Unified text styling & consistent symmetry -->
            <div class="row mb-4">
                <!-- Card 1: Overall Readiness -->
                <div class="col-xl-3 col-md-6 mb-3">
                    <div class="ios-metric-card ios-metric-green">
                        <div class="ios-metric-label">Placement Readiness</div>
                        <div class="ios-metric-value" style="color: var(--ios-green-dark);">
                            <c:out value="${dashboard.readinessScore.formattedOverall}" />%
                        </div>
                        <div class="ios-progress-md mb-2">
                            <div class="ios-progress-bar" style="width: ${dashboard.readinessScore.overallReadiness}%; background: linear-gradient(90deg, #34c759, #10b981);"></div>
                        </div>
                        <small class="text-muted font-weight-semibold">
                            <c:choose>
                                <c:when test="${dashboard.readinessScore.overallReadiness >= 75}">Placement Ready (Meets Target)</c:when>
                                <c:when test="${dashboard.readinessScore.overallReadiness >= 50}">Intermediate Preparation</c:when>
                                <c:otherwise>Early Stage Preparation</c:otherwise>
                            </c:choose>
                        </small>
                    </div>
                </div>

                <!-- Card 2: Skill Match -->
                <div class="col-xl-3 col-md-6 mb-3">
                    <div class="ios-metric-card ios-metric-blue">
                        <div class="ios-metric-label">Role Skill Match</div>
                        <div class="ios-metric-value" style="color: var(--ios-blue);">
                            <c:out value="${dashboard.readinessScore.formattedSkill}" />%
                        </div>
                        <div class="ios-progress-md mb-2">
                            <div class="ios-progress-bar" style="width: ${dashboard.readinessScore.skillReadiness}%; background: linear-gradient(90deg, #0071e3, #32ade6);"></div>
                        </div>
                        <small class="text-muted font-weight-semibold">
                            <c:out value="${dashboard.skillGap.matchedSkillsCount}" /> of <c:out value="${dashboard.skillGap.totalRequiredSkills}" /> core skills verified
                        </small>
                    </div>
                </div>

                <!-- Card 3: DSA Problems -->
                <div class="col-xl-3 col-md-6 mb-3">
                    <div class="ios-metric-card ios-metric-orange">
                        <div class="ios-metric-label">DSA Milestones Solved</div>
                        <div class="ios-metric-value" style="color: var(--ios-orange);">
                            <c:out value="${dashboard.dsaProblemsSolved}" />
                        </div>
                        <div class="ios-progress-md mb-2">
                            <div class="ios-progress-bar" style="width: ${dashboard.readinessScore.dsaReadiness}%; background: linear-gradient(90deg, #ff9500, #ff3b30);"></div>
                        </div>
                        <small class="text-muted font-weight-semibold">
                            Target benchmark: <c:out value="${dashboard.readinessScore.dsaBenchmark}" /> problems
                        </small>
                    </div>
                </div>

                <!-- Card 4: Projects & Certifications -->
                <div class="col-xl-3 col-md-6 mb-3">
                    <div class="ios-metric-card ios-metric-purple">
                        <div class="ios-metric-label">Projects & Certs</div>
                        <div class="ios-metric-value" style="color: var(--ios-purple);">
                            <c:out value="${dashboard.projectsCount}" /> <span style="font-size: 1.1rem; font-weight: 500; color: var(--ios-text-tertiary);">/ <c:out value="${dashboard.certsCount}" /> certs</span>
                        </div>
                        <div class="ios-progress-md mb-2">
                            <div class="ios-progress-bar" style="width: ${(dashboard.readinessScore.projectReadiness + dashboard.readinessScore.certReadiness)/2}%; background: linear-gradient(90deg, #af52de, #5856d6);"></div>
                        </div>
                        <small class="text-muted font-weight-semibold">
                            <c:out value="${dashboard.projectsCount}" /> Verified, <c:out value="${dashboard.certsCount}" /> Credentials
                        </small>
                    </div>
                </div>
            </div>

            <!-- 3. COMPONENT BREAKDOWN & INTERACTIVE RADAR ANALYTICS -->
            <div class="row mb-4">
                <!-- Breakdown Table -->
                <div class="col-lg-7 mb-3">
                    <div class="ios-card h-100">
                        <div class="ios-card-header">
                            <div>
                                <!-- Usability Fix 4: Correct H2 hierarchy -->
                                <h2 class="h5 font-weight-bold mb-0" style="color: var(--ios-text-primary); font-size: 1.05rem;">
                                    Readiness Weight Breakdown
                                </h2>
                                <small class="text-muted">Deterministic scoring based on industry cutoff models</small>
                            </div>
                            <span class="ios-badge ios-badge-gray text-nowrap">5 Pillars</span>
                        </div>
                        <div class="p-0">
                            <div class="table-responsive">
                                <!-- Usability Fix 6: Optimized Column Widths & Thicker Progress Bar -->
                                <table class="table table-hover align-middle mb-0" style="font-size: 0.9rem;">
                                    <thead style="background: #f8fafc; color: var(--ios-text-secondary); font-size: 0.775rem; text-transform: uppercase; letter-spacing: 0.05em;">
                                        <tr>
                                            <th class="border-top-0 px-3 px-sm-4 py-3" style="width: 35%;">Evaluation Pillar</th>
                                            <th class="border-top-0 py-3 text-center" style="width: 15%;">Weight</th>
                                            <th class="border-top-0 py-3" style="width: 32%;">Readiness Progress</th>
                                            <th class="border-top-0 px-3 px-sm-4 py-3 text-right" style="width: 18%;">Score</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td class="px-3 px-sm-4 font-weight-bold" style="color: var(--ios-text-primary);">
                                                Technical Skills Match
                                            </td>
                                            <td class="text-center"><span class="ios-badge ios-badge-gray text-nowrap"><c:out value="${dashboard.readinessScore.weightSkills * 100}" />%</span></td>
                                            <td>
                                                <div class="ios-progress-md">
                                                    <div class="ios-progress-bar" style="width: ${dashboard.readinessScore.skillReadiness}%; background: var(--ios-blue);"></div>
                                                </div>
                                            </td>
                                            <td class="px-3 px-sm-4 text-right font-weight-bold" style="color: var(--ios-blue);"><c:out value="${dashboard.readinessScore.formattedSkill}" />%</td>
                                        </tr>
                                        <tr>
                                            <td class="px-3 px-sm-4 font-weight-bold" style="color: var(--ios-text-primary);">
                                                DSA Problem Solving
                                            </td>
                                            <td class="text-center"><span class="ios-badge ios-badge-gray text-nowrap"><c:out value="${dashboard.readinessScore.weightDsa * 100}" />%</span></td>
                                            <td>
                                                <div class="ios-progress-md">
                                                    <div class="ios-progress-bar" style="width: ${dashboard.readinessScore.dsaReadiness}%; background: var(--ios-orange);"></div>
                                                </div>
                                            </td>
                                            <td class="px-3 px-sm-4 text-right font-weight-bold" style="color: var(--ios-orange);"><c:out value="${dashboard.readinessScore.formattedDsa}" />%</td>
                                        </tr>
                                        <tr>
                                            <td class="px-3 px-sm-4 font-weight-bold" style="color: var(--ios-text-primary);">
                                                Verified Projects
                                            </td>
                                            <td class="text-center"><span class="ios-badge ios-badge-gray text-nowrap"><c:out value="${dashboard.readinessScore.weightProjects * 100}" />%</span></td>
                                            <td>
                                                <div class="ios-progress-md">
                                                    <div class="ios-progress-bar" style="width: ${dashboard.readinessScore.projectReadiness}%; background: var(--ios-purple);"></div>
                                                </div>
                                            </td>
                                            <td class="px-3 px-sm-4 text-right font-weight-bold" style="color: var(--ios-purple);"><c:out value="${dashboard.readinessScore.formattedProject}" />%</td>
                                        </tr>
                                        <tr>
                                            <td class="px-3 px-sm-4 font-weight-bold" style="color: var(--ios-text-primary);">
                                                Verified Certifications
                                            </td>
                                            <td class="text-center"><span class="ios-badge ios-badge-gray text-nowrap"><c:out value="${dashboard.readinessScore.weightCerts * 100}" />%</span></td>
                                            <td>
                                                <div class="ios-progress-md">
                                                    <div class="ios-progress-bar" style="width: ${dashboard.readinessScore.certReadiness}%; background: var(--ios-green-dark);"></div>
                                                </div>
                                            </td>
                                            <td class="px-3 px-sm-4 text-right font-weight-bold" style="color: var(--ios-green-dark);"><c:out value="${dashboard.readinessScore.formattedCert}" />%</td>
                                        </tr>
                                        <tr>
                                            <td class="px-3 px-sm-4 font-weight-bold" style="color: var(--ios-text-primary);">
                                                Preparation Milestones
                                            </td>
                                            <td class="text-center"><span class="ios-badge ios-badge-gray text-nowrap"><c:out value="${dashboard.readinessScore.weightTasks * 100}" />%</span></td>
                                            <td>
                                                <div class="ios-progress-md">
                                                    <div class="ios-progress-bar" style="width: ${dashboard.readinessScore.taskReadiness}%; background: var(--ios-text-secondary);"></div>
                                                </div>
                                            </td>
                                            <td class="px-3 px-sm-4 text-right font-weight-bold" style="color: var(--ios-text-secondary);"><c:out value="${dashboard.readinessScore.formattedTask}" />%</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Radar Analytics Chart -->
                <div class="col-lg-5 mb-3">
                    <div class="ios-card h-100">
                        <div class="ios-card-header">
                            <div>
                                <!-- Usability Fix 4: Correct H2 hierarchy -->
                                <h2 class="h5 font-weight-bold mb-0" style="color: var(--ios-text-primary); font-size: 1.05rem;">
                                    Competency Radar
                                </h2>
                                <small class="text-muted">Live multidimensional profile balance</small>
                            </div>
                            <span class="ios-badge ios-badge-blue text-nowrap">Real-Time</span>
                        </div>
                        <div class="ios-card-body d-flex align-items-center justify-content-center p-3">
                            <canvas id="readinessChart" style="max-height: 250px; width: 100%;"></canvas>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 4. ACTIVE TASKS & RECENT PROJECTS SHOWCASE -->
            <div class="row">
                <!-- Active Tasks -->
                <div class="col-lg-6 mb-4">
                    <div class="ios-card h-100">
                        <div class="ios-card-header">
                            <div>
                                <h2 class="h5 font-weight-bold mb-0" style="color: var(--ios-text-primary); font-size: 1.05rem;">
                                    Active Preparation Tasks
                                </h2>
                                <small class="text-muted">Daily milestones to boost readiness</small>
                            </div>
                            <a href="${pageContext.request.contextPath}/app/student/tasks" class="small font-weight-bold text-nowrap flex-shrink-0" style="color: var(--ios-blue);">
                                View All &rarr;
                            </a>
                        </div>
                        <div class="p-0">
                            <ul class="list-group list-group-flush">
                                <c:choose>
                                    <c:when test="${empty dashboard.recentTasks}">
                                        <li class="list-group-item text-muted text-center py-4 border-0">
                                            <div class="mb-2">No pending tasks on your checklist.</div>
                                            <a href="${pageContext.request.contextPath}/app/student/tasks" class="ios-btn-secondary" style="padding: 0.4rem 1rem; font-size: 0.8rem;">
                                                + Add New Task
                                            </a>
                                        </li>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach items="${dashboard.recentTasks}" var="t">
                                            <li class="list-group-item d-flex justify-content-between align-items-center px-4 py-3 border-bottom" style="border-color: rgba(226, 232, 240, 0.6) !important;">
                                                <div class="d-flex align-items-center">
                                                    <span class="mr-3" style="color: ${t.completed ? 'var(--ios-green)' : '#cbd5e1'};">
                                                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="20 6 9 17 4 12"></polyline></svg>
                                                    </span>
                                                    <div>
                                                        <div class="${t.completed ? 'text-muted text-decoration-line-through' : 'font-weight-bold'}" style="color: var(--ios-text-primary); font-size: 0.925rem;">
                                                            <c:out value="${t.title}" />
                                                        </div>
                                                        <c:if test="${not empty t.formattedTargetDate}">
                                                            <small class="text-muted">Target: <c:out value="${t.formattedTargetDate}" /></small>
                                                        </c:if>
                                                    </div>
                                                </div>
                                                <span class="ios-badge ${t.completed ? 'ios-badge-green' : 'ios-badge-orange'}">
                                                    <c:out value="${t.status.displayName}" />
                                                </span>
                                            </li>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </ul>
                        </div>
                    </div>
                </div>

                <!-- Recent Projects Portfolio -->
                <div class="col-lg-6 mb-4">
                    <div class="ios-card h-100">
                        <div class="ios-card-header">
                            <div>
                                <h2 class="h5 font-weight-bold mb-0" style="color: var(--ios-text-primary); font-size: 1.05rem;">
                                    Verified Projects Portfolio
                                </h2>
                                <small class="text-muted">Showcase applications and GitHub repositories</small>
                            </div>
                            <a href="${pageContext.request.contextPath}/app/student/projects" class="small font-weight-bold text-nowrap flex-shrink-0" style="color: var(--ios-blue);">
                                View All &rarr;
                            </a>
                        </div>
                        <div class="p-0">
                            <ul class="list-group list-group-flush">
                                <c:choose>
                                    <c:when test="${empty dashboard.recentProjects}">
                                        <li class="list-group-item text-muted text-center py-4 border-0">
                                            <div class="mb-2">No projects listed yet.</div>
                                            <a href="${pageContext.request.contextPath}/app/student/projects" class="ios-btn-secondary" style="padding: 0.4rem 1rem; font-size: 0.8rem;">
                                                + Add First Project
                                            </a>
                                        </li>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach items="${dashboard.recentProjects}" var="p">
                                            <li class="list-group-item px-4 py-3 border-bottom" style="border-color: rgba(226, 232, 240, 0.6) !important;">
                                                <div class="d-flex justify-content-between align-items-start mb-1">
                                                    <h6 class="font-weight-bold mb-0" style="color: var(--ios-text-primary); font-size: 0.95rem;">
                                                        <c:out value="${p.title}" />
                                                    </h6>
                                                    <div class="d-flex gap-2">
                                                        <c:if test="${not empty p.githubUrl}">
                                                            <a href="<c:out value='${p.githubUrl}' />" target="_blank" rel="noopener noreferrer" class="ios-badge ios-badge-gray">
                                                                <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="mr-1"><path d="M9 19c-5 1.5-5-2.5-7-3m14 6v-3.87a3.37 3.37 0 0 0-.94-2.61c3.14-.35 6.44-1.54 6.44-7A5.44 5.44 0 0 0 20 4.77 5.07 5.07 0 0 0 19.91 1S18.73.65 16 2.48a13.38 13.38 0 0 0-7 0C6.27.65 5.09 1 5.09 1A5.07 5.07 0 0 0 5 4.77a5.44 5.44 0 0 0-1.5 3.78c0 5.42 3.3 6.61 6.44 7A3.37 3.37 0 0 0 9 18.13V22"></path></svg>
                                                                GitHub
                                                            </a>
                                                        </c:if>
                                                        <c:if test="${not empty p.liveDemoUrl}">
                                                            <a href="<c:out value='${p.liveDemoUrl}' />" target="_blank" rel="noopener noreferrer" class="ios-badge ios-badge-green">
                                                                <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="mr-1"><polygon points="5 3 19 12 5 21 5 3"></polygon></svg>
                                                                Live Demo
                                                            </a>
                                                        </c:if>
                                                    </div>
                                                </div>
                                                <small class="text-muted d-block" style="font-size: 0.8rem;">
                                                    <span class="font-weight-semibold">Tech Stack:</span> <c:out value="${p.techStack}" />
                                                </small>
                                            </li>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Disclaimer Notice -->
            <div class="ios-alert ios-alert-info mt-2 mb-4">
                <span class="ios-alert-icon">
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="16" x2="12" y2="12"></line><line x1="12" y1="8" x2="12.01" y2="8"></line></svg>
                </span>
                <div>
                    <strong>Algorithm Notice:</strong> <c:out value="${disclaimer}" default="Placement Readiness Scores are calculated using deterministic weighted algorithms based on target role benchmarks." />
                </div>
            </div>
        </main>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js"></script>
<script>
document.addEventListener("DOMContentLoaded", function() {
    var chartCanvas = document.getElementById('readinessChart');
    if (chartCanvas) {
        var ctx = chartCanvas.getContext('2d');
        
        var skillScore = ${dashboard.readinessScore.skillReadiness != null ? dashboard.readinessScore.skillReadiness : 0};
        var dsaScore = ${dashboard.readinessScore.dsaReadiness != null ? dashboard.readinessScore.dsaReadiness : 0};
        var projScore = ${dashboard.readinessScore.projectReadiness != null ? dashboard.readinessScore.projectReadiness : 0};
        var certScore = ${dashboard.readinessScore.certReadiness != null ? dashboard.readinessScore.certReadiness : 0};
        var taskScore = ${dashboard.readinessScore.taskReadiness != null ? dashboard.readinessScore.taskReadiness : 0};

        new Chart(ctx, {
            type: 'radar',
            data: {
                labels: ['Skills', 'DSA', 'Projects', 'Certs', 'Tasks'],
                datasets: [
                    {
                        label: 'Current Readiness (%)',
                        data: [skillScore, dsaScore, projScore, certScore, taskScore],
                        backgroundColor: 'rgba(0, 113, 227, 0.18)',
                        borderColor: '#0071e3',
                        borderWidth: 2.2,
                        pointBackgroundColor: '#0071e3',
                        pointBorderColor: '#ffffff',
                        pointBorderWidth: 2,
                        pointRadius: 4,
                        pointHoverRadius: 6,
                        pointHoverBackgroundColor: '#ffffff',
                        pointHoverBorderColor: '#0071e3'
                    },
                    /* Usability Fix 5: Secondary Ghost Benchmark Dataset for clear visual feedback in initial state */
                    {
                        label: 'Target Benchmark (100%)',
                        data: [100, 100, 100, 100, 100],
                        backgroundColor: 'transparent',
                        borderColor: 'rgba(0, 113, 227, 0.22)',
                        borderWidth: 1.5,
                        borderDash: [4, 4],
                        pointRadius: 0,
                        pointHoverRadius: 0
                    }
                ]
            },
            options: {
                scale: {
                    ticks: {
                        beginAtZero: true,
                        max: 100,
                        stepSize: 25,
                        display: false
                    },
                    gridLines: {
                        color: 'rgba(226, 232, 240, 0.8)'
                    },
                    angleLines: {
                        color: 'rgba(226, 232, 240, 0.8)'
                    },
                    pointLabels: {
                        fontSize: 11,
                        fontStyle: 'bold',
                        fontColor: '#475569',
                        fontFamily: "'Plus Jakarta Sans', sans-serif"
                    }
                },
                legend: {
                    display: false
                },
                tooltips: {
                    backgroundColor: 'rgba(15, 23, 42, 0.9)',
                    titleFontFamily: "'Plus Jakarta Sans', sans-serif",
                    bodyFontFamily: "'Plus Jakarta Sans', sans-serif",
                    cornerRadius: 8,
                    xPadding: 10,
                    yPadding: 10,
                    callbacks: {
                        label: function(tooltipItem, data) {
                            if (tooltipItem.datasetIndex === 1) {
                                return 'Benchmark: 100% Target';
                            }
                            return data.labels[tooltipItem.index] + ': ' + tooltipItem.yLabel + '% Ready';
                        }
                    }
                }
            }
        });
    }
});
</script>

<%@ include file="/WEB-INF/views/common/footer.jspf" %>
