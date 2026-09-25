<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="ATS Resume Scanner & Matcher" />
<c:set var="activeNav" value="ats-scanner" />
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
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" aria-hidden="true"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                            ATS Diagnostic Engine
                        </span>
                        <span class="ios-badge ios-badge-blue">
                            Placement Screening Simulator
                        </span>
                    </div>
                    <h1 class="h3 font-weight-bold text-gray-800 mb-0" style="letter-spacing: -0.03em;">ATS Resume Scanner &amp; Matcher</h1>
                    <p class="text-muted small mb-0 mt-1">Audit your resume against company job descriptions and target role benchmarks to eliminate automated filter rejections</p>
                </div>
                <div class="d-flex align-items-center flex-wrap flex-sm-nowrap gap-2 mt-3 mt-lg-0 w-100 w-lg-auto" style="gap: 0.5rem;">
                    <a href="${pageContext.request.contextPath}/app/student/ats-resume" class="ios-btn-primary d-inline-flex align-items-center justify-content-center flex-grow-1 flex-sm-grow-0" style="padding: 0.6rem 1.25rem; font-size: 0.875rem; box-shadow: 0 4px 12px rgba(0, 113, 227, 0.25); white-space: nowrap;">
                        <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" class="mr-1.5"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path><polyline points="14 2 14 8 20 8"></polyline><line x1="16" y1="13" x2="8" y2="13"></line><line x1="16" y1="17" x2="8" y2="17"></line></svg>
                        1-Click ATS Resume Builder &rarr;
                    </a>
                </div>
            </div>

            <div class="row">
                <!-- Left Column: Input Form -->
                <div class="col-lg-5 mb-4">
                    <div class="ios-card h-100">
                        <div class="ios-card-header" style="padding: 1.25rem 1.5rem;">
                            <div>
                                <h2 class="h5 font-weight-bold text-dark mb-0" style="font-size: 1.15rem; letter-spacing: -0.02em;">
                                    Resume Content &amp; Target Setup
                                </h2>
                                <small class="text-muted">Select your target benchmark and paste your resume text</small>
                            </div>
                        </div>
                        <div class="ios-card-body" style="padding: 1.5rem;">
                            <form action="${pageContext.request.contextPath}/app/student/ats-scanner" method="post" id="atsScanForm">
                                <input type="hidden" name="csrfToken" value="${sessionScope.CSRF_TOKEN}" />

                                <div class="form-group mb-3">
                                    <label class="ios-form-label">Target Role Benchmark</label>
                                    <select class="ios-form-control" name="targetRoleId" id="targetRoleId">
                                        <option value="">Select Target Role...</option>
                                        <c:forEach items="${targetRoles}" var="r">
                                            <option value="${r.roleId}" ${selectedRoleId == r.roleId ? 'selected' : ''}>
                                                <c:out value="${r.roleTitle}" />
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <div class="form-group mb-3">
                                    <label class="ios-form-label">Or Compare Specific Company Cutoff</label>
                                    <select class="ios-form-control" name="criteriaId" id="criteriaId">
                                        <option value="">None (Use Target Role Benchmark)</option>
                                        <c:forEach items="${criteriaList}" var="c">
                                            <option value="${c.criteriaId}" ${selectedCriteriaId == c.criteriaId ? 'selected' : ''}>
                                                <c:out value="${c.companyName}" /> &bull; <c:out value="${c.roleTitle}" />
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <div class="form-group mb-3">
                                    <div class="d-flex justify-content-between align-items-center mb-1">
                                        <label for="resumeText" class="ios-form-label mb-0">Resume Text Content</label>
                                        <button type="button" class="btn btn-sm btn-link p-0 text-primary font-weight-bold" id="loadProfileTextBtn" style="font-size: 0.8rem; text-decoration: underline;">
                                            &circlearrowright; Load from Profile
                                        </button>
                                    </div>
                                    <textarea class="ios-form-control" id="resumeText" name="resumeText" rows="12" placeholder="Paste your plain text resume here (Sections: Education, Skills, Projects, DSA, Certifications)..." style="font-family: 'JetBrains Mono', Consolas, monospace; font-size: 0.825rem; line-height: 1.55;"><c:out value="${resumeText}" /></textarea>
                                    <div class="d-flex justify-content-between align-items-center mt-1">
                                        <small class="text-muted" id="wordCountLabel">Words: <c:out value="${scanResult.wordCount}" default="0" /></small>
                                        <small class="text-muted" id="charCountLabel">Chars: <c:out value="${scanResult.characterCount}" default="0" /></small>
                                    </div>
                                </div>

                                <div class="pt-2">
                                    <button type="submit" class="ios-btn-primary w-100 d-flex align-items-center justify-content-center" style="padding: 0.75rem 1.5rem; font-size: 0.95rem; font-weight: 700; box-shadow: 0 4px 14px rgba(0, 113, 227, 0.3);">
                                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" class="mr-2"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                                        Run ATS Diagnostic Scan
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Right Column: Results & Diagnosis Panel -->
                <div class="col-lg-7 mb-4">
                    <c:choose>
                        <c:when test="${not empty scanResult}">
                            <!-- Overall Score Card -->
                            <div class="ios-card mb-4" style="border-left: 4px solid <c:choose><c:when test='${scanResult.overallScore >= 75}'>var(--ios-green)</c:when><c:when test='${scanResult.overallScore >= 50}'>var(--ios-orange)</c:when><c:otherwise>var(--ios-red)</c:otherwise></c:choose>;">
                                <div class="ios-card-body p-4">
                                    <div class="d-flex flex-column flex-sm-row justify-content-between align-items-sm-center gap-3">
                                        <div>
                                            <span class="ios-badge <c:choose><c:when test='${scanResult.overallScore >= 75}'>ios-badge-green</c:when><c:when test='${scanResult.overallScore >= 50}'>ios-badge-orange</c:when><c:otherwise>ios-badge-red</c:otherwise></c:choose> font-weight-bold mb-1">
                                                <c:choose>
                                                    <c:when test="${scanResult.overallScore >= 75}">High ATS Pass Probability</c:when>
                                                    <c:when test="${scanResult.overallScore >= 50}">Moderate Match &bull; Keyword Gaps</c:when>
                                                    <c:otherwise>High Risk of Filter Rejection</c:otherwise>
                                                </c:choose>
                                            </span>
                                            <h2 class="h4 font-weight-bold text-dark mb-1" style="letter-spacing: -0.02em;">
                                                ATS Match: <c:out value="${scanResult.targetRoleTitle}" />
                                                <c:if test="${not empty scanResult.companyName}">
                                                    <span style="font-size: 0.95rem; color: #64748b;">(<c:out value="${scanResult.companyName}" />)</span>
                                                </c:if>
                                            </h2>
                                            <small class="text-muted">Evaluated on keyword density, action verb strength, quantified metrics &amp; structural compliance</small>
                                        </div>
                                        <div class="text-sm-right flex-shrink-0">
                                            <div class="font-weight-bold" style="font-size: 2.5rem; line-height: 1; letter-spacing: -0.03em; color: <c:choose><c:when test='${scanResult.overallScore >= 75}'>var(--ios-green-dark)</c:when><c:when test='${scanResult.overallScore >= 50}'>#b45309</c:when><c:otherwise>var(--ios-red-dark)</c:otherwise></c:choose>;">
                                                <c:out value="${scanResult.overallScore}" />%
                                            </div>
                                            <small class="text-muted font-weight-bold">ATS Score</small>
                                        </div>
                                    </div>

                                    <!-- 4 Pillar Metrics Grid -->
                                    <div class="row mt-4 pt-3 border-top">
                                        <div class="col-6 col-md-3 mb-2 mb-md-0 text-center">
                                            <small class="text-muted text-uppercase font-weight-bold" style="font-size: 0.7rem;">Keywords</small>
                                            <div class="font-weight-bold text-dark mt-1" style="font-size: 1.15rem;"><c:out value="${scanResult.keywordScore}" />%</div>
                                            <small class="text-muted"><c:out value="${scanResult.matchedKeywords.size()}" /> Matched</small>
                                        </div>
                                        <div class="col-6 col-md-3 mb-2 mb-md-0 text-center">
                                            <small class="text-muted text-uppercase font-weight-bold" style="font-size: 0.7rem;">Action Verbs</small>
                                            <div class="font-weight-bold text-dark mt-1" style="font-size: 1.15rem;"><c:out value="${scanResult.actionVerbScore}" />%</div>
                                            <small class="text-muted"><c:out value="${scanResult.detectedActionVerbs.size()}" /> Verbs</small>
                                        </div>
                                        <div class="col-6 col-md-3 text-center">
                                            <small class="text-muted text-uppercase font-weight-bold" style="font-size: 0.7rem;">Metrics</small>
                                            <div class="font-weight-bold text-dark mt-1" style="font-size: 1.15rem;"><c:out value="${scanResult.metricScore}" />%</div>
                                            <small class="text-muted"><c:out value="${scanResult.detectedMetrics.size()}" /> Numbers</small>
                                        </div>
                                        <div class="col-6 col-md-3 text-center">
                                            <small class="text-muted text-uppercase font-weight-bold" style="font-size: 0.7rem;">Structure</small>
                                            <div class="font-weight-bold text-dark mt-1" style="font-size: 1.15rem;"><c:out value="${scanResult.formatScore}" />%</div>
                                            <small class="text-muted"><c:out value="${scanResult.presentSections.size()}" />/6 Sections</small>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Keyword Breakdown Card -->
                            <div class="ios-card mb-4">
                                <div class="ios-card-header" style="padding: 1.1rem 1.5rem;">
                                    <h3 class="h6 font-weight-bold text-dark mb-0">Role &amp; Placement Keyword Breakdown</h3>
                                </div>
                                <div class="ios-card-body p-4">
                                    <!-- Matched Keywords -->
                                    <div class="mb-3">
                                        <div class="d-flex align-items-center gap-1.5 mb-2">
                                            <span class="ios-badge ios-badge-green font-weight-bold" style="font-size: 0.75rem;">
                                                <svg width="10" height="10" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" class="mr-1"><polyline points="20 6 9 17 4 12"></polyline></svg>
                                                Matched Keywords (${scanResult.matchedKeywords.size()})
                                            </span>
                                        </div>
                                        <div class="d-flex flex-wrap gap-1.5" style="gap: 0.4rem;">
                                            <c:choose>
                                                <c:when test="${not empty scanResult.matchedKeywords}">
                                                    <c:forEach items="${scanResult.matchedKeywords}" var="kw">
                                                        <span class="ios-badge ios-badge-green" style="font-size: 0.8rem; padding: 0.3rem 0.65rem;">
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
                                                <span class="ios-badge ios-badge-red font-weight-bold" style="font-size: 0.75rem;">
                                                    <svg width="10" height="10" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" class="mr-1"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg>
                                                    Missing High-Priority Keywords (${scanResult.missingKeywords.size()})
                                                </span>
                                            </div>
                                            <div class="d-flex flex-wrap gap-1.5" style="gap: 0.4rem;">
                                                <c:forEach items="${scanResult.missingKeywords}" var="kw">
                                                    <span class="ios-badge ios-badge-red" style="font-size: 0.8rem; padding: 0.3rem 0.65rem;">
                                                        + <c:out value="${kw}" />
                                                    </span>
                                                </c:forEach>
                                            </div>
                                            <small class="text-muted d-block mt-2 font-weight-semibold" style="font-size: 0.8rem;">
                                                💡 Tip: Adding these keywords naturally to your projects or skills section will directly boost your ATS compatibility score.
                                            </small>
                                        </div>
                                    </c:if>
                                </div>
                            </div>

                            <!-- Recommendations Card -->
                            <div class="ios-card mb-4">
                                <div class="ios-card-header" style="padding: 1.1rem 1.5rem;">
                                    <h3 class="h6 font-weight-bold text-dark mb-0">Smart Actionable Recommendations</h3>
                                </div>
                                <div class="ios-card-body p-4">
                                    <ul class="list-unstyled mb-0">
                                        <c:forEach items="${scanResult.improvementTips}" var="tip">
                                            <li class="d-flex align-items-start mb-2.5" style="gap: 0.65rem;">
                                                <div class="d-flex align-items-center justify-content-center flex-shrink-0 mt-0.5" style="width: 20px; height: 20px; border-radius: 50%; background: rgba(0, 113, 227, 0.1); color: var(--ios-blue);">
                                                    <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3"><polyline points="9 18 15 12 9 6"></polyline></svg>
                                                </div>
                                                <span class="small font-weight-semibold" style="color: #334155; line-height: 1.5;"><c:out value="${tip}" /></span>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </div>
                        </c:when>
                    </c:choose>
                </div>
            </div>
        </main>
    </div>
</div>

<script>
(function() {
    var loadBtn = document.getElementById('loadProfileTextBtn');
    var resumeArea = document.getElementById('resumeText');
    var wordLabel = document.getElementById('wordCountLabel');
    var charLabel = document.getElementById('charCountLabel');

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

    if (loadBtn && resumeArea) {
        loadBtn.addEventListener('click', function() {
            var profileText = "${student.fullName}\n" +
                              "Email: ${student.email}\n" +
                              "Department: ${student.department}\n" +
                              "CGPA: ${student.formattedCgpa}\n\n" +
                              "EDUCATION\n" +
                              "Bachelor of Technology in ${student.department} - Batch ${student.graduationYear}\n\n" +
                              "TECHNICAL SKILLS\n" +
                              "<c:forEach items='${profile.skills}' var='sk'>${sk.skillName}, </c:forEach>\n\n" +
                              "PROJECTS\n" +
                              "<c:forEach items='${profile.projects}' var='p'>${p.title} | ${p.techStack}\n${p.description}\n\n</c:forEach>" +
                              "PROBLEM SOLVING\n" +
                              "Data Structures & Algorithms - Solved ${profile.totalDsaProblemsSolved} problems\n\n" +
                              "CERTIFICATIONS\n" +
                              "<c:forEach items='${profile.certifications}' var='c'>${c.title} - ${c.issuingOrg}\n</c:forEach>";
            resumeArea.value = profileText;
            updateCounts();
            if (typeof showToast === 'function') {
                showToast("✓ Loaded resume text from your SkillTrack profile!");
            }
        });
    }
})();
</script>

<%@ include file="/WEB-INF/views/common/footer.jspf" %>
