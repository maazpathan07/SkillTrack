<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:choose>
    <%-- If user is logged in, auto-redirect directly to their portal --%>
    <c:when test="${not empty sessionScope.SESSION_USER_ID}">
        <c:choose>
            <c:when test="${sessionScope.SESSION_USER_ROLE == 'ADMIN'}">
                <c:redirect url="/app/admin/dashboard" />
            </c:when>
            <c:otherwise>
                <c:redirect url="/app/student/dashboard" />
            </c:otherwise>
        </c:choose>
    </c:when>

    <%-- Public Apple iOS Glassmorphism Showcase & Product Portal --%>
    <c:otherwise>
        <c:set var="pageTitle" value="Smart Skill & Placement Readiness Management Platform" />
        <%@ include file="/WEB-INF/views/common/header.jspf" %>

        <!-- Apple iOS Glassmorphism Sticky Navbar -->
        <header class="ios-navbar d-flex align-items-center justify-content-between position-sticky">
            <div class="d-flex align-items-center">
                <a class="ios-brand" href="${pageContext.request.contextPath}/">
                    <span class="ios-brand-icon">
                        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M12 2L2 7l10 5 10-5-10-5z"></path>
                            <path d="M2 17l10 5 10-5"></path>
                            <path d="M2 12l10 5 10-5"></path>
                        </svg>
                    </span>
                    <span>SkillTrack</span>
                </a>
            </div>

            <!-- Apple Floating Capsule Pill Navigation Menu (Desktop: Compact & Dropdown Groups) -->
            <nav class="d-none d-lg-flex align-items-center ios-capsule-nav">
                <!-- 1. Overview -->
                <a href="#overview" class="ios-capsule-link active">Overview</a>

                <!-- 2. Features Dropdown -->
                <div class="dropdown">
                    <a href="javascript:void(0)" class="ios-capsule-link dropdown-toggle" id="navFeaturesDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <span>Capabilities</span>
                        <svg class="ios-capsule-chevron" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="6 9 12 15 18 9"></polyline></svg>
                    </a>
                    <div class="dropdown-menu ios-capsule-dropdown-menu" aria-labelledby="navFeaturesDropdown">
                        <a class="dropdown-item ios-capsule-dropdown-item" href="#features">
                            <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="3" width="7" height="7"></rect><rect x="14" y="3" width="7" height="7"></rect><rect x="14" y="14" width="7" height="7"></rect><rect x="3" y="14" width="7" height="7"></rect></svg>
                            <span>4 Placement Engines</span>
                        </a>
                        <a class="dropdown-item ios-capsule-dropdown-item" href="#features">
                            <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"></polygon></svg>
                            <span>LeetCode Sync &amp; DSA</span>
                        </a>
                        <a class="dropdown-item ios-capsule-dropdown-item" href="#features">
                            <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><polyline points="16 18 22 12 16 6"></polyline><polyline points="8 6 2 12 8 18"></polyline></svg>
                            <span>Code Playground</span>
                        </a>
                        <a class="dropdown-item ios-capsule-dropdown-item" href="#features">
                            <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path><polyline points="14 2 14 8 20 8"></polyline></svg>
                            <span>ATS Resume &amp; AI</span>
                        </a>
                        <a class="dropdown-item ios-capsule-dropdown-item" href="#features">
                            <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path></svg>
                            <span>Verified Passport</span>
                        </a>
                    </div>
                </div>

                <!-- 3. Solutions Dropdown -->
                <div class="dropdown">
                    <a href="javascript:void(0)" class="ios-capsule-link dropdown-toggle" id="navSolutionsDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <span>Solutions</span>
                        <svg class="ios-capsule-chevron" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="6 9 12 15 18 9"></polyline></svg>
                    </a>
                    <div class="dropdown-menu ios-capsule-dropdown-menu" aria-labelledby="navSolutionsDropdown">
                        <a class="dropdown-item ios-capsule-dropdown-item" href="#comparison">
                            <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><polygon points="16.24 7.76 14.12 14.12 7.76 16.24 9.88 9.88 16.24 7.76"></polygon></svg>
                            <span>Why SkillTrack</span>
                        </a>
                        <a class="dropdown-item ios-capsule-dropdown-item" href="#roadmap">
                            <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 14 14"></polyline></svg>
                            <span>4-Step Roadmap</span>
                        </a>
                        <a class="dropdown-item ios-capsule-dropdown-item" href="#tpo-portal">
                            <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 19a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h5l2 3h9a2 2 0 0 1 2 2z"></path></svg>
                            <span>Placement Cells &amp; TPO</span>
                        </a>
                    </div>
                </div>

                <!-- 4. FAQ -->
                <a href="#faq" class="ios-capsule-link">FAQ</a>
            </nav>

            <!-- Desktop Action Buttons -->
            <div class="d-none d-lg-flex align-items-center ios-desktop-actions">
                <a class="ios-btn-secondary mr-2" href="${pageContext.request.contextPath}/login" style="padding: 0.5rem 1.25rem; font-size: 0.875rem;">
                    Sign In
                </a>
                <a class="ios-btn-primary" href="${pageContext.request.contextPath}/register" style="padding: 0.5rem 1.35rem; font-size: 0.875rem;">
                    Get Started &rarr;
                </a>
            </div>

            <!-- Mobile Actions & Hamburger Toggle (< 992px) -->
            <div class="d-flex d-lg-none align-items-center">
                <a class="ios-btn-primary mr-2" href="${pageContext.request.contextPath}/register" style="padding: 0.4rem 0.85rem; font-size: 0.8rem;">
                    Get Started
                </a>
                <button type="button" class="ios-mobile-toggle" id="iosMobileNavToggle" aria-label="Toggle navigation menu" onclick="window.toggleSkillTrackMobileDrawer(event)">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                        <line x1="3" y1="12" x2="21" y2="12"></line>
                        <line x1="3" y1="6" x2="21" y2="6"></line>
                        <line x1="3" y1="18" x2="21" y2="18"></line>
                    </svg>
                </button>
            </div>

            <!-- Apple iOS Mobile Glass Drawer Menu -->
            <div class="ios-mobile-drawer" id="iosMobileDrawer">
                <div class="mb-3">
                    <a href="#overview" class="ios-mobile-link active">
                        <span>Overview</span>
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="9 18 15 12 9 6"></polyline></svg>
                    </a>
                    
                    <div class="px-3 pt-2 pb-1 text-uppercase text-muted" style="font-size: 0.68rem; font-weight: 700; letter-spacing: 0.08em;">Capabilities</div>
                    <a href="#features" class="ios-mobile-link pl-4">
                        <span>Placement Engines &amp; DSA</span>
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="9 18 15 12 9 6"></polyline></svg>
                    </a>
                    <a href="#comparison" class="ios-mobile-link pl-4">
                        <span>Why SkillTrack</span>
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="9 18 15 12 9 6"></polyline></svg>
                    </a>
                    <a href="#roadmap" class="ios-mobile-link pl-4">
                        <span>4-Step Roadmap</span>
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="9 18 15 12 9 6"></polyline></svg>
                    </a>
                    <a href="#tpo-portal" class="ios-mobile-link pl-4">
                        <span>Placement Cells &amp; TPO</span>
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="9 18 15 12 9 6"></polyline></svg>
                    </a>
                    <a href="#faq" class="ios-mobile-link">
                        <span>FAQ</span>
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="9 18 15 12 9 6"></polyline></svg>
                    </a>
                </div>
                <div class="pt-2 border-top d-flex flex-column gap-2">
                    <a class="ios-btn-secondary text-center mb-2" href="${pageContext.request.contextPath}/login" style="padding: 0.65rem; font-size: 0.9rem;">
                        Sign In to Portal
                    </a>
                    <a class="ios-btn-primary text-center" href="${pageContext.request.contextPath}/register" style="padding: 0.65rem; font-size: 0.9rem;">
                        Create Student Account &rarr;
                    </a>
                </div>
            </div>
        </header>

        <!-- 1. HERO SECTION (APPLE LIQUID GLASS AESTHETIC & INTERACTIVE MULTI-ENGINE TERMINAL) -->
        <section class="ios-ambient-canvas py-5" id="overview" style="padding-top: 4.5rem !important; padding-bottom: 5rem !important;">
            <div class="container position-relative" style="z-index: 2;">
                <div class="row align-items-center">
                    <!-- Left Column: Hero Headline, Subtitle & Action CTAs -->
                    <div class="col-lg-7 text-center text-lg-left mb-5 mb-lg-0">
                        <!-- Apple Style Pill Tag -->
                        <div class="d-inline-flex align-items-center px-3 py-1 mb-3 rounded-pill border" style="background: rgba(255, 255, 255, 0.9); backdrop-filter: blur(20px); font-size: 0.825rem; font-weight: 700; color: #0071e3; box-shadow: 0 2px 8px rgba(0, 113, 227, 0.08);">
                            <span class="mr-2" style="width: 7px; height: 7px; border-radius: 50%; background: #10b981; display: inline-block; box-shadow: 0 0 0 3px rgba(16, 185, 129, 0.25);"></span>
                            Next-Gen Placement Intelligence &bull; AI Powered
                        </div>
                        
                        <!-- Hero Typography -->
                        <h1 class="ios-hero-title font-weight-bold mb-3" style="color: #0f172a; letter-spacing: -0.03em; line-height: 1.15;">
                            Master Industry Skills. <br />
                            <span style="background: linear-gradient(135deg, #0071e3 0%, #6366f1 50%, #8b5cf6 100%); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">
                                Accelerate Placement Readiness.
                            </span>
                        </h1>

                        <!-- Subtitle -->
                        <p class="lead mb-4" style="color: #475569; font-size: 1.15rem; line-height: 1.6; max-width: 620px;">
                            The unified placement operating system for engineering campuses. Auto-sync <strong>LeetCode stats</strong>, code in <strong>Live Playgrounds</strong>, scan <strong>ATS Resumes</strong> against company cutoffs, and earn a verified <strong>100-Point Placement Passport</strong>.
                        </p>

                        <!-- Action Buttons -->
                        <div class="d-flex flex-column flex-sm-row justify-content-center justify-content-lg-start gap-3 mb-4">
                            <a href="${pageContext.request.contextPath}/register" class="ios-btn-primary mr-sm-3 mb-3 mb-sm-0" style="padding: 0.85rem 2rem; font-size: 1rem; box-shadow: 0 8px 20px -3px rgba(0, 113, 227, 0.35);">
                                Register as Student &rarr;
                            </a>
                            <a href="${pageContext.request.contextPath}/login" class="ios-btn-secondary" style="padding: 0.85rem 2rem; font-size: 1rem;">
                                Access Portal
                            </a>
                        </div>

                        <!-- Micro Feature Badges with Official Vector Icons -->
                        <div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start gap-2 pt-1">
                            <span class="ios-badge ios-badge-gray mr-2 mb-2" style="font-size: 0.775rem; padding: 0.35rem 0.75rem;">
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="#FFA116" class="mr-1.5"><path d="M13.483 0a1.374 1.374 0 0 0-.961.438L7.116 6.226l-3.854 4.126a5.266 5.266 0 0 0-1.209 2.104 5.35 5.35 0 0 0-.125.513 5.527 5.527 0 0 0 .062 2.362 5.83 5.83 0 0 0 .349 1.017 5.938 5.938 0 0 0 1.271 1.818l4.277 4.193.039.038c2.248 2.165 5.852 2.133 8.063-.074l2.396-2.392c.54-.54.54-1.414.003-1.955a1.378 1.378 0 0 0-1.951-.003l-2.396 2.392a3.021 3.021 0 0 1-4.205.038l-.02-.019-4.276-4.193c-.652-.64-.972-1.469-.948-2.263a2.68 2.68 0 0 1 .666-1.607L9.4 7.64l4.083-4.371A1.38 1.38 0 0 0 13.483 0zm-2.88 7.218a1.38 1.38 0 0 0-.979.405l-4.54 4.54a1.38 1.38 0 0 0 0 1.952l4.54 4.54a1.38 1.38 0 0 0 1.952-1.952L7.962 13.11l3.614-3.614a1.38 1.38 0 0 0-.973-2.278z"/></svg>
                                LeetCode Live Sync
                            </span>
                            <span class="ios-badge ios-badge-gray mr-2 mb-2" style="font-size: 0.775rem; padding: 0.35rem 0.75rem;">
                                <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="#0071e3" stroke-width="2.2" class="mr-1.5"><polyline points="16 18 22 12 16 6"></polyline><polyline points="8 6 2 12 8 18"></polyline></svg>
                                Code Playground
                            </span>
                            <span class="ios-badge ios-badge-gray mr-2 mb-2" style="font-size: 0.775rem; padding: 0.35rem 0.75rem;">
                                <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="#10b981" stroke-width="2.2" class="mr-1.5"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path><polyline points="14 2 14 8 20 8"></polyline></svg>
                                ATS Resume Scanner
                            </span>
                            <span class="ios-badge ios-badge-gray mb-2" style="font-size: 0.775rem; padding: 0.35rem 0.75rem;">
                                <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="#8b5cf6" stroke-width="2.2" class="mr-1.5"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path></svg>
                                Verified Passport
                            </span>
                        </div>
                    </div>

                    <!-- Right Column: Interactive Multi-Engine Terminal Widget -->
                    <div class="col-lg-5">
                        <div class="ios-glass-card p-4" style="background: rgba(255, 255, 255, 0.94); backdrop-filter: blur(24px); border: 1px solid rgba(226, 232, 240, 0.95); box-shadow: 0 20px 50px -10px rgba(0, 0, 0, 0.12), 0 0 0 1px rgba(0, 0, 0, 0.04); border-radius: 20px;">
                            <!-- macOS Window Header Bar -->
                            <div class="d-flex justify-content-between align-items-center mb-3 pb-2.5 border-bottom" style="border-color: #f1f5f9 !important;">
                                <div class="d-flex align-items-center">
                                    <div class="d-flex align-items-center mr-2.5" style="gap: 5px;">
                                        <span style="width: 10px; height: 10px; border-radius: 50%; background: #ff5f56; display: inline-block;"></span>
                                        <span style="width: 10px; height: 10px; border-radius: 50%; background: #ffbd2e; display: inline-block;"></span>
                                        <span style="width: 10px; height: 10px; border-radius: 50%; background: #27c93f; display: inline-block;"></span>
                                    </div>
                                    <span class="font-weight-bold" style="font-size: 0.8rem; color: #334155;">Interactive Terminal</span>
                                </div>
                                <span class="ios-badge ios-badge-green" style="font-size: 0.7rem; padding: 2px 8px;">
                                    <span class="mr-1" style="width: 5px; height: 5px; border-radius: 50%; background: #10b981; display: inline-block;"></span>
                                    Live Preview
                                </span>
                            </div>

                            <!-- 3 Mode Segmented Control (Readiness, LeetCode, ATS Scanner) -->
                            <div class="ios-segmented-control mb-3" style="background: #f1f5f9; padding: 3px; border-radius: 12px;">
                                <button type="button" class="ios-segment-btn active" onclick="switchTerminalTab('readiness')" id="tabBtnReadiness" style="font-size: 0.775rem;">
                                    Readiness Score
                                </button>
                                <button type="button" class="ios-segment-btn" onclick="switchTerminalTab('leetcode')" id="tabBtnLeetcode" style="font-size: 0.775rem;">
                                    LeetCode Sync
                                </button>
                                <button type="button" class="ios-segment-btn" onclick="switchTerminalTab('ats')" id="tabBtnAts" style="font-size: 0.775rem;">
                                    ATS Resume
                                </button>
                            </div>

                            <!-- TAB 1: READINESS SCORE VIEW -->
                            <div id="terminalTabReadiness">
                                <!-- Role Selector Pills -->
                                <div class="d-flex align-items-center justify-content-between mb-2">
                                    <span class="text-uppercase font-weight-bold" style="font-size: 0.7rem; letter-spacing: 0.05em; color: #64748b;">Target Role:</span>
                                    <div class="d-flex gap-1" style="gap: 4px;">
                                        <button type="button" class="btn-quick-add" onclick="switchPreviewRole('fullstack')" id="btnRole1" style="font-size: 0.72rem; padding: 2px 7px;">Full Stack</button>
                                        <button type="button" class="btn-quick-add" onclick="switchPreviewRole('data')" id="btnRole2" style="font-size: 0.72rem; padding: 2px 7px; background: transparent; border: none; color: #64748b;">Data Eng</button>
                                        <button type="button" class="btn-quick-add" onclick="switchPreviewRole('cloud')" id="btnRole3" style="font-size: 0.72rem; padding: 2px 7px; background: transparent; border: none; color: #64748b;">Cloud</button>
                                    </div>
                                </div>

                                <!-- Score Gauge Box -->
                                <div class="p-3 mb-2.5 rounded-lg" style="background: #f8fafc; border: 1px solid #e2e8f0;">
                                    <div class="d-flex justify-content-between align-items-center mb-1.5">
                                        <span class="small font-weight-bold" id="previewRoleTitle" style="color: #0f172a;">Full Stack Engineer</span>
                                        <span class="font-weight-bold" style="font-size: 1.25rem; color: #0071e3;" id="previewScoreText">88 / 100</span>
                                    </div>
                                    <div class="progress" style="height: 8px; border-radius: 4px; background: #e2e8f0;">
                                        <div class="progress-bar" id="previewProgressBar" role="progressbar" style="width: 88%; background: #10b981; border-radius: 4px; transition: width 0.5s ease;" aria-valuenow="88" aria-valuemin="0" aria-valuemax="100"></div>
                                    </div>
                                </div>

                                <!-- 4 Metrics Tiles -->
                                <div class="row text-center mb-2.5 no-gutters" style="gap: 6px;">
                                    <div class="col">
                                        <div class="p-2 border rounded" style="background: #ffffff;">
                                            <div class="font-weight-bold text-primary" style="font-size: 1.1rem; line-height: 1.1;" id="previewDsaCount">156</div>
                                            <small class="text-muted font-weight-bold" style="font-size: 0.68rem;">DSA Solved</small>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <div class="p-2 border rounded" style="background: #ffffff;">
                                            <div class="font-weight-bold text-success" style="font-size: 1.1rem; line-height: 1.1;" id="previewSkillCount">9 / 10</div>
                                            <small class="text-muted font-weight-bold" style="font-size: 0.68rem;">Skills</small>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <div class="p-2 border rounded" style="background: #ffffff;">
                                            <div class="font-weight-bold" style="font-size: 1.1rem; line-height: 1.1; color: #7c3aed;" id="previewProjectsCount">4 Proj</div>
                                            <small class="text-muted font-weight-bold" style="font-size: 0.68rem;">Verified</small>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <div class="p-2 border rounded" style="background: #ffffff;">
                                            <div class="font-weight-bold" style="font-size: 1.1rem; line-height: 1.1; color: #d97706;" id="previewCriteriaCount">95%</div>
                                            <small class="text-muted font-weight-bold" style="font-size: 0.68rem;">Eligibility</small>
                                        </div>
                                    </div>
                                </div>

                                <!-- Required Skills -->
                                <div class="mb-3">
                                    <div id="previewSkillChips" class="d-flex flex-wrap gap-1">
                                        <span class="ios-badge ios-badge-green mr-1 mb-1" style="font-size: 0.72rem;">Java Core</span>
                                        <span class="ios-badge ios-badge-green mr-1 mb-1" style="font-size: 0.72rem;">Spring Boot</span>
                                        <span class="ios-badge ios-badge-green mr-1 mb-1" style="font-size: 0.72rem;">React.js</span>
                                        <span class="ios-badge ios-badge-orange mr-1 mb-1" style="font-size: 0.72rem;">Docker (Interm)</span>
                                    </div>
                                </div>
                            </div>

                            <!-- TAB 2: LEETCODE AUTO-SYNC VIEW -->
                            <div id="terminalTabLeetcode" class="d-none">
                                <div class="p-3 mb-2.5 rounded-lg" style="background: linear-gradient(135deg, #fffbeb, #fef3c7); border: 1.5px solid rgba(245, 158, 11, 0.35);">
                                    <div class="d-flex align-items-center justify-content-between mb-2">
                                        <div class="d-flex align-items-center gap-2">
                                            <svg width="22" height="22" viewBox="0 0 24 24" fill="#FFA116"><path d="M13.483 0a1.374 1.374 0 0 0-.961.438L7.116 6.226l-3.854 4.126a5.266 5.266 0 0 0-1.209 2.104 5.35 5.35 0 0 0-.125.513 5.527 5.527 0 0 0 .062 2.362 5.83 5.83 0 0 0 .349 1.017 5.938 5.938 0 0 0 1.271 1.818l4.277 4.193.039.038c2.248 2.165 5.852 2.133 8.063-.074l2.396-2.392c.54-.54.54-1.414.003-1.955a1.378 1.378 0 0 0-1.951-.003l-2.396 2.392a3.021 3.021 0 0 1-4.205.038l-.02-.019-4.276-4.193c-.652-.64-.972-1.469-.948-2.263a2.68 2.68 0 0 1 .666-1.607L9.4 7.64l4.083-4.371A1.38 1.38 0 0 0 13.483 0zm-2.88 7.218a1.38 1.38 0 0 0-.979.405l-4.54 4.54a1.38 1.38 0 0 0 0 1.952l4.54 4.54a1.38 1.38 0 0 0 1.952-1.952L7.962 13.11l3.614-3.614a1.38 1.38 0 0 0-.973-2.278z"/></svg>
                                            <span class="font-weight-bold text-dark" style="font-size: 0.9rem;">@maaz_sde</span>
                                        </div>
                                        <span class="ios-badge ios-badge-green" style="font-size: 0.68rem; padding: 2px 7px;">✓ Live Synced</span>
                                    </div>
                                    <div class="d-flex justify-content-between align-items-baseline mb-1">
                                        <span class="small font-weight-bold text-muted">156 / 150 Solved</span>
                                        <span class="font-weight-bold text-success" style="font-size: 0.85rem;">Target Met 104%</span>
                                    </div>
                                    <div class="progress" style="height: 6px; border-radius: 3px; background: #e2e8f0;">
                                        <div class="progress-bar" style="width: 100%; background: #f59e0b;"></div>
                                    </div>
                                </div>

                                <!-- Difficulty Breakdown Chips -->
                                <div class="row text-center mb-2.5 no-gutters" style="gap: 6px;">
                                    <div class="col">
                                        <div class="p-2 border rounded" style="background: #ffffff;">
                                            <div class="font-weight-bold text-success" style="font-size: 1.1rem; line-height: 1.1;">84</div>
                                            <small class="text-muted font-weight-bold" style="font-size: 0.68rem;">🟢 Easy</small>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <div class="p-2 border rounded" style="background: #ffffff;">
                                            <div class="font-weight-bold text-warning" style="font-size: 1.1rem; line-height: 1.1;">52</div>
                                            <small class="text-muted font-weight-bold" style="font-size: 0.68rem;">🟡 Medium</small>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <div class="p-2 border rounded" style="background: #ffffff;">
                                            <div class="font-weight-bold text-danger" style="font-size: 1.1rem; line-height: 1.1;">20</div>
                                            <small class="text-muted font-weight-bold" style="font-size: 0.68rem;">🔴 Hard</small>
                                        </div>
                                    </div>
                                </div>

                                <div class="p-2 mb-3 rounded bg-light border d-flex justify-content-between align-items-center" style="font-size: 0.75rem;">
                                    <span class="text-muted">🏆 Global Rank: <strong>#18,420</strong></span>
                                    <span class="badge badge-primary px-2 py-1">Top 8.5% Globally</span>
                                </div>
                            </div>

                            <!-- TAB 3: ATS RESUME SCANNER VIEW -->
                            <div id="terminalTabAts" class="d-none">
                                <div class="p-3 mb-2.5 rounded-lg" style="background: #f0fdf4; border: 1.5px solid rgba(16, 185, 129, 0.35);">
                                    <div class="d-flex justify-content-between align-items-center mb-1">
                                        <span class="small font-weight-bold text-dark">ATS Diagnostic Score</span>
                                        <span class="font-weight-bold text-success" style="font-size: 1.25rem;">92 / 100</span>
                                    </div>
                                    <div class="progress mb-2" style="height: 6px; border-radius: 3px; background: #dcfce7;">
                                        <div class="progress-bar bg-success" style="width: 92%;"></div>
                                    </div>
                                    <span class="small text-muted d-block" style="font-size: 0.72rem;">Harvard / Ivy-League 1-Page A4 Standard Compliant</span>
                                </div>

                                <div class="row text-center mb-2.5 no-gutters" style="gap: 6px;">
                                    <div class="col">
                                        <div class="p-2 border rounded" style="background: #ffffff;">
                                            <div class="font-weight-bold text-success" style="font-size: 1rem; line-height: 1.1;">95%</div>
                                            <small class="text-muted font-weight-bold" style="font-size: 0.65rem;">Keywords</small>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <div class="p-2 border rounded" style="background: #ffffff;">
                                            <div class="font-weight-bold text-primary" style="font-size: 1rem; line-height: 1.1;">88%</div>
                                            <small class="text-muted font-weight-bold" style="font-size: 0.65rem;">Action Verbs</small>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <div class="p-2 border rounded" style="background: #ffffff;">
                                            <div class="font-weight-bold text-success" style="font-size: 1rem; line-height: 1.1;">100%</div>
                                            <small class="text-muted font-weight-bold" style="font-size: 0.65rem;">Format</small>
                                        </div>
                                    </div>
                                </div>

                                <div class="p-2 mb-3 rounded bg-light border d-flex justify-content-between align-items-center" style="font-size: 0.75rem;">
                                    <span class="text-muted">Target Company Cutoffs:</span>
                                    <span class="badge badge-success px-2 py-1">Tier-1 Eligible ✓</span>
                                </div>
                            </div>

                            <a href="${pageContext.request.contextPath}/register" class="ios-btn-primary btn-block text-center" style="border-radius: 12px; font-size: 0.9rem; padding: 0.7rem;">
                                Launch Your Student Portal &rarr;
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- 2. APPLE GLASS COMPARISON SECTION (CLEAN CIRCULAR VECTOR BADGES) -->
        <section class="py-5 bg-white border-top border-bottom" id="comparison">
            <div class="container py-5">
                <div class="text-center mb-5">
                    <span class="ios-badge ios-badge-blue px-3 py-1 mb-2">Why SkillTrack?</span>
                    <h2 class="ios-section-title font-weight-bold" style="color: var(--ios-text-primary);">
                        The Placement Revolution: Data Over Guesswork
                    </h2>
                    <p class="text-muted" style="max-width: 650px; margin: auto; font-size: 1.1rem;">
                        Eliminate campus hiring anxiety with transparent skill gap benchmarks instead of random last-minute preparation.
                    </p>
                </div>

                <div class="row">
                    <!-- Left: Traditional Guesswork -->
                    <div class="col-lg-6 mb-4">
                        <div class="ios-compare-card-old h-100">
                            <div class="text-center mb-4">
                                <span class="ios-badge ios-badge-red">Traditional Campus Approach</span>
                            </div>
                            
                            <h3 class="font-weight-bold mb-4" style="font-size: 1.45rem; letter-spacing: -0.02em; color: var(--ios-text-primary);">
                                Why Many Engineering Students Face Rejection
                            </h3>

                            <!-- Point 1: Blind Skill Prep -->
                            <div class="d-flex align-items-start mb-4">
                                <div class="ios-circle-icon ios-circle-red mr-3 flex-shrink-0">
                                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                        <circle cx="12" cy="12" r="10"></circle>
                                        <polygon points="16.24 7.76 14.12 14.12 7.76 16.24 9.88 9.88 16.24 7.76"></polygon>
                                    </svg>
                                </div>
                                <div>
                                    <h6 class="font-weight-bold mb-1" style="color: var(--ios-text-primary);">Blind Skill Preparation</h6>
                                    <p class="text-muted small mb-0">Students study generic theory without knowing what specific technical stacks (Spring Boot, React, AWS, Docker) hiring companies demand.</p>
                                </div>
                            </div>

                            <!-- Point 2: Unstructured DSA -->
                            <div class="d-flex align-items-start mb-4">
                                <div class="ios-circle-icon ios-circle-red mr-3 flex-shrink-0">
                                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                        <polyline points="16 18 22 12 16 6"></polyline>
                                        <polyline points="8 6 2 12 8 18"></polyline>
                                    </svg>
                                </div>
                                <div>
                                    <h6 class="font-weight-bold mb-1" style="color: var(--ios-text-primary);">Unstructured DSA Practice</h6>
                                    <p class="text-muted small mb-0">Solving 100 random easy array questions while skipping essential Trees, Graphs, Dynamic Programming, and System Design patterns.</p>
                                </div>
                            </div>

                            <!-- Point 3: Sudden Disqualification -->
                            <div class="d-flex align-items-start mb-0">
                                <div class="ios-circle-icon ios-circle-red mr-3 flex-shrink-0">
                                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                        <polygon points="22 3 2 3 10 12.46 10 19 14 21 14 12.46 22 3"></polygon>
                                    </svg>
                                </div>
                                <div>
                                    <h6 class="font-weight-bold mb-1" style="color: var(--ios-text-primary);">Sudden Shortlist Elimination</h6>
                                    <p class="text-muted small mb-0">Getting filtered out during initial screening rounds due to unseen minimum CGPA cutoffs, backlog limits, or unverified project portfolios.</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Right: SkillTrack Solution -->
                    <div class="col-lg-6 mb-4">
                        <div class="ios-compare-card-new h-100">
                            <div class="text-center mb-4">
                                <span class="ios-badge ios-badge-green">SkillTrack Scientific System</span>
                            </div>
                            
                            <h3 class="font-weight-bold mb-4" style="font-size: 1.45rem; letter-spacing: -0.02em; color: var(--ios-text-primary);">
                                Guaranteed Readiness with 4-Tier Intelligence
                            </h3>

                            <!-- Point 1: Role Gap Radar -->
                            <div class="d-flex align-items-start mb-4">
                                <div class="ios-circle-icon ios-circle-green mr-3 flex-shrink-0">
                                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                        <circle cx="12" cy="12" r="10"></circle>
                                        <circle cx="12" cy="12" r="6"></circle>
                                        <circle cx="12" cy="12" r="2"></circle>
                                    </svg>
                                </div>
                                <div>
                                    <h6 class="font-weight-bold mb-1" style="color: var(--ios-text-primary);">Target-Role Skill Gap Radar</h6>
                                    <p class="text-muted small mb-0">Clear visual status indicators reveal exactly what competencies are missing and what level to reach for your target role.</p>
                                </div>
                            </div>

                            <!-- Point 2: DSA Tracker -->
                            <div class="d-flex align-items-start mb-4">
                                <div class="ios-circle-icon ios-circle-green mr-3 flex-shrink-0">
                                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                        <polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"></polygon>
                                    </svg>
                                </div>
                                <div>
                                    <h6 class="font-weight-bold mb-1" style="color: var(--ios-text-primary);">Topic-Wise DSA Milestone Tracker</h6>
                                    <p class="text-muted small mb-0">Structured progress tracking across Easy, Medium, and Hard problem goals across all core algorithmic topics.</p>
                                </div>
                            </div>

                            <!-- Point 3: Scorecard -->
                            <div class="d-flex align-items-start mb-0">
                                <div class="ios-circle-icon ios-circle-green mr-3 flex-shrink-0">
                                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                        <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path>
                                        <polyline points="9 12 11 14 15 10"></polyline>
                                    </svg>
                                </div>
                                <div>
                                    <h6 class="font-weight-bold mb-1" style="color: var(--ios-text-primary);">Deterministic 100-Point Scorecard</h6>
                                    <p class="text-muted small mb-0">Transparent score computed from Skills (40%), DSA (25%), Projects (20%), and Academic Standing (15%) for company recruitment.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- 3. FOUR CORE CAPABILITIES (APPLE GLASS CARDS) -->
        <section class="py-5" id="features" style="background: var(--ios-bg-base);">
            <div class="container py-5">
                <div class="text-center mb-5">
                    <span class="ios-badge ios-badge-blue px-3 py-1 mb-2">Core Capabilities</span>
                    <h2 class="ios-section-title font-weight-bold" style="color: var(--ios-text-primary);">
                        Four Modular Placement Engines
                    </h2>
                    <p class="text-muted" style="max-width: 650px; margin: auto; font-size: 1.1rem;">
                        Built on clean data models to guide you step-by-step to your campus offer letter.
                    </p>
                </div>

                <div class="row">
                    <!-- Feature Card 1: Role Skill Gap Engine -->
                    <div class="col-lg-6 mb-4">
                        <div class="ios-feature-card">
                            <div class="d-flex align-items-center mb-3">
                                <div class="ios-icon-box ios-icon-blue mr-3 flex-shrink-0">
                                    <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><circle cx="12" cy="12" r="6"></circle><circle cx="12" cy="12" r="2"></circle></svg>
                                </div>
                                <div>
                                    <h5 class="font-weight-bold mb-0" style="color: var(--ios-text-primary); line-height: 1.25;">Role Skill Gap Engine</h5>
                                    <small class="text-muted" style="display: block; margin-top: 2px;">Target Competency Benchmarking</small>
                                </div>
                            </div>
                            <p class="text-muted small mb-4">
                                Select your target role (Full Stack, Backend, Cloud DevOps) and immediately discover acquired proficiencies vs missing requirements.
                            </p>

                            <!-- Enhanced Apple Glass Skill Tracker -->
                            <div class="p-3 bg-light rounded-lg border" style="background: rgba(248, 250, 252, 0.95); border-radius: var(--ios-radius-sm);">
                                <div class="d-flex justify-content-between small font-weight-bold mb-1">
                                    <span style="color: var(--ios-text-primary);">Java / Spring Boot Core</span>
                                    <span class="text-success font-weight-bold">Matched (Advanced)</span>
                                </div>
                                <div class="progress mb-3" style="height: 6px; border-radius: 3px; background: #e2e8f0;">
                                    <div class="progress-bar bg-success" style="width: 100%;"></div>
                                </div>

                                <div class="d-flex justify-content-between small font-weight-bold mb-1">
                                    <span style="color: var(--ios-text-primary);">Docker & Containerization</span>
                                    <span style="color: #c2410c;" class="font-weight-bold">Needs Level Up (Basic ➔ Interm)</span>
                                </div>
                                <div class="progress mb-3" style="height: 6px; border-radius: 3px; background: #e2e8f0;">
                                    <div class="progress-bar" style="width: 65%; background: var(--ios-orange);"></div>
                                </div>

                                <div class="d-flex justify-content-between small font-weight-bold mb-1">
                                    <span style="color: var(--ios-text-primary);">Kubernetes Orchestration</span>
                                    <span class="text-danger font-weight-bold">Missing Competency</span>
                                </div>
                                <div class="progress" style="height: 6px; border-radius: 3px; background: #e2e8f0;">
                                    <div class="progress-bar bg-danger" style="width: 15%;"></div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Feature Card 2: DSA Problem Solving Engine -->
                    <div class="col-lg-6 mb-4">
                        <div class="ios-feature-card">
                            <div class="d-flex align-items-center mb-3">
                                <div class="ios-icon-box ios-icon-green mr-3 flex-shrink-0">
                                    <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"></polyline></svg>
                                </div>
                                <div>
                                    <h5 class="font-weight-bold mb-0" style="color: var(--ios-text-primary); line-height: 1.25;">DSA & Problem Solving Engine</h5>
                                    <small class="text-muted" style="display: block; margin-top: 2px;">Topic-Wise Algorithmic Milestones</small>
                                </div>
                            </div>
                            <p class="text-muted small mb-4">
                                Maintain structured daily logs across Arrays, Trees, Graphs, and Dynamic Programming with difficulty breakdown counters.
                            </p>

                            <!-- Enhanced Apple Glass DSA Counters -->
                            <div class="row text-center mb-3">
                                <div class="col-4">
                                    <div class="p-3 rounded border bg-white shadow-xs">
                                        <div class="font-weight-bold text-success" style="font-size: 1.5rem; line-height: 1;">84</div>
                                        <span class="ios-badge ios-badge-green small mt-2">Easy</span>
                                    </div>
                                </div>
                                <div class="col-4">
                                    <div class="p-3 rounded border bg-white shadow-xs">
                                        <div class="font-weight-bold" style="font-size: 1.5rem; line-height: 1; color: var(--ios-orange);">52</div>
                                        <span class="ios-badge ios-badge-orange small mt-2">Medium</span>
                                    </div>
                                </div>
                                <div class="col-4">
                                    <div class="p-3 rounded border bg-white shadow-xs">
                                        <div class="font-weight-bold text-danger" style="font-size: 1.5rem; line-height: 1;">20</div>
                                        <span class="ios-badge ios-badge-red small mt-2">Hard</span>
                                    </div>
                                </div>
                            </div>
                            <div class="text-center">
                                <span class="text-muted small font-weight-bold">156 Solved Questions Across 12 Algorithmic Topics</span>
                            </div>
                        </div>
                    </div>

                    <!-- Feature Card 3: Project & Certification Portfolio -->
                    <div class="col-lg-6 mb-4">
                        <div class="ios-feature-card">
                            <div class="d-flex align-items-center mb-3">
                                <div class="ios-icon-box ios-icon-purple mr-3 flex-shrink-0">
                                    <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="2" y="3" width="20" height="14" rx="2" ry="2"></rect><line x1="8" y1="21" x2="16" y2="21"></line><line x1="12" y1="17" x2="12" y2="21"></line></svg>
                                </div>
                                <div>
                                    <h5 class="font-weight-bold mb-0" style="color: var(--ios-text-primary); line-height: 1.25;">Project & Certification Portfolio</h5>
                                    <small class="text-muted" style="display: block; margin-top: 2px;">Verified Proof-of-Work</small>
                                </div>
                            </div>
                            <p class="text-muted small mb-3">
                                Showcase real-world GitHub repositories, live deployed application URLs, tech stacks, and industry certification credentials.
                            </p>
                            
                            <!-- Enhanced Project Card -->
                            <div class="p-3 bg-light rounded-lg border" style="background: rgba(248, 250, 252, 0.95); border-radius: var(--ios-radius-sm);">
                                <div class="d-flex flex-wrap justify-content-between align-items-center gap-2">
                                    <div class="d-flex align-items-center">
                                        <span class="mr-2" style="width: 8px; height: 8px; border-radius: 50%; background: var(--ios-green); display: inline-block;"></span>
                                        <span class="font-weight-bold small" style="color: var(--ios-text-primary);">E-Commerce Microservices Platform</span>
                                    </div>
                                    <span class="ios-badge ios-badge-blue">Live Demo</span>
                                </div>
                                <div class="mt-2 text-muted small">
                                    <span>Stack: Java, Spring Cloud, Kafka, Docker, MySQL</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Feature Card 4: Placement Cutoff Matcher -->
                    <div class="col-lg-6 mb-4">
                        <div class="ios-feature-card">
                            <div class="d-flex align-items-center mb-3">
                                <div class="ios-icon-box ios-icon-orange mr-3 flex-shrink-0">
                                    <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path><polyline points="9 22 9 12 15 12 15 22"></polyline></svg>
                                </div>
                                <div>
                                    <h5 class="font-weight-bold mb-0" style="color: var(--ios-text-primary); line-height: 1.25;">Placement Cutoff Matcher</h5>
                                    <small class="text-muted" style="display: block; margin-top: 2px;">Real-Time Company Eligibility</small>
                                </div>
                            </div>
                            <p class="text-muted small mb-3">
                                Automated evaluation against hiring criteria (CGPA threshold, allowed backlogs, mandatory skills) with real-time match status.
                            </p>
                            
                            <!-- Enhanced Criteria Matcher Box -->
                            <div class="p-3 bg-light rounded-lg border d-flex flex-wrap justify-content-between align-items-center gap-2" style="background: rgba(248, 250, 252, 0.95); border-radius: var(--ios-radius-sm);">
                                <div>
                                    <div class="font-weight-bold small" style="color: var(--ios-text-primary);">Tier-1 Product Company Cutoff</div>
                                    <small class="text-muted">Min CGPA: 8.0 | Max Backlogs: 0 | Score &ge; 80</small>
                                </div>
                                <span class="ios-badge ios-badge-green font-weight-bold">Eligible ✓</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- 4. STEP-BY-STEP STUDENT ROADMAP -->
        <section class="py-5 bg-white border-top border-bottom" id="roadmap">
            <div class="container py-5">
                <div class="text-center mb-5">
                    <span class="ios-badge ios-badge-blue px-3 py-1 mb-2">4-Step Action Plan</span>
                    <h2 class="ios-section-title font-weight-bold" style="color: var(--ios-text-primary);">
                        Your Structured Roadmap to Placement
                    </h2>
                    <p class="text-muted" style="max-width: 650px; margin: auto; font-size: 1.1rem;">
                        From initial registration to walking out with top tier job offers.
                    </p>
                </div>

                <div class="row">
                    <div class="col-md-3 mb-4">
                        <div class="ios-feature-card text-center">
                            <span class="ios-badge ios-badge-blue mb-3 font-weight-bold">STEP 01</span>
                            <h5 class="font-weight-bold mb-2" style="color: var(--ios-text-primary);">Register Profile</h5>
                            <p class="text-muted small mb-0">Sign up with your college email, department (CSE, IT, ECE), graduation year, and current CGPA.</p>
                        </div>
                    </div>

                    <div class="col-md-3 mb-4">
                        <div class="ios-feature-card text-center">
                            <span class="ios-badge ios-badge-blue mb-3 font-weight-bold">STEP 02</span>
                            <h5 class="font-weight-bold mb-2" style="color: var(--ios-text-primary);">Select Target Role</h5>
                            <p class="text-muted small mb-0">Pick your desired industry role to instantly uncover required competencies and proficiency benchmarks.</p>
                        </div>
                    </div>

                    <div class="col-md-3 mb-4">
                        <div class="ios-feature-card text-center">
                            <span class="ios-badge ios-badge-blue mb-3 font-weight-bold">STEP 03</span>
                            <h5 class="font-weight-bold mb-2" style="color: var(--ios-text-primary);">Execute Daily Prep</h5>
                            <p class="text-muted small mb-0">Rate mastered skills, log solved DSA questions, add GitHub project repositories, and complete action tasks.</p>
                        </div>
                    </div>

                    <div class="col-md-3 mb-4">
                        <div class="ios-feature-card text-center">
                            <span class="ios-badge ios-badge-blue mb-3 font-weight-bold">STEP 04</span>
                            <h5 class="font-weight-bold mb-2" style="color: var(--ios-text-primary);">Qualify & Get Hired</h5>
                            <p class="text-muted small mb-0">Export your official verified Readiness Card, check company eligibility cutoffs, and sit for campus drives.</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- 5. TPO / PLACEMENT CELL ENTERPRISE SHOWCASE -->
        <section class="py-5" id="tpo-portal" style="background: var(--ios-bg-base);">
            <div class="container py-5">
                <div class="row align-items-center">
                    <div class="col-lg-6 mb-5 mb-lg-0">
                        <span class="ios-badge ios-badge-blue px-3 py-1 mb-2">Faculty &amp; TPO Console</span>
                        <h2 class="ios-section-title font-weight-bold mb-3" style="color: var(--ios-text-primary);">
                            Enterprise Intelligence for Placement Officers
                        </h2>
                        <p class="text-muted mb-4" style="font-size: 1.05rem; line-height: 1.6;">
                            Give your college Training &amp; Placement Cell (TPO) the real-time analytics needed to boost campus placement conversions, filter eligible batches, and generate reports in seconds.
                        </p>
                        
                        <!-- Feature 1 -->
                        <div class="d-flex align-items-start mb-4 p-3 rounded-lg" style="background: rgba(255, 255, 255, 0.6); border: 1px solid rgba(0, 0, 0, 0.04); border-radius: var(--ios-radius-md); transition: var(--ios-ease);">
                            <div class="ios-icon-box ios-icon-blue mr-3 flex-shrink-0" style="width: 44px; height: 44px; margin-bottom: 0; box-shadow: 0 4px 12px rgba(0, 113, 227, 0.15);">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="18" y1="20" x2="18" y2="10"></line><line x1="12" y1="20" x2="12" y2="4"></line><line x1="6" y1="20" x2="6" y2="14"></line></svg>
                            </div>
                            <div>
                                <h6 class="font-weight-bold mb-1" style="color: var(--ios-text-primary); font-size: 0.95rem;">Instant Cohort Intelligence &amp; PDF/Excel Export</h6>
                                <p class="text-muted small mb-0" style="line-height: 1.5;">Filter candidates by department, CGPA range, and readiness score with one-click exportable rosters.</p>
                            </div>
                        </div>

                        <!-- Feature 2 -->
                        <div class="d-flex align-items-start mb-4 p-3 rounded-lg" style="background: rgba(255, 255, 255, 0.6); border: 1px solid rgba(0, 0, 0, 0.04); border-radius: var(--ios-radius-md); transition: var(--ios-ease);">
                            <div class="ios-icon-box ios-icon-green mr-3 flex-shrink-0" style="width: 44px; height: 44px; margin-bottom: 0; box-shadow: 0 4px 12px rgba(52, 199, 89, 0.15);">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path><polyline points="22 4 12 14.01 9 11.01"></polyline></svg>
                            </div>
                            <div>
                                <h6 class="font-weight-bold mb-1" style="color: var(--ios-text-primary); font-size: 0.95rem;">Dynamic Company Hiring Criteria Rules</h6>
                                <p class="text-muted small mb-0" style="line-height: 1.5;">Configure company-specific cutoff parameters (minimum CGPA, max backlogs, required skills) with instant match stats.</p>
                            </div>
                        </div>

                        <!-- Feature 3 -->
                        <div class="d-flex align-items-start p-3 rounded-lg" style="background: rgba(255, 255, 255, 0.6); border: 1px solid rgba(0, 0, 0, 0.04); border-radius: var(--ios-radius-md); transition: var(--ios-ease);">
                            <div class="ios-icon-box ios-icon-purple mr-3 flex-shrink-0" style="width: 44px; height: 44px; margin-bottom: 0; box-shadow: 0 4px 12px rgba(175, 82, 222, 0.15);">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
                            </div>
                            <div>
                                <h6 class="font-weight-bold mb-1" style="color: var(--ios-text-primary); font-size: 0.95rem;">360° Verified Student Academic Profile</h6>
                                <p class="text-muted small mb-0" style="line-height: 1.5;">Inspect student skill proofs, GitHub project links, DSA completion ratios, and full audit logs.</p>
                            </div>
                        </div>
                    </div>

                    <!-- Right Demo Console -->
                    <div class="col-lg-6">
                        <div class="ios-card p-4" style="background: rgba(255, 255, 255, 0.92); backdrop-filter: blur(24px); border: 1px solid rgba(255, 255, 255, 0.95); box-shadow: 0 20px 50px -10px rgba(0, 0, 0, 0.12), 0 0 0 1px rgba(0, 0, 0, 0.04); border-radius: var(--ios-radius-lg);">
                            <!-- Top macOS window bar -->
                            <div class="d-flex justify-content-between align-items-center mb-3 pb-3 border-bottom" style="border-color: #f1f5f9 !important;">
                                <div class="d-flex align-items-center">
                                    <div class="d-flex align-items-center mr-3" style="gap: 6px;">
                                        <span style="width: 10px; height: 10px; border-radius: 50%; background: #ff5f56; display: inline-block;"></span>
                                        <span style="width: 10px; height: 10px; border-radius: 50%; background: #ffbd2e; display: inline-block;"></span>
                                        <span style="width: 10px; height: 10px; border-radius: 50%; background: #27c93f; display: inline-block;"></span>
                                    </div>
                                    <div>
                                        <h3 class="h6 font-weight-bold mb-0" style="color: var(--ios-text-primary); font-size: 0.95rem;">TPO Management Console</h3>
                                        <small class="text-muted" style="font-size: 0.75rem;">Live Batch Filtering &amp; Intelligence</small>
                                    </div>
                                </div>
                                <span class="ios-badge ios-badge-blue font-weight-bold" style="font-size: 0.75rem;">Live Demo</span>
                            </div>

                            <!-- Table -->
                            <div class="table-responsive" style="border-radius: var(--ios-radius-sm); overflow: hidden; border: 1px solid #f1f5f9;">
                                <table class="table table-hover mb-0 text-center" style="font-size: 0.85rem; border-collapse: separate;">
                                    <thead class="bg-light">
                                        <tr style="border-bottom: 1px solid #e2e8f0;">
                                            <th class="text-left font-weight-bold small text-uppercase py-2 px-3" style="color: #334155; letter-spacing: 0.05em;">Candidate</th>
                                            <th class="font-weight-bold small text-uppercase py-2" style="color: #334155; letter-spacing: 0.05em;">Dept</th>
                                            <th class="font-weight-bold small text-uppercase py-2" style="color: #334155; letter-spacing: 0.05em;">CGPA</th>
                                            <th class="font-weight-bold small text-uppercase py-2" style="color: #334155; letter-spacing: 0.05em;">Readiness</th>
                                            <th class="font-weight-bold small text-uppercase py-2 px-3 text-right" style="color: #334155; letter-spacing: 0.05em;">Status</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr style="border-bottom: 1px solid #f8fafc;">
                                            <td class="text-left font-weight-bold py-2 px-3" style="vertical-align: middle;">
                                                <div class="d-flex align-items-center">
                                                    <div class="st-avatar-xs mr-2" style="background: rgba(0, 113, 227, 0.1); color: var(--ios-blue); border-radius: 50%; width: 26px; height: 26px; display: inline-flex; align-items: center; justify-content: center; font-weight: 700; font-size: 0.7rem;" aria-hidden="true">
                                                        RS
                                                    </div>
                                                    <span style="color: var(--ios-text-primary);">Rahul Sharma</span>
                                                </div>
                                            </td>
                                            <td style="vertical-align: middle;"><span class="ios-badge ios-badge-gray" style="font-size: 0.72rem; padding: 0.2rem 0.45rem;">CSE</span></td>
                                            <td style="vertical-align: middle; font-weight: 600; color: #334155;">8.85</td>
                                            <td style="vertical-align: middle;"><span class="font-weight-bold text-success">92 / 100</span></td>
                                            <td class="text-right py-2 px-3" style="vertical-align: middle;">
                                                <span class="ios-badge ios-badge-green font-weight-bold" style="font-size: 0.75rem; padding: 0.25rem 0.6rem;">Ready</span>
                                            </td>
                                        </tr>
                                        <tr style="border-bottom: 1px solid #f8fafc;">
                                            <td class="text-left font-weight-bold py-2 px-3" style="vertical-align: middle;">
                                                <div class="d-flex align-items-center">
                                                    <div class="st-avatar-xs mr-2" style="background: rgba(175, 82, 222, 0.1); color: var(--ios-purple); border-radius: 50%; width: 26px; height: 26px; display: inline-flex; align-items: center; justify-content: center; font-weight: 700; font-size: 0.7rem;" aria-hidden="true">
                                                        PP
                                                    </div>
                                                    <span style="color: var(--ios-text-primary);">Priya Patel</span>
                                                </div>
                                            </td>
                                            <td style="vertical-align: middle;"><span class="ios-badge ios-badge-gray" style="font-size: 0.72rem; padding: 0.2rem 0.45rem;">IT</span></td>
                                            <td style="vertical-align: middle; font-weight: 600; color: #334155;">8.40</td>
                                            <td style="vertical-align: middle;"><span class="font-weight-bold text-success">84 / 100</span></td>
                                            <td class="text-right py-2 px-3" style="vertical-align: middle;">
                                                <span class="ios-badge ios-badge-green font-weight-bold" style="font-size: 0.75rem; padding: 0.25rem 0.6rem;">Ready</span>
                                            </td>
                                        </tr>
                                        <tr style="border-bottom: 1px solid #f8fafc;">
                                            <td class="text-left font-weight-bold py-2 px-3" style="vertical-align: middle;">
                                                <div class="d-flex align-items-center">
                                                    <div class="st-avatar-xs mr-2" style="background: rgba(52, 199, 89, 0.12); color: var(--ios-green-dark); border-radius: 50%; width: 26px; height: 26px; display: inline-flex; align-items: center; justify-content: center; font-weight: 700; font-size: 0.7rem;" aria-hidden="true">
                                                        SG
                                                    </div>
                                                    <span style="color: var(--ios-text-primary);">Sneha Gupta</span>
                                                </div>
                                            </td>
                                            <td style="vertical-align: middle;"><span class="ios-badge ios-badge-gray" style="font-size: 0.72rem; padding: 0.2rem 0.45rem;">AI &amp; DS</span></td>
                                            <td style="vertical-align: middle; font-weight: 600; color: #334155;">9.12</td>
                                            <td style="vertical-align: middle;"><span class="font-weight-bold text-success">96 / 100</span></td>
                                            <td class="text-right py-2 px-3" style="vertical-align: middle;">
                                                <span class="ios-badge ios-badge-green font-weight-bold" style="font-size: 0.75rem; padding: 0.25rem 0.6rem;">Ready</span>
                                            </td>
                                        </tr>
                                        <tr style="border-bottom: 1px solid #f8fafc;">
                                            <td class="text-left font-weight-bold py-2 px-3" style="vertical-align: middle;">
                                                <div class="d-flex align-items-center">
                                                    <div class="st-avatar-xs mr-2" style="background: rgba(255, 149, 0, 0.1); color: var(--ios-orange); border-radius: 50%; width: 26px; height: 26px; display: inline-flex; align-items: center; justify-content: center; font-weight: 700; font-size: 0.7rem;" aria-hidden="true">
                                                        AK
                                                    </div>
                                                    <span style="color: var(--ios-text-primary);">Amit Kumar</span>
                                                </div>
                                            </td>
                                            <td style="vertical-align: middle;"><span class="ios-badge ios-badge-gray" style="font-size: 0.72rem; padding: 0.2rem 0.45rem;">ECE</span></td>
                                            <td style="vertical-align: middle; font-weight: 600; color: #334155;">7.60</td>
                                            <td style="vertical-align: middle;"><span class="font-weight-bold" style="color: #b45309;">68 / 100</span></td>
                                            <td class="text-right py-2 px-3" style="vertical-align: middle;">
                                                <span class="ios-badge ios-badge-orange font-weight-bold" style="font-size: 0.75rem; padding: 0.25rem 0.6rem;">In Progress</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="text-left font-weight-bold py-2 px-3" style="vertical-align: middle;">
                                                <div class="d-flex align-items-center">
                                                    <div class="st-avatar-xs mr-2" style="background: rgba(88, 86, 214, 0.1); color: var(--ios-indigo); border-radius: 50%; width: 26px; height: 26px; display: inline-flex; align-items: center; justify-content: center; font-weight: 700; font-size: 0.7rem;" aria-hidden="true">
                                                        RV
                                                    </div>
                                                    <span style="color: var(--ios-text-primary);">Rohan Verma</span>
                                                </div>
                                            </td>
                                            <td style="vertical-align: middle;"><span class="ios-badge ios-badge-gray" style="font-size: 0.72rem; padding: 0.2rem 0.45rem;">CSE</span></td>
                                            <td style="vertical-align: middle; font-weight: 600; color: #334155;">8.05</td>
                                            <td style="vertical-align: middle;"><span class="font-weight-bold text-success">78 / 100</span></td>
                                            <td class="text-right py-2 px-3" style="vertical-align: middle;">
                                                <span class="ios-badge ios-badge-green font-weight-bold" style="font-size: 0.75rem; padding: 0.25rem 0.6rem;">Ready</span>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>

                            <!-- Bottom Card Summary Toolbar -->
                            <div class="d-flex flex-wrap justify-content-between align-items-center mt-3 pt-2">
                                <div class="small text-muted font-weight-semibold">
                                    <span>Showing <strong>5 of 142</strong> eligible candidates</span>
                                </div>
                                <div class="d-flex align-items-center gap-2">
                                    <span class="ios-badge ios-badge-green font-weight-bold" style="font-size: 0.72rem;">
                                        94% Placement Ready
                                    </span>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- 6. FREQUENTLY ASKED QUESTIONS (FAQ) -->
        <section class="py-5 bg-white border-top border-bottom" id="faq">
            <div class="container py-5">
                <div class="text-center mb-5">
                    <span class="ios-badge ios-badge-blue px-3 py-1 mb-2">Got Questions?</span>
                    <h2 class="ios-section-title font-weight-bold" style="color: var(--ios-text-primary);">
                        Frequently Asked Questions
                    </h2>
                    <p class="text-muted" style="max-width: 650px; margin: auto; font-size: 1.1rem;">
                        Everything you need to know about SkillTrack algorithms and workflows.
                    </p>
                </div>

                <div class="row justify-content-center">
                    <div class="col-lg-8">
                        <div class="accordion" id="faqAccordion">
                            <!-- FAQ 1 -->
                            <div class="ios-accordion-item">
                                <button class="ios-accordion-btn collapsed" type="button" data-toggle="collapse" data-target="#faqCollapse1" aria-expanded="false" aria-controls="faqCollapse1">
                                    <span>How is the 100-Point Placement Readiness Score calculated?</span>
                                    <span class="ios-accordion-icon-circle">
                                        <svg class="ios-chevron" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                                            <polyline points="6 9 12 15 18 9"></polyline>
                                        </svg>
                                    </span>
                                </button>
                                <div id="faqCollapse1" class="collapse" data-parent="#faqAccordion">
                                    <div class="ios-accordion-body">
                                        SkillTrack uses a weighted deterministic algorithm designed by industry hiring leads:
                                        <ul class="mb-0 mt-2 pl-3">
                                            <li class="mb-1"><strong>Target Role Skill Match (40% weight):</strong> Verified proficiency across core, secondary, and tooling requirements.</li>
                                            <li class="mb-1"><strong>DSA Milestones (25% weight):</strong> Structured problem-solving across Easy, Medium, and Hard algorithmic topics.</li>
                                            <li class="mb-1"><strong>Verified Projects & Certifications (20% weight):</strong> GitHub-hosted full stack / specialized engineering applications.</li>
                                            <li><strong>Academic CGPA & Cutoff Eligibility (15% weight):</strong> College standing and zero active backlogs compliance.</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>

                            <!-- FAQ 2 -->
                            <div class="ios-accordion-item">
                                <button class="ios-accordion-btn collapsed" type="button" data-toggle="collapse" data-target="#faqCollapse2" aria-expanded="false" aria-controls="faqCollapse2">
                                    <span>Can I change my target industry career role later?</span>
                                    <span class="ios-accordion-icon-circle">
                                        <svg class="ios-chevron" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                                            <polyline points="6 9 12 15 18 9"></polyline>
                                        </svg>
                                    </span>
                                </button>
                                <div id="faqCollapse2" class="collapse" data-parent="#faqAccordion">
                                    <div class="ios-accordion-body">
                                        Yes. You can switch your primary target career role (e.g. from <em>Full Stack Developer</em> to <em>Cloud DevOps Engineer</em> or <em>Data Engineer</em>) at any time from your Academic Profile. SkillTrack will instantly recalibrate your Skill Gap radar, missing skills list, and readiness percentage in real time.
                                    </div>
                                </div>
                            </div>

                            <!-- FAQ 3 -->
                            <div class="ios-accordion-item">
                                <button class="ios-accordion-btn collapsed" type="button" data-toggle="collapse" data-target="#faqCollapse3" aria-expanded="false" aria-controls="faqCollapse3">
                                    <span>How does the DSA Milestone Tracker evaluate my progress?</span>
                                    <span class="ios-accordion-icon-circle">
                                        <svg class="ios-chevron" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                                            <polyline points="6 9 12 15 18 9"></polyline>
                                        </svg>
                                    </span>
                                </button>
                                <div id="faqCollapse3" class="collapse" data-parent="#faqAccordion">
                                    <div class="ios-accordion-body">
                                        Unlike raw problem counters, SkillTrack tracks structured milestones categorized by data structures (Arrays, Linked Lists, Binary Trees, Graphs, Dynamic Programming). This guarantees well-rounded algorithmic competence rather than repetitive easy question grinding.
                                    </div>
                                </div>
                            </div>

                            <!-- FAQ 4 -->
                            <div class="ios-accordion-item">
                                <button class="ios-accordion-btn collapsed" type="button" data-toggle="collapse" data-target="#faqCollapse4" aria-expanded="false" aria-controls="faqCollapse4">
                                    <span>Can I download or print my official Readiness Profile Card?</span>
                                    <span class="ios-accordion-icon-circle">
                                        <svg class="ios-chevron" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                                            <polyline points="6 9 12 15 18 9"></polyline>
                                        </svg>
                                    </span>
                                </button>
                                <div id="faqCollapse4" class="collapse" data-parent="#faqAccordion">
                                    <div class="ios-accordion-body">
                                        Yes. SkillTrack includes a specialized vector print-engine stylesheet that renders your entire profile into an official, single-page verified readiness card with verifiable metrics, skill badges, and readiness status for recruiters and campus placement drives.
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- 7. APPLE LIQUID GLASS CTA BANNER -->
        <section class="py-5" style="background: var(--ios-bg-base);">
            <div class="container py-5">
                <div class="ios-dark-glass-banner">
                    <div class="d-inline-flex align-items-center px-3 py-1 mb-4 rounded-pill" style="background: rgba(255, 255, 255, 0.12); border: 1px solid rgba(255, 255, 255, 0.2); font-size: 0.8rem; font-weight: 600; color: #ffffff;">
                        <span class="mr-2" style="width: 6px; height: 6px; border-radius: 50%; background: #34c759; display: inline-block;"></span>
                        Placement Readiness Platform
                    </div>
                    
                    <h2 class="ios-section-title font-weight-bold mb-3 text-white">
                        Ready to Take Control of Your Career Readiness?
                    </h2>
                    
                    <p class="lead text-white-50 mb-4 mx-auto" style="max-width: 620px; font-size: 1.15rem; line-height: 1.6;">
                        Join engineering and IT students actively bridging skill gaps, tracking DSA milestones, and securing top tier corporate offers.
                    </p>
                    
                    <div class="d-flex flex-column flex-sm-row justify-content-center align-items-center gap-3">
                        <a href="${pageContext.request.contextPath}/register" class="ios-btn-primary mr-sm-3 mb-3 mb-sm-0" style="background: #ffffff; color: #111827 !important; padding: 0.95rem 2.25rem; font-size: 1rem; box-shadow: 0 10px 25px rgba(0, 0, 0, 0.25);">
                            Create Student Account &rarr;
                        </a>
                        <a href="${pageContext.request.contextPath}/login" class="ios-btn-secondary" style="background: rgba(255, 255, 255, 0.1); color: #ffffff !important; border-color: rgba(255, 255, 255, 0.25); padding: 0.95rem 2.25rem; font-size: 1rem;">
                            Sign In to Portal
                        </a>
                    </div>
                </div>
            </div>
        </section>

        <!-- 8. APPLE MINIMALIST MULTI-COLUMN FOOTER -->
        <footer class="ios-footer">
            <div class="container">
                <div class="row mb-5 text-center text-lg-left">
                    <!-- Brand Column -->
                    <div class="col-lg-4 mb-4 mb-lg-0">
                        <a class="ios-brand d-inline-flex mb-3 justify-content-center justify-content-lg-start" href="${pageContext.request.contextPath}/">
                            <span class="ios-brand-icon">
                                <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M12 2L2 7l10 5 10-5-10-5z"></path>
                                    <path d="M2 17l10 5 10-5"></path>
                                    <path d="M2 12l10 5 10-5"></path>
                                </svg>
                            </span>
                            <span class="ml-2 font-weight-bold" style="color: var(--ios-text-primary);">SkillTrack</span>
                        </a>
                        <p class="text-muted small pr-lg-4 mb-3 mx-auto ml-lg-0" style="line-height: 1.6; max-width: 420px;">
                            Student Skill Benchmarking, DSA Milestone Tracker & Placement Readiness Management Platform.
                        </p>
                        <div class="d-flex justify-content-center justify-content-lg-start">
                            <span class="ios-badge ios-badge-gray">
                                Designed for Engineering & Tech Universities
                            </span>
                        </div>
                    </div>

                    <!-- Column 2: Student Engines -->
                    <div class="col-6 col-lg-2 mb-4 mb-lg-0">
                        <div class="ios-footer-heading">Student Tools</div>
                        <a href="${pageContext.request.contextPath}/register" class="ios-footer-link">Skill Gap Radar</a>
                        <a href="${pageContext.request.contextPath}/register" class="ios-footer-link">DSA Milestones</a>
                        <a href="${pageContext.request.contextPath}/register" class="ios-footer-link">Project Portfolio</a>
                        <a href="${pageContext.request.contextPath}/register" class="ios-footer-link">Readiness Card</a>
                    </div>

                    <!-- Column 3: Placement TPO -->
                    <div class="col-6 col-lg-3 mb-4 mb-lg-0">
                        <div class="ios-footer-heading">Placement Cells</div>
                        <a href="${pageContext.request.contextPath}/login" class="ios-footer-link">Cohort Intelligence</a>
                        <a href="${pageContext.request.contextPath}/login" class="ios-footer-link">Company Criteria Rules</a>
                        <a href="${pageContext.request.contextPath}/login" class="ios-footer-link">Candidate PDF/Excel Export</a>
                        <a href="${pageContext.request.contextPath}/login" class="ios-footer-link">Security Audit Logs</a>
                    </div>

                    <!-- Column 4: Portals -->
                    <div class="col-12 col-lg-3">
                        <div class="ios-footer-heading">Quick Access</div>
                        <a href="${pageContext.request.contextPath}/register" class="ios-footer-link">Create Student Account</a>
                        <a href="${pageContext.request.contextPath}/login" class="ios-footer-link">Administrator Portal</a>
                        <a href="#faq" class="ios-footer-link">System Documentation</a>
                        <a href="#overview" class="ios-footer-link font-weight-bold" style="color: var(--ios-blue);">Back to Top ↑</a>
                    </div>
                </div>

                <!-- Bottom Copyright Bar -->
                <div class="border-top pt-4 d-flex flex-column flex-sm-row justify-content-center justify-content-sm-between align-items-center text-center text-sm-left small" style="color: #64748b; font-weight: 500; gap: 0.5rem;">
                    <div>
                        &copy; 2026 <strong style="color: var(--ios-text-primary); font-weight: 700;">SkillTrack</strong> — Placement Readiness Platform.
                    </div>
                    <div class="d-inline-flex align-items-center justify-content-center">
                        <span class="mr-1">Developed by</span>&nbsp;
                        <a href="https://www.linkedin.com/in/maazpathan/" target="_blank" rel="noopener noreferrer" class="st-dev-link" style="text-decoration: none;">
                            <span>Maaz Pathan</span>
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" class="ml-1" style="vertical-align: middle;">
                                <line x1="7" y1="17" x2="17" y2="7"></line>
                                <polyline points="7 7 17 7 17 17"></polyline>
                            </svg>
                        </a>
                    </div>
                </div>
            </div>
        </footer>

        <!-- Scripts -->
        <script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/app-validation.js?v=4.7"></script>

        <!-- Apple iOS 18 Dynamic ScrollSpy & Smooth Section Navigation -->
        <script>
        (function() {
            var sectionIds = ['overview', 'comparison', 'features', 'roadmap', 'tpo-portal', 'faq'];
            var sections = [];
            sectionIds.forEach(function(id) {
                var el = document.getElementById(id);
                if (el) sections.push({ id: id, el: el });
            });

            var capsuleLinks = document.querySelectorAll('.ios-capsule-nav .ios-capsule-link');
            var mobileLinks = document.querySelectorAll('#iosMobileDrawer .ios-mobile-link');

            function updateActiveNav(activeId) {
                if (!activeId) return;
                capsuleLinks.forEach(function(link) {
                    var href = link.getAttribute('href');
                    if (href === '#' + activeId) {
                        link.classList.add('active');
                    } else {
                        link.classList.remove('active');
                    }
                });

                mobileLinks.forEach(function(link) {
                    var href = link.getAttribute('href');
                    if (href === '#' + activeId) {
                        link.classList.add('active');
                    } else {
                        link.classList.remove('active');
                    }
                });
            }

            var isManualScrolling = false;
            var manualScrollTimeout = null;

            function handleScrollSpy() {
                if (isManualScrolling) return;

                var scrollY = window.pageYOffset || document.documentElement.scrollTop;
                var windowHeight = window.innerHeight;
                var docHeight = document.documentElement.scrollHeight;

                // Check bottom of page -> highlight last item (FAQ)
                if ((scrollY + windowHeight) >= (docHeight - 90)) {
                    if (sections.length > 0) {
                        updateActiveNav(sections[sections.length - 1].id);
                        return;
                    }
                }

                var headerOffset = 130;
                var currentId = sectionIds[0];

                for (var i = 0; i < sections.length; i++) {
                    var sectionTop = sections[i].el.getBoundingClientRect().top + scrollY - headerOffset;
                    var sectionHeight = sections[i].el.offsetHeight;

                    if (scrollY >= sectionTop && scrollY < (sectionTop + sectionHeight)) {
                        currentId = sections[i].id;
                        break;
                    } else if (scrollY >= sectionTop) {
                        currentId = sections[i].id;
                    }
                }

                updateActiveNav(currentId);
            }

            window.addEventListener('scroll', handleScrollSpy, { passive: true });
            window.addEventListener('resize', handleScrollSpy, { passive: true });
            handleScrollSpy();

            // Smooth click handler with navbar offset (including capsule dropdown items)
            document.querySelectorAll('.ios-capsule-nav a[href^="#"], .ios-capsule-dropdown-item[href^="#"], #iosMobileDrawer a[href^="#"]').forEach(function(anchor) {
                anchor.addEventListener('click', function(e) {
                    var href = this.getAttribute('href');
                    if (!href || href === '#' || href === 'javascript:void(0)') return;
                    var targetId = href.replace('#', '');
                    var targetEl = document.getElementById(targetId);
                    if (targetEl) {
                        e.preventDefault();
                        isManualScrolling = true;
                        updateActiveNav(targetId);

                        var headerOffset = 78;
                        var targetPosition = targetEl.getBoundingClientRect().top + window.pageYOffset - headerOffset;

                        window.scrollTo({
                            top: targetPosition,
                            behavior: 'smooth'
                        });

                        // Auto close open dropdowns
                        $('.dropdown.show').removeClass('show').find('.dropdown-menu').removeClass('show');

                        if (manualScrollTimeout) clearTimeout(manualScrollTimeout);
                        manualScrollTimeout = setTimeout(function() {
                            isManualScrolling = false;
                            handleScrollSpy();
                        }, 700);

                        // Close mobile drawer if open
                        var drawer = document.getElementById('iosMobileDrawer');
                        if (drawer && drawer.classList.contains('is-open')) {
                            drawer.classList.remove('is-open');
                        }
                    }
                });
            });
        })();
        </script>

        <!-- Interactive Hero Terminal & Role Switcher Demo Script -->
        <script>
        function switchTerminalTab(tabKey) {
            var tabBtnReadiness = document.getElementById('tabBtnReadiness');
            var tabBtnLeetcode = document.getElementById('tabBtnLeetcode');
            var tabBtnAts = document.getElementById('tabBtnAts');

            var tabContentReadiness = document.getElementById('terminalTabReadiness');
            var tabContentLeetcode = document.getElementById('terminalTabLeetcode');
            var tabContentAts = document.getElementById('terminalTabAts');

            [tabBtnReadiness, tabBtnLeetcode, tabBtnAts].forEach(function(b) {
                if (b) b.classList.remove('active');
            });
            [tabContentReadiness, tabContentLeetcode, tabContentAts].forEach(function(c) {
                if (c) c.classList.add('d-none');
            });

            if (tabKey === 'readiness') {
                if (tabBtnReadiness) tabBtnReadiness.classList.add('active');
                if (tabContentReadiness) tabContentReadiness.classList.remove('d-none');
            } else if (tabKey === 'leetcode') {
                if (tabBtnLeetcode) tabBtnLeetcode.classList.add('active');
                if (tabContentLeetcode) tabContentLeetcode.classList.remove('d-none');
            } else if (tabKey === 'ats') {
                if (tabBtnAts) tabBtnAts.classList.add('active');
                if (tabContentAts) tabContentAts.classList.remove('d-none');
            }
        }

        function switchPreviewRole(roleKey) {
            var title = document.getElementById('previewRoleTitle');
            var score = document.getElementById('previewScoreText');
            var bar = document.getElementById('previewProgressBar');
            var dsa = document.getElementById('previewDsaCount');
            var skills = document.getElementById('previewSkillCount');
            var chips = document.getElementById('previewSkillChips');

            var btn1 = document.getElementById('btnRole1');
            var btn2 = document.getElementById('btnRole2');
            var btn3 = document.getElementById('btnRole3');

            [btn1, btn2, btn3].forEach(function(b) {
                if (b) {
                    b.style.background = "transparent";
                    b.style.border = "none";
                    b.style.color = "#64748b";
                }
            });

            if (roleKey === 'fullstack') {
                if (btn1) {
                    btn1.style.background = "#f1f5f9";
                    btn1.style.border = "1px solid #e2e8f0";
                    btn1.style.color = "#0f172a";
                }
                if (title) title.textContent = "Full Stack Engineer";
                if (score) score.textContent = "88 / 100";
                if (bar) {
                    bar.style.width = "88%";
                    bar.style.background = "#10b981";
                }
                if (dsa) dsa.textContent = "156";
                if (skills) skills.textContent = "9 / 10";
                if (chips) {
                    chips.innerHTML = '<span class="ios-badge ios-badge-green mr-1 mb-1" style="font-size: 0.72rem;">Java Core</span>' +
                                      '<span class="ios-badge ios-badge-green mr-1 mb-1" style="font-size: 0.72rem;">Spring Boot</span>' +
                                      '<span class="ios-badge ios-badge-green mr-1 mb-1" style="font-size: 0.72rem;">React.js</span>' +
                                      '<span class="ios-badge ios-badge-orange mr-1 mb-1" style="font-size: 0.72rem;">Docker (Interm)</span>';
                }
            } else if (roleKey === 'data') {
                if (btn2) {
                    btn2.style.background = "#f1f5f9";
                    btn2.style.border = "1px solid #e2e8f0";
                    btn2.style.color = "#0f172a";
                }
                if (title) title.textContent = "Data Engineer";
                if (score) score.textContent = "76 / 100";
                if (bar) {
                    bar.style.width = "76%";
                    bar.style.background = "#0071e3";
                }
                if (dsa) dsa.textContent = "118";
                if (skills) skills.textContent = "7 / 9";
                if (chips) {
                    chips.innerHTML = '<span class="ios-badge ios-badge-green mr-1 mb-1" style="font-size: 0.72rem;">Python 3</span>' +
                                      '<span class="ios-badge ios-badge-green mr-1 mb-1" style="font-size: 0.72rem;">SQL / MySQL</span>' +
                                      '<span class="ios-badge ios-badge-orange mr-1 mb-1" style="font-size: 0.72rem;">Apache Spark</span>' +
                                      '<span class="ios-badge ios-badge-red mr-1 mb-1" style="font-size: 0.72rem;">Kafka (Missing)</span>';
                }
            } else if (roleKey === 'cloud') {
                if (btn3) {
                    btn3.style.background = "#f1f5f9";
                    btn3.style.border = "1px solid #e2e8f0";
                    btn3.style.color = "#0f172a";
                }
                if (title) title.textContent = "Cloud DevOps Architect";
                if (score) score.textContent = "64 / 100";
                if (bar) {
                    bar.style.width = "64%";
                    bar.style.background = "#f59e0b";
                }
                if (dsa) dsa.textContent = "94";
                if (skills) skills.textContent = "5 / 8";
                if (chips) {
                    chips.innerHTML = '<span class="ios-badge ios-badge-green mr-1 mb-1" style="font-size: 0.72rem;">Linux / Bash</span>' +
                                      '<span class="ios-badge ios-badge-green mr-1 mb-1" style="font-size: 0.72rem;">Docker Containers</span>' +
                                      '<span class="ios-badge ios-badge-red mr-1 mb-1" style="font-size: 0.72rem;">Kubernetes (Missing)</span>' +
                                      '<span class="ios-badge ios-badge-orange mr-1 mb-1" style="font-size: 0.72rem;">Terraform (Basic)</span>';
                }
            }
        }
        </script>
    </body>
    </html>
    </c:otherwise>
</c:choose>
