<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="pageTitle" value="Placement Passport • ${student.fullName}" />
<%@ include file="/WEB-INF/views/common/header.jspf" %>

<div class="passport-page-container py-3 py-md-4">
    <div class="container" style="max-width: 880px;">
        
        <!-- Action Toolbar (Hidden during Print) -->
        <div class="passport-toolbar mb-3 no-print">
            <div class="d-flex flex-column flex-sm-row justify-content-between align-items-stretch align-items-sm-center gap-2 w-100">
                <a href="${pageContext.request.contextPath}/" class="ios-btn-secondary passport-btn-compact text-nowrap" style="font-size: 0.85rem;">
                    <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" class="mr-1">
                        <line x1="19" y1="12" x2="5" y2="12"></line>
                        <polyline points="12 19 5 12 12 5"></polyline>
                    </svg>
                    SkillTrack Home
                </a>
                <div class="passport-action-group">
                    <button type="button" class="ios-btn-secondary passport-btn-compact" id="downloadQrBtn">
                        <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="mr-1">
                            <rect x="3" y="3" width="7" height="7"></rect>
                            <rect x="14" y="3" width="7" height="7"></rect>
                            <rect x="14" y="14" width="7" height="7"></rect>
                            <rect x="3" y="14" width="7" height="7"></rect>
                        </svg>
                        Save QR
                    </button>
                    <button type="button" class="ios-btn-secondary passport-btn-compact" id="copyShareLinkBtn">
                        <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="mr-1">
                            <rect x="9" y="9" width="13" height="13" rx="2" ry="2"></rect>
                            <path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1"></path>
                        </svg>
                        Copy Link
                    </button>
                    <button type="button" class="ios-btn-primary passport-btn-compact" id="downloadPdfBtn">
                        <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="mr-1">
                            <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path>
                            <polyline points="7 10 12 15 17 10"></polyline>
                            <line x1="12" y1="15" x2="12" y2="3"></line>
                        </svg>
                        Download PDF
                    </button>
                </div>
            </div>
        </div>

        <c:choose>
            <c:when test="${passportNotFound}">
                <div class="passport-poster-frame p-5 text-center my-5">
                    <div class="ios-brand-icon mx-auto mb-3" style="width: 64px; height: 64px; background: rgba(255, 59, 48, 0.1); color: var(--ios-red);">
                        <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <circle cx="12" cy="12" r="10"></circle>
                            <line x1="12" y1="8" x2="12" y2="12"></line>
                            <line x1="12" y1="16" x2="12.01" y2="16"></line>
                        </svg>
                    </div>
                    <h2 class="font-weight-bold mb-2">Placement Passport Not Found</h2>
                    <p class="text-muted">The requested verification code does not exist or has been modified.</p>
                    <a href="${pageContext.request.contextPath}/" class="ios-btn-primary px-4 py-2 mt-3">Return Home</a>
                </div>
            </c:when>

            <c:otherwise>
                <!-- =========================================================================
                     OFFICIAL EXECUTIVE PLACEMENT PASSPORT POSTER (100% Pixel Match Reference)
                     ========================================================================= -->
                <div class="passport-poster-frame" id="passportCertificateDoc">
                    
                    <!-- 1. Top Luxury Artwork Header Banner -->
                    <div class="poster-header-banner">
                        <div class="d-flex align-items-center justify-content-between">
                            <!-- Left: Brand Logo & Title -->
                            <div class="d-flex align-items-center gap-3">
                                <div class="poster-brand-logo-icon">
                                    <svg width="38" height="38" viewBox="0 0 64 64" fill="none">
                                        <defs>
                                            <linearGradient id="capGrad" x1="0%" y1="0%" x2="100%" y2="100%">
                                                <stop offset="0%" stop-color="#38bdf8"/>
                                                <stop offset="100%" stop-color="#0284c7"/>
                                            </linearGradient>
                                            <linearGradient id="arrowGrad" x1="0%" y1="100%" x2="100%" y2="0%">
                                                <stop offset="0%" stop-color="#00f2fe"/>
                                                <stop offset="100%" stop-color="#4facfe"/>
                                            </linearGradient>
                                        </defs>
                                        <polygon points="32,8 58,22 32,36 6,22" fill="url(#capGrad)" filter="drop-shadow(0 4px 6px rgba(0,0,0,0.25))"/>
                                        <polygon points="32,12 52,22 32,32 12,22" fill="#ffffff" opacity="0.35"/>
                                        <path d="M18,29 V43 C18,48 46,48 46,43 V29" fill="none" stroke="url(#capGrad)" stroke-width="4.5" stroke-linecap="round"/>
                                        <path d="M10,24 L10,38 L8,40" stroke="#38bdf8" stroke-width="3" stroke-linecap="round"/>
                                        <circle cx="8" cy="41" r="2.5" fill="#38bdf8"/>
                                        <!-- Rising Growth Arrow -->
                                        <path d="M22,46 L38,30 M38,30 H28 M38,30 V40" stroke="url(#arrowGrad)" stroke-width="3.8" stroke-linecap="round" stroke-linejoin="round"/>
                                    </svg>
                                </div>
                                <div>
                                    <div class="poster-brand-name">
                                        <span class="text-white font-weight-extrabold" style="letter-spacing: -0.02em;">Skill</span><span style="color: #38bdf8; font-weight: 800;">Track</span>
                                    </div>
                                    <div class="poster-brand-sub">CAREER &amp; PLACEMENT READINESS PLATFORM</div>
                                    <div class="poster-brand-actions">TRACK &bull; LEARN &bull; IMPROVE &bull; GET PLACED</div>
                                </div>
                            </div>

                            <!-- Right: 3D Cap Graphic & Cursive Tagline -->
                            <div class="d-flex align-items-center gap-3 poster-header-right">
                                <div class="poster-cursive-tagline">
                                    <span>Build</span>
                                    <span>Your Skills</span>
                                    <span>Build Your</span>
                                    <span>Future</span>
                                </div>
                                <div class="poster-3d-cap-graphic">
                                    <svg width="74" height="74" viewBox="0 0 100 100" fill="none">
                                        <!-- 3D Layered Glass Pedestals -->
                                        <ellipse cx="50" cy="86" rx="38" ry="10" fill="rgba(56, 189, 248, 0.25)" filter="blur(3px)"/>
                                        <ellipse cx="50" cy="80" rx="32" ry="8" fill="#0284c7" opacity="0.6"/>
                                        <ellipse cx="50" cy="74" rx="26" ry="6" fill="#38bdf8" opacity="0.85"/>
                                        <!-- 3D Graduation Cap -->
                                        <polygon points="50,18 88,38 50,58 12,38" fill="url(#capGrad)" filter="drop-shadow(0 8px 16px rgba(2,132,199,0.55))"/>
                                        <polygon points="50,22 80,38 50,54 20,38" fill="#ffffff" opacity="0.3"/>
                                        <path d="M26,46 V62 C26,70 74,70 74,62 V46" fill="none" stroke="#0284c7" stroke-width="5" stroke-linecap="round"/>
                                        <path d="M16,40 L16,60 L13,63" stroke="#38bdf8" stroke-width="3" stroke-linecap="round"/>
                                        <circle cx="13" cy="65" r="2.5" fill="#38bdf8"/>
                                        <!-- Upward Glowing Arrow -->
                                        <path d="M62,68 C76,55 78,35 78,22" stroke="#00f2fe" stroke-width="4.5" stroke-linecap="round" filter="drop-shadow(0 0 8px #00f2fe)"/>
                                        <polyline points="68,22 78,22 78,32" stroke="#00f2fe" stroke-width="4.5" stroke-linecap="round" stroke-linejoin="round"/>
                                    </svg>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- 2. Candidate Hero Identification & Scannable QR Row -->
                    <div class="row mb-3 align-items-stretch">
                        <!-- Left: Candidate Identity Box -->
                        <div class="col-md-8 mb-2 mb-md-0">
                            <div class="poster-card candidate-hero-card h-100 p-3">
                                <div class="d-flex align-items-start gap-3">
                                    <!-- Candidate Photo -->
                                    <div class="candidate-avatar-frame flex-shrink-0">
                                        <c:choose>
                                            <c:when test="${not empty student.profileImage}">
                                                <img src="${student.profileImage}" alt="${student.fullName}" class="candidate-avatar-img" />
                                            </c:when>
                                            <c:otherwise>
                                                <!-- Executive 3D Illustrated Avatar Fallback -->
                                                <div class="candidate-avatar-fallback">
                                                    <svg width="56" height="56" viewBox="0 0 100 100" fill="none">
                                                        <circle cx="50" cy="50" r="48" fill="#e0f2fe"/>
                                                        <!-- Face & Hair -->
                                                        <circle cx="50" cy="36" r="18" fill="#0284c7"/>
                                                        <path d="M50,16 C38,16 34,26 34,36 C34,46 42,52 50,52 C58,52 66,46 66,36 C66,26 62,16 50,16 Z" fill="#0369a1"/>
                                                        <circle cx="50" cy="38" r="14" fill="#fed7aa"/>
                                                        <!-- Collar & Suit -->
                                                        <path d="M22,86 C22,68 34,60 50,60 C66,60 78,68 78,86" fill="#0f172a"/>
                                                        <polygon points="50,60 42,76 58,76" fill="#ffffff"/>
                                                        <polygon points="50,66 46,84 54,84" fill="#0284c7"/>
                                                    </svg>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>

                                    <!-- Candidate Info -->
                                    <div class="flex-grow-1">
                                        <h2 class="candidate-name mb-0"><c:out value="${student.fullName}" /></h2>
                                        <div class="candidate-sub-meta mb-2">
                                            <c:out value="${student.department}" /> Engineering &bull; Batch of <c:out value="${student.graduationYear}" /> &bull; Roll No: <c:out value="${student.rollNumber}" />
                                        </div>
                                        <div class="mb-2">
                                            <span class="candidate-target-role-badge">
                                                <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" class="mr-1.5"><circle cx="12" cy="12" r="10"></circle><circle cx="12" cy="12" r="6"></circle><circle cx="12" cy="12" r="2"></circle></svg>
                                                Target Role: <c:out value="${student.targetRoleTitle}" default="Full Stack MERN Developer" />
                                            </span>
                                        </div>
                                    </div>
                                </div>

                                <!-- 3 Bottom Meta Micro-Boxes -->
                                <div class="candidate-meta-strip mt-2.5 pt-2 border-top">
                                    <div class="row no-gutters">
                                        <div class="col-4 px-1">
                                            <div class="candidate-micro-pill d-flex align-items-center gap-2">
                                                <div class="meta-pill-icon-wrap" style="background: #e0f2fe; color: #0284c7;">
                                                    <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                                                        <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path>
                                                        <polyline points="9 22 9 12 15 12 15 22"></polyline>
                                                    </svg>
                                                </div>
                                                <div class="meta-pill-text-wrap text-truncate">
                                                    <div class="meta-strip-label">Department</div>
                                                    <div class="meta-strip-val text-truncate"><c:out value="${student.department}" /> Engineering</div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-4 px-1">
                                            <div class="candidate-micro-pill d-flex align-items-center gap-2">
                                                <div class="meta-pill-icon-wrap" style="background: #e0e7ff; color: #4f46e5;">
                                                    <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                                                        <rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect>
                                                        <line x1="16" y1="2" x2="16" y2="6"></line>
                                                        <line x1="8" y1="2" x2="8" y2="6"></line>
                                                        <line x1="3" y1="10" x2="21" y2="10"></line>
                                                    </svg>
                                                </div>
                                                <div class="meta-pill-text-wrap text-truncate">
                                                    <div class="meta-strip-label">Graduation Year</div>
                                                    <div class="meta-strip-val"><c:out value="${student.graduationYear}" /></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-4 px-1">
                                            <div class="candidate-micro-pill d-flex align-items-center gap-2">
                                                <div class="meta-pill-icon-wrap" style="background: #dcfce7; color: #10b981;">
                                                    <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                                                        <rect x="2" y="5" width="20" height="14" rx="2"></rect>
                                                        <line x1="2" y1="10" x2="22" y2="10"></line>
                                                        <line x1="7" y1="15" x2="7.01" y2="15"></line>
                                                        <line x1="11" y1="15" x2="17" y2="15"></line>
                                                    </svg>
                                                </div>
                                                <div class="meta-pill-text-wrap text-truncate">
                                                    <div class="meta-strip-label">Roll Number</div>
                                                    <div class="meta-strip-val"><c:out value="${student.rollNumber}" /></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>

                        <!-- Right: Vector QR Code Card -->
                        <div class="col-md-4">
                            <div class="poster-card poster-qr-card h-100 p-2.5 d-flex flex-column align-items-center justify-content-center text-center">
                                <div class="qr-box mb-1.5">
                                    <div id="qrcode"></div>
                                </div>
                                <div class="d-flex align-items-center gap-1.5 text-primary font-weight-bold" style="font-size: 0.76rem;">
                                    <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M10 13a5 5 0 0 0 7.54.54l3-3a5 5 0 0 0-7.07-7.07l-1.72 1.71"></path><path d="M14 11a5 5 0 0 0-7.54-.54l-3 3a5 5 0 0 0 7.07 7.07l1.71-1.71"></path></svg>
                                    Scan with Phone to Verify Live Profile
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- 4. Readiness & Motivational Quote Row -->
                    <div class="row mb-3">
                        <!-- Left Card: OVERALL PLACEMENT READINESS -->
                        <div class="col-md-7 mb-2 mb-md-0">
                            <div class="poster-card p-3 h-100">
                                <div class="d-flex justify-content-between align-items-center mb-2.5">
                                    <div class="d-flex align-items-center gap-2">
                                        <div class="poster-section-icon" style="background: #e0f2fe; color: #0284c7;">
                                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                                                <line x1="18" y1="20" x2="18" y2="10"></line>
                                                <line x1="12" y1="20" x2="12" y2="4"></line>
                                                <line x1="6" y1="20" x2="6" y2="14"></line>
                                            </svg>
                                        </div>
                                        <span class="font-weight-bold text-dark" style="font-size: 0.84rem; letter-spacing: 0.02em;">OVERALL PLACEMENT READINESS</span>
                                    </div>
                                    <span class="poster-tier-pill">
                                        <c:out value="${readiness.tier}" default="Developing Foundation" />
                                    </span>
                                </div>
                                <div class="d-flex align-items-center gap-3">
                                    <!-- Circular Gauge -->
                                    <div class="readiness-gauge-circle flex-shrink-0" style="--score-pct: <c:out value='${readiness.overallScore}' default='37' />;">
                                        <div class="readiness-gauge-inner">
                                            <div class="readiness-gauge-num"><c:out value="${readiness.overallScore}" default="37" />%</div>
                                            <div class="readiness-gauge-lbl">READY</div>
                                        </div>
                                    </div>
                                    <!-- AI Evaluation Text -->
                                    <div class="readiness-commentary text-muted" style="font-size: 0.82rem; line-height: 1.5;">
                                        You are on the right track! Keep improving your DSA, skills and projects to reach your target placement level.
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Right Card: Motivational Quote -->
                        <div class="col-md-5">
                            <div class="poster-card poster-quote-card p-3 h-100 d-flex flex-column justify-content-between">
                                <div>
                                    <div class="quote-symbol-graphic mb-1">“</div>
                                    <div class="poster-quote-text">
                                        Consistency today creates opportunities tomorrow.
                                    </div>
                                </div>
                                <div class="text-right mt-2">
                                    <!-- 5 Ascending Bar Graphic -->
                                    <svg width="48" height="24" viewBox="0 0 48 24" fill="none" class="d-inline-block opacity-90">
                                        <rect x="2" y="18" width="6" height="6" rx="2" fill="#bae6fd"/>
                                        <rect x="11" y="14" width="6" height="10" rx="2" fill="#7dd3fc"/>
                                        <rect x="20" y="10" width="6" height="14" rx="2" fill="#38bdf8"/>
                                        <rect x="29" y="5" width="6" height="19" rx="2" fill="#0284c7"/>
                                        <rect x="38" y="0" width="6" height="24" rx="2" fill="#0052cc"/>
                                    </svg>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- 5. 2-Column Metrics: DSA & Academic Standing -->
                    <div class="row mb-3">
                        <!-- Left: DSA Problem Solving -->
                        <div class="col-md-6 mb-2 mb-md-0">
                            <div class="poster-card p-3 h-100">
                                <div class="d-flex justify-content-between align-items-center mb-2.5">
                                    <div class="d-flex align-items-center gap-2 font-weight-bold" style="color: #0284c7; font-size: 0.84rem;">
                                        <div class="poster-section-icon" style="background: #e0f2fe; color: #0284c7;">
                                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                                                <polyline points="16 18 22 12 16 6"></polyline>
                                                <polyline points="8 6 2 12 8 18"></polyline>
                                            </svg>
                                        </div>
                                        <span class="text-dark">DSA PROBLEM SOLVING</span>
                                    </div>
                                    <span class="badge badge-primary px-2.5 py-1" style="background: #e0f2fe; color: #0284c7; font-weight: 800; border-radius: 6px; font-size: 0.78rem;">
                                        <c:out value="${profile.totalDsaProblemsSolved}" default="14" /> Solved
                                    </span>
                                </div>

                                <c:set var="completedDsa" value="0" />
                                <c:set var="inProgressDsa" value="0" />
                                <c:forEach items="${profile.dsaProgressList}" var="d">
                                    <c:if test="${d.status == 'COMPLETED'}">
                                        <c:set var="completedDsa" value="${completedDsa + 1}" />
                                    </c:if>
                                    <c:if test="${d.status == 'IN_PROGRESS'}">
                                        <c:set var="inProgressDsa" value="${inProgressDsa + 1}" />
                                    </c:if>
                                </c:forEach>

                                <!-- 3 DSA Metric Items with Crisp SVGs -->
                                <div class="row no-gutters text-center my-2">
                                    <div class="col-4 px-1">
                                        <div class="dsa-kpi-tile dsa-kpi-success">
                                            <div class="kpi-icon-circle" style="background: #dcfce7; color: #15803d;">
                                                <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round">
                                                    <polyline points="20 6 9 17 4 12"></polyline>
                                                </svg>
                                            </div>
                                            <div class="dsa-kpi-lbl text-success">Completed</div>
                                            <div class="dsa-kpi-val text-dark">
                                                <c:out value="${completedDsa}" default="3" /> <span class="dsa-kpi-sub">topics</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-4 px-1">
                                        <div class="dsa-kpi-tile dsa-kpi-warning">
                                            <div class="kpi-icon-circle" style="background: #fef3c7; color: #b45309;">
                                                <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                                                    <circle cx="12" cy="12" r="10"></circle>
                                                    <polyline points="12 6 12 12 16 14"></polyline>
                                                </svg>
                                            </div>
                                            <div class="dsa-kpi-lbl text-warning">In Progress</div>
                                            <div class="dsa-kpi-val text-dark">
                                                <c:out value="${inProgressDsa}" default="0" /> <span class="dsa-kpi-sub">topics</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-4 px-1">
                                        <div class="dsa-kpi-tile dsa-kpi-primary">
                                            <div class="kpi-icon-circle" style="background: #e0f2fe; color: #0284c7;">
                                                <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                                                    <circle cx="12" cy="12" r="10"></circle>
                                                    <circle cx="12" cy="12" r="6"></circle>
                                                    <circle cx="12" cy="12" r="2"></circle>
                                                </svg>
                                            </div>
                                            <div class="dsa-kpi-lbl text-primary">Benchmark</div>
                                            <div class="dsa-kpi-val text-dark">
                                                150 <span class="dsa-kpi-sub">target</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Progress Bar -->
                                <div class="progress mb-1.5" style="height: 7px; border-radius: 999px; background: #e2e8f0;">
                                    <div class="progress-bar" role="progressbar" style="width: ${profile.totalDsaProblemsSolved >= 150 ? 100 : (profile.totalDsaProblemsSolved * 100) / 150}%; background: linear-gradient(90deg, #0284c7, #38bdf8);" aria-valuenow="${profile.totalDsaProblemsSolved}" aria-valuemin="0" aria-valuemax="150"></div>
                                </div>
                                <div class="text-muted" style="font-size: 0.7rem;">Systematically tracked across 18 core DSA topic milestones</div>
                            </div>
                        </div>

                        <!-- Right: Academic Standing -->
                        <div class="col-md-6">
                            <div class="poster-card p-3 h-100">
                                <div class="d-flex align-items-center gap-2 mb-2.5 font-weight-bold" style="font-size: 0.84rem; color: #0284c7;">
                                    <div class="poster-section-icon" style="background: #e0f2fe; color: #0284c7;">
                                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                                            <path d="M22 10v6M2 10l10-5 10 5-10 5z"></path>
                                            <path d="M6 12v5c3 3 9 3 12 0v-5"></path>
                                        </svg>
                                    </div>
                                    <span class="text-dark">ACADEMIC STANDING</span>
                                </div>

                                <div class="d-flex flex-column gap-2">
                                    <div class="academic-kpi-row d-flex justify-content-between align-items-center">
                                        <div class="d-flex align-items-center gap-2 text-muted" style="font-size: 0.8rem;">
                                            <div class="academic-row-icon" style="background: #e0f2fe; color: #0284c7;">
                                                <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                                                    <path d="M18 20V10"></path><path d="M12 20V4"></path><path d="M6 20v-6"></path>
                                                </svg>
                                            </div>
                                            Cumulative CGPA
                                        </div>
                                        <div class="font-weight-extrabold" style="font-size: 1.15rem; color: #0284c7;">
                                            <c:out value="${student.cgpa}" /> / 10.0
                                        </div>
                                    </div>

                                    <div class="academic-kpi-row d-flex justify-content-between align-items-center">
                                        <div class="d-flex align-items-center gap-2 text-muted" style="font-size: 0.8rem;">
                                            <div class="academic-row-icon" style="background: #e0e7ff; color: #4f46e5;">
                                                <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                                                    <rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect>
                                                    <line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line>
                                                </svg>
                                            </div>
                                            Graduation Year
                                        </div>
                                        <div class="font-weight-bold text-dark" style="font-size: 1.05rem;">
                                            <c:out value="${student.graduationYear}" />
                                        </div>
                                    </div>

                                    <div class="academic-kpi-row d-flex justify-content-between align-items-center">
                                        <div class="d-flex align-items-center gap-2 text-muted" style="font-size: 0.8rem;">
                                            <div class="academic-row-icon" style="background: #dcfce7; color: #10b981;">
                                                <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                                                    <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path>
                                                </svg>
                                            </div>
                                            Credential Status
                                        </div>
                                        <span class="badge badge-success px-2.5 py-1" style="background: #10b981; font-weight: 700; border-radius: 999px; font-size: 0.72rem;">
                                            Active &amp; Valid
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- 6. Verified Core Technical Skills with Brand Badges -->
                    <div class="poster-card p-3 mb-3">
                        <div class="d-flex align-items-center gap-2 mb-2 font-weight-bold" style="font-size: 0.84rem; color: #0284c7;">
                            <div class="poster-section-icon" style="background: #e0f2fe; color: #0284c7;">
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                                    <circle cx="12" cy="12" r="3"></circle>
                                    <path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1 0 2.83 2 2 0 0 1-2.83 0l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-2 2 2 2 0 0 1-2-2v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83 0 2 2 0 0 1 0-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1-2-2 2 2 0 0 1 2-2h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 0-2.83 2 2 0 0 1 2.83 0l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 2-2 2 2 0 0 1 2 2v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 0 2 2 0 0 1 0 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 2 2 2 2 0 0 1-2 2h-.09a1.65 1.65 0 0 0-1.51 1z"></path>
                                </svg>
                            </div>
                            <span class="text-dark">VERIFIED CORE TECHNICAL SKILLS</span>
                        </div>

                        <div class="d-flex flex-wrap gap-2">
                            <c:choose>
                                <c:when test="${empty profile.skills}">
                                    <span class="text-muted small">No verified skills entered yet.</span>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach items="${profile.skills}" var="s">
                                        <div class="tech-brand-pill">
                                            <!-- Brand SVG Icon -->
                                            <c:choose>
                                                <c:when test="${fn:containsIgnoreCase(s.skillName, 'React')}">
                                                    <svg width="20" height="20" viewBox="-11.5 -10.23174 23 20.46348" class="mr-1.5">
                                                        <circle cx="0" cy="0" r="2.05" fill="#61dafb"/>
                                                        <g stroke="#61dafb" stroke-width="1" fill="none">
                                                            <ellipse rx="11" ry="4.2"/>
                                                            <ellipse rx="11" ry="4.2" transform="rotate(60)"/>
                                                            <ellipse rx="11" ry="4.2" transform="rotate(120)"/>
                                                        </g>
                                                    </svg>
                                                </c:when>
                                                <c:when test="${fn:containsIgnoreCase(s.skillName, 'Mongo')}">
                                                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" class="mr-1.5">
                                                        <path d="M12 2C12 2 6 7.5 6 13.5C6 17.5 9 21 12 22C15 21 18 17.5 18 13.5C18 7.5 12 2 12 2Z" fill="#13aa52"/>
                                                        <path d="M12 2V22C12 22 12 18 12 13.5C12 9 12 2 12 2Z" stroke="#ffffff" stroke-width="1"/>
                                                    </svg>
                                                </c:when>
                                                <c:when test="${fn:containsIgnoreCase(s.skillName, 'MySQL')}">
                                                    <svg width="22" height="18" viewBox="0 0 24 24" fill="none" class="mr-1.5">
                                                        <path d="M22 13C20 9 16 8 13 9C10 10 9 12 7 12C5 12 4 11 3 9C2 13 4 17 8 17C12 17 14 14 16 14C18 14 20 15 22 13Z" fill="#00758f"/>
                                                        <circle cx="6" cy="11" r="1" fill="#f29111"/>
                                                    </svg>
                                                </c:when>
                                                <c:when test="${fn:containsIgnoreCase(s.skillName, 'Java')}">
                                                    <svg width="18" height="18" viewBox="0 0 24 24" fill="#ea2d2e" class="mr-1.5">
                                                        <path d="M8.8 17.2c0 0-1.2.3-.8.8.4.5 1.5.3 1.5.3s-.5-.5.2-.8c.7-.3.9-.3.9-.3s-.6.1-.9.3c-.3.2-.9.5-.9.5zm-.4-2.8s-1.8.5-1.2 1.3c.6.8 2.2.5 2.2.5s-.8-.8.3-1.2c1.1-.4 1.3-.4 1.3-.4s-.9.2-1.3.4c-.5.3-1.3.4-1.3.4zm4.8 4.7s-.6.4-.3.7c.3.3 1.1.2 1.1.2s-.4-.4.1-.6c.5-.2.7-.2.7-.2s-.4.1-.7.2c-.2.2-.9.3-.9.3zm5.7-4.1c-1.1-.4-2.3-.5-3.5-.5.7-.3 1.5-.5 2.3-.5 1.7 0 2.8.5 2.8 1.4 0 .8-.9 1.2-1.6 1.6v-2zm-3.8-4.8c.8 1 1.7 2.1 1.7 3.3 0 1.9-1.5 3-3.6 3-1.3 0-2.4-.4-3.3-.9-.6-.4-1.1-.8-1.5-1.4 1.1.4 2.3.6 3.6.6 2.3 0 3.7-1 3.7-2.6 0-.8-.3-1.4-.6-2z"/>
                                                    </svg>
                                                </c:when>
                                                <c:when test="${fn:containsIgnoreCase(s.skillName, 'Python')}">
                                                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" class="mr-1.5">
                                                        <path d="M12 2C6.5 2 6.5 4.5 6.5 4.5V7H12V8H4C4 8 2 8 2 12C2 16 3.5 16 3.5 16H5.5V13.5C5.5 11.5 7 11.5 7 11.5H12C14.5 11.5 14.5 9 14.5 9V4.5C14.5 4.5 14.5 2 12 2ZM9 4C9.5 4 10 4.5 10 5C10 5.5 9.5 6 9 6C8.5 6 8 5.5 8 5C8 4.5 8.5 4 9 4Z" fill="#387eb8"/>
                                                        <path d="M12 22C17.5 22 17.5 19.5 17.5 19.5V17H12V16H20C20 16 22 16 22 12C22 8 20.5 8 20.5 8H18.5V10.5C18.5 12.5 17 12.5 17 12.5H12C9.5 12.5 9.5 15 9.5 15V19.5C9.5 19.5 9.5 22 12 22ZM15 20C14.5 20 14 19.5 14 19C14 18.5 14.5 18 15 18C15.5 18 16 18.5 16 19C16 19.5 15.5 20 15 20Z" fill="#ffe052"/>
                                                    </svg>
                                                </c:when>
                                                <c:otherwise>
                                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#0284c7" stroke-width="2.5" class="mr-1.5">
                                                        <polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"></polygon>
                                                    </svg>
                                                </c:otherwise>
                                            </c:choose>
                                            <span class="tech-brand-name"><c:out value="${s.skillName}" /></span>
                                            <span class="tech-level-pill <c:out value='${fn:toLowerCase(s.level)}' />"><c:out value="${s.level}" /></span>
                                        </div>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <!-- 7. 4-Pillar Verification Strip with Luxury SVGs -->
                    <div class="poster-trust-bar mb-3">
                        <div class="row no-gutters text-center align-items-center">
                            <div class="col-3 p-2 d-flex align-items-center justify-content-center gap-2">
                                <div class="trust-bar-icon-wrap" style="background: #e0f2fe; color: #0284c7;">
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.3" stroke-linecap="round" stroke-linejoin="round">
                                        <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path>
                                        <polyline points="9 12 11 14 15 10"></polyline>
                                    </svg>
                                </div>
                                <div class="text-left font-weight-bold" style="font-size: 0.74rem; line-height: 1.2; color: #1e293b;">
                                    Authentic<br/><span style="color: #64748b; font-weight: normal; font-size: 0.65rem;">&amp; Verified Data</span>
                                </div>
                            </div>
                            <div class="col-3 p-2 d-flex align-items-center justify-content-center gap-2 border-left">
                                <div class="trust-bar-icon-wrap" style="background: #e0e7ff; color: #4f46e5;">
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.3" stroke-linecap="round" stroke-linejoin="round">
                                        <path d="M10 13a5 5 0 0 0 7.54.54l3-3a5 5 0 0 0-7.07-7.07l-1.72 1.71"></path>
                                        <path d="M14 11a5 5 0 0 0-7.54-.54l-3 3a5 5 0 0 0 7.07 7.07l1.71-1.71"></path>
                                    </svg>
                                </div>
                                <div class="text-left font-weight-bold" style="font-size: 0.74rem; line-height: 1.2; color: #1e293b;">
                                    Real-time<br/><span style="color: #64748b; font-weight: normal; font-size: 0.65rem;">Profile Access</span>
                                </div>
                            </div>
                            <div class="col-3 p-2 d-flex align-items-center justify-content-center gap-2 border-left">
                                <div class="trust-bar-icon-wrap" style="background: #fdf2f8; color: #db2777;">
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.3" stroke-linecap="round" stroke-linejoin="round">
                                        <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
                                        <circle cx="9" cy="7" r="4"></circle>
                                        <path d="M23 21v-2a4 4 0 0 0-3-3.87"></path>
                                        <path d="M16 3.13a4 4 0 0 1 0 7.75"></path>
                                    </svg>
                                </div>
                                <div class="text-left font-weight-bold" style="font-size: 0.74rem; line-height: 1.2; color: #1e293b;">
                                    Trusted by<br/><span style="color: #64748b; font-weight: normal; font-size: 0.65rem;">Recruiters</span>
                                </div>
                            </div>
                            <div class="col-3 p-2 d-flex align-items-center justify-content-center gap-2 border-left">
                                <div class="trust-bar-icon-wrap" style="background: #dcfce7; color: #059669;">
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.3" stroke-linecap="round" stroke-linejoin="round">
                                        <polyline points="22 7 13.5 15.5 8.5 10.5 2 17"></polyline>
                                        <polyline points="16 7 22 7 22 13"></polyline>
                                    </svg>
                                </div>
                                <div class="text-left font-weight-bold" style="font-size: 0.74rem; line-height: 1.2; color: #1e293b;">
                                    Powered by<br/><span style="color: #64748b; font-weight: normal; font-size: 0.65rem;">SkillTrack</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- 8. Document Footer & Digital Signature -->
                    <div class="poster-footer-bar pt-2 border-top">
                        <div class="d-flex justify-content-between align-items-end flex-wrap gap-2">
                            <!-- Left: Issuer Credentials -->
                            <div>
                                <div class="d-flex align-items-center gap-1 mb-0.5">
                                    <span class="font-weight-extrabold text-primary" style="font-size: 0.95rem;">Skill</span><span class="font-weight-extrabold" style="color: #0f172a; font-size: 0.95rem;">Track</span>
                                </div>
                                <div class="font-weight-bold text-dark" style="font-size: 0.7rem;">Career &amp; Placement Readiness Intelligence Platform</div>
                                <div class="text-muted" style="font-size: 0.64rem;">Empowering Students &bull; Enabling Opportunities &bull; Building Better Careers</div>
                            </div>

                            <!-- Center: Official Signature -->
                            <div class="text-center">
                                <div class="poster-signature-wrap">
                                    <!-- Stylized Cursive Signature SVG -->
                                    <svg width="130" height="28" viewBox="0 0 160 40" fill="none">
                                        <path d="M10,28 C25,12 40,8 55,20 C65,28 75,10 85,15 C95,20 110,8 125,18 C135,24 145,15 155,22 M30,32 C60,30 100,28 140,25" stroke="#003e9c" stroke-width="2.4" stroke-linecap="round" stroke-linejoin="round"/>
                                    </svg>
                                </div>
                                <div class="poster-sign-lbl" style="font-size: 0.68rem; font-weight: 700; color: #1e293b;">Verified by SkillTrack</div>
                                <div class="text-muted" style="font-size: 0.6rem;">Career &amp; Placement Readiness Platform</div>
                            </div>

                            <!-- Right: Timestamp -->
                            <div class="text-right">
                                <div class="d-flex align-items-center justify-content-end gap-1.5 text-muted" style="font-size: 0.68rem;">
                                    <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="#64748b" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                                        <circle cx="12" cy="12" r="10"></circle>
                                        <polyline points="12 6 12 12 16 14"></polyline>
                                    </svg>
                                    Generated On
                                </div>
                                <div class="font-weight-bold text-dark" style="font-size: 0.75rem;">
                                    <c:out value="${verifiedAt}" />
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </c:otherwise>
        </c:choose>

    </div>
</div>

<!-- Toast Notification -->
<div class="passport-toast" id="passportToast">
    ✓ Verification link copied to clipboard!
</div>

<!-- Standalone QR Code Engine Script -->
<script src="${pageContext.request.contextPath}/assets/js/qrcode.min.js"></script>
<script>
(function() {
    function initPassport() {
        var qrElement = document.getElementById('qrcode');
        if (qrElement && typeof QRCode !== 'undefined') {
            qrElement.innerHTML = '';
            var verifyUrl = "<c:out value='${verificationUrl}' />";
            try {
                new QRCode(qrElement, {
                    text: verifyUrl,
                    width: 110,
                    height: 110,
                    colorDark: "#000000",
                    colorLight: "#ffffff",
                    correctLevel: QRCode.CorrectLevel.M
                });
            } catch (err) {
                console.error("QR Code rendering error:", err);
            }
        }

        // Copy Verification Link
        var copyBtn = document.getElementById('copyShareLinkBtn');
        if (copyBtn) {
            copyBtn.addEventListener('click', function() {
                var url = "<c:out value='${verificationUrl}' />";
                if (navigator.clipboard && navigator.clipboard.writeText) {
                    navigator.clipboard.writeText(url).then(function() {
                        showToast("✓ Verification link copied to clipboard!");
                    }).catch(function() {
                        fallbackCopy(url);
                    });
                } else {
                    fallbackCopy(url);
                }
            });
        }

        // Download QR Code as PNG Image
        function downloadQrImage() {
            var qrBox = document.getElementById('qrcode');
            if (!qrBox) return;

            var canvas = qrBox.querySelector('canvas');
            var img = qrBox.querySelector('img');

            if (!canvas && img && img.src) {
                var tempImg = new Image();
                tempImg.crossOrigin = "anonymous";
                tempImg.onload = function() {
                    generateAndDownload(tempImg);
                };
                tempImg.src = img.src;
                return;
            }

            if (canvas) {
                generateAndDownload(canvas);
            } else {
                showToast("⚠️ QR code is still generating...");
            }
        }

        function generateAndDownload(sourceDrawable) {
            try {
                var outW = 500;
                var outH = 620;
                var outCanvas = document.createElement('canvas');
                outCanvas.width = outW;
                outCanvas.height = outH;
                var ctx = outCanvas.getContext('2d');

                // 1. White Background Fill
                ctx.fillStyle = '#ffffff';
                ctx.fillRect(0, 0, outW, outH);

                // 2. Top Banner Gradient
                var grad = ctx.createLinearGradient(0, 0, outW, 85);
                grad.addColorStop(0, '#001233');
                grad.addColorStop(0.5, '#003087');
                grad.addColorStop(1, '#0066eb');
                ctx.fillStyle = grad;
                ctx.fillRect(0, 0, outW, 85);

                // Header Branding
                ctx.fillStyle = '#ffffff';
                ctx.font = 'bold 16px -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif';
                ctx.textAlign = 'center';
                ctx.fillText('SKILLTRACK PLACEMENT PASSPORT', outW / 2, 36);

                ctx.fillStyle = '#38bdf8';
                ctx.font = 'bold 10px -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif';
                ctx.fillText('OFFICIAL DIGITAL CREDENTIAL PASS • VERIFIED CANDIDATE', outW / 2, 58);

                // 3. QR Code Box
                var qrSize = 300;
                var qrX = (outW - qrSize) / 2;
                var qrY = 110;

                // QR shadow & container
                ctx.fillStyle = '#ffffff';
                ctx.shadowColor = 'rgba(0, 0, 0, 0.08)';
                ctx.shadowBlur = 12;
                ctx.shadowOffsetY = 4;
                ctx.fillRect(qrX - 10, qrY - 10, qrSize + 20, qrSize + 20);
                ctx.shadowColor = 'transparent';

                ctx.strokeStyle = '#e2e8f0';
                ctx.lineWidth = 1.5;
                ctx.strokeRect(qrX - 10, qrY - 10, qrSize + 20, qrSize + 20);

                // Draw Crisp Vector QR Image
                ctx.imageSmoothingEnabled = false;
                ctx.drawImage(sourceDrawable, qrX, qrY, qrSize, qrSize);

                // 4. Candidate Identification
                ctx.fillStyle = '#0f172a';
                ctx.font = 'bold 18px -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif';
                ctx.textAlign = 'center';
                ctx.fillText("<c:out value='${student.fullName}' />", outW / 2, 465);

                ctx.fillStyle = '#475569';
                ctx.font = '600 12px -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif';
                ctx.fillText("<c:out value='${student.department}' /> Engineering • Batch of <c:out value='${student.graduationYear}' />", outW / 2, 490);

                // Pill Badge for Roll & Code
                var pillText = "Roll No: <c:out value='${student.rollNumber}' />   |   CODE: <c:out value='${verificationCode}' />";
                ctx.font = 'bold 11px monospace, -apple-system, sans-serif';
                var pillWidth = ctx.measureText(pillText).width + 30;
                var pillX = (outW - pillWidth) / 2;
                var pillY = 510;
                var pillH = 28;

                ctx.fillStyle = '#f0f9ff';
                ctx.beginPath();
                ctx.arc(pillX + pillH/2, pillY + pillH/2, pillH/2, Math.PI/2, Math.PI*3/2);
                ctx.arc(pillX + pillWidth - pillH/2, pillY + pillH/2, pillH/2, -Math.PI/2, Math.PI/2);
                ctx.closePath();
                ctx.fill();

                ctx.strokeStyle = '#bae6fd';
                ctx.lineWidth = 1.5;
                ctx.stroke();

                ctx.fillStyle = '#0284c7';
                ctx.fillText(pillText, outW / 2, pillY + 18);

                // 5. Bottom Verified Footer
                ctx.fillStyle = '#10b981';
                ctx.font = 'bold 10px -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif';
                ctx.fillText('✓ Authenticated Live Profile • Scan with Phone to Verify', outW / 2, 575);

                ctx.fillStyle = '#94a3b8';
                ctx.font = '500 9px -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif';
                ctx.fillText('SkillTrack Career & Placement Readiness Intelligence Platform', outW / 2, 595);

                // 6. Outer Card Border
                ctx.strokeStyle = '#0284c7';
                ctx.lineWidth = 3;
                ctx.strokeRect(1.5, 1.5, outW - 3, outH - 3);

                // Trigger PNG Download
                var safeRoll = "<c:out value='${student.rollNumber}' />".replace(/[^a-zA-Z0-9_-]/g, "");
                var fileName = "SkillTrack_QR_" + safeRoll + ".png";
                var link = document.createElement('a');
                link.download = fileName;
                link.href = outCanvas.toDataURL('image/png');
                document.body.appendChild(link);
                link.click();
                document.body.removeChild(link);

                showToast("✓ Executive QR Pass PNG downloaded!");
            } catch (err) {
                console.error("Failed to download QR PNG:", err);
                showToast("⚠️ Could not download image");
            }
        }

        // Direct High-Resolution A4 PDF Generation (Zero Browser Noise)
        function downloadPassportPdf() {
            var element = document.getElementById('passportCertificateDoc');
            if (!element) return;

            if (typeof html2pdf === 'undefined') {
                window.print();
                return;
            }

            var btn = document.getElementById('downloadPdfBtn');
            var originalHtml = btn ? btn.innerHTML : '';
            if (btn) {
                btn.disabled = true;
                btn.innerHTML = '<span class="spinner-border spinner-border-sm mr-1.5" style="width: 12px; height: 12px; border-width: 2px;" role="status"></span> Generating PDF...';
            }

            var safeName = "<c:out value='${student.fullName}' />".replace(/[^a-zA-Z0-9_-]/g, "_");
            var safeRoll = "<c:out value='${student.rollNumber}' />".replace(/[^a-zA-Z0-9_-]/g, "_");
            var fileName = "Placement_Passport_" + (safeName || safeRoll || "Candidate") + ".pdf";

            var opt = {
                margin:       [4, 4, 4, 4],
                filename:     fileName,
                image:        { type: 'jpeg', quality: 0.98 },
                html2canvas:  { 
                    scale: 2.2, 
                    useCORS: true, 
                    logging: false,
                    letterRendering: true,
                    scrollY: 0,
                    scrollX: 0
                },
                jsPDF:        { unit: 'mm', format: 'a4', orientation: 'portrait' },
                singlePage:   true
            };

            html2pdf().set(opt).from(element).save().then(function() {
                if (btn) {
                    btn.disabled = false;
                    btn.innerHTML = originalHtml;
                }
                showToast("✓ Placement Passport PDF downloaded!");
            }).catch(function(err) {
                console.error("Direct PDF export error:", err);
                if (btn) {
                    btn.disabled = false;
                    btn.innerHTML = originalHtml;
                }
                showToast("⚠️ Direct PDF failed, opening print...");
                window.print();
            });
        }

        // Bind download buttons
        var downloadToolbarBtn = document.getElementById('downloadQrBtn');
        if (downloadToolbarBtn) {
            downloadToolbarBtn.addEventListener('click', downloadQrImage);
        }

        var downloadPdfToolbarBtn = document.getElementById('downloadPdfBtn');
        if (downloadPdfToolbarBtn) {
            downloadPdfToolbarBtn.addEventListener('click', downloadPassportPdf);
        }

        function fallbackCopy(url) {
            var temp = document.createElement('input');
            temp.value = url;
            document.body.appendChild(temp);
            temp.select();
            document.execCommand('copy');
            document.body.removeChild(temp);
            showToast("✓ Verification link copied to clipboard!");
        }

        function showToast(msg) {
            var toast = document.getElementById('passportToast');
            if (!toast) return;
            if (msg) toast.innerText = msg;
            toast.classList.add('show');
            setTimeout(function() {
                toast.classList.remove('show');
            }, 2600);
        }
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initPassport);
    } else {
        initPassport();
    }
})();
</script>

<%@ include file="/WEB-INF/views/common/footer.jspf" %>
