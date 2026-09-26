<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Industry Certifications" />
<c:set var="activeNav" value="certifications" />
<%@ include file="/WEB-INF/views/common/header.jspf" %>
<%@ include file="/WEB-INF/views/common/navbar.jspf" %>

<style>
    .cert-page-wrapper {
        max-width: 1440px;
        margin: 0 auto;
    }

    /* Page Header Card */
    .cert-header-card {
        background: rgba(255, 255, 255, 0.85);
        backdrop-filter: blur(12px);
        -webkit-backdrop-filter: blur(12px);
        border: 1px solid rgba(226, 232, 240, 0.8);
        border-radius: 16px;
        padding: 1.25rem 1.5rem;
        box-shadow: 0 4px 20px -2px rgba(0, 0, 0, 0.03);
        margin-bottom: 1.25rem;
    }

    /* AI Auto-Fetch Banner Card */
    .cert-autofetch-card {
        background: linear-gradient(135deg, rgba(255, 255, 255, 0.98), rgba(248, 250, 252, 0.95));
        border: 1px solid rgba(226, 232, 240, 0.9);
        border-radius: 16px;
        padding: 1.5rem;
        box-shadow: 0 4px 20px -2px rgba(0, 0, 0, 0.04);
        margin-bottom: 1.5rem;
    }

    .cert-icon-emerald {
        width: 46px;
        height: 46px;
        border-radius: 14px;
        background: linear-gradient(135deg, #10b981, #059669);
        color: #ffffff;
        box-shadow: 0 8px 16px -4px rgba(16, 185, 129, 0.35);
        display: flex;
        align-items: center;
        justify-content: center;
        flex-shrink: 0;
    }

    .autofetch-input-container {
        background: rgba(241, 245, 249, 0.85);
        border: 1px solid rgba(226, 232, 240, 0.95);
        border-radius: 14px;
        padding: 1rem 1.25rem;
    }

    /* Form & List Cards */
    .cert-card {
        background: #ffffff;
        border: 1px solid rgba(226, 232, 240, 0.85);
        border-radius: 16px;
        box-shadow: 0 4px 20px -2px rgba(0, 0, 0, 0.04);
        overflow: hidden;
    }

    .cert-card-header {
        padding: 1.25rem 1.5rem;
        border-bottom: 1px solid rgba(241, 245, 249, 0.9);
        display: flex;
        align-items: center;
        justify-content: space-between;
    }

    .cert-card-body {
        padding: 1.5rem;
    }

    /* Form Elements */
    .cert-form-label {
        font-size: 0.82rem;
        font-weight: 700;
        color: #1e293b;
        margin-bottom: 0.4rem;
        display: flex;
        align-items: center;
        gap: 6px;
    }

    .cert-form-input {
        width: 100%;
        border: 1px solid #cbd5e1;
        border-radius: 10px;
        padding: 0.65rem 1rem;
        font-size: 0.9rem;
        color: #1e293b;
        background: #ffffff;
        transition: all 0.2s ease;
    }

    .cert-form-input:focus {
        outline: none;
        border-color: #10b981;
        box-shadow: 0 0 0 3px rgba(16, 185, 129, 0.15);
    }

    /* Certificate Item Card */
    .cert-item-card {
        background: #ffffff;
        border: 1px solid rgba(226, 232, 240, 0.9);
        border-radius: 14px;
        padding: 1.25rem 1.5rem;
        margin-bottom: 1rem;
        transition: transform 0.2s ease, box-shadow 0.2s ease;
        position: relative;
    }

    .cert-item-card:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 24px -4px rgba(0, 0, 0, 0.06);
        border-color: rgba(16, 185, 129, 0.4);
    }

    .cert-badge-pill {
        display: inline-flex;
        align-items: center;
        gap: 5px;
        padding: 4px 10px;
        border-radius: 8px;
        font-size: 0.75rem;
        font-weight: 600;
        line-height: 1.2;
    }

    .badge-org {
        background: rgba(0, 113, 227, 0.08);
        color: #0071e3;
        border: 1px solid rgba(0, 113, 227, 0.15);
    }

    .badge-date {
        background: #f1f5f9;
        color: #475569;
        border: 1px solid #e2e8f0;
    }

    /* Empty State Illustration */
    .cert-empty-box {
        padding: 3rem 1.5rem;
        text-align: center;
        background: #ffffff;
        border: 1.5px dashed #cbd5e1;
        border-radius: 16px;
    }

    .quick-chip-btn {
        background: #f8fafc;
        border: 1px solid #e2e8f0;
        color: #334155;
        border-radius: 20px;
        padding: 4px 12px;
        font-size: 0.78rem;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.15s ease;
        display: inline-flex;
        align-items: center;
        gap: 5px;
    }

    .quick-chip-btn:hover {
        background: #10b981;
        color: #ffffff;
        border-color: #10b981;
        transform: translateY(-1px);
    }
</style>

<div class="container-fluid py-4">
    <div class="cert-page-wrapper">
        <%@ include file="/WEB-INF/views/common/alerts.jspf" %>

        <!-- 1. Page Header Card -->
        <div class="cert-header-card">
            <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3">
                <div>
                    <div class="d-flex align-items-center gap-2 mb-1 flex-wrap">
                        <span class="ios-badge ios-badge-green">
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><circle cx="12" cy="8" r="7"></circle><polyline points="8.21 13.89 7 23 12 20 17 23 15.79 13.88"></polyline></svg>
                            Accreditation Bank
                        </span>
                        <span class="ios-badge ios-badge-blue">
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path></svg>
                            Verified Proof-of-Skill
                        </span>
                    </div>
                    <h1 class="h3 font-weight-bold text-gray-900 mb-0" style="letter-spacing: -0.03em;">
                        Industry Certifications &amp; Credentials
                    </h1>
                    <p class="text-muted small mb-0 mt-1">
                        Record recognized cloud, development, and engineering credentials to enhance recruitment verification.
                    </p>
                </div>
                
                <div class="d-flex align-items-center gap-2">
                    <span class="ios-badge <c:choose><c:when test='${certifications.size() >= 2}'>ios-badge-green</c:when><c:otherwise>ios-badge-blue</c:otherwise></c:choose>" style="font-size: 0.85rem; padding: 0.5rem 1.15rem;">
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg>
                        Benchmark: 2 Credentials (${certifications.size()}/2)
                    </span>
                </div>
            </div>
        </div>

        <!-- 2. Universal AI Auto-Fetch Engine Card -->
        <div class="cert-autofetch-card">
            <div class="d-flex flex-column flex-xl-row align-items-xl-center justify-content-between gap-4">
                
                <!-- Left Details -->
                <div class="d-flex align-items-start gap-3">
                    <div class="cert-icon-emerald">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.3"><circle cx="12" cy="8" r="7"></circle><polyline points="8.21 13.89 7 23 12 20 17 23 15.79 13.88"></polyline></svg>
                    </div>
                    <div>
                        <div class="d-flex align-items-center flex-wrap gap-2 mb-1">
                            <h2 class="h5 font-weight-bold text-dark mb-0" style="font-size: 1.12rem; letter-spacing: -0.02em;">
                                Live Certificate &amp; Credential Auto-Fetch Engine
                            </h2>
                            <span class="badge badge-success px-2.5 py-1" style="border-radius: 999px; font-weight: 600; font-size: 0.72rem; background: #10b981;">
                                ⚡ Universal AI Web Extractor
                            </span>
                        </div>
                        <p class="text-muted small mb-0" style="max-width: 680px; line-height: 1.5;">
                            Paste any <strong>Certificate URL</strong> or <strong>Credential ID</strong> from <strong>ANY platform, university, MOOC, or portal</strong> (Coursera, Credly, LinkedIn, AWS, Google, HackerRank, NPTEL). Metadata will be auto-verified and recorded.
                        </p>
                    </div>
                </div>

                <!-- Right Auto-Fetch Form -->
                <div class="autofetch-input-container flex-shrink-0" style="min-width: 320px; max-width: 480px; width: 100%;">
                    <form action="${pageContext.request.contextPath}/app/student/certifications" method="POST" onsubmit="return handleAutoFetchSubmit(this);">
                        <input type="hidden" name="csrfToken" value="${sessionScope.CSRF_TOKEN}">
                        <input type="hidden" name="action" value="auto-fetch">
                        
                        <label for="certInput" class="small font-weight-bold text-dark mb-1.5 d-flex justify-content-between align-items-center">
                            <span>🔗 Certificate Link / Verification ID:</span>
                            <span class="badge badge-success px-1.5 py-0.5" style="font-size: 0.68rem; background: #059669;">Universal</span>
                        </label>
                        
                        <div class="input-group input-group-sm mb-2">
                            <input type="text" id="certInput" name="certInput" class="form-control" placeholder="Paste Credly badge, Coursera link, or cert ID..." required style="font-size: 0.84rem; border-radius: 8px 0 0 8px; border-color: #cbd5e1;">
                            <div class="input-group-append">
                                <button type="submit" id="autoFetchBtn" class="btn btn-success font-weight-bold px-3 d-flex align-items-center" style="font-size: 0.82rem; border-radius: 0 8px 8px 0; background: linear-gradient(135deg, #10b981, #059669); border: none;">
                                    <span id="autoFetchSpinner" class="spinner-border spinner-border-sm d-none mr-1" role="status" aria-hidden="true"></span>
                                    <span id="autoFetchText">⚡ Fetch &amp; Add</span>
                                </button>
                            </div>
                        </div>

                        <div class="d-flex align-items-center justify-content-between flex-wrap gap-2">
                            <select name="platform" class="custom-select custom-select-sm" style="font-size: 0.75rem; height: 26px; padding-top: 2px; padding-bottom: 2px; width: 190px; border-radius: 6px; border-color: #cbd5e1;">
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

        <!-- 3. Dual-Column Grid: Form (Left) & Verified List (Right) -->
        <div class="row">
            
            <!-- Left Column: Manual Form -->
            <div class="col-lg-5 mb-4">
                <div class="cert-card h-100">
                    <div class="cert-card-header">
                        <div>
                            <h2 class="h5 font-weight-bold text-dark mb-0" style="font-size: 1.15rem; letter-spacing: -0.02em;">
                                <c:out value="${not empty editCert ? 'Edit Certification' : 'Add Certification'}" />
                            </h2>
                            <small class="text-muted">
                                <c:out value="${not empty editCert ? 'Update credential issuer & verification link' : 'Record official technology certification'}" />
                            </small>
                        </div>
                        <c:if test="${not empty editCert}">
                            <span class="ios-badge ios-badge-orange">Editing ID: ${editCert.certId}</span>
                        </c:if>
                    </div>

                    <div class="cert-card-body">
                        <form id="certForm" action="${pageContext.request.contextPath}/app/student/certifications" method="post" class="needs-validation" novalidate>
                            <input type="hidden" name="csrfToken" value="${sessionScope.CSRF_TOKEN}" />
                            <input type="hidden" name="certId" value="<c:out value='${editCert.certId}' default='0' />" />

                            <div class="form-group mb-3">
                                <label for="title" class="cert-form-label">
                                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" class="text-primary"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path><polyline points="14 2 14 8 20 8"></polyline></svg>
                                    Certification Title *
                                </label>
                                <input type="text" class="cert-form-input" id="title" name="title" value="<c:out value='${editCert.title}' />" required placeholder="e.g. AWS Certified Solutions Architect - Associate">
                                <div class="invalid-feedback small mt-1">Certification title is required.</div>
                            </div>

                            <div class="form-group mb-3">
                                <label for="issuingOrg" class="cert-form-label">
                                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" class="text-primary"><circle cx="12" cy="12" r="10"></circle><polygon points="12 6 12 12 16 14"></polygon></svg>
                                    Issuing Organization / Platform *
                                </label>
                                <input type="text" class="cert-form-input" id="issuingOrg" name="issuingOrg" value="<c:out value='${editCert.issuingOrg}' />" required placeholder="e.g. Amazon Web Services, Oracle, Google Cloud, Coursera">
                                <div class="invalid-feedback small mt-1">Issuing organization is required.</div>
                            </div>

                            <div class="form-group mb-3">
                                <label for="issueDate" class="cert-form-label">
                                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" class="text-primary"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg>
                                    Issue / Completion Date *
                                </label>
                                <input type="date" class="cert-form-input" id="issueDate" name="issueDate" value="<c:out value='${editCert.issueDate}' />" required>
                                <div class="invalid-feedback small mt-1">Valid issue date is required.</div>
                            </div>

                            <div class="form-group mb-4">
                                <label for="credentialUrl" class="cert-form-label">
                                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" class="text-primary"><path d="M10 13a5 5 0 0 0 7.54.54l3-3a5 5 0 0 0-7.07-7.07l-1.72 1.71"></path><path d="M14 11a5 5 0 0 0-7.54-.54l-3 3a5 5 0 0 0 7.07 7.07l1.71-1.71"></path></svg>
                                    Credential Verification Link (Credly / Badge URL)
                                </label>
                                <input type="url" class="cert-form-input" id="credentialUrl" name="credentialUrl" value="<c:out value='${editCert.credentialUrl}' />" placeholder="https://www.credly.com/badges/...">
                                <small class="text-muted mt-1 d-block" style="font-size: 0.76rem;">Public verification link for recruiters and placement audits</small>
                            </div>

                            <div class="d-flex justify-content-between align-items-center pt-3 border-top">
                                <c:choose>
                                    <c:when test="${not empty editCert}">
                                        <a href="${pageContext.request.contextPath}/app/student/certifications" class="ios-btn-secondary" style="padding: 0.6rem 1.25rem; font-size: 0.875rem;">Cancel</a>
                                        <button type="submit" class="ios-btn-primary" style="padding: 0.6rem 1.5rem; font-size: 0.875rem; background: linear-gradient(135deg, #10b981, #059669);">
                                            <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="20 6 9 17 4 12"></polyline></svg>
                                            Update Credential
                                        </button>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="d-flex justify-content-end w-100">
                                            <button type="submit" class="ios-btn-primary" style="padding: 0.65rem 1.75rem; font-size: 0.875rem; background: linear-gradient(135deg, #0071e3, #2563eb);">
                                                <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><line x1="12" y1="5" x2="12" y2="19"></line><line x1="5" y1="12" x2="19" y2="12"></line></svg>
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

            <!-- Right Column: Verified Credentials List -->
            <div class="col-lg-7 mb-4">
                <div class="cert-card h-100">
                    <div class="cert-card-header">
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

                    <div class="cert-card-body" style="background: rgba(248, 250, 252, 0.5);">
                        <c:choose>
                            <c:when test="${empty certifications}">
                                <!-- Elevated Empty State -->
                                <div class="cert-empty-box">
                                    <div class="d-inline-flex align-items-center justify-content-center p-3 mb-3" style="width: 64px; height: 64px; border-radius: 50%; background: rgba(16, 185, 129, 0.1); color: #10b981;">
                                        <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="8" r="7"></circle><polyline points="8.21 13.89 7 23 12 20 17 23 15.79 13.88"></polyline></svg>
                                    </div>
                                    <h3 class="h5 font-weight-bold text-gray-900 mb-1">No certifications recorded yet</h3>
                                    <p class="text-muted small mb-4" style="max-width: 440px; margin: 0 auto; line-height: 1.5;">
                                        Add recognized AWS, Oracle, Google Cloud, or Coursera certifications to boost your candidate placement readiness score.
                                    </p>

                                    <!-- Quick Starter Suggestions -->
                                    <div class="pt-3 border-top">
                                        <span class="small font-weight-bold text-muted d-block mb-2">⚡ Quick Add Suggestions:</span>
                                        <div class="d-flex flex-wrap justify-content-center gap-2">
                                            <button type="button" class="quick-chip-btn" onclick="prefillCert('AWS Certified Cloud Practitioner', 'Amazon Web Services')">
                                                ☁️ AWS Practitioner
                                            </button>
                                            <button type="button" class="quick-chip-btn" onclick="prefillCert('Oracle Certified Professional: Java SE', 'Oracle')">
                                                ☕ Java SE Certified
                                            </button>
                                            <button type="button" class="quick-chip-btn" onclick="prefillCert('Google Cloud Associate Cloud Engineer', 'Google Cloud')">
                                                🔷 GCP Associate
                                            </button>
                                            <button type="button" class="quick-chip-btn" onclick="prefillCert('Meta Front-End Developer Specialization', 'Coursera / Meta')">
                                                🎓 Meta Front-End
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </c:when>

                            <c:otherwise>
                                <!-- Populated Certification Cards -->
                                <c:forEach items="${certifications}" var="c">
                                    <div class="cert-item-card">
                                        <div class="d-flex justify-content-between align-items-start mb-2">
                                            <div class="d-flex align-items-start gap-3">
                                                <div class="cert-icon-emerald" style="width: 40px; height: 40px; border-radius: 12px; margin-top: 2px;">
                                                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.3"><circle cx="12" cy="8" r="7"></circle><polyline points="8.21 13.89 7 23 12 20 17 23 15.79 13.88"></polyline></svg>
                                                </div>
                                                <div>
                                                    <h3 class="h6 font-weight-bold text-dark mb-1.5" style="font-size: 1.05rem; line-height: 1.35;">
                                                        <c:out value="${c.title}" />
                                                    </h3>
                                                    <div class="d-flex flex-wrap align-items-center gap-2">
                                                        <span class="cert-badge-pill badge-org">
                                                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><polygon points="12 6 12 12 16 14"></polygon></svg>
                                                            <c:out value="${c.issuingOrg}" />
                                                        </span>
                                                        <span class="cert-badge-pill badge-date">
                                                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg>
                                                            Issued: <strong class="text-dark ml-1"><c:out value="${c.formattedIssueDate}" /></strong>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="d-flex align-items-center gap-1.5">
                                                <a href="${pageContext.request.contextPath}/app/student/certifications?editId=${c.certId}" class="btn btn-sm btn-outline-secondary d-inline-flex align-items-center" style="border-radius: 8px; padding: 0.3rem 0.75rem; font-size: 0.8rem; font-weight: 600;" title="Edit Certification">
                                                    <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" class="mr-1"><path d="M12 20h9"></path><path d="M16.5 3.5a2.121 2.121 0 0 1 3 3L7 19l-4 1 1-4L16.5 3.5z"></path></svg>
                                                    Edit
                                                </a>
                                                <form action="${pageContext.request.contextPath}/app/student/certifications" method="post" class="d-inline">
                                                    <input type="hidden" name="csrfToken" value="${sessionScope.CSRF_TOKEN}" />
                                                    <input type="hidden" name="action" value="delete" />
                                                    <input type="hidden" name="certId" value="${c.certId}" />
                                                    <button type="submit" class="btn btn-sm btn-outline-danger confirm-delete d-inline-flex align-items-center" style="border-radius: 8px; padding: 0.3rem 0.75rem; font-size: 0.8rem; font-weight: 600;" data-confirm="Delete certification '${c.title}'?">
                                                        <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="mr-1">
                                                            <polyline points="3 6 5 6 21 6"></polyline>
                                                            <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
                                                        </svg>
                                                        Delete
                                                    </button>
                                                </form>
                                            </div>
                                        </div>

                                        <c:if test="${not empty c.credentialUrl}">
                                            <div class="pt-2.5 mt-2.5 border-top d-flex align-items-center justify-content-between flex-wrap gap-2">
                                                <a href="<c:out value='${c.credentialUrl}' />" target="_blank" rel="noopener noreferrer" class="ios-btn-secondary" style="padding: 0.35rem 0.85rem; font-size: 0.78rem; text-decoration: none; border-radius: 8px;">
                                                    <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="mr-1"><path d="M18 13v6a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h6"></path><polyline points="15 3 21 3 21 9"></polyline><line x1="10" y1="14" x2="21" y2="3"></line></svg>
                                                    Verify Online Badge ↗
                                                </a>
                                                <span class="ios-badge ios-badge-green" style="font-size: 0.72rem;">
                                                    <svg width="10" height="10" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3"><polyline points="20 6 9 17 4 12"></polyline></svg>
                                                    Verified Record
                                                </span>
                                            </div>
                                        </c:if>
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

        </div>

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

function prefillCert(title, org) {
    var titleInput = document.getElementById('title');
    var orgInput = document.getElementById('issuingOrg');
    if (titleInput) titleInput.value = title;
    if (orgInput) orgInput.value = org;
    if (titleInput) titleInput.focus();
}
</script>

<%@ include file="/WEB-INF/views/common/footer.jspf" %>
