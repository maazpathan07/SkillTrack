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

            <!-- Apple Floating Capsule Pill Navigation Menu (Desktop: Clean Horizontal Links) -->
            <nav class="d-none d-lg-flex align-items-center ios-capsule-nav">
                <a href="#overview" class="ios-capsule-link active">Overview</a>
                <a href="#comparison" class="ios-capsule-link">Why SkillTrack</a>
                <a href="#features" class="ios-capsule-link">Capabilities</a>
                <a href="#roadmap" class="ios-capsule-link">Roadmap</a>
                <a href="#tpo-portal" class="ios-capsule-link">Placement Cells</a>
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
                    <a href="#comparison" class="ios-mobile-link">
                        <span>Why SkillTrack</span>
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="9 18 15 12 9 6"></polyline></svg>
                    </a>
                    <a href="#features" class="ios-mobile-link">
                        <span>Capabilities</span>
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="9 18 15 12 9 6"></polyline></svg>
                    </a>
                    <a href="#roadmap" class="ios-mobile-link">
                        <span>Roadmap</span>
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="9 18 15 12 9 6"></polyline></svg>
                    </a>
                    <a href="#tpo-portal" class="ios-mobile-link">
                        <span>Placement Cells</span>
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
                    <h2 class="ios-section-title font-weight-bold" style="color: #0f172a; letter-spacing: -0.025em;">
                        The Placement Paradigm Shift: Data Over Guesswork
                    </h2>
                    <p class="text-muted" style="max-width: 680px; margin: auto; font-size: 1.05rem; line-height: 1.6;">
                        Most engineering students prepare blindly without knowing corporate tech cutoffs or ATS standards. SkillTrack transforms campus preparation with deterministic data intelligence.
                    </p>
                </div>

                <div class="row">
                    <!-- Left: Traditional Campus Approach -->
                    <div class="col-lg-6 mb-4">
                        <div class="h-100 p-4" style="background: linear-gradient(180deg, rgba(254, 242, 242, 0.7) 0%, rgba(255, 255, 255, 0.95) 100%); border: 1.5px solid rgba(254, 202, 202, 0.8); border-radius: 20px; box-shadow: 0 10px 30px -5px rgba(239, 68, 68, 0.07); backdrop-filter: blur(20px);">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <span class="ios-badge ios-badge-red" style="font-size: 0.75rem; padding: 0.3rem 0.75rem;">Traditional Campus Approach</span>
                                <span class="small font-weight-bold text-danger" style="font-size: 0.75rem;">High Screening Risk ✕</span>
                            </div>
                            
                            <h3 class="font-weight-bold mb-4" style="font-size: 1.35rem; letter-spacing: -0.02em; color: #0f172a;">
                                Why 85% of Students Face Placement Rejection
                            </h3>

                            <!-- Point 1: Blind Skill Prep -->
                            <div class="d-flex align-items-start mb-3.5 p-3 rounded-lg" style="background: rgba(255, 255, 255, 0.8); border: 1px solid rgba(254, 226, 226, 0.9); border-radius: 14px;">
                                <div class="ios-circle-icon ios-circle-red mr-3 flex-shrink-0" style="width: 36px; height: 36px; border-radius: 10px;">
                                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                                        <circle cx="12" cy="12" r="10"></circle>
                                        <line x1="12" y1="8" x2="12" y2="12"></line>
                                        <line x1="12" y1="16" x2="12.01" y2="16"></line>
                                    </svg>
                                </div>
                                <div>
                                    <div class="d-flex align-items-center justify-content-between mb-1">
                                        <h6 class="font-weight-bold mb-0" style="color: #0f172a; font-size: 0.925rem;">Blind Tech Stack Grinding</h6>
                                        <span class="ios-badge ios-badge-red" style="font-size: 0.65rem;">No Role Context</span>
                                    </div>
                                    <p class="text-muted small mb-0" style="line-height: 1.45;">Studying generic theory without knowing specific framework competencies (Java 17, Spring Boot, React, Docker) demanded by Tier-1 hiring teams.</p>
                                </div>
                            </div>

                            <!-- Point 2: Unstructured DSA -->
                            <div class="d-flex align-items-start mb-3.5 p-3 rounded-lg" style="background: rgba(255, 255, 255, 0.8); border: 1px solid rgba(254, 226, 226, 0.9); border-radius: 14px;">
                                <div class="ios-circle-icon ios-circle-red mr-3 flex-shrink-0" style="width: 36px; height: 36px; border-radius: 10px;">
                                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                                        <polyline points="16 18 22 12 16 6"></polyline>
                                        <polyline points="8 6 2 12 8 18"></polyline>
                                    </svg>
                                </div>
                                <div>
                                    <div class="d-flex align-items-center justify-content-between mb-1">
                                        <h6 class="font-weight-bold mb-0" style="color: #0f172a; font-size: 0.925rem;">Easy Question Trap &amp; Topic Imbalance</h6>
                                        <span class="ios-badge ios-badge-red" style="font-size: 0.65rem;">Random Practice</span>
                                    </div>
                                    <p class="text-muted small mb-0" style="line-height: 1.45;">Grinding 100+ random easy array questions while skipping essential Trees, Graphs, Dynamic Programming, and System Design patterns.</p>
                                </div>
                            </div>

                            <!-- Point 3: Low ATS Resume Pass Rate -->
                            <div class="d-flex align-items-start mb-3.5 p-3 rounded-lg" style="background: rgba(255, 255, 255, 0.8); border: 1px solid rgba(254, 226, 226, 0.9); border-radius: 14px;">
                                <div class="ios-circle-icon ios-circle-red mr-3 flex-shrink-0" style="width: 36px; height: 36px; border-radius: 10px;">
                                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                                        <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
                                        <line x1="9" y1="15" x2="15" y2="15"></line>
                                    </svg>
                                </div>
                                <div>
                                    <div class="d-flex align-items-center justify-content-between mb-1">
                                        <h6 class="font-weight-bold mb-0" style="color: #0f172a; font-size: 0.925rem;">Silent ATS Resume Rejection</h6>
                                        <span class="ios-badge ios-badge-red" style="font-size: 0.65rem;">&lt; 30% Pass Rate</span>
                                    </div>
                                    <p class="text-muted small mb-0" style="line-height: 1.45;">Using messy multi-column graphic resumes that fail automated corporate ATS parsers due to missing keywords and metrics.</p>
                                </div>
                            </div>

                            <!-- Point 4: Unverifiable Project Claims -->
                            <div class="d-flex align-items-start p-3 rounded-lg" style="background: rgba(255, 255, 255, 0.8); border: 1px solid rgba(254, 226, 226, 0.9); border-radius: 14px;">
                                <div class="ios-circle-icon ios-circle-red mr-3 flex-shrink-0" style="width: 36px; height: 36px; border-radius: 10px;">
                                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                                        <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path>
                                        <line x1="8" y1="12" x2="16" y2="12"></line>
                                    </svg>
                                </div>
                                <div>
                                    <div class="d-flex align-items-center justify-content-between mb-1">
                                        <h6 class="font-weight-bold mb-0" style="color: #0f172a; font-size: 0.925rem;">Unverifiable Project Portfolios</h6>
                                        <span class="ios-badge ios-badge-red" style="font-size: 0.65rem;">No Live Proof</span>
                                    </div>
                                    <p class="text-muted small mb-0" style="line-height: 1.45;">Submitting resume bullet points without active GitHub repositories, live cloud deployments, or authenticated skill audits.</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Right: SkillTrack Solution -->
                    <div class="col-lg-6 mb-4">
                        <div class="h-100 p-4" style="background: linear-gradient(180deg, rgba(240, 253, 244, 0.7) 0%, rgba(255, 255, 255, 0.95) 100%); border: 1.5px solid rgba(187, 247, 208, 0.9); border-radius: 20px; box-shadow: 0 10px 30px -5px rgba(16, 185, 129, 0.08); backdrop-filter: blur(20px);">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <span class="ios-badge ios-badge-green" style="font-size: 0.75rem; padding: 0.3rem 0.75rem;">SkillTrack Precision Engine</span>
                                <span class="small font-weight-bold text-success" style="font-size: 0.75rem;">94% Placement Success ✓</span>
                            </div>
                            
                            <h3 class="font-weight-bold mb-4" style="font-size: 1.35rem; letter-spacing: -0.02em; color: #0f172a;">
                                Guaranteed Readiness with 4-Tier Placement Intelligence
                            </h3>

                            <!-- Point 1: Role Gap Radar -->
                            <div class="d-flex align-items-start mb-3.5 p-3 rounded-lg" style="background: rgba(255, 255, 255, 0.85); border: 1px solid rgba(220, 252, 231, 0.9); border-radius: 14px;">
                                <div class="ios-circle-icon ios-circle-green mr-3 flex-shrink-0" style="width: 36px; height: 36px; border-radius: 10px;">
                                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                                        <circle cx="12" cy="12" r="10"></circle>
                                        <circle cx="12" cy="12" r="6"></circle>
                                        <circle cx="12" cy="12" r="2"></circle>
                                    </svg>
                                </div>
                                <div>
                                    <div class="d-flex align-items-center justify-content-between mb-1">
                                        <h6 class="font-weight-bold mb-0" style="color: #0f172a; font-size: 0.925rem;">Target-Role Skill Gap Radar</h6>
                                        <span class="ios-badge ios-badge-green" style="font-size: 0.65rem;">Tier-1 Benchmarks</span>
                                    </div>
                                    <p class="text-muted small mb-0" style="line-height: 1.45;">Instant visual status indicators reveal exact missing proficiencies benchmarked against live Amazon, Google, TCS, and Infosys standards.</p>
                                </div>
                            </div>

                            <!-- Point 2: DSA Tracker -->
                            <div class="d-flex align-items-start mb-3.5 p-3 rounded-lg" style="background: rgba(255, 255, 255, 0.85); border: 1px solid rgba(220, 252, 231, 0.9); border-radius: 14px;">
                                <div class="ios-circle-icon ios-circle-green mr-3 flex-shrink-0" style="width: 36px; height: 36px; border-radius: 10px;">
                                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                                        <polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"></polygon>
                                    </svg>
                                </div>
                                <div>
                                    <div class="d-flex align-items-center justify-content-between mb-1">
                                        <h6 class="font-weight-bold mb-0" style="color: #0f172a; font-size: 0.925rem;">LeetCode Sync &amp; 18-Topic Matrix</h6>
                                        <span class="ios-badge ios-badge-green" style="font-size: 0.65rem;">Automated API</span>
                                    </div>
                                    <p class="text-muted small mb-0" style="line-height: 1.45;">Direct real-time API sync from LeetCode with automated difficulty allocation and in-browser code sandbox execution.</p>
                                </div>
                            </div>

                            <!-- Point 3: Scorecard & ATS -->
                            <div class="d-flex align-items-start mb-3.5 p-3 rounded-lg" style="background: rgba(255, 255, 255, 0.85); border: 1px solid rgba(220, 252, 231, 0.9); border-radius: 14px;">
                                <div class="ios-circle-icon ios-circle-green mr-3 flex-shrink-0" style="width: 36px; height: 36px; border-radius: 10px;">
                                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                                        <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
                                        <polyline points="14 2 14 8 20 8"></polyline>
                                        <polyline points="10 9 9 9 8 9"></polyline>
                                    </svg>
                                </div>
                                <div>
                                    <div class="d-flex align-items-center justify-content-between mb-1">
                                        <h6 class="font-weight-bold mb-0" style="color: #0f172a; font-size: 0.925rem;">Ivy-League ATS Resume Engine</h6>
                                        <span class="ios-badge ios-badge-green" style="font-size: 0.65rem;">95%+ ATS Score</span>
                                    </div>
                                    <p class="text-muted small mb-0" style="line-height: 1.45;">Single-column standard Ivy-League A4 PDF resume generator with real-time keyword match diagnostics and action-verb scoring.</p>
                                </div>
                            </div>

                            <!-- Point 4: Placement Passport -->
                            <div class="d-flex align-items-start p-3 rounded-lg" style="background: rgba(255, 255, 255, 0.85); border: 1px solid rgba(220, 252, 231, 0.9); border-radius: 14px;">
                                <div class="ios-circle-icon ios-circle-green mr-3 flex-shrink-0" style="width: 36px; height: 36px; border-radius: 10px;">
                                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                                        <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path>
                                        <polyline points="9 12 11 14 15 10"></polyline>
                                    </svg>
                                </div>
                                <div>
                                    <div class="d-flex align-items-center justify-content-between mb-1">
                                        <h6 class="font-weight-bold mb-0" style="color: #0f172a; font-size: 0.925rem;">Verified Placement Passport &amp; QR</h6>
                                        <span class="ios-badge ios-badge-green" style="font-size: 0.65rem;">Tamper-Proof URL</span>
                                    </div>
                                    <p class="text-muted small mb-0" style="line-height: 1.45;">Public verifiable link (<code style="color: #059669;">/passport/{hash}</code>) backed by university seals, authenticated GitHub repositories, and live code proofs.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- 3. FOUR CORE PLACEMENT ENGINES (APPLE GLASS CARDS) -->
        <section class="py-5" id="features" style="background: var(--ios-bg-base);">
            <div class="container py-5">
                <div class="text-center mb-5">
                    <span class="ios-badge ios-badge-blue px-3 py-1 mb-2">Core Capabilities</span>
                    <h2 class="ios-section-title font-weight-bold" style="color: #0f172a; letter-spacing: -0.025em;">
                        Four Modular Placement Intelligence Engines
                    </h2>
                    <p class="text-muted" style="max-width: 680px; margin: auto; font-size: 1.05rem; line-height: 1.6;">
                        Built on deterministic data models to benchmark skills, track algorithmic mastery, and guide you directly to top-tier campus offers.
                    </p>
                </div>

                <div class="row">
                    <!-- Engine Card 1: LeetCode Auto-Sync & 18-Topic DSA Matrix -->
                    <div class="col-lg-6 mb-4">
                        <div class="ios-feature-card h-100" style="background: rgba(255, 255, 255, 0.95); backdrop-filter: blur(20px); border: 1px solid rgba(226, 232, 240, 0.9); border-radius: 18px; padding: 1.75rem; box-shadow: 0 4px 20px -2px rgba(0, 0, 0, 0.04);">
                            <div class="d-flex align-items-center mb-3">
                                <div class="ios-icon-box mr-3 flex-shrink-0" style="width: 48px; height: 48px; border-radius: 14px; background: linear-gradient(135deg, #fffbeb, #fef3c7); border: 1.5px solid rgba(245, 158, 11, 0.35); display: flex; align-items: center; justify-content: center; box-shadow: 0 4px 12px rgba(245, 158, 11, 0.18);">
                                    <svg width="24" height="24" viewBox="0 0 24 24" fill="#FFA116">
                                        <path d="M13.483 0a1.374 1.374 0 0 0-.961.438L7.116 6.226l-3.854 4.126a5.266 5.266 0 0 0-1.209 2.104 5.35 5.35 0 0 0-.125.513 5.527 5.527 0 0 0 .062 2.362 5.83 5.83 0 0 0 .349 1.017 5.938 5.938 0 0 0 1.271 1.818l4.277 4.193.039.038c2.248 2.165 5.852 2.133 8.063-.074l2.396-2.392c.54-.54.54-1.414.003-1.955a1.378 1.378 0 0 0-1.951-.003l-2.396 2.392a3.021 3.021 0 0 1-4.205.038l-.02-.019-4.276-4.193c-.652-.64-.972-1.469-.948-2.263a2.68 2.68 0 0 1 .666-1.607L9.4 7.64l4.083-4.371A1.38 1.38 0 0 0 13.483 0zm-2.88 7.218a1.38 1.38 0 0 0-.979.405l-4.54 4.54a1.38 1.38 0 0 0 0 1.952l4.54 4.54a1.38 1.38 0 0 0 1.952-1.952L7.962 13.11l3.614-3.614a1.38 1.38 0 0 0-.973-2.278z"/>
                                    </svg>
                                </div>
                                <div>
                                    <h5 class="font-weight-bold mb-0" style="color: #0f172a; font-size: 1.1rem; line-height: 1.3;">LeetCode Auto-Sync &amp; 18-Topic DSA Matrix</h5>
                                    <small class="text-muted" style="font-size: 0.775rem;">Real-time API Sync &bull; Automated Allocation</small>
                                </div>
                            </div>
                            <p class="text-muted small mb-3" style="line-height: 1.5;">
                                Auto-sync problem counts (Easy, Medium, Hard breakdown) directly from your LeetCode profile. Progress is automatically mapped across 18 core algorithmic topics without manual entry.
                            </p>

                            <!-- Glass LeetCode Live Container -->
                            <div class="p-3 rounded-lg border" style="background: rgba(248, 250, 252, 0.95); border-radius: 14px;">
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <div class="d-flex align-items-center gap-1.5">
                                        <span class="font-weight-bold text-dark small">LeetCode Benchmark:</span>
                                        <span class="ios-badge ios-badge-green" style="font-size: 0.7rem;">156 / 150 Solved (104%)</span>
                                    </div>
                                    <span class="ios-badge ios-badge-blue" style="font-size: 0.7rem;">18 Core Topics</span>
                                </div>

                                <div class="row text-center no-gutters mb-2" style="gap: 5px;">
                                    <div class="col p-1.5 rounded border bg-white">
                                        <div class="font-weight-bold text-success" style="font-size: 0.95rem;">84</div>
                                        <small class="text-muted font-weight-bold" style="font-size: 0.65rem;">🟢 Easy</small>
                                    </div>
                                    <div class="col p-1.5 rounded border bg-white">
                                        <div class="font-weight-bold text-warning" style="font-size: 0.95rem;">52</div>
                                        <small class="text-muted font-weight-bold" style="font-size: 0.65rem;">🟡 Medium</small>
                                    </div>
                                    <div class="col p-1.5 rounded border bg-white">
                                        <div class="font-weight-bold text-danger" style="font-size: 0.95rem;">20</div>
                                        <small class="text-muted font-weight-bold" style="font-size: 0.65rem;">🔴 Hard</small>
                                    </div>
                                </div>

                                <div class="d-flex flex-wrap gap-1">
                                    <span class="ios-badge ios-badge-gray mr-1 mb-1" style="font-size: 0.68rem;">Arrays &amp; Strings</span>
                                    <span class="ios-badge ios-badge-gray mr-1 mb-1" style="font-size: 0.68rem;">Two Pointers</span>
                                    <span class="ios-badge ios-badge-gray mr-1 mb-1" style="font-size: 0.68rem;">Binary Search</span>
                                    <span class="ios-badge ios-badge-gray mr-1 mb-1" style="font-size: 0.68rem;">Dynamic Programming</span>
                                    <span class="ios-badge ios-badge-gray mb-1" style="font-size: 0.68rem;">+14 More</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Engine Card 2: ATS Placement Resume & Keyword Scanner -->
                    <div class="col-lg-6 mb-4">
                        <div class="ios-feature-card h-100" style="background: rgba(255, 255, 255, 0.95); backdrop-filter: blur(20px); border: 1px solid rgba(226, 232, 240, 0.9); border-radius: 18px; padding: 1.75rem; box-shadow: 0 4px 20px -2px rgba(0, 0, 0, 0.04);">
                            <div class="d-flex align-items-center mb-3">
                                <div class="ios-icon-box mr-3 flex-shrink-0" style="width: 48px; height: 48px; border-radius: 14px; background: rgba(16, 185, 129, 0.1); border: 1.5px solid rgba(16, 185, 129, 0.3); display: flex; align-items: center; justify-content: center; box-shadow: 0 4px 12px rgba(16, 185, 129, 0.18);">
                                    <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#059669" stroke-width="2.2">
                                        <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
                                        <polyline points="14 2 14 8 20 8"></polyline>
                                        <line x1="16" y1="13" x2="8" y2="13"></line>
                                        <line x1="16" y1="17" x2="8" y2="17"></line>
                                        <polyline points="10 9 9 9 8 9"></polyline>
                                    </svg>
                                </div>
                                <div>
                                    <h5 class="font-weight-bold mb-0" style="color: #0f172a; font-size: 1.1rem; line-height: 1.3;">ATS Resume &amp; Diagnostic Engine</h5>
                                    <small class="text-muted" style="font-size: 0.775rem;">Ivy-League A4 Layout &bull; 0-100% Keyword Score</small>
                                </div>
                            </div>
                            <p class="text-muted small mb-3" style="line-height: 1.5;">
                                Audit your placement resume against enterprise applicant tracking systems (ATS). Optimize action verbs, quantified bullet points, and export Ivy-League standard 1-page A4 PDF resumes.
                            </p>

                            <!-- Enhanced ATS Diagnostic Container -->
                            <div class="p-3 rounded-lg border" style="background: rgba(248, 250, 252, 0.95); border-radius: 14px;">
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <span class="small font-weight-bold text-dark">ATS Keyword Match Diagnostic</span>
                                    <span class="font-weight-bold text-success" style="font-size: 0.9rem;">94 / 100 &bull; Grade A+</span>
                                </div>
                                
                                <div class="d-flex justify-content-between small font-weight-bold mb-1">
                                    <span class="text-muted">Target Role Skill Keywords</span>
                                    <span class="text-success">95% Matched</span>
                                </div>
                                <div class="progress mb-2" style="height: 5px; border-radius: 3px; background: #e2e8f0;">
                                    <div class="progress-bar bg-success" style="width: 95%;"></div>
                                </div>

                                <div class="d-flex justify-content-between small font-weight-bold mb-1">
                                    <span class="text-muted">Impact Action Verbs &amp; Metrics</span>
                                    <span style="color: #0071e3;">88% Optimized</span>
                                </div>
                                <div class="progress mb-2" style="height: 5px; border-radius: 3px; background: #e2e8f0;">
                                    <div class="progress-bar" style="width: 88%; background: #0071e3;"></div>
                                </div>

                                <div class="d-flex justify-content-between align-items-center pt-1 border-top" style="font-size: 0.725rem;">
                                    <span class="text-muted">📄 Single-Column Ivy-League A4 Format</span>
                                    <span class="text-success font-weight-bold">100% Compliant ✓</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Engine Card 3: Dream Job Matcher & Skill Gap Radar -->
                    <div class="col-lg-6 mb-4">
                        <div class="ios-feature-card h-100" style="background: rgba(255, 255, 255, 0.95); backdrop-filter: blur(20px); border: 1px solid rgba(226, 232, 240, 0.9); border-radius: 18px; padding: 1.75rem; box-shadow: 0 4px 20px -2px rgba(0, 0, 0, 0.04);">
                            <div class="d-flex align-items-center mb-3">
                                <div class="ios-icon-box mr-3 flex-shrink-0" style="width: 48px; height: 48px; border-radius: 14px; background: rgba(0, 113, 227, 0.1); border: 1.5px solid rgba(0, 113, 227, 0.3); display: flex; align-items: center; justify-content: center; box-shadow: 0 4px 12px rgba(0, 113, 227, 0.18);">
                                    <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#0071e3" stroke-width="2.2">
                                        <circle cx="12" cy="12" r="10"></circle>
                                        <circle cx="12" cy="12" r="6"></circle>
                                        <circle cx="12" cy="12" r="2"></circle>
                                    </svg>
                                </div>
                                <div>
                                    <h5 class="font-weight-bold mb-0" style="color: #0f172a; font-size: 1.1rem; line-height: 1.3;">Dream Job Matcher &amp; Gap Radar</h5>
                                    <small class="text-muted" style="font-size: 0.775rem;">Company Standards &bull; Dynamic Competency Radar</small>
                                </div>
                            </div>
                            <p class="text-muted small mb-3" style="line-height: 1.5;">
                                Benchmark your readiness against Tier-1 company cutoffs (Google, Amazon, Microsoft, TCS, Infosys). Uncover required technical competencies, DSA goals, and missing skill levels.
                            </p>

                            <!-- Enhanced Company Matching Box -->
                            <div class="p-3 rounded-lg border" style="background: rgba(248, 250, 252, 0.95); border-radius: 14px;">
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <span class="small font-weight-bold text-dark">Target Role: Full Stack Developer</span>
                                    <span class="ios-badge ios-badge-green" style="font-size: 0.7rem;">Ready (88%)</span>
                                </div>

                                <div class="p-2 mb-2 rounded bg-white border d-flex justify-content-between align-items-center">
                                    <div>
                                        <div class="font-weight-bold text-dark" style="font-size: 0.8rem;">Tier-1 Product Tech Preset (Amazon / SDE-1)</div>
                                        <small class="text-muted" style="font-size: 0.68rem;">Min CGPA: 7.5 &bull; DSA: 150+ &bull; Projects: 2+ Full Stack</small>
                                    </div>
                                    <span class="ios-badge ios-badge-green font-weight-bold" style="font-size: 0.72rem;">Eligible ✓</span>
                                </div>

                                <div class="d-flex flex-wrap gap-1 pt-1">
                                    <span class="ios-badge ios-badge-green mr-1 mb-1" style="font-size: 0.68rem;">Java / Spring Boot (Advanced)</span>
                                    <span class="ios-badge ios-badge-green mr-1 mb-1" style="font-size: 0.68rem;">React.js (Proficient)</span>
                                    <span class="ios-badge ios-badge-orange mr-1 mb-1" style="font-size: 0.68rem;">Docker (Level Up)</span>
                                    <span class="ios-badge ios-badge-red mb-1" style="font-size: 0.68rem;">System Design (Prep)</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Engine Card 4: Public Verified Placement Passport & QR Engine -->
                    <div class="col-lg-6 mb-4">
                        <div class="ios-feature-card h-100" style="background: rgba(255, 255, 255, 0.95); backdrop-filter: blur(20px); border: 1px solid rgba(226, 232, 240, 0.9); border-radius: 18px; padding: 1.75rem; box-shadow: 0 4px 20px -2px rgba(0, 0, 0, 0.04);">
                            <div class="d-flex align-items-center mb-3">
                                <div class="ios-icon-box mr-3 flex-shrink-0" style="width: 48px; height: 48px; border-radius: 14px; background: rgba(139, 92, 246, 0.1); border: 1.5px solid rgba(139, 92, 246, 0.3); display: flex; align-items: center; justify-content: center; box-shadow: 0 4px 12px rgba(139, 92, 246, 0.18);">
                                    <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#7c3aed" stroke-width="2.2">
                                        <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path>
                                        <polyline points="9 12 11 14 15 10"></polyline>
                                    </svg>
                                </div>
                                <div>
                                    <h5 class="font-weight-bold mb-0" style="color: #0f172a; font-size: 1.1rem; line-height: 1.3;">Verified Placement Passport &amp; QR</h5>
                                    <small class="text-muted" style="font-size: 0.775rem;">Tamper-Proof Credential &bull; 1-Click Verification</small>
                                </div>
                            </div>
                            <p class="text-muted small mb-3" style="line-height: 1.5;">
                                Share an official public placement profile (<code style="color: #7c3aed;">/passport/{hash}</code>) with verified GitHub repositories, live deployments, LeetCode ratings, and university seal.
                            </p>

                            <!-- Enhanced Passport Preview Box -->
                            <div class="p-3 rounded-lg border" style="background: rgba(248, 250, 252, 0.95); border-radius: 14px;">
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <div class="d-flex align-items-center gap-2">
                                        <div class="st-avatar-xs" style="width: 28px; height: 28px; border-radius: 50%; background: linear-gradient(135deg, #0071e3, #5856d6); color: #ffffff; display: flex; align-items: center; justify-content: center; font-weight: 700; font-size: 0.75rem;">
                                            MP
                                        </div>
                                        <div>
                                            <div class="font-weight-bold text-dark small">Maaz Pathan</div>
                                            <small class="text-muted" style="font-size: 0.65rem;">B.Tech CSE &bull; CGPA 8.85</small>
                                        </div>
                                    </div>
                                    <span class="ios-badge ios-badge-purple font-weight-bold" style="font-size: 0.68rem;">Verified Passport ✓</span>
                                </div>

                                <div class="p-2 mb-2 rounded bg-white border d-flex justify-content-between align-items-center" style="font-size: 0.75rem;">
                                    <div class="d-flex align-items-center gap-1.5">
                                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#10b981" stroke-width="2.5"><polyline points="20 6 9 17 4 12"></polyline></svg>
                                        <span>4 GitHub Repos &bull; Live Deployments</span>
                                    </div>
                                    <span class="badge badge-success px-2 py-0.5" style="font-size: 0.65rem;">Active</span>
                                </div>

                                <div class="d-flex justify-content-between align-items-center pt-1 border-top" style="font-size: 0.725rem;">
                                    <span class="text-muted">🔗 Shareable Verification URL</span>
                                    <span class="font-weight-bold" style="color: #7c3aed;">skilltrack.edu/passport/a9f1...</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- 4. IN-BROWSER LIVE CODE PLAYGROUND SHOWCASE -->
        <section class="py-5 bg-white border-top border-bottom" id="playground">
            <div class="container py-4">
                <div class="row align-items-center">
                    <div class="col-lg-5 mb-5 mb-lg-0">
                        <span class="ios-badge ios-badge-blue px-3 py-1 mb-2">Algorithmic Sandbox</span>
                        <h2 class="ios-section-title font-weight-bold mb-3" style="color: #0f172a; letter-spacing: -0.025em;">
                            Code, Test &amp; Benchmark Directly In Your Browser
                        </h2>
                        <p class="text-muted mb-4" style="font-size: 1.05rem; line-height: 1.6;">
                            Zero setup required. Compile, execute, and verify algorithms against test cases across <strong>7+ programming languages</strong> with microsecond profiling.
                        </p>

                        <div class="d-flex align-items-start mb-3">
                            <div class="ios-circle-icon mr-3 flex-shrink-0" style="width: 40px; height: 40px; border-radius: 12px; display: flex; align-items: center; justify-content: center; background: rgba(0, 113, 227, 0.1); color: #0071e3;">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><polyline points="16 18 22 12 16 6"></polyline><polyline points="8 6 2 12 8 18"></polyline></svg>
                            </div>
                            <div>
                                <h6 class="font-weight-bold mb-1" style="color: #0f172a; font-size: 0.95rem;">Multi-Language Runtime Engine</h6>
                                <p class="text-muted small mb-0">Native execution support for Java 17, Python 3, C++17, JavaScript (Node.js), Go, C, and Rust.</p>
                            </div>
                        </div>

                        <div class="d-flex align-items-start mb-3">
                            <div class="ios-circle-icon mr-3 flex-shrink-0" style="width: 40px; height: 40px; border-radius: 12px; display: flex; align-items: center; justify-content: center; background: rgba(16, 185, 129, 0.1); color: #059669;">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"></polygon></svg>
                            </div>
                            <div>
                                <h6 class="font-weight-bold mb-1" style="color: #0f172a; font-size: 0.95rem;">Curated Algorithm Presets</h6>
                                <p class="text-muted small mb-0">Instant access to interview classics: Two Sum, Binary Search, LRU Cache, Fast-Slow Pointers, and Dynamic Programming.</p>
                            </div>
                        </div>

                        <div class="d-flex align-items-start mb-4">
                            <div class="ios-circle-icon mr-3 flex-shrink-0" style="width: 40px; height: 40px; border-radius: 12px; display: flex; align-items: center; justify-content: center; background: rgba(139, 92, 246, 0.1); color: #7c3aed;">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg>
                            </div>
                            <div>
                                <h6 class="font-weight-bold mb-1" style="color: #0f172a; font-size: 0.95rem;">Automated DSA Sync &amp; Profiling</h6>
                                <p class="text-muted small mb-0">Solved problem counts automatically update your topic progress matrix and boost placement readiness.</p>
                            </div>
                        </div>

                        <a href="${pageContext.request.contextPath}/register" class="ios-btn-primary" style="padding: 0.75rem 1.75rem; font-size: 0.9rem;">
                            Try Code Playground &rarr;
                        </a>
                    </div>

                    <!-- Right Column: Live Monaco-style Code Sandbox Preview Frame -->
                    <div class="col-lg-7">
                        <div class="p-0 border shadow-lg" style="background: #1e1e1e; border-radius: 18px; overflow: hidden; border: 1px solid #334155;">
                            <!-- Dark Window Top Bar -->
                            <div class="d-flex justify-content-between align-items-center px-4 py-2.5" style="background: #2d3748; border-bottom: 1px solid #4a5568;">
                                <div class="d-flex align-items-center">
                                    <div class="d-flex align-items-center mr-3" style="gap: 6px;">
                                        <span style="width: 10px; height: 10px; border-radius: 50%; background: #ff5f56; display: inline-block;"></span>
                                        <span style="width: 10px; height: 10px; border-radius: 50%; background: #ffbd2e; display: inline-block;"></span>
                                        <span style="width: 10px; height: 10px; border-radius: 50%; background: #27c93f; display: inline-block;"></span>
                                    </div>
                                    <span class="text-white-50 font-weight-bold small" style="font-family: monospace;">Solution.java &bull; TwoSum_Optimal</span>
                                </div>
                                <div class="d-flex align-items-center gap-2">
                                    <span class="badge badge-primary px-2 py-1" style="font-size: 0.7rem; font-weight: 600;">Java 17 OpenJDK</span>
                                </div>
                            </div>

                            <!-- Code Editor Area -->
                            <div class="p-4" style="background: #1a202c; font-family: 'SFMono-Regular', Consolas, 'Liberation Mono', Menlo, monospace; font-size: 0.85rem; line-height: 1.6; color: #e2e8f0;">
                                <div style="color: #68d391;">// Optimal Hash-Map Strategy: Time O(N) | Space O(N)</div>
                                <div><span style="color: #e53e3e;">class</span> <span style="color: #f6e05e;">Solution</span> {</div>
                                <div class="pl-3"><span style="color: #e53e3e;">public int</span>[] <span style="color: #63b3ed;">twoSum</span>(<span style="color: #e53e3e;">int</span>[] nums, <span style="color: #e53e3e;">int</span> target) {</div>
                                <div class="pl-4">Map&lt;Integer, Integer&gt; map = <span style="color: #e53e3e;">new</span> HashMap&lt;&gt;();</div>
                                <div class="pl-4"><span style="color: #e53e3e;">for</span> (<span style="color: #e53e3e;">int</span> i = 0; i &lt; nums.length; i++) {</div>
                                <div class="pl-5"><span style="color: #e53e3e;">int</span> complement = target - nums[i];</div>
                                <div class="pl-5"><span style="color: #e53e3e;">if</span> (map.containsKey(complement)) {</div>
                                <div class="pl-5" style="padding-left: 2rem !important;"><span style="color: #e53e3e;">return new int</span>[] { map.get(complement), i };</div>
                                <div class="pl-5">}</div>
                                <div class="pl-5">map.put(nums[i], i);</div>
                                <div class="pl-4">}</div>
                                <div class="pl-4"><span style="color: #e53e3e;">return new int</span>[] {};</div>
                                <div class="pl-3">}</div>
                                <div>}</div>
                            </div>

                            <!-- Terminal Output Console -->
                            <div class="px-4 py-3" style="background: #111827; border-top: 1px solid #374151;">
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <div class="d-flex align-items-center gap-2">
                                        <span class="badge badge-success px-2 py-1 font-weight-bold" style="font-size: 0.72rem;">✓ PASSED (3/3 Test Cases)</span>
                                        <span class="text-white-50 small" style="font-size: 0.75rem;">Runtime: <strong>42 ms</strong> (Beats 94.2%)</span>
                                    </div>
                                    <span class="text-white-50 small" style="font-size: 0.75rem;">Memory: <strong>41.8 MB</strong></span>
                                </div>
                                <div class="p-2 rounded" style="background: #1f2937; font-family: monospace; font-size: 0.775rem; color: #a7f3d0;">
                                    <span>&gt; TestCase 1: nums=[2,7,11,15], target=9 &rarr; Output: [0, 1] ✓</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- 5. 24/7 AI PLACEMENT COACH SHOWCASE -->
        <section class="py-5" id="ai-coach" style="background: var(--ios-bg-base);">
            <div class="container py-5">
                <div class="row align-items-center">
                    <!-- Left Column: Interactive Glass AI Chat Demo Widget -->
                    <div class="col-lg-6 mb-5 mb-lg-0 order-2 order-lg-1">
                        <div class="ios-glass-card p-4" style="background: rgba(255, 255, 255, 0.95); backdrop-filter: blur(24px); border: 1px solid rgba(226, 232, 240, 0.95); box-shadow: 0 20px 50px -10px rgba(0, 0, 0, 0.1), 0 0 0 1px rgba(0, 0, 0, 0.04); border-radius: 20px;">
                            <!-- AI Chat Header -->
                            <div class="d-flex justify-content-between align-items-center pb-3 mb-3 border-bottom" style="border-color: #f1f5f9 !important;">
                                <div class="d-flex align-items-center">
                                    <div class="st-avatar-xs mr-2.5" style="width: 34px; height: 34px; border-radius: 10px; background: linear-gradient(135deg, #3b82f6, #6366f1); color: #ffffff; display: flex; align-items: center; justify-content: center; box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);">
                                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M12 2a2 2 0 0 1 2 2v2a2 2 0 0 1-2 2 2 2 0 0 1-2-2V4a2 2 0 0 1 2-2z"></path><rect x="4" y="8" width="16" height="12" rx="2"></rect><circle cx="9" cy="14" r="1"></circle><circle cx="15" cy="14" r="1"></circle></svg>
                                    </div>
                                    <div>
                                        <h6 class="font-weight-bold mb-0" style="color: #0f172a; font-size: 0.95rem;">SkillTrack AI Placement Coach</h6>
                                        <small class="text-success font-weight-bold" style="font-size: 0.72rem;">● Active &bull; SDE Placement Specialist</small>
                                    </div>
                                </div>
                                <span class="ios-badge ios-badge-blue" style="font-size: 0.7rem;">AI Powered</span>
                            </div>

                            <!-- Student Query Message -->
                            <div class="d-flex justify-content-end mb-3">
                                <div class="p-3 rounded-lg text-white" style="background: #0071e3; border-radius: 16px 16px 4px 16px; max-width: 85%; font-size: 0.85rem; line-height: 1.5; box-shadow: 0 4px 12px rgba(0, 113, 227, 0.2);">
                                    How do I explain Two-Pointer approach vs Hash-Map in Amazon SDE-1 interview?
                                </div>
                            </div>

                            <!-- AI Coach Response -->
                            <div class="d-flex justify-content-start mb-3">
                                <div class="p-3 rounded-lg" style="background: #f1f5f9; border-radius: 16px 16px 16px 4px; max-width: 90%; font-size: 0.85rem; line-height: 1.55; color: #1e293b; border: 1px solid #e2e8f0;">
                                    <div class="font-weight-bold mb-1" style="color: #0071e3; font-size: 0.8rem;">💡 Key Interview Distinction:</div>
                                    <ul class="pl-3 mb-2" style="font-size: 0.825rem;">
                                        <li class="mb-1"><strong>Two-Pointer:</strong> Requires a sorted array. Achieves <code>O(N)</code> time and <code>O(1)</code> space (Optimal for memory).</li>
                                        <li><strong>Hash-Map:</strong> Works on unsorted arrays in single pass. Achieves <code>O(N)</code> time and <code>O(N)</code> extra space.</li>
                                    </ul>
                                    <span class="small text-muted font-weight-bold">Amazon Interview Tip: Always state the Space-Time trade-off first before writing code!</span>
                                </div>
                            </div>

                            <!-- Quick Action Chips -->
                            <div class="d-flex flex-wrap gap-1.5 pt-2 border-top" style="border-color: #f1f5f9 !important;">
                                <span class="ios-badge ios-badge-blue mr-1" style="font-size: 0.72rem;">🧪 Open in Playground</span>
                                <span class="ios-badge ios-badge-green mr-1" style="font-size: 0.72rem;">📈 Add to DSA Tracker</span>
                                <span class="ios-badge ios-badge-purple" style="font-size: 0.72rem;">🎯 Amazon Mock Questions</span>
                            </div>
                        </div>
                    </div>

                    <!-- Right Column: AI Mentorship Description -->
                    <div class="col-lg-6 order-1 order-lg-2 mb-4 mb-lg-0">
                        <span class="ios-badge ios-badge-blue px-3 py-1 mb-2">24/7 Placement Mentorship</span>
                        <h2 class="ios-section-title font-weight-bold mb-3" style="color: #0f172a; letter-spacing: -0.025em;">
                            Your Personal AI Coach &amp; Algorithmic Architect
                        </h2>
                        <p class="text-muted mb-4" style="font-size: 1.05rem; line-height: 1.6;">
                            Never get stuck on hard algorithmic problems or complex system design interviews. SkillTrack's AI Placement Coach provides instant personalized guidance at every step of your preparation.
                        </p>

                        <!-- Feature Point 1 -->
                        <div class="d-flex align-items-start mb-3">
                            <div class="ios-circle-icon mr-3 flex-shrink-0" style="width: 40px; height: 40px; border-radius: 12px; display: flex; align-items: center; justify-content: center; background: rgba(0, 113, 227, 0.1); color: #0071e3;">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"></polygon></svg>
                            </div>
                            <div>
                                <h6 class="font-weight-bold mb-1" style="color: #0f172a; font-size: 0.95rem;">Step-by-Step Hints (No Spoilers)</h6>
                                <p class="text-muted small mb-0">Receive progressive hints and edge case checklists to develop algorithmic problem-solving intuition.</p>
                            </div>
                        </div>

                        <!-- Feature Point 2 -->
                        <div class="d-flex align-items-start mb-3">
                            <div class="ios-circle-icon mr-3 flex-shrink-0" style="width: 40px; height: 40px; border-radius: 12px; display: flex; align-items: center; justify-content: center; background: rgba(16, 185, 129, 0.1); color: #059669;">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path><polyline points="14 2 14 8 20 8"></polyline></svg>
                            </div>
                            <div>
                                <h6 class="font-weight-bold mb-1" style="color: #0f172a; font-size: 0.95rem;">Company-Tailored Mock Questions</h6>
                                <p class="text-muted small mb-0">Simulate actual hiring rounds for Google, Amazon, Microsoft, and startups with role-specific question sets.</p>
                            </div>
                        </div>

                        <!-- Feature Point 3 -->
                        <div class="d-flex align-items-start mb-4">
                            <div class="ios-circle-icon mr-3 flex-shrink-0" style="width: 40px; height: 40px; border-radius: 12px; display: flex; align-items: center; justify-content: center; background: rgba(139, 92, 246, 0.1); color: #7c3aed;">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg>
                            </div>
                            <div>
                                <h6 class="font-weight-bold mb-1" style="color: #0f172a; font-size: 0.95rem;">Draggable Smart Floating Assistant</h6>
                                <p class="text-muted small mb-0">Accessible across all student portal pages with persistent drag positioning so it never covers your content.</p>
                            </div>
                        </div>

                        <a href="${pageContext.request.contextPath}/register" class="ios-btn-primary" style="padding: 0.75rem 1.75rem; font-size: 0.9rem;">
                            Get Started with AI Coach &rarr;
                        </a>
                    </div>
                </div>
            </div>
        </section>

        <!-- 6. STEP-BY-STEP STUDENT ROADMAP -->
        <section class="py-5 bg-white border-top border-bottom" id="roadmap">
            <div class="container py-5">
                <div class="text-center mb-5">
                    <span class="ios-badge ios-badge-blue px-3 py-1 mb-2">4-Step Action Plan</span>
                    <h2 class="ios-section-title font-weight-bold" style="color: #0f172a; letter-spacing: -0.025em;">
                        Your Structured Roadmap to Campus Placement
                    </h2>
                    <p class="text-muted" style="max-width: 680px; margin: auto; font-size: 1.05rem; line-height: 1.6;">
                        From initial registration to walking out with top-tier corporate job offers.
                    </p>
                </div>

                <div class="row">
                    <!-- Step 1 -->
                    <div class="col-lg-3 col-md-6 mb-4">
                        <div class="ios-feature-card text-center h-100 p-4" style="background: rgba(248, 250, 252, 0.9); border: 1px solid rgba(226, 232, 240, 0.9); border-radius: 18px; box-shadow: 0 4px 15px rgba(0, 0, 0, 0.03);">
                            <div class="d-inline-flex align-items-center justify-content-center mb-3" style="width: 48px; height: 48px; border-radius: 14px; background: rgba(0, 113, 227, 0.1); color: #0071e3; border: 1.5px solid rgba(0, 113, 227, 0.25);">
                                <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                                    <circle cx="12" cy="7" r="4"></circle>
                                </svg>
                            </div>
                            <div class="mb-2">
                                <span class="ios-badge ios-badge-blue font-weight-bold" style="font-size: 0.7rem; padding: 0.25rem 0.6rem;">STEP 01</span>
                            </div>
                            <h5 class="font-weight-bold mb-2" style="color: #0f172a; font-size: 1.05rem;">Connect Profile &amp; LeetCode</h5>
                            <p class="text-muted small mb-3" style="line-height: 1.5;">Sign up with your college email, department (CSE/IT/ECE), CGPA, and link your LeetCode handle for live API sync.</p>
                            <span class="ios-badge ios-badge-gray" style="font-size: 0.68rem;">1-Click Auto-Sync</span>
                        </div>
                    </div>

                    <!-- Step 2 -->
                    <div class="col-lg-3 col-md-6 mb-4">
                        <div class="ios-feature-card text-center h-100 p-4" style="background: rgba(248, 250, 252, 0.9); border: 1px solid rgba(226, 232, 240, 0.9); border-radius: 18px; box-shadow: 0 4px 15px rgba(0, 0, 0, 0.03);">
                            <div class="d-inline-flex align-items-center justify-content-center mb-3" style="width: 48px; height: 48px; border-radius: 14px; background: rgba(139, 92, 246, 0.1); color: #7c3aed; border: 1.5px solid rgba(139, 92, 246, 0.25);">
                                <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                                    <circle cx="12" cy="12" r="10"></circle>
                                    <polygon points="16.24 7.76 14.12 14.12 7.76 16.24 9.88 9.88 16.24 7.76"></polygon>
                                </svg>
                            </div>
                            <div class="mb-2">
                                <span class="ios-badge ios-badge-purple font-weight-bold" style="font-size: 0.7rem; padding: 0.25rem 0.6rem;">STEP 02</span>
                            </div>
                            <h5 class="font-weight-bold mb-2" style="color: #0f172a; font-size: 1.05rem;">Choose Industry Role</h5>
                            <p class="text-muted small mb-3" style="line-height: 1.5;">Pick your target career track (Full Stack, Cloud, Data) to immediately render your Skill Gap Radar and company cutoffs.</p>
                            <span class="ios-badge ios-badge-gray" style="font-size: 0.68rem;">Dynamic Gap Radar</span>
                        </div>
                    </div>

                    <!-- Step 3 -->
                    <div class="col-lg-3 col-md-6 mb-4">
                        <div class="ios-feature-card text-center h-100 p-4" style="background: rgba(248, 250, 252, 0.9); border: 1px solid rgba(226, 232, 240, 0.9); border-radius: 18px; box-shadow: 0 4px 15px rgba(0, 0, 0, 0.03);">
                            <div class="d-inline-flex align-items-center justify-content-center mb-3" style="width: 48px; height: 48px; border-radius: 14px; background: rgba(245, 158, 11, 0.1); color: #d97706; border: 1.5px solid rgba(245, 158, 11, 0.25);">
                                <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                                    <polyline points="16 18 22 12 16 6"></polyline>
                                    <polyline points="8 6 2 12 8 18"></polyline>
                                </svg>
                            </div>
                            <div class="mb-2">
                                <span class="ios-badge ios-badge-orange font-weight-bold" style="font-size: 0.7rem; padding: 0.25rem 0.6rem;">STEP 03</span>
                            </div>
                            <h5 class="font-weight-bold mb-2" style="color: #0f172a; font-size: 1.05rem;">Master Skills &amp; ATS Resume</h5>
                            <p class="text-muted small mb-3" style="line-height: 1.5;">Code in the live sandbox, complete 18 DSA topics, and generate an Ivy-League A4 ATS resume with 95%+ match score.</p>
                            <span class="ios-badge ios-badge-gray" style="font-size: 0.68rem;">Ivy-League A4 Format</span>
                        </div>
                    </div>

                    <!-- Step 4 -->
                    <div class="col-lg-3 col-md-6 mb-4">
                        <div class="ios-feature-card text-center h-100 p-4" style="background: rgba(248, 250, 252, 0.9); border: 1px solid rgba(226, 232, 240, 0.9); border-radius: 18px; box-shadow: 0 4px 15px rgba(0, 0, 0, 0.03);">
                            <div class="d-inline-flex align-items-center justify-content-center mb-3" style="width: 48px; height: 48px; border-radius: 14px; background: rgba(16, 185, 129, 0.1); color: #059669; border: 1.5px solid rgba(16, 185, 129, 0.25);">
                                <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path>
                                    <polyline points="9 12 11 14 15 10"></polyline>
                                </svg>
                            </div>
                            <div class="mb-2">
                                <span class="ios-badge ios-badge-green font-weight-bold" style="font-size: 0.7rem; padding: 0.25rem 0.6rem;">STEP 04</span>
                            </div>
                            <h5 class="font-weight-bold mb-2" style="color: #0f172a; font-size: 1.05rem;">Verified Passport &amp; Hired</h5>
                            <p class="text-muted small mb-3" style="line-height: 1.5;">Share your verified cryptographic Passport URL (<code style="color: #059669;">/passport/{hash}</code>), meet TPO drive cutoffs, and land campus offers.</p>
                            <span class="ios-badge ios-badge-gray" style="font-size: 0.68rem;">Tamper-Proof Credential</span>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- 5. TPO / PLACEMENT CELL ENTERPRISE SHOWCASE -->
        <section class="py-5" id="tpo-portal" style="background: var(--ios-bg-base);">
            <div class="container py-5">
                <div class="row align-items-center">
                    <!-- Left Column: TPO Enterprise Features -->
                    <div class="col-lg-6 mb-5 mb-lg-0">
                        <span class="ios-badge ios-badge-blue px-3 py-1 mb-2">Faculty &amp; TPO Console</span>
                        <h2 class="ios-section-title font-weight-bold mb-3" style="color: #0f172a; letter-spacing: -0.025em;">
                            Enterprise Intelligence for Placement Cells
                        </h2>
                        <p class="text-muted mb-4" style="font-size: 1.05rem; line-height: 1.6;">
                            Empower Training &amp; Placement Officers (TPOs) and department faculty with deterministic cohort filtering, dynamic drive criteria matching, and verified student audits in seconds.
                        </p>
                        
                        <!-- Feature 1: Drive Shortlisting Simulator -->
                        <div class="d-flex align-items-start mb-3.5 p-3 rounded-lg border" style="background: rgba(255, 255, 255, 0.85); backdrop-filter: blur(16px); border-radius: 16px; border-color: rgba(226, 232, 240, 0.9);">
                            <div class="ios-icon-box mr-3 flex-shrink-0" style="width: 44px; height: 44px; border-radius: 12px; background: rgba(0, 113, 227, 0.1); border: 1.5px solid rgba(0, 113, 227, 0.25); display: flex; align-items: center; justify-content: center; color: #0071e3;">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                                    <line x1="4" y1="21" x2="4" y2="14"></line><line x1="4" y1="10" x2="4" y2="3"></line>
                                    <line x1="12" y1="21" x2="12" y2="12"></line><line x1="12" y1="8" x2="12" y2="3"></line>
                                    <line x1="20" y1="21" x2="20" y2="16"></line><line x1="20" y1="12" x2="20" y2="3"></line>
                                    <line x1="1" y1="14" x2="7" y2="14"></line><line x1="9" y1="8" x2="15" y2="8"></line><line x1="17" y1="16" x2="23" y2="16"></line>
                                </svg>
                            </div>
                            <div>
                                <h6 class="font-weight-bold mb-1" style="color: #0f172a; font-size: 0.95rem;">Multi-Factor Drive Shortlisting Simulator</h6>
                                <p class="text-muted small mb-0" style="line-height: 1.5;">Instantly filter 1,000+ student batches by CGPA cutoffs, active backlog count, LeetCode solved counts, and mandatory technical competencies.</p>
                            </div>
                        </div>

                        <!-- Feature 2: Verified Academic & Project Proofs -->
                        <div class="d-flex align-items-start mb-3.5 p-3 rounded-lg border" style="background: rgba(255, 255, 255, 0.85); backdrop-filter: blur(16px); border-radius: 16px; border-color: rgba(226, 232, 240, 0.9);">
                            <div class="ios-icon-box mr-3 flex-shrink-0" style="width: 44px; height: 44px; border-radius: 12px; background: rgba(16, 185, 129, 0.1); border: 1.5px solid rgba(16, 185, 129, 0.25); display: flex; align-items: center; justify-content: center; color: #059669;">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path>
                                    <polyline points="9 12 11 14 15 10"></polyline>
                                </svg>
                            </div>
                            <div>
                                <h6 class="font-weight-bold mb-1" style="color: #0f172a; font-size: 0.95rem;">Cryptographically Verified Placement Passports</h6>
                                <p class="text-muted small mb-0" style="line-height: 1.5;">Audit real GitHub repositories, live deployment links, verified LeetCode stats, and ATS Ivy-League resumes with 1-click verification.</p>
                            </div>
                        </div>

                        <!-- Feature 3: Institutional Export -->
                        <div class="d-flex align-items-start mb-4 p-3 rounded-lg border" style="background: rgba(255, 255, 255, 0.85); backdrop-filter: blur(16px); border-radius: 16px; border-color: rgba(226, 232, 240, 0.9);">
                            <div class="ios-icon-box mr-3 flex-shrink-0" style="width: 44px; height: 44px; border-radius: 12px; background: rgba(139, 92, 246, 0.1); border: 1.5px solid rgba(139, 92, 246, 0.25); display: flex; align-items: center; justify-content: center; color: #7c3aed;">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path>
                                    <polyline points="7 10 12 15 17 10"></polyline>
                                    <line x1="12" y1="15" x2="12" y2="3"></line>
                                </svg>
                            </div>
                            <div>
                                <h6 class="font-weight-bold mb-1" style="color: #0f172a; font-size: 0.95rem;">1-Click Excel, CSV &amp; Vector PDF Rosters</h6>
                                <p class="text-muted small mb-0" style="line-height: 1.5;">Export company-specific candidate rosters, institutional placement analytics, and student readiness scorecards ready for corporate recruiters.</p>
                            </div>
                        </div>

                        <a href="${pageContext.request.contextPath}/login" class="ios-btn-primary" style="padding: 0.75rem 1.75rem; font-size: 0.9rem;">
                            Access Placement Console &rarr;
                        </a>
                    </div>

                    <!-- Right Column: Interactive TPO Live Drive Simulator Console -->
                    <div class="col-lg-6">
                        <div class="ios-glass-card p-4" style="background: rgba(255, 255, 255, 0.95); backdrop-filter: blur(24px); border: 1px solid rgba(226, 232, 240, 0.95); box-shadow: 0 20px 50px -10px rgba(0, 0, 0, 0.1), 0 0 0 1px rgba(0, 0, 0, 0.04); border-radius: 20px;">
                            <!-- Top macOS window bar -->
                            <div class="d-flex justify-content-between align-items-center mb-3 pb-3 border-bottom" style="border-color: #f1f5f9 !important;">
                                <div class="d-flex align-items-center">
                                    <div class="d-flex align-items-center mr-3" style="gap: 6px;">
                                        <span style="width: 10px; height: 10px; border-radius: 50%; background: #ff5f56; display: inline-block;"></span>
                                        <span style="width: 10px; height: 10px; border-radius: 50%; background: #ffbd2e; display: inline-block;"></span>
                                        <span style="width: 10px; height: 10px; border-radius: 50%; background: #27c93f; display: inline-block;"></span>
                                    </div>
                                    <div>
                                        <h6 class="font-weight-bold mb-0" style="color: #0f172a; font-size: 0.95rem;">TPO Drive Shortlisting Simulator</h6>
                                        <small class="text-muted" style="font-size: 0.72rem;">2026 Batch &bull; 142 Active Candidates</small>
                                    </div>
                                </div>
                                <span class="ios-badge ios-badge-blue" style="font-size: 0.7rem;">Interactive Demo</span>
                            </div>

                            <!-- Interactive Company Preset Filter Tabs -->
                            <div class="mb-3">
                                <label class="small text-muted font-weight-bold mb-1.5 d-block" style="font-size: 0.75rem; text-transform: uppercase; letter-spacing: 0.05em;">Select Company Hiring Preset:</label>
                                <div class="d-flex flex-wrap gap-1.5" style="gap: 6px;">
                                    <button type="button" id="tpoBtnTier1" onclick="switchTpoPreset('tier1')" class="btn btn-sm font-weight-bold" style="font-size: 0.75rem; border-radius: 8px; padding: 0.35rem 0.75rem; background: #0071e3; color: #ffffff; border: 1px solid #0071e3; transition: all 0.2s ease;">
                                        Amazon SDE (CGPA ≥ 8.5)
                                    </button>
                                    <button type="button" id="tpoBtnTcs" onclick="switchTpoPreset('tcs')" class="btn btn-sm font-weight-bold" style="font-size: 0.75rem; border-radius: 8px; padding: 0.35rem 0.75rem; background: #f1f5f9; color: #475569; border: 1px solid #e2e8f0; transition: all 0.2s ease;">
                                        TCS Digital (CGPA ≥ 7.5)
                                    </button>
                                    <button type="button" id="tpoBtnFintech" onclick="switchTpoPreset('fintech')" class="btn btn-sm font-weight-bold" style="font-size: 0.75rem; border-radius: 8px; padding: 0.35rem 0.75rem; background: #f1f5f9; color: #475569; border: 1px solid #e2e8f0; transition: all 0.2s ease;">
                                        Fintech (Java / DSA 150+)
                                    </button>
                                </div>
                            </div>

                            <!-- Live Candidate Roster Table -->
                            <div class="table-responsive" style="border-radius: 12px; overflow: hidden; border: 1px solid #e2e8f0;">
                                <table class="table table-hover mb-0 text-center" style="font-size: 0.825rem; border-collapse: separate;">
                                    <thead style="background: #f8fafc;">
                                        <tr style="border-bottom: 1px solid #e2e8f0;">
                                            <th class="text-left font-weight-bold small text-uppercase py-2 px-3" style="color: #475569;">Candidate</th>
                                            <th class="font-weight-bold small text-uppercase py-2" style="color: #475569;">Dept</th>
                                            <th class="font-weight-bold small text-uppercase py-2" style="color: #475569;">CGPA</th>
                                            <th class="font-weight-bold small text-uppercase py-2" style="color: #475569;">DSA</th>
                                            <th class="font-weight-bold small text-uppercase py-2 px-3 text-right" style="color: #475569;">Drive Status</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <!-- Candidate 1 -->
                                        <tr style="border-bottom: 1px solid #f1f5f9;">
                                            <td class="text-left font-weight-bold py-2 px-3" style="vertical-align: middle;">
                                                <div class="d-flex align-items-center">
                                                    <div class="st-avatar-xs mr-2" style="background: linear-gradient(135deg, #3b82f6, #6366f1); color: #fff; border-radius: 50%; width: 26px; height: 26px; display: inline-flex; align-items: center; justify-content: center; font-weight: 700; font-size: 0.7rem;">
                                                        RS
                                                    </div>
                                                    <span style="color: #0f172a;">Rahul Sharma</span>
                                                </div>
                                            </td>
                                            <td style="vertical-align: middle;"><span class="ios-badge ios-badge-gray" style="font-size: 0.7rem;">CSE</span></td>
                                            <td style="vertical-align: middle; font-weight: 600; color: #0f172a;">8.85</td>
                                            <td style="vertical-align: middle; font-weight: 600; color: #0071e3;">184</td>
                                            <td class="text-right py-2 px-3" style="vertical-align: middle;" id="tpoStatus1">
                                                <span class="ios-badge ios-badge-green font-weight-bold" style="font-size: 0.72rem;">Shortlisted ✓</span>
                                            </td>
                                        </tr>

                                        <!-- Candidate 2 -->
                                        <tr style="border-bottom: 1px solid #f1f5f9;">
                                            <td class="text-left font-weight-bold py-2 px-3" style="vertical-align: middle;">
                                                <div class="d-flex align-items-center">
                                                    <div class="st-avatar-xs mr-2" style="background: linear-gradient(135deg, #10b981, #059669); color: #fff; border-radius: 50%; width: 26px; height: 26px; display: inline-flex; align-items: center; justify-content: center; font-weight: 700; font-size: 0.7rem;">
                                                        SG
                                                    </div>
                                                    <span style="color: #0f172a;">Sneha Gupta</span>
                                                </div>
                                            </td>
                                            <td style="vertical-align: middle;"><span class="ios-badge ios-badge-gray" style="font-size: 0.7rem;">AI &amp; DS</span></td>
                                            <td style="vertical-align: middle; font-weight: 600; color: #0f172a;">9.12</td>
                                            <td style="vertical-align: middle; font-weight: 600; color: #0071e3;">210</td>
                                            <td class="text-right py-2 px-3" style="vertical-align: middle;" id="tpoStatus2">
                                                <span class="ios-badge ios-badge-green font-weight-bold" style="font-size: 0.72rem;">Top Pick ★</span>
                                            </td>
                                        </tr>

                                        <!-- Candidate 3 -->
                                        <tr style="border-bottom: 1px solid #f1f5f9;">
                                            <td class="text-left font-weight-bold py-2 px-3" style="vertical-align: middle;">
                                                <div class="d-flex align-items-center">
                                                    <div class="st-avatar-xs mr-2" style="background: linear-gradient(135deg, #8b5cf6, #7c3aed); color: #fff; border-radius: 50%; width: 26px; height: 26px; display: inline-flex; align-items: center; justify-content: center; font-weight: 700; font-size: 0.7rem;">
                                                        PP
                                                    </div>
                                                    <span style="color: #0f172a;">Priya Patel</span>
                                                </div>
                                            </td>
                                            <td style="vertical-align: middle;"><span class="ios-badge ios-badge-gray" style="font-size: 0.7rem;">IT</span></td>
                                            <td style="vertical-align: middle; font-weight: 600; color: #0f172a;">8.40</td>
                                            <td style="vertical-align: middle; font-weight: 600; color: #0071e3;">142</td>
                                            <td class="text-right py-2 px-3" style="vertical-align: middle;" id="tpoStatus3">
                                                <span class="ios-badge ios-badge-orange font-weight-bold" style="font-size: 0.72rem;">CGPA &lt; 8.5</span>
                                            </td>
                                        </tr>

                                        <!-- Candidate 4 -->
                                        <tr style="border-bottom: 1px solid #f1f5f9;">
                                            <td class="text-left font-weight-bold py-2 px-3" style="vertical-align: middle;">
                                                <div class="d-flex align-items-center">
                                                    <div class="st-avatar-xs mr-2" style="background: linear-gradient(135deg, #f59e0b, #d97706); color: #fff; border-radius: 50%; width: 26px; height: 26px; display: inline-flex; align-items: center; justify-content: center; font-weight: 700; font-size: 0.7rem;">
                                                        AK
                                                    </div>
                                                    <span style="color: #0f172a;">Amit Kumar</span>
                                                </div>
                                            </td>
                                            <td style="vertical-align: middle;"><span class="ios-badge ios-badge-gray" style="font-size: 0.7rem;">ECE</span></td>
                                            <td style="vertical-align: middle; font-weight: 600; color: #0f172a;">7.60</td>
                                            <td style="vertical-align: middle; font-weight: 600; color: #0071e3;">94</td>
                                            <td class="text-right py-2 px-3" style="vertical-align: middle;" id="tpoStatus4">
                                                <span class="ios-badge ios-badge-red font-weight-bold" style="font-size: 0.72rem;">Screened Out</span>
                                            </td>
                                        </tr>

                                        <!-- Candidate 5 -->
                                        <tr>
                                            <td class="text-left font-weight-bold py-2 px-3" style="vertical-align: middle;">
                                                <div class="d-flex align-items-center">
                                                    <div class="st-avatar-xs mr-2" style="background: linear-gradient(135deg, #0ea5e9, #0284c7); color: #fff; border-radius: 50%; width: 26px; height: 26px; display: inline-flex; align-items: center; justify-content: center; font-weight: 700; font-size: 0.7rem;">
                                                        RV
                                                    </div>
                                                    <span style="color: #0f172a;">Rohan Verma</span>
                                                </div>
                                            </td>
                                            <td style="vertical-align: middle;"><span class="ios-badge ios-badge-gray" style="font-size: 0.7rem;">CSE</span></td>
                                            <td style="vertical-align: middle; font-weight: 600; color: #0f172a;">8.05</td>
                                            <td style="vertical-align: middle; font-weight: 600; color: #0071e3;">126</td>
                                            <td class="text-right py-2 px-3" style="vertical-align: middle;" id="tpoStatus5">
                                                <span class="ios-badge ios-badge-orange font-weight-bold" style="font-size: 0.72rem;">CGPA &lt; 8.5</span>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>

                            <!-- Bottom Simulator Toolbar & Metrics -->
                            <div class="d-flex flex-wrap justify-content-between align-items-center mt-3 pt-2">
                                <div class="small font-weight-bold" id="tpoSummaryCount" style="color: #475569;">
                                    Shortlisted: <strong class="text-dark" id="tpoCountText">2 of 5</strong> Candidates
                                </div>
                                <div class="d-flex align-items-center" style="gap: 8px;">
                                    <span class="ios-badge ios-badge-green font-weight-bold" id="tpoConversionBadge" style="font-size: 0.72rem;">
                                        40% Drive Match
                                    </span>
                                    <span class="ios-badge ios-badge-gray" style="font-size: 0.7rem; cursor: pointer;">
                                        📥 Export Excel
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
                    <h2 class="ios-section-title font-weight-bold" style="color: #0f172a; letter-spacing: -0.025em;">
                        Frequently Asked Questions
                    </h2>
                    <p class="text-muted" style="max-width: 680px; margin: auto; font-size: 1.05rem; line-height: 1.6;">
                        Everything you need to know about SkillTrack algorithms, LeetCode sync, ATS diagnostics, and verification pass.
                    </p>
                </div>

                <div class="row justify-content-center">
                    <div class="col-lg-9">
                        <div class="accordion" id="faqAccordion">
                            <!-- FAQ 1: Readiness Score -->
                            <div class="ios-accordion-item mb-3" style="background: rgba(248, 250, 252, 0.9); border: 1px solid rgba(226, 232, 240, 0.95); border-radius: 16px; overflow: hidden;">
                                <button class="ios-accordion-btn collapsed p-3.5 d-flex justify-content-between align-items-center w-100" type="button" data-toggle="collapse" data-target="#faqCollapse1" aria-expanded="false" aria-controls="faqCollapse1" style="background: transparent; border: none; font-weight: 600; color: #0f172a; font-size: 0.975rem;">
                                    <span>How is the 100-Point Placement Readiness Score calculated?</span>
                                    <span class="ios-accordion-icon-circle ml-2 flex-shrink-0" style="width: 28px; height: 28px; border-radius: 50%; background: #ffffff; border: 1px solid #e2e8f0; display: flex; align-items: center; justify-content: center;">
                                        <svg class="ios-chevron" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#0071e3" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                                            <polyline points="6 9 12 15 18 9"></polyline>
                                        </svg>
                                    </span>
                                </button>
                                <div id="faqCollapse1" class="collapse" data-parent="#faqAccordion">
                                    <div class="ios-accordion-body p-4 pt-0 text-muted" style="font-size: 0.9rem; line-height: 1.6; border-top: 1px solid #f1f5f9;">
                                        SkillTrack uses a weighted deterministic model designed in collaboration with corporate tech hiring leads:
                                        <ul class="mb-2 mt-2 pl-3" style="line-height: 1.6;">
                                            <li class="mb-1.5"><strong>Target Role Skill Match (40% weight):</strong> Verified proficiency levels (Core, Secondary, Tools) benchmarked against live industry role requirements.</li>
                                            <li class="mb-1.5"><strong>18-Topic DSA Matrix (25% weight):</strong> Structured problem-solving progress across Easy, Medium, and Hard algorithmic milestones.</li>
                                            <li class="mb-1.5"><strong>Verified GitHub Projects (20% weight):</strong> GitHub-hosted full stack engineering applications with live deployment links.</li>
                                            <li><strong>Academic Standing &amp; Backlog Compliance (15% weight):</strong> Degree CGPA and zero active backlog standing for company drive qualification.</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>

                            <!-- FAQ 2: LeetCode Auto-Sync & 18 Topics -->
                            <div class="ios-accordion-item mb-3" style="background: rgba(248, 250, 252, 0.9); border: 1px solid rgba(226, 232, 240, 0.95); border-radius: 16px; overflow: hidden;">
                                <button class="ios-accordion-btn collapsed p-3.5 d-flex justify-content-between align-items-center w-100" type="button" data-toggle="collapse" data-target="#faqCollapse2" aria-expanded="false" aria-controls="faqCollapse2" style="background: transparent; border: none; font-weight: 600; color: #0f172a; font-size: 0.975rem;">
                                    <span>How does LeetCode Auto-Sync and the 18-Topic DSA Matrix work?</span>
                                    <span class="ios-accordion-icon-circle ml-2 flex-shrink-0" style="width: 28px; height: 28px; border-radius: 50%; background: #ffffff; border: 1px solid #e2e8f0; display: flex; align-items: center; justify-content: center;">
                                        <svg class="ios-chevron" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#0071e3" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                                            <polyline points="6 9 12 15 18 9"></polyline>
                                        </svg>
                                    </span>
                                </button>
                                <div id="faqCollapse2" class="collapse" data-parent="#faqAccordion">
                                    <div class="ios-accordion-body p-4 pt-0 text-muted" style="font-size: 0.9rem; line-height: 1.6; border-top: 1px solid #f1f5f9;">
                                        SkillTrack connects directly to public GraphQL APIs to synchronize your solved problem count across Easy, Medium, and Hard tiers in real time. It automatically maps your count across 18 core DSA topics (Arrays, Two Pointers, Sliding Window, Trees, Graphs, Dynamic Programming, etc.) and updates your readiness score without tedious manual logging.
                                    </div>
                                </div>
                            </div>

                            <!-- FAQ 3: ATS Resume & Scanner -->
                            <div class="ios-accordion-item mb-3" style="background: rgba(248, 250, 252, 0.9); border: 1px solid rgba(226, 232, 240, 0.95); border-radius: 16px; overflow: hidden;">
                                <button class="ios-accordion-btn collapsed p-3.5 d-flex justify-content-between align-items-center w-100" type="button" data-toggle="collapse" data-target="#faqCollapse3" aria-expanded="false" aria-controls="faqCollapse3" style="background: transparent; border: none; font-weight: 600; color: #0f172a; font-size: 0.975rem;">
                                    <span>Why is the Ivy-League ATS Resume Builder superior to standard graphic templates?</span>
                                    <span class="ios-accordion-icon-circle ml-2 flex-shrink-0" style="width: 28px; height: 28px; border-radius: 50%; background: #ffffff; border: 1px solid #e2e8f0; display: flex; align-items: center; justify-content: center;">
                                        <svg class="ios-chevron" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#0071e3" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                                            <polyline points="6 9 12 15 18 9"></polyline>
                                        </svg>
                                    </span>
                                </button>
                                <div id="faqCollapse3" class="collapse" data-parent="#faqAccordion">
                                    <div class="ios-accordion-body p-4 pt-0 text-muted" style="font-size: 0.9rem; line-height: 1.6; border-top: 1px solid #f1f5f9;">
                                        Over 75% of graphic multi-column resumes get silently rejected by corporate Applicant Tracking Systems (ATS) due to parsing errors. SkillTrack generates a clean, single-column Ivy-League standard A4 PDF resume and runs an automated 0-100% keyword diagnostic checking for target tech stack keywords, high-impact action verbs, and quantified business metrics.
                                    </div>
                                </div>
                            </div>

                            <!-- FAQ 4: Public Verified Passport -->
                            <div class="ios-accordion-item mb-3" style="background: rgba(248, 250, 252, 0.9); border: 1px solid rgba(226, 232, 240, 0.95); border-radius: 16px; overflow: hidden;">
                                <button class="ios-accordion-btn collapsed p-3.5 d-flex justify-content-between align-items-center w-100" type="button" data-toggle="collapse" data-target="#faqCollapse4" aria-expanded="false" aria-controls="faqCollapse4" style="background: transparent; border: none; font-weight: 600; color: #0f172a; font-size: 0.975rem;">
                                    <span>What is the Public Verified Placement Passport (<code style="color: #7c3aed;">/passport/{hash}</code>)?</span>
                                    <span class="ios-accordion-icon-circle ml-2 flex-shrink-0" style="width: 28px; height: 28px; border-radius: 50%; background: #ffffff; border: 1px solid #e2e8f0; display: flex; align-items: center; justify-content: center;">
                                        <svg class="ios-chevron" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#0071e3" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                                            <polyline points="6 9 12 15 18 9"></polyline>
                                        </svg>
                                    </span>
                                </button>
                                <div id="faqCollapse4" class="collapse" data-parent="#faqAccordion">
                                    <div class="ios-accordion-body p-4 pt-0 text-muted" style="font-size: 0.9rem; line-height: 1.6; border-top: 1px solid #f1f5f9;">
                                        Every registered student receives a unique, tamper-proof cryptographic profile URL and QR code. Recruiters and placement officers can open this link to verify live GitHub source repositories, working application deployments, authenticated LeetCode solves, and official college academic standing in 1 click.
                                    </div>
                                </div>
                            </div>

                            <!-- FAQ 5: TPO & Placement Cell Integration -->
                            <div class="ios-accordion-item" style="background: rgba(248, 250, 252, 0.9); border: 1px solid rgba(226, 232, 240, 0.95); border-radius: 16px; overflow: hidden;">
                                <button class="ios-accordion-btn collapsed p-3.5 d-flex justify-content-between align-items-center w-100" type="button" data-toggle="collapse" data-target="#faqCollapse5" aria-expanded="false" aria-controls="faqCollapse5" style="background: transparent; border: none; font-weight: 600; color: #0f172a; font-size: 0.975rem;">
                                    <span>How does SkillTrack support college TPOs and faculty coordinators?</span>
                                    <span class="ios-accordion-icon-circle ml-2 flex-shrink-0" style="width: 28px; height: 28px; border-radius: 50%; background: #ffffff; border: 1px solid #e2e8f0; display: flex; align-items: center; justify-content: center;">
                                        <svg class="ios-chevron" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#0071e3" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                                            <polyline points="6 9 12 15 18 9"></polyline>
                                        </svg>
                                    </span>
                                </button>
                                <div id="faqCollapse5" class="collapse" data-parent="#faqAccordion">
                                    <div class="ios-accordion-body p-4 pt-0 text-muted" style="font-size: 0.9rem; line-height: 1.6; border-top: 1px solid #f1f5f9;">
                                        College Training &amp; Placement Cells (TPOs) gain access to an enterprise console featuring an instant drive shortlisting simulator (applying CGPA cutoffs, backlog filters, and required tech skills), department cohort analytics, and 1-click exportable Excel/PDF rosters ready for visiting campus recruiters.
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
            var sectionIds = ['overview', 'comparison', 'features', 'playground', 'ai-coach', 'roadmap', 'tpo-portal', 'faq'];
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

        function switchTpoPreset(presetKey) {
            var btn1 = document.getElementById('tpoBtnTier1');
            var btn2 = document.getElementById('tpoBtnTcs');
            var btn3 = document.getElementById('tpoBtnFintech');

            var s1 = document.getElementById('tpoStatus1');
            var s2 = document.getElementById('tpoStatus2');
            var s3 = document.getElementById('tpoStatus3');
            var s4 = document.getElementById('tpoStatus4');
            var s5 = document.getElementById('tpoStatus5');

            var countText = document.getElementById('tpoCountText');
            var matchBadge = document.getElementById('tpoConversionBadge');

            [btn1, btn2, btn3].forEach(function(b) {
                if (b) {
                    b.style.background = "#f1f5f9";
                    b.style.color = "#475569";
                    b.style.borderColor = "#e2e8f0";
                }
            });

            if (presetKey === 'tier1') {
                if (btn1) {
                    btn1.style.background = "#0071e3";
                    btn1.style.color = "#ffffff";
                    btn1.style.borderColor = "#0071e3";
                }
                if (s1) s1.innerHTML = '<span class="ios-badge ios-badge-green font-weight-bold" style="font-size: 0.72rem;">Shortlisted ✓</span>';
                if (s2) s2.innerHTML = '<span class="ios-badge ios-badge-green font-weight-bold" style="font-size: 0.72rem;">Top Pick ★</span>';
                if (s3) s3.innerHTML = '<span class="ios-badge ios-badge-orange font-weight-bold" style="font-size: 0.72rem;">CGPA &lt; 8.5</span>';
                if (s4) s4.innerHTML = '<span class="ios-badge ios-badge-red font-weight-bold" style="font-size: 0.72rem;">Screened Out</span>';
                if (s5) s5.innerHTML = '<span class="ios-badge ios-badge-orange font-weight-bold" style="font-size: 0.72rem;">CGPA &lt; 8.5</span>';
                if (countText) countText.textContent = "2 of 5";
                if (matchBadge) {
                    matchBadge.textContent = "40% Drive Match";
                    matchBadge.className = "ios-badge ios-badge-green font-weight-bold";
                }
            } else if (presetKey === 'tcs') {
                if (btn2) {
                    btn2.style.background = "#0071e3";
                    btn2.style.color = "#ffffff";
                    btn2.style.borderColor = "#0071e3";
                }
                if (s1) s1.innerHTML = '<span class="ios-badge ios-badge-green font-weight-bold" style="font-size: 0.72rem;">Shortlisted ✓</span>';
                if (s2) s2.innerHTML = '<span class="ios-badge ios-badge-green font-weight-bold" style="font-size: 0.72rem;">Top Pick ★</span>';
                if (s3) s3.innerHTML = '<span class="ios-badge ios-badge-green font-weight-bold" style="font-size: 0.72rem;">Shortlisted ✓</span>';
                if (s4) s4.innerHTML = '<span class="ios-badge ios-badge-green font-weight-bold" style="font-size: 0.72rem;">Eligible ✓</span>';
                if (s5) s5.innerHTML = '<span class="ios-badge ios-badge-green font-weight-bold" style="font-size: 0.72rem;">Shortlisted ✓</span>';
                if (countText) countText.textContent = "5 of 5";
                if (matchBadge) {
                    matchBadge.textContent = "100% Batch Eligible";
                    matchBadge.className = "ios-badge ios-badge-green font-weight-bold";
                }
            } else if (presetKey === 'fintech') {
                if (btn3) {
                    btn3.style.background = "#0071e3";
                    btn3.style.color = "#ffffff";
                    btn3.style.borderColor = "#0071e3";
                }
                if (s1) s1.innerHTML = '<span class="ios-badge ios-badge-green font-weight-bold" style="font-size: 0.72rem;">Shortlisted ✓</span>';
                if (s2) s2.innerHTML = '<span class="ios-badge ios-badge-green font-weight-bold" style="font-size: 0.72rem;">Top Pick ★</span>';
                if (s3) s3.innerHTML = '<span class="ios-badge ios-badge-orange font-weight-bold" style="font-size: 0.72rem;">DSA &lt; 150</span>';
                if (s4) s4.innerHTML = '<span class="ios-badge ios-badge-red font-weight-bold" style="font-size: 0.72rem;">DSA &lt; 150</span>';
                if (s5) s5.innerHTML = '<span class="ios-badge ios-badge-orange font-weight-bold" style="font-size: 0.72rem;">DSA &lt; 150</span>';
                if (countText) countText.textContent = "2 of 5";
                if (matchBadge) {
                    matchBadge.textContent = "40% High-Algorithmic Match";
                    matchBadge.className = "ios-badge ios-badge-purple font-weight-bold";
                }
            }
        }
        </script>
    </body>
    </html>
    </c:otherwise>
</c:choose>
