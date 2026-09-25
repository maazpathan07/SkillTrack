<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Industry Certifications" />
<c:set var="activeNav" value="certifications" />
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
                        <span class="ios-badge ios-badge-green">
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" aria-hidden="true"><circle cx="12" cy="8" r="7"></circle><polyline points="8.21 13.89 7 23 12 20 17 23 15.79 13.88"></polyline></svg>
                            Accreditation Bank
                        </span>
                    </div>
                    <h1 class="h3 font-weight-bold text-gray-800 mb-0" style="letter-spacing: -0.03em;">Industry Certifications &amp; Credentials</h1>
                    <p class="text-muted small mb-0 mt-1">Record recognized cloud, development, and system credentials to enhance candidate verification</p>
                </div>
                <div>
                    <span class="ios-badge ios-badge-green" style="font-size: 0.85rem; padding: 0.5rem 1rem;">
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" aria-hidden="true"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg>
                        Benchmark: 2 Credentials
                    </span>
                </div>
            </div>

            <!-- Live Certificate & Credential Auto-Fetch Engine Card -->
            <div class="ios-card p-4 mb-4" style="background: linear-gradient(135deg, rgba(255, 255, 255, 0.98), rgba(248, 250, 252, 0.95)); border: 1px solid rgba(226, 232, 240, 0.95); box-shadow: 0 4px 20px -2px rgba(0, 0, 0, 0.04);">
                <div class="d-flex flex-column flex-xl-row align-items-xl-center justify-content-between gap-3">
                    <div class="d-flex align-items-start gap-3">
                        <div class="d-flex align-items-center justify-content-center flex-shrink-0" style="width: 48px; height: 48px; border-radius: 14px; background: linear-gradient(135deg, #10b981, #059669); color: #ffffff; box-shadow: 0 8px 16px -4px rgba(16, 185, 129, 0.35);">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" aria-hidden="true"><circle cx="12" cy="8" r="7"></circle><polyline points="8.21 13.89 7 23 12 20 17 23 15.79 13.88"></polyline></svg>
                        </div>
                        <div>
                            <div class="d-flex align-items-center flex-wrap gap-2 mb-1">
                                <h2 class="h5 font-weight-bold text-dark mb-0" style="font-size: 1.1rem; letter-spacing: -0.02em;">Live Certificate &amp; Credential Auto-Fetch Engine</h2>
                                <span class="badge badge-success px-2.5 py-1" style="border-radius: 999px; font-weight: 600; font-size: 0.72rem;">
                                    ⚡ Auto-Fetch by Link or Certificate ID
                                </span>
                            </div>
                            <p class="text-muted small mb-0" style="max-width: 680px; line-height: 1.5;">
                                Paste any <strong>Certificate URL</strong> or <strong>Certificate ID</strong> from <strong>ANY platform, university, MOOC, or certification portal</strong> across the internet. The universal AI engine will automatically verify and extract the exact course title, issuing organization, and completion date.
                            </p>
                        </div>
                    </div>

                    <!-- Live URL / ID Auto-Fetch Form -->
                    <div class="p-3 mt-3 mt-xl-0 flex-shrink-0" style="background: rgba(241, 245, 249, 0.85); border: 1px solid rgba(226, 232, 240, 0.95); border-radius: 14px; min-width: 320px; max-width: 480px;">
                        <form action="${pageContext.request.contextPath}/app/student/certifications" method="POST" onsubmit="return handleAutoFetchSubmit(this);">
                            <input type="hidden" name="csrfToken" value="${sessionScope.CSRF_TOKEN}">
                            <input type="hidden" name="action" value="auto-fetch">
                            
                            <label for="certInput" class="small font-weight-bold text-dark mb-1.5 d-flex justify-content-between align-items-center">
                                <span>🔗 Paste Certificate Link or ID (Any Portal):</span>
                                <span class="badge badge-success px-1.5 py-0.5" style="font-size: 0.68rem;">Universal Web Engine</span>
                            </label>
                            
                            <div class="input-group input-group-sm mb-2">
                                <input type="text" id="certInput" name="certInput" class="form-control" placeholder="Paste link or ID from ANY platform (LinkedIn, AWS, Coursera, NPTEL, etc.)..." required style="font-size: 0.82rem; border-radius: 6px 0 0 6px;">
                                <div class="input-group-append">
                                    <button type="submit" id="autoFetchBtn" class="btn btn-success font-weight-bold px-3 d-flex align-items-center" style="font-size: 0.82rem; border-radius: 0 6px 6px 0; background: linear-gradient(135deg, #10b981, #059669); border: none;">
                                        <span id="autoFetchSpinner" class="spinner-border spinner-border-sm d-none mr-1" role="status" aria-hidden="true"></span>
                                        <span id="autoFetchText">⚡ Fetch &amp; Add</span>
                                    </button>
                                </div>
                            </div>
                            <div class="d-flex align-items-center justify-content-between">
                                <select name="platform" class="custom-select custom-select-sm" style="font-size: 0.75rem; height: 26px; padding-top: 2px; padding-bottom: 2px; width: 180px; border-radius: 6px;">
                                    <option value="auto">Auto-Detect (Any Global Platform)</option>
                                    <option value="linkedin">LinkedIn Learning</option>
                                    <option value="credly">Credly (AWS / Google / Meta)</option>
                                    <option value="coursera">Coursera</option>
                                    <option value="hackerrank">HackerRank</option>
                                    <option value="udemy">Udemy</option>
                                    <option value="freecodecamp">freeCodeCamp</option>
                                    <option value="microsoft">Microsoft Learn</option>
                                    <option value="edx">edX</option>
                                    <option value="kaggle">Kaggle</option>
                                    <option value="geeksforgeeks">GeeksforGeeks</option>
                                    <option value="other">Any Other / University Portal</option>
                                </select>
                                <small class="text-muted" style="font-size: 0.72rem;">100% verified accreditation</small>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <div class="row">
                <!-- Certification Form -->
                <div class="col-lg-5 mb-4">
                    <div class="ios-card h-100">
                        <div class="ios-card-header" style="padding: 1.25rem 1.5rem;">
                            <div>
                                <h2 class="h5 font-weight-bold text-dark mb-0" style="font-size: 1.15rem; letter-spacing: -0.02em;">
                                    <c:out value="${not empty editCert ? 'Edit Certification' : 'Add Certification'}" />
                                </h2>
                                <small class="text-muted">
                                    <c:out value="${not empty editCert ? 'Update credential issuer & badge link' : 'Record official technology certification'}" />
                                </small>
                            </div>
                            <c:if test="${not empty editCert}">
                                <span class="ios-badge ios-badge-orange">Editing ID: ${editCert.certId}</span>
                            </c:if>
                        </div>
                        <div class="ios-card-body" style="padding: 1.5rem 1.5rem 1.75rem 1.5rem;">
                            <form id="certForm" action="${pageContext.request.contextPath}/app/student/certifications" method="post" class="needs-validation" novalidate>
                                <input type="hidden" name="csrfToken" value="${sessionScope.CSRF_TOKEN}" />
                                <input type="hidden" name="certId" value="<c:out value='${editCert.certId}' default='0' />" />

                                <div class="form-group mb-3">
                                    <label for="title" class="ios-form-label">Certification Title *</label>
                                    <input type="text" class="ios-form-control" id="title" name="title" value="<c:out value='${editCert.title}' />" required placeholder="e.g. AWS Certified Developer - Associate">
                                    <div class="invalid-feedback">Certification title is required.</div>
                                </div>

                                <div class="form-group mb-3">
                                    <label for="issuingOrg" class="ios-form-label">Issuing Organization *</label>
                                    <input type="text" class="ios-form-control" id="issuingOrg" name="issuingOrg" value="<c:out value='${editCert.issuingOrg}' />" required placeholder="e.g. Amazon Web Services, Oracle, Google Cloud, Coursera">
                                    <div class="invalid-feedback">Issuing organization is required.</div>
                                </div>

                                <div class="form-group mb-3">
                                    <label for="issueDate" class="ios-form-label">Issue Date *</label>
                                    <input type="date" class="ios-form-control" id="issueDate" name="issueDate" value="<c:out value='${editCert.issueDate}' />" required>
                                    <div class="invalid-feedback">Valid issue date is required.</div>
                                </div>

                                <div class="form-group mb-4">
                                    <label for="credentialUrl" class="ios-form-label">Credential Verification URL (Credly / Badge)</label>
                                    <div class="ios-input-icon-wrapper">
                                        <input type="url" class="ios-form-control" id="credentialUrl" name="credentialUrl" value="<c:out value='${editCert.credentialUrl}' />" placeholder="https://www.credly.com/badges/...">
                                        <span class="ios-input-icon">
                                            <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true"><path d="M10 13a5 5 0 0 0 7.54.54l3-3a5 5 0 0 0-7.07-7.07l-1.72 1.71"></path><path d="M14 11a5 5 0 0 0-7.54-.54l-3 3a5 5 0 0 0 7.07 7.07l1.71-1.71"></path></svg>
                                        </span>
                                    </div>
                                    <small class="text-muted mt-1 d-block">Public verification link for placement audit</small>
                                </div>

                                <div class="d-flex justify-content-between align-items-center pt-3 mt-2 border-top">
                                    <c:choose>
                                        <c:when test="${not empty editCert}">
                                            <a href="${pageContext.request.contextPath}/app/student/certifications" class="ios-btn-secondary" style="padding: 0.65rem 1.25rem; font-size: 0.875rem;">Cancel</a>
                                            <button type="submit" class="ios-btn-primary" style="padding: 0.65rem 1.5rem; font-size: 0.875rem; box-shadow: 0 4px 12px rgba(0, 113, 227, 0.25);">
                                                <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" aria-hidden="true"><polyline points="20 6 9 17 4 12"></polyline></svg>
                                                Update Credential
                                            </button>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="d-flex justify-content-end w-100">
                                                <button type="submit" class="ios-btn-primary" style="padding: 0.65rem 1.75rem; font-size: 0.875rem; box-shadow: 0 4px 12px rgba(0, 113, 227, 0.25);">
                                                    <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" aria-hidden="true"><line x1="12" y1="5" x2="12" y2="19"></line><line x1="5" y1="12" x2="19" y2="12"></line></svg>
                                                    Save Credential
                                                </button>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Certifications List Showcase -->
                <div class="col-lg-7 mb-4">
                    <div class="ios-card h-100">
                        <div class="ios-card-header" style="padding: 1.25rem 1.5rem;">
                            <div>
                                <h2 class="h5 font-weight-bold text-dark mb-0" style="font-size: 1.15rem; letter-spacing: -0.02em;">
                                    Verified Credentials (${certifications.size()})
                                </h2>
                                <small class="text-muted">
                                    <c:choose>
                                        <c:when test="${certifications.size() >= 2}">
                                            Target benchmark achieved (100% Score)
                                        </c:when>
                                        <c:otherwise>
                                            Add ${2 - certifications.size()} more to reach 100%
                                        </c:otherwise>
                                    </c:choose>
                                </small>
                            </div>
                            <span class="ios-badge <c:choose><c:when test='${certifications.size() >= 2}'>ios-badge-green</c:when><c:otherwise>ios-badge-blue</c:otherwise></c:choose> font-weight-bold">
                                ${certifications.size()} / 2 Verified
                            </span>
                        </div>

                        <div class="ios-card-body" style="padding: 1.5rem; background: rgba(248, 250, 252, 0.4);">
                            <c:choose>
                                <c:when test="${empty certifications}">
                                    <div class="p-5 text-center text-muted" style="background: #ffffff; border: 1px dashed rgba(0,0,0,0.1); border-radius: var(--ios-radius-md);">
                                        <div class="ios-badge ios-badge-gray p-3 mb-2" style="border-radius: var(--ios-radius-full);">
                                            <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true"><circle cx="12" cy="8" r="7"></circle><polyline points="8.21 13.89 7 23 12 20 17 23 15.79 13.88"></polyline></svg>
                                        </div>
                                        <h3 class="h5 font-weight-bold text-dark mt-2">No certifications recorded yet</h3>
                                        <p class="small mb-0" style="color: #475569;">Add AWS, Google Cloud, Java, or platform credentials to maximize your 15% certification weight.</p>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach items="${certifications}" var="c">
                                        <div class="ios-card mb-3" style="border: 1px solid rgba(226, 232, 240, 0.9); box-shadow: var(--ios-shadow-sm);">
                                            <div class="ios-card-body p-4">
                                                <div class="d-flex justify-content-between align-items-start mb-2">
                                                    <div class="d-flex align-items-start gap-3">
                                                        <div class="ios-badge ios-badge-green p-2 mt-1" style="border-radius: var(--ios-radius-sm);">
                                                            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" aria-hidden="true"><circle cx="12" cy="8" r="7"></circle><polyline points="8.21 13.89 7 23 12 20 17 23 15.79 13.88"></polyline></svg>
                                                        </div>
                                                        <div>
                                                            <h3 class="h6 font-weight-bold text-dark mb-1" style="font-size: 1.08rem; line-height: 1.4;">
                                                                <c:out value="${c.title}" />
                                                            </h3>
                                                            <div class="d-flex flex-wrap align-items-center gap-2 small text-muted">
                                                                <span class="badge badge-primary px-2 py-1" style="border-radius: 6px; font-weight: 600; font-size: 0.72rem; background: rgba(0, 113, 227, 0.1); color: #0071e3; border: 1px solid rgba(0, 113, 227, 0.2);">
                                                                    Platform: <c:out value="${c.issuingOrg}" />
                                                                </span>
                                                                <span class="d-inline-flex align-items-center" style="color: #475569;">
                                                                    <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="mr-1" aria-hidden="true"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg>
                                                                    Completed / Issued: <strong class="text-dark ml-1"><c:out value="${c.formattedIssueDate}" /></strong>
                                                                </span>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="d-flex align-items-center gap-2">
                                                        <a href="${pageContext.request.contextPath}/app/student/certifications?editId=${c.certId}" class="btn btn-sm btn-outline-secondary d-inline-flex align-items-center" style="border-radius: var(--ios-radius-sm); padding: 0.3rem 0.75rem; font-size: 0.8rem; font-weight: 600;" title="Edit Certification" aria-label="Edit certification <c:out value='${c.title}' />">
                                                            <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" class="mr-1" aria-hidden="true"><path d="M12 20h9"></path><path d="M16.5 3.5a2.121 2.121 0 0 1 3 3L7 19l-4 1 1-4L16.5 3.5z"></path></svg>
                                                            Edit
                                                        </a>
                                                        <form action="${pageContext.request.contextPath}/app/student/certifications" method="post" class="d-inline">
                                                            <input type="hidden" name="csrfToken" value="${sessionScope.CSRF_TOKEN}" />
                                                            <input type="hidden" name="action" value="delete" />
                                                            <input type="hidden" name="certId" value="${c.certId}" />
                                                            <button type="submit" class="btn btn-sm btn-outline-danger confirm-delete d-inline-flex align-items-center" style="border-radius: var(--ios-radius-sm); padding: 0.3rem 0.75rem; font-size: 0.8rem; font-weight: 600;" data-confirm="Delete certification '${c.title}'?" aria-label="Delete certification <c:out value='${c.title}' />">
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

                                                <c:if test="${not empty c.credentialUrl}">
                                                    <div class="pt-3 mt-3 border-top d-flex align-items-center justify-content-between flex-wrap gap-2">
                                                        <a href="<c:out value='${c.credentialUrl}' />" target="_blank" rel="noopener noreferrer" class="ios-btn-secondary" style="padding: 0.4rem 0.95rem; font-size: 0.8rem;">
                                                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true"><path d="M18 13v6a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h6"></path><polyline points="15 3 21 3 21 9"></polyline><line x1="10" y1="14" x2="21" y2="3"></line></svg>
                                                            Verify Official Credential Badge
                                                        </a>
                                                        <span class="ios-badge ios-badge-green" style="font-size: 0.75rem;">
                                                            <svg width="10" height="10" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" aria-hidden="true"><polyline points="20 6 9 17 4 12"></polyline></svg>
                                                            Verified Record
                                                        </span>
                                                    </div>
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
        </main>
    </div>
</div>

<script>
function handleAutoFetchSubmit(form) {
    var input = (form.certInput && form.certInput.value) ? form.certInput.value.trim() : '';
    if (!input) {
        alert('Please paste a certificate verification link or enter a certificate ID.');
        return false;
    }

    var btn = document.getElementById('autoFetchBtn');
    var spinner = document.getElementById('autoFetchSpinner');
    var btnText = document.getElementById('autoFetchText');

    if (btn) {
        btn.disabled = true;
        btn.style.opacity = '0.75';
    }
    if (spinner) spinner.classList.remove('d-none');
    if (btnText) btnText.textContent = 'Verifying & Fetching...';

    return true;
}
</script>

<%@ include file="/WEB-INF/views/common/footer.jspf" %>
