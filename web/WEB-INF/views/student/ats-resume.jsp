<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="ATS-Compliant Placement Resume" />
<c:set var="activeNav" value="ats-resume" />
<%@ include file="/WEB-INF/views/common/header.jspf" %>
<%@ include file="/WEB-INF/views/common/navbar.jspf" %>

<style>
/* =====================================================================
   ATS-Compliant Placement Resume Stylesheet
   Strict Single-Column Standard | Machine Parseable | Complete 1-Page A4 Fit
   ===================================================================== */
.ats-page-container {
    max-width: 920px;
    margin: 0 auto;
}

.ats-paper {
    background: #ffffff;
    color: #111827;
    font-family: 'Times New Roman', Times, 'Georgia', serif;
    line-height: 1.48;
    font-size: 10.75pt;
    padding: 44px 52px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
    border-radius: 4px;
    border: 1px solid #e5e7eb;
    margin-bottom: 2.5rem;
}

.ats-paper h1.ats-name {
    font-size: 20pt;
    font-weight: 700;
    text-align: center;
    letter-spacing: 0.6px;
    text-transform: uppercase;
    margin-bottom: 4px;
    color: #000000;
}

.ats-paper .ats-contact-bar {
    text-align: center;
    font-size: 9.75pt;
    color: #374151;
    margin-bottom: 14px;
}

.ats-paper .ats-contact-bar a {
    color: #004085;
    text-decoration: underline;
}

.ats-paper .ats-contact-bar span.sep {
    margin: 0 6px;
    color: #6b7280;
}

.ats-paper .ats-section {
    margin-top: 13px;
    margin-bottom: 9px;
}

.ats-paper .ats-section-title {
    font-size: 11.5pt;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.8px;
    color: #000000;
    border-bottom: 1.25px solid #111827;
    padding-bottom: 2px;
    margin-bottom: 7px;
}

.ats-paper .ats-summary-text {
    font-size: 10.25pt;
    color: #1f2937;
    line-height: 1.48;
    text-align: justify;
    margin-bottom: 6px;
}

.ats-paper .ats-entry {
    margin-bottom: 9px;
}

.ats-paper .ats-entry-header {
    display: flex;
    justify-content: space-between;
    align-items: baseline;
    font-size: 10.75pt;
}

.ats-paper .ats-entry-title {
    font-weight: 700;
    color: #000000;
}

.ats-paper .ats-entry-subtitle {
    font-style: italic;
    color: #374151;
}

.ats-paper .ats-entry-date {
    font-size: 9.75pt;
    font-weight: 600;
    color: #4b5563;
    text-align: right;
    white-space: nowrap;
}

.ats-paper ul.ats-bullets {
    margin: 3px 0 6px 18px;
    padding: 0;
    list-style-type: disc;
}

.ats-paper ul.ats-bullets li {
    margin-bottom: 3px;
    color: #1f2937;
    font-size: 10.25pt;
    line-height: 1.44;
}

.ats-paper .ats-skills-line {
    font-size: 10.25pt;
    margin-bottom: 4px;
    line-height: 1.48;
}

.ats-paper .ats-skills-line strong {
    color: #000000;
}

/* Summary Edit Modal Styling */
.summary-preset-card {
    background: #f8fafc;
    border: 1px solid #e2e8f0;
    border-radius: var(--ios-radius-md);
    padding: 0.85rem 1rem;
    cursor: pointer;
    transition: var(--ios-ease);
    margin-bottom: 0.75rem;
}

.summary-preset-card:hover {
    border-color: var(--ios-blue);
    background: rgba(0, 113, 227, 0.04);
    transform: translateY(-1px);
}

/* Print Specific Rules */
@media print {
    body {
        background: #ffffff !important;
        margin: 0 !important;
        padding: 0 !important;
    }
    .no-print, nav, footer, .ios-navbar, .ios-toast-container, #iosToastContainer, .modal, .modal-backdrop {
        display: none !important;
    }
    .ats-page-container {
        max-width: 100% !important;
        margin: 0 !important;
        padding: 0 !important;
    }
    .ats-paper {
        border: none !important;
        box-shadow: none !important;
        padding: 0 !important;
        margin: 0 !important;
        font-size: 10.25pt !important;
    }
}
</style>

<div class="container-fluid">
    <div class="row">
        <%@ include file="/WEB-INF/views/common/sidebar.jspf" %>

        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4 py-4">
            <%@ include file="/WEB-INF/views/common/alerts.jspf" %>

            <!-- Top Dashboard Header & Controls (Hidden on Print) -->
            <div class="ios-dash-header mb-4 no-print">
                <div>
                    <div class="d-flex align-items-center gap-2 mb-1">
                        <span class="ios-badge ios-badge-blue">
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" aria-hidden="true"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path><polyline points="14 2 14 8 20 8"></polyline><line x1="16" y1="13" x2="8" y2="13"></line><line x1="16" y1="17" x2="8" y2="17"></line></svg>
                            ATS Resume Generator
                        </span>
                        <span class="ios-badge ios-badge-green font-weight-bold">
                            <svg width="10" height="10" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" class="mr-1"><polyline points="20 6 9 17 4 12"></polyline></svg>
                            Full-Page A4 Standard
                        </span>
                    </div>
                    <h1 class="h3 font-weight-bold text-gray-800 mb-0" style="letter-spacing: -0.03em;">ATS-Compliant Placement Resume</h1>
                    <p class="text-muted small mb-0 mt-1">Machine-readable single-column Ivy-League format compiled live from your verified SkillTrack portfolio</p>
                </div>
                <div class="d-flex align-items-center flex-wrap flex-sm-nowrap gap-2 mt-3 mt-lg-0 w-100 w-lg-auto" style="gap: 0.5rem;">
                    <button type="button" class="ios-btn-secondary d-inline-flex align-items-center justify-content-center flex-grow-1 flex-sm-grow-0" id="openSummaryModalBtn" data-toggle="modal" data-target="#summaryModal" style="padding: 0.6rem 1.15rem; font-size: 0.875rem; white-space: nowrap; color: var(--ios-blue); border-color: rgba(0, 113, 227, 0.3);">
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" class="mr-1.5"><path d="M12 20h9"></path><path d="M16.5 3.5a2.121 2.121 0 0 1 3 3L7 19l-4 1 1-4L16.5 3.5z"></path></svg>
                        Edit Summary
                    </button>
                    <button type="button" class="ios-btn-primary d-inline-flex align-items-center justify-content-center flex-grow-1 flex-sm-grow-0" id="downloadAtsPdfBtn" style="padding: 0.6rem 1.25rem; font-size: 0.875rem; box-shadow: 0 4px 12px rgba(0, 113, 227, 0.25); white-space: nowrap;">
                        <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" class="mr-1.5" aria-hidden="true"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path><polyline points="7 10 12 15 17 10"></polyline><line x1="12" y1="15" x2="12" y2="3"></line></svg>
                        Download ATS PDF
                    </button>
                    <button type="button" class="ios-btn-secondary d-inline-flex align-items-center justify-content-center flex-grow-1 flex-sm-grow-0" onclick="window.print()" style="padding: 0.6rem 1.15rem; font-size: 0.875rem; white-space: nowrap;">
                        <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="mr-1.5" aria-hidden="true"><polyline points="6 9 6 2 18 2 18 9"></polyline><path d="M6 18H4a2 2 0 0 1-2-2v-5a2 2 0 0 1 2-2h16a2 2 0 0 1 2 2v5a2 2 0 0 1-2 2h-2"></path><rect x="6" y="14" width="12" height="8"></rect></svg>
                        Print
                    </button>
                    <a href="${pageContext.request.contextPath}/app/student/profile" class="ios-btn-secondary d-inline-flex align-items-center justify-content-center flex-grow-1 flex-sm-grow-0" style="padding: 0.6rem 1rem; font-size: 0.875rem; white-space: nowrap;">
                        Edit Profile
                    </a>
                </div>
            </div>

            <!-- ATS Compliance Guide Pill (No Print) -->
            <div class="ios-card p-3 mb-4 no-print" style="background: rgba(0, 113, 227, 0.03); border: 1px solid rgba(0, 113, 227, 0.15);">
                <div class="d-flex align-items-center justify-content-between flex-wrap gap-2">
                    <div class="d-flex align-items-center" style="gap: 0.75rem;">
                        <div class="d-flex align-items-center justify-content-center" style="width: 36px; height: 36px; border-radius: 50%; background: rgba(0, 113, 227, 0.1); color: var(--ios-blue);">
                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="20 6 9 17 4 12"></polyline></svg>
                        </div>
                        <div>
                            <div class="font-weight-bold text-dark" style="font-size: 0.9rem;">1-Page ATS Standard: Built with Maximum Parser Density</div>
                            <small class="text-muted">Includes Professional Career Summary &bull; Core CS Coursework &bull; Action-Oriented Project Bullets &bull; Developer Tools &bull; Verified Coding Milestones.</small>
                        </div>
                    </div>
                    <div>
                        <span class="ios-badge ios-badge-blue font-weight-bold" style="font-size: 0.775rem;">Target: <c:out value="${student.targetRoleTitle}" default="Software Engineer" /></span>
                    </div>
                </div>
            </div>

            <!-- Printable ATS Document Canvas -->
            <div class="ats-page-container">
                <div class="ats-paper" id="atsResumeDoc">
                    <!-- 1. Header / Contact Information -->
                    <h1 class="ats-name"><c:out value="${student.fullName}" /></h1>
                    <div class="ats-contact-bar">
                        <span><c:out value="${student.email}" /></span>
                        <span class="sep">&bull;</span>
                        <span>Roll: <c:out value="${student.rollNumber}" /></span>
                        <span class="sep">&bull;</span>
                        <span><c:out value="${student.department}" /> (Batch '<c:out value="${student.graduationYear % 100}" />)</span>
                        <c:if test="${not empty profile.projects}">
                            <c:forEach items="${profile.projects}" var="p" end="0">
                                <c:if test="${not empty p.githubUrl}">
                                    <span class="sep">&bull;</span>
                                    <span>GitHub: <a href="<c:out value='${p.githubUrl}' />" target="_blank">Portfolio Link</a></span>
                                </c:if>
                            </c:forEach>
                        </c:if>
                    </div>

                    <!-- 2. Professional Career Summary (Editable Live) -->
                    <div class="ats-section">
                        <div class="d-flex justify-content-between align-items-center">
                            <div class="ats-section-title flex-grow-1">Professional Summary</div>
                            <button type="button" class="btn btn-sm btn-link p-0 text-primary font-weight-bold no-print" data-toggle="modal" data-target="#summaryModal" style="font-size: 0.775rem; font-family: -apple-system, BlinkMacSystemFont, sans-serif; text-decoration: underline; margin-top: -6px;">
                                ✏️ Customize Summary
                            </button>
                        </div>
                        <div class="ats-summary-text" id="liveResumeSummary">
                            Aspiring <strong><c:out value="${student.targetRoleTitle}" default="Software Development Engineer" /></strong> with strong foundational expertise in <strong>Data Structures, Algorithms, and Software Engineering</strong>. Proven track record of developing responsive full stack applications, designing efficient database schemas, and solving <strong><c:out value="${profile.totalDsaProblemsSolved}" default="10" />+ algorithmic problems</strong>. Dedicated to building reliable, high-performance systems and contributing to high-velocity software engineering teams.
                        </div>
                    </div>

                    <!-- 3. Education Section -->
                    <div class="ats-section">
                        <div class="ats-section-title">Education</div>
                        <div class="ats-entry">
                            <div class="ats-entry-header">
                                <div class="ats-entry-title">Bachelor of Technology / Degree in <c:out value="${student.department}" /></div>
                                <div class="ats-entry-date">Expected Graduation: <c:out value="${student.graduationYear}" /></div>
                            </div>
                            <div class="ats-entry-header">
                                <div class="ats-entry-subtitle">University Engineering College &bull; SkillTrack Verified Cohort</div>
                                <div class="ats-entry-date">Cumulative CGPA: <strong><c:out value="${student.formattedCgpa}" /> / 10.00</strong></div>
                            </div>
                            <div class="ats-skills-line mt-1">
                                <strong>Relevant Coursework:</strong> Data Structures &amp; Algorithms, Object-Oriented Programming (OOP), Database Management Systems (DBMS), Operating Systems, Computer Networks, Software Engineering Principles.
                            </div>
                        </div>
                    </div>

                    <!-- 4. Technical Skills Section -->
                    <div class="ats-section">
                        <div class="ats-section-title">Technical Skills &amp; Core Competencies</div>
                        <c:choose>
                            <c:when test="${not empty categorizedSkills}">
                                <c:forEach items="${categorizedSkills}" var="catEntry">
                                    <div class="ats-skills-line">
                                        <strong><c:out value="${catEntry.key}" />:</strong>
                                        <c:forEach items="${catEntry.value}" var="skName" varStatus="skLoop">
                                            <c:out value="${skName}" /><c:if test="${!skLoop.last}">, </c:if>
                                        </c:forEach>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="ats-skills-line">
                                    <strong>Programming Languages:</strong> Java, JavaScript, Python, C++, SQL
                                </div>
                                <div class="ats-skills-line">
                                    <strong>Frameworks &amp; Libraries:</strong> React.js, Node.js, Express.js, Spring Boot, HTML5, CSS3, Bootstrap
                                </div>
                            </c:otherwise>
                        </c:choose>
                        <div class="ats-skills-line">
                            <strong>Databases &amp; Cloud:</strong> MySQL, MongoDB, PostgreSQL, Relational Schema Modeling, Query Optimization
                        </div>
                        <div class="ats-skills-line">
                            <strong>Developer Tools &amp; Methodologies:</strong> Git, GitHub, VS Code, Postman, Linux Terminal, RESTful APIs, MVC Architecture, Agile Methodologies
                        </div>
                    </div>

                    <!-- 5. Technical Projects Section -->
                    <div class="ats-section">
                        <div class="ats-section-title">Technical &amp; Software Projects</div>
                        <c:choose>
                            <c:when test="${not empty profile.projects}">
                                <c:forEach items="${profile.projects}" var="proj">
                                    <div class="ats-entry">
                                        <div class="ats-entry-header">
                                            <div class="ats-entry-title">
                                                <c:out value="${proj.title}" />
                                                <c:if test="${not empty proj.techStack}">
                                                    <span style="font-weight: normal; color: #374151;"> | <em><c:out value="${proj.techStack}" /></em></span>
                                                </c:if>
                                            </div>
                                            <div class="ats-entry-date">
                                                <c:choose>
                                                    <c:when test="${not empty proj.githubUrl}">
                                                        <a href="<c:out value='${proj.githubUrl}' />" target="_blank" style="color: #004085; text-decoration: underline;">GitHub Repo</a>
                                                    </c:when>
                                                    <c:otherwise>Software Project</c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                        <ul class="ats-bullets">
                                            <c:if test="${not empty proj.description}">
                                                <li><c:out value="${proj.description}" /></li>
                                            </c:if>
                                            <li>Architected end-to-end full stack system with modular separation of concerns, secure input sanitization, and structured API endpoints.</li>
                                            <li>Designed and optimized database schemas to guarantee low latency and clean relational integrity across transactions.</li>
                                            <li>Implemented responsive, mobile-first client user interfaces ensuring cross-browser compatibility and accessible interaction.</li>
                                        </ul>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="ats-entry">
                                    <div class="ats-entry-header">
                                        <div class="ats-entry-title">Full Stack Career Intelligence &amp; Placement Application | <em>React.js, Node.js, MongoDB, REST APIs</em></div>
                                        <div class="ats-entry-date">Major Project</div>
                                    </div>
                                    <ul class="ats-bullets">
                                        <li>Architected responsive web application featuring role-based authentication, interactive dashboards, and real-time database queries.</li>
                                        <li>Implemented deterministic scoring algorithms, automated report generation, and modular RESTful API endpoints.</li>
                                        <li>Optimized database indexing and state management to achieve sub-100ms API response latency across core transactional routes.</li>
                                    </ul>
                                </div>
                                <div class="ats-entry">
                                    <div class="ats-entry-header">
                                        <div class="ats-entry-title">Algorithmic Code Tracker &amp; Diagnostic Platform | <em>Java, MySQL, MVC Architecture, Bootstrap</em></div>
                                        <div class="ats-entry-date">Academic Capstone</div>
                                    </div>
                                    <ul class="ats-bullets">
                                        <li>Engineered backend MVC architecture managing candidate problem-solving milestones across major competitive programming platforms.</li>
                                        <li>Integrated automated validation filters, session security tokens, and responsive single-column document export capabilities.</li>
                                    </ul>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- 6. Problem Solving & Algorithmic Milestones -->
                    <div class="ats-section">
                        <div class="ats-section-title">Problem Solving &amp; Algorithmic Milestones</div>
                        <div class="ats-entry">
                            <div class="ats-entry-header">
                                <div class="ats-entry-title">Competitive Programming &amp; Core Data Structures</div>
                                <div class="ats-entry-date">Total Solved: <strong><c:out value="${profile.totalDsaProblemsSolved}" default="0" /> Problems</strong></div>
                            </div>
                            <ul class="ats-bullets">
                                <li>Consistently practiced and solved coding problems covering <strong>Arrays, Strings, Two Pointers, Linked Lists, Binary Search, Trees, and Dynamic Programming</strong>.</li>
                                <li>Placement Readiness Index independently evaluated at <strong><c:out value="${readiness.formattedOverall}" default="0" />%</strong> benchmark compliance for <c:out value="${student.targetRoleTitle}" default="Software Engineering" /> hiring cutoffs.</li>
                            </ul>
                        </div>
                    </div>

                    <!-- 7. Key Achievements & Certifications -->
                    <div class="ats-section">
                        <div class="ats-section-title">Achievements &amp; Certifications</div>
                        <ul class="ats-bullets">
                            <c:choose>
                                <c:when test="${not empty profile.certifications}">
                                    <c:forEach items="${profile.certifications}" var="cert">
                                        <li>
                                            <strong><c:out value="${cert.title}" /></strong> &mdash; Issued by <c:out value="${cert.issuingOrg}" /> (<c:out value="${cert.formattedIssueDate}" />)
                                            <c:if test="${not empty cert.credentialUrl}">
                                                &bull; <a href="<c:out value='${cert.credentialUrl}' />" target="_blank" style="color: #004085; text-decoration: underline;">Verify Link</a>
                                            </c:if>
                                        </li>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <li><strong>Academic Distinction:</strong> Maintained high academic performance with a cumulative CGPA of <strong><c:out value="${student.formattedCgpa}" /> / 10.00</strong> in <c:out value="${student.department}" />.</li>
                                    <li><strong>Technical Milestones:</strong> Successfully solved <strong><c:out value="${profile.totalDsaProblemsSolved}" default="0" />+ DSA challenges</strong> and verified core full-stack competencies on SkillTrack Placement Engine.</li>
                                </c:otherwise>
                            </c:choose>
                            <li><strong>Campus Placement Drive Ready:</strong> Verified participant in institutional placement training cohorts, mock interviews, and technical screening rounds.</li>
                        </ul>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>

<!-- Interactive Summary Customizer Modal (No Print) -->
<div class="modal fade no-print" id="summaryModal" tabindex="-1" role="dialog" aria-labelledby="summaryModalTitle" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
        <div class="modal-content" style="border-radius: var(--ios-radius-lg); border: 1px solid #e2e8f0; box-shadow: var(--ios-shadow-glass);">
            <div class="modal-header pb-2" style="border-bottom: 1px solid #f1f5f9;">
                <div>
                    <h2 class="modal-title h5 font-weight-bold text-dark mb-0" id="summaryModalTitle">
                        Customize Professional Resume Summary
                    </h2>
                    <small class="text-muted">Choose a tailored archetype preset or write your own custom pitch.</small>
                </div>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body p-4">
                <!-- 3 Instant Smart Presets -->
                <div class="mb-3">
                    <label class="ios-form-label mb-2">⚡ 1-Click Smart Archetype Presets</label>
                    
                    <!-- Preset 1: Target Role Focused -->
                    <div class="summary-preset-card" onclick="applyPreset(1)">
                        <div class="d-flex justify-content-between align-items-center mb-1">
                            <strong style="color: var(--ios-blue); font-size: 0.875rem;">1. Role-Focused Specialist Archetype</strong>
                            <span class="ios-badge ios-badge-blue" style="font-size: 0.7rem;">Recommended</span>
                        </div>
                        <p class="small text-muted mb-0" id="presetText1">
                            Aspiring <strong><c:out value="${student.targetRoleTitle}" default="Software Development Engineer" /></strong> with strong academic grounding in <strong><c:out value="${student.department}" /> (CGPA: <c:out value="${student.formattedCgpa}" />/10.00)</strong>. Proficient in modern full stack development, database schema modeling, and scalable web architectures. Dedicated to building secure, maintainable applications and collaborating in high-velocity software engineering teams.
                        </p>
                    </div>

                    <!-- Preset 2: Project & Full-Stack Execution Focused -->
                    <div class="summary-preset-card" onclick="applyPreset(2)">
                        <div class="d-flex justify-content-between align-items-center mb-1">
                            <strong style="color: #7e22ce; font-size: 0.875rem;">2. Project-Driven Full Stack Builder Archetype</strong>
                            <span class="ios-badge ios-badge-purple" style="font-size: 0.7rem;">Project Heavy</span>
                        </div>
                        <p class="small text-muted mb-0" id="presetText2">
                            Hands-on Software Engineer with practical experience designing and shipping full-stack web applications. Skilled in building responsive client interfaces, designing normalized relational databases, and implementing RESTful APIs. Passionate about software architecture, clean code standards, and agile development lifecycles.
                        </p>
                    </div>

                    <!-- Preset 3: Algorithmic & Problem Solving Focused -->
                    <div class="summary-preset-card" onclick="applyPreset(3)">
                        <div class="d-flex justify-content-between align-items-center mb-1">
                            <strong style="color: #c2410c; font-size: 0.875rem;">3. Algorithmic &amp; Problem Solving Specialist Archetype</strong>
                            <span class="ios-badge ios-badge-orange" style="font-size: 0.7rem;">DSA Heavy</span>
                        </div>
                        <p class="small text-muted mb-0" id="presetText3">
                            Analytical problem solver with <strong><c:out value="${profile.totalDsaProblemsSolved}" default="15" />+ algorithmic coding milestones</strong> across core data structures including Trees, Dynamic Programming, and Graph Traversals. Placement Readiness Index evaluated at <strong><c:out value="${readiness.formattedOverall}" default="0" />%</strong>. Focused on algorithmic efficiency, backend performance, and robust system design.
                        </p>
                    </div>
                </div>

                <!-- Custom Text Area Input -->
                <div class="form-group mb-0">
                    <label for="customSummaryInput" class="ios-form-label">Or Write Your Custom Summary Text</label>
                    <textarea class="ios-form-control" id="customSummaryInput" rows="4" placeholder="Type your personalized professional career summary here..." style="font-size: 0.9rem; line-height: 1.5;"></textarea>
                    <div class="d-flex justify-content-between align-items-center mt-1">
                        <small class="text-muted" id="summaryCharCount">Chars: 0</small>
                        <button type="button" class="btn btn-sm btn-link p-0 text-muted" onclick="resetToDefaultSummary()" style="font-size: 0.8rem;">
                            Reset to Default
                        </button>
                    </div>
                </div>
            </div>
            <div class="modal-footer pt-2" style="border-top: 1px solid #f1f5f9;">
                <button type="button" class="ios-btn-secondary" data-dismiss="modal" style="padding: 0.55rem 1.25rem; font-size: 0.85rem;">Cancel</button>
                <button type="button" class="ios-btn-primary" onclick="saveAndApplySummary()" style="padding: 0.55rem 1.5rem; font-size: 0.85rem; box-shadow: 0 4px 12px rgba(0, 113, 227, 0.25);">
                    Save &amp; Apply to Resume
                </button>
            </div>
        </div>
    </div>
</div>

<script>
var studentStorageKey = "skilltrack_ats_summary_${student.studentId}";
var liveSummaryEl = document.getElementById('liveResumeSummary');
var customSummaryInput = document.getElementById('customSummaryInput');
var defaultSummaryHtml = liveSummaryEl ? liveSummaryEl.innerHTML : '';

function updateSummaryCharCount() {
    if (customSummaryInput) {
        var count = customSummaryInput.value.length;
        var countEl = document.getElementById('summaryCharCount');
        if (countEl) countEl.textContent = 'Chars: ' + count;
    }
}

if (customSummaryInput) {
    customSummaryInput.addEventListener('input', updateSummaryCharCount);
}

function applyPreset(presetNum) {
    var presetEl = document.getElementById('presetText' + presetNum);
    if (presetEl && customSummaryInput) {
        // Strip extra spaces and set text
        var text = presetEl.innerText || presetEl.textContent;
        customSummaryInput.value = text.trim();
        updateSummaryCharCount();
        if (typeof showToast === 'function') {
            showToast("✓ Preset " + presetNum + " copied to summary box!");
        }
    }
}

function resetToDefaultSummary() {
    if (liveSummaryEl) {
        liveSummaryEl.innerHTML = defaultSummaryHtml;
    }
    if (customSummaryInput) {
        customSummaryInput.value = liveSummaryEl.innerText || liveSummaryEl.textContent;
        updateSummaryCharCount();
    }
    try {
        localStorage.removeItem(studentStorageKey);
    } catch(e) {}
    if (typeof showToast === 'function') {
        showToast("✓ Reset to standard default summary.");
    }
}

function saveAndApplySummary() {
    if (!customSummaryInput || !liveSummaryEl) return;
    var newText = customSummaryInput.value.trim();
    if (newText.length > 0) {
        liveSummaryEl.textContent = newText;
        try {
            localStorage.setItem(studentStorageKey, newText);
        } catch(e) {}
        if (typeof showToast === 'function') {
            showToast("✓ Custom summary applied live to your ATS Resume!");
        }
    }
    if ($ && typeof $('#summaryModal').modal === 'function') {
        $('#summaryModal').modal('hide');
    }
}

// Load saved custom summary from localStorage on page load if exists
(function() {
    try {
        var saved = localStorage.getItem(studentStorageKey);
        if (saved && saved.trim().length > 0 && liveSummaryEl) {
            liveSummaryEl.textContent = saved.trim();
            if (customSummaryInput) {
                customSummaryInput.value = saved.trim();
                updateSummaryCharCount();
            }
        } else if (liveSummaryEl && customSummaryInput) {
            customSummaryInput.value = (liveSummaryEl.innerText || liveSummaryEl.textContent).trim();
            updateSummaryCharCount();
        }
    } catch(e) {}
})();

// PDF Export Handler
(function() {
    var btn = document.getElementById('downloadAtsPdfBtn');
    if (btn) {
        btn.addEventListener('click', function() {
            var element = document.getElementById('atsResumeDoc');
            if (!element) return;

            if (typeof html2pdf === 'undefined') {
                window.print();
                return;
            }

            var originalHtml = btn.innerHTML;
            btn.disabled = true;
            btn.innerHTML = '<span class="spinner-border spinner-border-sm mr-1.5" style="width: 12px; height: 12px; border-width: 2px;" role="status"></span> Generating ATS PDF...';

            var opt = {
                margin:       [6, 6, 6, 6],
                filename:     "SkillTrack_${student.rollNumber}_ATS_Resume.pdf",
                image:        { type: 'jpeg', quality: 0.98 },
                html2canvas:  { 
                    scale: 2.2, 
                    useCORS: true, 
                    logging: false,
                    letterRendering: true,
                    scrollY: 0,
                    scrollX: 0
                },
                jsPDF:        { unit: 'mm', format: 'a4', orientation: 'portrait' }
            };

            html2pdf().set(opt).from(element).save().then(function() {
                btn.disabled = false;
                btn.innerHTML = originalHtml;
                if (typeof showToast === 'function') {
                    showToast("✓ ATS-Compliant Resume downloaded successfully!");
                }
            }).catch(function(err) {
                console.error("ATS Resume PDF export error:", err);
                btn.disabled = false;
                btn.innerHTML = originalHtml;
                window.print();
            });
        });
    }
})();
</script>

<%@ include file="/WEB-INF/views/common/footer.jspf" %>
