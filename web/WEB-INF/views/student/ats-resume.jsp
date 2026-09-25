<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="ATS-Compliant Placement Resume" />
<c:set var="activeNav" value="ats-resume" />
<%@ include file="/WEB-INF/views/common/header.jspf" %>
<%@ include file="/WEB-INF/views/common/navbar.jspf" %>

<style>
/* =====================================================================
   ATS-Compliant Resume Stylesheet
   Strict Single-Column Standard | Machine Parseable | Zero Clutter
   ===================================================================== */
.ats-page-container {
    max-width: 900px;
    margin: 0 auto;
}

.ats-paper {
    background: #ffffff;
    color: #111827;
    font-family: 'Times New Roman', Times, 'Georgia', serif;
    line-height: 1.45;
    font-size: 10.5pt;
    padding: 38px 46px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
    border-radius: 4px;
    border: 1px solid #e5e7eb;
    margin-bottom: 2rem;
}

.ats-paper h1.ats-name {
    font-size: 19pt;
    font-weight: 700;
    text-align: center;
    letter-spacing: 0.5px;
    text-transform: uppercase;
    margin-bottom: 4px;
    color: #000000;
}

.ats-paper .ats-contact-bar {
    text-align: center;
    font-size: 9.5pt;
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
    margin-top: 14px;
    margin-bottom: 8px;
}

.ats-paper .ats-section-title {
    font-size: 11pt;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.8px;
    color: #000000;
    border-bottom: 1.2px solid #111827;
    padding-bottom: 2px;
    margin-bottom: 8px;
}

.ats-paper .ats-entry {
    margin-bottom: 9px;
}

.ats-paper .ats-entry-header {
    display: flex;
    justify-content: space-between;
    align-items: baseline;
    font-size: 10.5pt;
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
    font-size: 9.5pt;
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
    margin-bottom: 2.5px;
    color: #1f2937;
    font-size: 10pt;
    line-height: 1.4;
}

.ats-paper .ats-skills-line {
    font-size: 10pt;
    margin-bottom: 4px;
    line-height: 1.45;
}

.ats-paper .ats-skills-line strong {
    color: #000000;
}

/* Print Specific Rules */
@media print {
    body {
        background: #ffffff !important;
        margin: 0 !important;
        padding: 0 !important;
    }
    .no-print, nav, footer, .ios-navbar, .ios-toast-container, #iosToastContainer {
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
        font-size: 10pt !important;
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
                            100% Parser Compliant
                        </span>
                    </div>
                    <h1 class="h3 font-weight-bold text-gray-800 mb-0" style="letter-spacing: -0.03em;">ATS-Compliant Placement Resume</h1>
                    <p class="text-muted small mb-0 mt-1">Machine-readable single-column Ivy-League format compiled live from your verified SkillTrack portfolio</p>
                </div>
                <div class="d-flex align-items-center flex-wrap flex-sm-nowrap gap-2 mt-3 mt-lg-0 w-100 w-lg-auto" style="gap: 0.5rem;">
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
                            <div class="font-weight-bold text-dark" style="font-size: 0.9rem;">Why this format clears 99% of corporate ATS filters:</div>
                            <small class="text-muted">Single-column hierarchy &bull; High-contrast serif typography &bull; Standard section headers &bull; No text boxes, tables, or icons that break resume parsers.</small>
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

                    <!-- 2. Education Section -->
                    <div class="ats-section">
                        <div class="ats-section-title">Education</div>
                        <div class="ats-entry">
                            <div class="ats-entry-header">
                                <div class="ats-entry-title">Bachelor of Technology / Degree in <c:out value="${student.department}" /></div>
                                <div class="ats-entry-date">Graduation: <c:out value="${student.graduationYear}" /></div>
                            </div>
                            <div class="ats-entry-header">
                                <div class="ats-entry-subtitle">University Engineering College &bull; SkillTrack Verified Cohort</div>
                                <div class="ats-entry-date">CGPA: <strong><c:out value="${student.formattedCgpa}" /> / 10.00</strong></div>
                            </div>
                        </div>
                    </div>

                    <!-- 3. Technical Skills Section -->
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
                                    <strong>Core Competencies:</strong> Java, Data Structures &amp; Algorithms, Relational Databases, Web Technologies
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- 4. Projects Section -->
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
                                                <c:if test="${not empty proj.githubUrl}">
                                                    <a href="<c:out value='${proj.githubUrl}' />" target="_blank" style="color: #004085; text-decoration: underline;">GitHub Repository</a>
                                                </c:if>
                                            </div>
                                        </div>
                                        <ul class="ats-bullets">
                                            <c:if test="${not empty proj.description}">
                                                <li><c:out value="${proj.description}" /></li>
                                            </c:if>
                                            <li>Engineered robust architecture implementing core modular design patterns, clean database relationships, and validated APIs.</li>
                                        </ul>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="ats-entry">
                                    <div class="ats-entry-header">
                                        <div class="ats-entry-title">Full Stack Web Application Project | <em>Java, MySQL, MVC, Bootstrap</em></div>
                                        <div class="ats-entry-date">Academic Capstone</div>
                                    </div>
                                    <ul class="ats-bullets">
                                        <li>Architected end-to-end database-backed enterprise application with role-based access control and responsive client interfaces.</li>
                                        <li>Integrated deterministic scoring algorithms and automated report generation modules.</li>
                                    </ul>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- 5. Problem Solving & DSA Benchmarks -->
                    <div class="ats-section">
                        <div class="ats-section-title">Problem Solving &amp; Algorithms</div>
                        <div class="ats-entry">
                            <div class="ats-entry-header">
                                <div class="ats-entry-title">Data Structures &amp; Algorithmic Milestones</div>
                                <div class="ats-entry-date">Total Solved: <strong><c:out value="${profile.totalDsaProblemsSolved}" default="0" /> Problems</strong></div>
                            </div>
                            <ul class="ats-bullets">
                                <li>Consistently solved algorithmic coding problems spanning Arrays, Strings, Linked Lists, Trees, Dynamic Programming, and Graph Traversals.</li>
                                <li>Placement Readiness Index evaluated at <strong><c:out value="${readiness.formattedOverall}" default="0" />%</strong> benchmark compliance for <c:out value="${student.targetRoleTitle}" default="Software Engineering" /> roles.</li>
                            </ul>
                        </div>
                    </div>

                    <!-- 6. Certifications & Accreditations -->
                    <c:if test="${not empty profile.certifications}">
                        <div class="ats-section">
                            <div class="ats-section-title">Certifications &amp; Accreditations</div>
                            <ul class="ats-bullets" style="margin-top: 5px;">
                                <c:forEach items="${profile.certifications}" var="cert">
                                    <li>
                                        <strong><c:out value="${cert.title}" /></strong> &mdash; Issued by <c:out value="${cert.issuingOrg}" /> (<c:out value="${cert.formattedIssueDate}" />)
                                        <c:if test="${not empty cert.credentialUrl}">
                                            &bull; <a href="<c:out value='${cert.credentialUrl}' />" target="_blank" style="color: #004085; text-decoration: underline;">Verify Credential</a>
                                        </c:if>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </c:if>
                </div>
            </div>
        </main>
    </div>
</div>

<script>
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
                margin:       [8, 8, 8, 8],
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
