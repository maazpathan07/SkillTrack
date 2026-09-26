<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="ATS Resume Scanner & Matcher" />
<c:set var="activeNav" value="ats-scanner" />
<%@ include file="/WEB-INF/views/common/header.jspf" %>
<%@ include file="/WEB-INF/views/common/navbar.jspf" %>

<style>
    .ats-page-wrapper {
        max-width: 1440px;
        margin: 0 auto;
    }

    /* Glassmorphic Page Header */
    .ats-header-card {
        background: rgba(255, 255, 255, 0.85);
        backdrop-filter: blur(12px);
        -webkit-backdrop-filter: blur(12px);
        border: 1px solid rgba(226, 232, 240, 0.8);
        border-radius: 16px;
        padding: 1.25rem 1.5rem;
        box-shadow: 0 4px 20px -2px rgba(0, 0, 0, 0.03);
        margin-bottom: 1.5rem;
    }

    /* Standard Glass Cards */
    .ats-card {
        background: #ffffff;
        border: 1px solid rgba(226, 232, 240, 0.85);
        border-radius: 16px;
        box-shadow: 0 4px 20px -2px rgba(0, 0, 0, 0.03);
        margin-bottom: 1.5rem;
        overflow: hidden;
    }

    .ats-card-header {
        padding: 1.15rem 1.5rem;
        background: rgba(248, 250, 252, 0.7);
        border-bottom: 1px solid rgba(226, 232, 240, 0.8);
        display: flex;
        align-items: center;
        justify-content: space-between;
        flex-wrap: wrap;
        gap: 0.75rem;
    }

    .ats-card-body {
        padding: 1.5rem;
    }

    /* Form Controls */
    .ats-form-label {
        font-size: 0.825rem;
        font-weight: 600;
        color: #334155;
        margin-bottom: 0.4rem;
        display: flex;
        align-items: center;
        justify-content: space-between;
    }

    .ats-input {
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

    .ats-input:focus {
        border-color: #3b82f6;
        outline: none;
        box-shadow: 0 0 0 3.5px rgba(59, 130, 246, 0.12);
    }

    .ats-textarea {
        font-family: 'JetBrains Mono', 'Fira Code', Consolas, monospace;
        font-size: 0.825rem;
        line-height: 1.6;
        background: #f8fafc;
        border: 1.5px solid #e2e8f0;
        border-radius: 12px;
        padding: 0.85rem 1rem;
        width: 100%;
        color: #0f172a;
        resize: vertical;
        transition: all 0.2s ease;
    }

    .ats-textarea:focus {
        background: #ffffff;
        border-color: #3b82f6;
        outline: none;
        box-shadow: 0 0 0 3.5px rgba(59, 130, 246, 0.12);
    }

    /* Badges */
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

    /* Score Metric Mini Cards */
    .metric-mini-card {
        background: #f8fafc;
        border: 1px solid #e2e8f0;
        border-radius: 12px;
        padding: 0.75rem 0.5rem;
        text-align: center;
        transition: all 0.2s ease;
    }

    .metric-mini-card:hover {
        background: #ffffff;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.04);
        transform: translateY(-1px);
    }

    /* Buttons */
    .btn-ats-primary {
        background: linear-gradient(135deg, #3b82f6, #2563eb);
        color: #ffffff;
        border: none;
        border-radius: 12px;
        padding: 0.75rem 1.75rem;
        font-size: 0.9rem;
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

    .btn-ats-primary:hover {
        transform: translateY(-1px);
        box-shadow: 0 6px 18px -2px rgba(37, 99, 235, 0.5);
        color: #ffffff;
    }

    .btn-action-light {
        background: #f1f5f9;
        color: #334155;
        border: 1px solid #e2e8f0;
        border-radius: 10px;
        padding: 0.5rem 1rem;
        font-size: 0.825rem;
        font-weight: 600;
        display: inline-flex;
        align-items: center;
        gap: 0.4rem;
        transition: all 0.2s ease;
        text-decoration: none !important;
        cursor: pointer;
    }

    .btn-action-light:hover {
        background: #e2e8f0;
        color: #0f172a;
    }
</style>

<div class="container-fluid px-3 px-lg-4 py-4 ats-page-wrapper">
    <%@ include file="/WEB-INF/views/common/alerts.jspf" %>

    <!-- Header Banner -->
    <div class="ats-header-card">
        <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">
            <div>
                <div class="d-flex align-items-center gap-2 mb-1">
                    <span class="ios-pill-badge ios-pill-purple">
                        <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                        ATS Diagnostic Engine
                    </span>
                    <span class="ios-pill-badge ios-pill-blue">
                        Placement Screening Simulator
                    </span>
                </div>
                <h1 class="h3 font-weight-bold text-gray-900 mb-0" style="letter-spacing: -0.025em;">ATS Resume Scanner &amp; Matcher</h1>
                <p class="text-muted small mb-0 mt-1">Audit resume keywords and structure against company benchmarks to eliminate automated filter rejections</p>
            </div>
            <div>
                <a href="${pageContext.request.contextPath}/app/student/ats-resume" class="btn-ats-primary" style="padding: 0.65rem 1.35rem; font-size: 0.875rem;">
                    <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path><polyline points="14 2 14 8 20 8"></polyline><line x1="16" y1="13" x2="8" y2="13"></line><line x1="16" y1="17" x2="8" y2="17"></line></svg>
                    1-Click ATS Resume Builder &rarr;
                </a>
            </div>
        </div>
    </div>

    <div class="row">
        <!-- Left Column: Input Form (5 Cols) -->
        <div class="col-lg-5 mb-4">
            <div class="ats-card h-100">
                <div class="ats-card-header">
                    <div>
                        <span class="font-weight-bold text-dark" style="font-size: 0.95rem;">Resume Content &amp; Target Setup</span>
                    </div>
                    <span class="ios-pill-badge ios-pill-blue">
                        <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 20h9"></path><path d="M16.5 3.5a2.121 2.121 0 0 1 3 3L7 19l-4 1 1-4L16.5 3.5z"></path></svg>
                        Plain Text Parser
                    </span>
                </div>
                <div class="ats-card-body">
                    <form action="${pageContext.request.contextPath}/app/student/ats-scanner" method="post" id="atsScanForm">
                        <input type="hidden" name="csrfToken" value="${sessionScope.CSRF_TOKEN}" />

                        <!-- Target Role -->
                        <div class="form-group mb-3">
                            <label class="ats-form-label" for="targetRoleId">Target Role Benchmark</label>
                            <select class="ats-input" name="targetRoleId" id="targetRoleId">
                                <option value="">Select Target Role...</option>
                                <c:forEach items="${targetRoles}" var="r">
                                    <option value="${r.roleId}" ${selectedRoleId == r.roleId ? 'selected' : ''}>
                                        <c:out value="${r.roleTitle}" />
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <!-- Specific Company Cutoff -->
                        <div class="form-group mb-3">
                            <label class="ats-form-label" for="criteriaId">Company Specific Cutoff (Optional)</label>
                            <select class="ats-input" name="criteriaId" id="criteriaId">
                                <option value="">None (Use Target Role Benchmark)</option>
                                <c:forEach items="${criteriaList}" var="c">
                                    <option value="${c.criteriaId}" ${selectedCriteriaId == c.criteriaId ? 'selected' : ''}>
                                        <c:out value="${c.companyName}" /> &bull; <c:out value="${c.roleTitle}" />
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <!-- Resume Text Content -->
                        <div class="form-group mb-3">
                            <div class="d-flex justify-content-between align-items-center mb-1">
                                <label for="resumeText" class="ats-form-label mb-0">Resume Text Content</label>
                                <button type="button" class="btn btn-sm btn-link p-0 text-primary font-weight-bold" id="loadProfileTextBtn" style="font-size: 0.8rem; text-decoration: none;">
                                    <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" class="mr-1"><polyline points="23 4 23 10 17 10"></polyline><polyline points="1 20 1 14 7 14"></polyline><path d="M3.51 9a9 9 0 0 1 14.85-3.36L23 10M1 14l4.64 4.36A9 9 0 0 0 20.49 15"></path></svg>
                                    Load from Profile
                                </button>
                            </div>
                            <textarea class="ats-textarea" id="resumeText" name="resumeText" rows="11" placeholder="Paste your plain text resume here (Sections: Education, Skills, Projects, DSA, Certifications)..."><c:out value="${resumeText}" /></textarea>
                            <div class="d-flex justify-content-between align-items-center mt-1 px-1">
                                <small class="text-muted" id="wordCountLabel">Words: <c:out value="${scanResult.wordCount}" default="0" /></small>
                                <small class="text-muted" id="charCountLabel">Chars: <c:out value="${scanResult.characterCount}" default="0" /></small>
                            </div>
                        </div>

                        <!-- Submit Button -->
                        <div class="pt-2">
                            <button type="submit" class="btn-ats-primary w-100">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                                Run ATS Diagnostic Scan
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Right Column: Results & Diagnosis Panel (7 Cols) -->
        <div class="col-lg-7 mb-4">
            <c:choose>
                <c:when test="${not empty scanResult}">
                    <!-- Overall Score Card -->
                    <div class="ats-card mb-4" style="border-left: 5px solid <c:choose><c:when test='${scanResult.overallScore >= 75}'>#10b981</c:when><c:when test='${scanResult.overallScore >= 50}'>#f59e0b</c:when><c:otherwise>#ef4444</c:otherwise></c:choose>;">
                        <div class="ats-card-body p-4">
                            <div class="d-flex flex-column flex-sm-row justify-content-between align-items-sm-center gap-3">
                                <div>
                                    <span class="ios-pill-badge <c:choose><c:when test='${scanResult.overallScore >= 75}'>ios-pill-emerald</c:when><c:when test='${scanResult.overallScore >= 50}'>ios-pill-amber</c:when><c:otherwise>ios-pill-rose</c:otherwise></c:choose> mb-1">
                                        <c:choose>
                                            <c:when test="${scanResult.overallScore >= 75}">
                                                <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3"><polyline points="20 6 9 17 4 12"></polyline></svg>
                                                High ATS Pass Probability
                                            </c:when>
                                            <c:when test="${scanResult.overallScore >= 50}">
                                                <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"></polygon></svg>
                                                Moderate Match &bull; Keyword Gaps
                                            </c:when>
                                            <c:otherwise>
                                                <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg>
                                                High Risk of Filter Rejection
                                            </c:otherwise>
                                        </c:choose>
                                    </span>
                                    <h2 class="h4 font-weight-bold text-dark mb-1" style="letter-spacing: -0.02em;">
                                        ATS Match: <c:out value="${scanResult.targetRoleTitle}" />
                                        <c:if test="${not empty scanResult.companyName}">
                                            <span style="font-size: 0.95rem; color: #64748b;">(<c:out value="${scanResult.companyName}" />)</span>
                                        </c:if>
                                    </h2>
                                    <p class="text-muted small mb-0">Evaluated on keyword density, action verb strength, quantified metrics &amp; structural compliance</p>
                                </div>
                                <div class="text-sm-right flex-shrink-0">
                                    <div class="font-weight-bold" style="font-size: 2.75rem; line-height: 1; letter-spacing: -0.03em; color: <c:choose><c:when test='${scanResult.overallScore >= 75}'>#059669</c:when><c:when test='${scanResult.overallScore >= 50}'>#d97706</c:when><c:otherwise>#dc2626</c:otherwise></c:choose>;">
                                        <c:out value="${scanResult.overallScore}" />%
                                    </div>
                                    <small class="text-muted font-weight-bold text-uppercase" style="letter-spacing: 0.05em; font-size: 0.75rem;">ATS Score</small>
                                </div>
                            </div>

                            <!-- 4 Pillar Metrics Grid -->
                            <div class="row mt-4 pt-3 border-top">
                                <div class="col-6 col-md-3 mb-2 mb-md-0">
                                    <div class="metric-mini-card">
                                        <small class="text-muted text-uppercase font-weight-bold" style="font-size: 0.68rem; letter-spacing: 0.04em;">Keywords</small>
                                        <div class="font-weight-bold text-dark mt-0.5" style="font-size: 1.15rem;"><c:out value="${scanResult.keywordScore}" />%</div>
                                        <small class="text-muted font-weight-500" style="font-size: 0.75rem;"><c:out value="${scanResult.matchedKeywords.size()}" /> Matched</small>
                                    </div>
                                </div>
                                <div class="col-6 col-md-3 mb-2 mb-md-0">
                                    <div class="metric-mini-card">
                                        <small class="text-muted text-uppercase font-weight-bold" style="font-size: 0.68rem; letter-spacing: 0.04em;">Action Verbs</small>
                                        <div class="font-weight-bold text-dark mt-0.5" style="font-size: 1.15rem;"><c:out value="${scanResult.actionVerbScore}" />%</div>
                                        <small class="text-muted font-weight-500" style="font-size: 0.75rem;"><c:out value="${scanResult.detectedActionVerbs.size()}" /> Verbs</small>
                                    </div>
                                </div>
                                <div class="col-6 col-md-3">
                                    <div class="metric-mini-card">
                                        <small class="text-muted text-uppercase font-weight-bold" style="font-size: 0.68rem; letter-spacing: 0.04em;">Metrics</small>
                                        <div class="font-weight-bold text-dark mt-0.5" style="font-size: 1.15rem;"><c:out value="${scanResult.metricScore}" />%</div>
                                        <small class="text-muted font-weight-500" style="font-size: 0.75rem;"><c:out value="${scanResult.detectedMetrics.size()}" /> Numbers</small>
                                    </div>
                                </div>
                                <div class="col-6 col-md-3">
                                    <div class="metric-mini-card">
                                        <small class="text-muted text-uppercase font-weight-bold" style="font-size: 0.68rem; letter-spacing: 0.04em;">Structure</small>
                                        <div class="font-weight-bold text-dark mt-0.5" style="font-size: 1.15rem;"><c:out value="${scanResult.formatScore}" />%</div>
                                        <small class="text-muted font-weight-500" style="font-size: 0.75rem;"><c:out value="${scanResult.presentSections.size()}" />/6 Sections</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Keyword Breakdown Card -->
                    <div class="ats-card mb-4">
                        <div class="ats-card-header">
                            <span class="font-weight-bold text-dark" style="font-size: 0.95rem;">Role &amp; Placement Keyword Breakdown</span>
                            <span class="ios-pill-badge ios-pill-blue">Keyword Engine</span>
                        </div>
                        <div class="ats-card-body p-4">
                            <!-- Matched Keywords -->
                            <div class="mb-3">
                                <div class="d-flex align-items-center gap-1.5 mb-2">
                                    <span class="ios-pill-badge ios-pill-emerald">
                                        <svg width="10" height="10" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3"><polyline points="20 6 9 17 4 12"></polyline></svg>
                                        Matched Keywords (${scanResult.matchedKeywords.size()})
                                    </span>
                                </div>
                                <div class="d-flex flex-wrap gap-2">
                                    <c:choose>
                                        <c:when test="${not empty scanResult.matchedKeywords}">
                                            <c:forEach items="${scanResult.matchedKeywords}" var="kw">
                                                <span class="ios-pill-badge ios-pill-emerald" style="font-size: 0.8rem; padding: 0.35rem 0.75rem;">
                                                    <c:out value="${kw}" />
                                                </span>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted small">No target keywords matched yet.</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>

                            <!-- Missing Keywords -->
                            <c:if test="${not empty scanResult.missingKeywords}">
                                <div class="pt-3 border-top">
                                    <div class="d-flex align-items-center gap-1.5 mb-2">
                                        <span class="ios-pill-badge ios-pill-rose">
                                            <svg width="10" height="10" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg>
                                            Missing High-Priority Keywords (${scanResult.missingKeywords.size()})
                                        </span>
                                    </div>
                                    <div class="d-flex flex-wrap gap-2">
                                        <c:forEach items="${scanResult.missingKeywords}" var="kw">
                                            <span class="ios-pill-badge ios-pill-rose" style="font-size: 0.8rem; padding: 0.35rem 0.75rem;">
                                                + <c:out value="${kw}" />
                                            </span>
                                        </c:forEach>
                                    </div>
                                    <small class="text-muted d-block mt-2 font-weight-500" style="font-size: 0.8rem;">
                                        💡 Tip: Adding these keywords naturally to your projects or skills section will directly boost your ATS compatibility score.
                                    </small>
                                </div>
                            </c:if>
                        </div>
                    </div>

                    <!-- Recommendations Card -->
                    <div class="ats-card mb-4">
                        <div class="ats-card-header">
                            <span class="font-weight-bold text-dark" style="font-size: 0.95rem;">Smart Actionable Recommendations</span>
                            <span class="ios-pill-badge ios-pill-purple">AI Insights</span>
                        </div>
                        <div class="ats-card-body p-4">
                            <ul class="list-unstyled mb-0">
                                <c:forEach items="${scanResult.improvementTips}" var="tip">
                                    <li class="d-flex align-items-start mb-2.5" style="gap: 0.65rem;">
                                        <div class="d-flex align-items-center justify-content-center flex-shrink-0 mt-0.5" style="width: 22px; height: 22px; border-radius: 50%; background: rgba(59, 130, 246, 0.1); color: #2563eb;">
                                            <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3"><polyline points="9 18 15 12 9 6"></polyline></svg>
                                        </div>
                                        <span class="small font-weight-500" style="color: #334155; line-height: 1.55;"><c:out value="${tip}" /></span>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </c:when>
            </c:choose>
        </div>
    </div>
</div>

<textarea id="profileTemplateText" style="display:none;"><c:out value="${student.fullName}" />
Email: <c:out value="${student.email}" />
Department: <c:out value="${student.department}" />
CGPA: <c:out value="${student.formattedCgpa}" />

EDUCATION
Bachelor of Technology in <c:out value="${student.department}" /> - Batch <c:out value="${student.graduationYear}" />

TECHNICAL SKILLS
<c:forEach items="${profile.skills}" var="sk"><c:out value="${sk.skillName}" />, </c:forEach>

PROJECTS
<c:forEach items="${profile.projects}" var="p"><c:out value="${p.title}" /> | <c:out value="${p.techStack}" />
<c:out value="${p.description}" />

</c:forEach>
PROBLEM SOLVING
Data Structures & Algorithms - Solved <c:out value="${profile.totalDsaProblemsSolved}" default="0" /> problems

CERTIFICATIONS
<c:forEach items="${profile.certifications}" var="c"><c:out value="${c.title}" /> - <c:out value="${c.issuingOrg}" />
</c:forEach></textarea>

<script>
(function() {
    var loadBtn = document.getElementById('loadProfileTextBtn');
    var resumeArea = document.getElementById('resumeText');
    var wordLabel = document.getElementById('wordCountLabel');
    var charLabel = document.getElementById('charCountLabel');
    var templateArea = document.getElementById('profileTemplateText');

    function updateCounts() {
        if (!resumeArea) return;
        var text = resumeArea.value || '';
        var words = text.trim() ? text.trim().split(/\s+/).length : 0;
        if (wordLabel) wordLabel.textContent = 'Words: ' + words;
        if (charLabel) charLabel.textContent = 'Chars: ' + text.length;
    }

    if (resumeArea) {
        resumeArea.addEventListener('input', updateCounts);
        updateCounts();
    }

    if (loadBtn && resumeArea && templateArea) {
        loadBtn.addEventListener('click', function() {
            resumeArea.value = templateArea.value;
            updateCounts();
            if (typeof showToast === 'function') {
                showToast("✓ Loaded resume text from your SkillTrack profile!");
            }
        });
    }
})();
</script>

<%@ include file="/WEB-INF/views/common/footer.jspf" %>
