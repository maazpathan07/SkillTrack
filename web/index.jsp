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

            <!-- Apple Floating Capsule Pill Navigation Menu (Desktop) -->
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

        <!-- 1. HERO SECTION (APPLE LIQUID GLASS AESTHETIC) -->
        <section class="ios-ambient-canvas py-5" id="overview" style="padding-top: 5rem !important; padding-bottom: 5.5rem !important;">
            <div class="container position-relative" style="z-index: 2;">
                <div class="row align-items-center">
                    <div class="col-lg-7 text-center text-lg-left mb-5 mb-lg-0">
                        <!-- Apple Style Pill Tag -->
                        <div class="d-inline-flex align-items-center px-3 py-1 mb-4 rounded-pill border" style="background: rgba(255, 255, 255, 0.85); backdrop-filter: blur(20px); font-size: 0.825rem; font-weight: 700; color: var(--ios-blue);">
                            <span class="mr-2" style="width: 6px; height: 6px; border-radius: 50%; background: var(--ios-blue); display: inline-block;"></span>
                            Placement Intelligence Platform
                        </div>
                        
                        <!-- Hero Typography -->
                        <h1 class="ios-hero-title font-weight-bold mb-3" style="color: #1d1d1f;">
                            Master Industry Skills. <br />
                            <span style="background: linear-gradient(135deg, #0071e3, #5856d6); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">
                                Accelerate Career Readiness.
                            </span>
                        </h1>

                        <!-- Subtitle -->
                        <p class="lead mb-4" style="color: #6e6e73; font-size: 1.2rem; line-height: 1.6; max-width: 620px;">
                            The intelligent platform that benchmarks your technical competencies against target roles, tracks daily DSA milestones, validates live GitHub projects, and calculates a deterministic <strong>100-Point Readiness Score</strong>.
                        </p>

                        <!-- Action Buttons -->
                        <div class="d-flex flex-column flex-sm-row justify-content-center justify-content-lg-start gap-3 mb-4">
                            <a href="${pageContext.request.contextPath}/register" class="ios-btn-primary mr-sm-3 mb-3 mb-sm-0" style="padding: 0.85rem 2rem; font-size: 1rem;">
                                Register as Student &rarr;
                            </a>
                            <a href="${pageContext.request.contextPath}/login" class="ios-btn-secondary" style="padding: 0.85rem 2rem; font-size: 1rem;">
                                Access Portal
                            </a>
                        </div>

                        <!-- Micro Feature Badges -->
                        <div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start gap-2 pt-2">
                            <span class="ios-badge ios-badge-gray mr-2 mb-2">
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="mr-1"><polyline points="22 12 18 12 15 21 9 3 6 12 2 12"></polyline></svg>
                                Deterministic Algorithm
                            </span>
                            <span class="ios-badge ios-badge-gray mr-2 mb-2">
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="mr-1"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 14 14"></polyline></svg>
                                12+ Industry Roles
                            </span>
                            <span class="ios-badge ios-badge-gray mb-2">
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="mr-1"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path><polyline points="14 2 14 8 20 8"></polyline></svg>
                                PDF Readiness Card
                            </span>
                        </div>
                    </div>

                    <!-- Right Column: Apple iPad / macOS Glass Widget Container -->
                    <div class="col-lg-5">
                        <div class="ios-glass-card p-4">
                            <!-- Header & Live Role Display -->
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <div>
                                    <span class="text-uppercase font-weight-bold" style="font-size: 0.725rem; letter-spacing: 0.06em; color: var(--ios-text-tertiary);">Interactive Preview</span>
                                    <h5 class="font-weight-bold mb-0 mt-1" id="previewRoleTitle" style="color: var(--ios-text-primary);">Full Stack Engineer</h5>
                                </div>
                                <span class="ios-badge ios-badge-green" id="previewReadyBadge">Ready (88%)</span>
                            </div>

                            <!-- Apple iOS Segmented Control -->
                            <div class="ios-segmented-control mb-3">
                                <button type="button" class="ios-segment-btn active" onclick="switchPreviewRole('fullstack')" id="btnRole1">Full Stack</button>
                                <button type="button" class="ios-segment-btn" onclick="switchPreviewRole('data')" id="btnRole2">Data Engineer</button>
                                <button type="button" class="ios-segment-btn" onclick="switchPreviewRole('cloud')" id="btnRole3">Cloud DevOps</button>
                            </div>

                            <!-- Circular Score Gauge Card -->
                            <div class="p-3 mb-3 rounded" style="background: rgba(255, 255, 255, 0.95); border: 1px solid rgba(0, 0, 0, 0.06); box-shadow: var(--ios-shadow-sm);">
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <span class="small font-weight-bold text-muted">Placement Readiness Score</span>
                                    <span class="font-weight-bold" style="font-size: 1.35rem; color: var(--ios-blue);" id="previewScoreText">88 / 100</span>
                                </div>
                                <div class="progress" style="height: 10px; border-radius: 5px; background: rgba(0, 0, 0, 0.06);">
                                    <div class="progress-bar" id="previewProgressBar" role="progressbar" style="width: 88%; background: var(--ios-green);" aria-valuenow="88" aria-valuemin="0" aria-valuemax="100"></div>
                                </div>
                            </div>

                            <!-- 4-Tile Metrics Grid -->
                            <div class="row text-center mb-3">
                                <div class="col-6 mb-2 pr-1">
                                    <div class="p-2 border rounded" style="background: rgba(255, 255, 255, 0.95);">
                                        <div class="font-weight-bold" style="font-size: 1.25rem; color: var(--ios-blue);" id="previewDsaCount">156</div>
                                        <small class="text-muted font-weight-semibold">DSA Solved</small>
                                    </div>
                                </div>
                                <div class="col-6 mb-2 pl-1">
                                    <div class="p-2 border rounded" style="background: rgba(255, 255, 255, 0.95);">
                                        <div class="font-weight-bold" style="font-size: 1.25rem; color: var(--ios-green-dark);" id="previewSkillCount">9 / 10</div>
                                        <small class="text-muted font-weight-semibold">Skills Matched</small>
                                    </div>
                                </div>
                                <div class="col-6 pr-1">
                                    <div class="p-2 border rounded" style="background: rgba(255, 255, 255, 0.95);">
                                        <div class="font-weight-bold" style="font-size: 1.25rem; color: #7e22ce;" id="previewProjectsCount">4 Verified</div>
                                        <small class="text-muted font-weight-semibold">Projects</small>
                                    </div>
                                </div>
                                <div class="col-6 pl-1">
                                    <div class="p-2 border rounded" style="background: rgba(255, 255, 255, 0.95);">
                                        <div class="font-weight-bold" style="font-size: 1.25rem; color: #c2410c;" id="previewCriteriaCount">95% Match</div>
                                        <small class="text-muted font-weight-semibold">Company Cutoffs</small>
                                    </div>
                                </div>
                            </div>

                            <!-- Live Competencies -->
                            <div class="mb-3">
                                <small class="text-muted font-weight-bold d-block mb-1">Required Competencies:</small>
                                <div id="previewSkillChips" class="d-flex flex-wrap gap-1">
                                    <span class="ios-badge ios-badge-green mr-1 mb-1">Java Core</span>
                                    <span class="ios-badge ios-badge-green mr-1 mb-1">Spring Boot</span>
                                    <span class="ios-badge ios-badge-green mr-1 mb-1">React.js</span>
                                    <span class="ios-badge ios-badge-orange mr-1 mb-1">Docker (Intermediate)</span>
                                </div>
                            </div>

                            <a href="${pageContext.request.contextPath}/register" class="ios-btn-primary btn-block text-center" style="border-radius: var(--ios-radius-sm); font-size: 0.925rem;">
                                Create Your Profile &rarr;
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

            // Smooth click handler with navbar offset
            document.querySelectorAll('.ios-capsule-nav a[href^="#"], #iosMobileDrawer a[href^="#"]').forEach(function(anchor) {
                anchor.addEventListener('click', function(e) {
                    var targetId = this.getAttribute('href').replace('#', '');
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

        <!-- Interactive Hero Role Switcher Demo Script -->
        <script>
        function switchPreviewRole(roleKey) {
            var title = document.getElementById('previewRoleTitle');
            var score = document.getElementById('previewScoreText');
            var bar = document.getElementById('previewProgressBar');
            var dsa = document.getElementById('previewDsaCount');
            var skills = document.getElementById('previewSkillCount');
            var chips = document.getElementById('previewSkillChips');
            var badge = document.getElementById('previewReadyBadge');

            var btn1 = document.getElementById('btnRole1');
            var btn2 = document.getElementById('btnRole2');
            var btn3 = document.getElementById('btnRole3');

            [btn1, btn2, btn3].forEach(function(b) {
                b.className = "ios-segment-btn";
            });

            if (roleKey === 'fullstack') {
                btn1.className = "ios-segment-btn active";
                title.textContent = "Full Stack Engineer";
                score.textContent = "88 / 100";
                bar.style.width = "88%";
                bar.style.background = "var(--ios-green)";
                badge.className = "ios-badge ios-badge-green";
                badge.textContent = "Ready (88%)";
                dsa.textContent = "156";
                skills.textContent = "9 / 10";
                chips.innerHTML = '<span class="ios-badge ios-badge-green mr-1 mb-1">Java Core</span>' +
                                  '<span class="ios-badge ios-badge-green mr-1 mb-1">Spring Boot</span>' +
                                  '<span class="ios-badge ios-badge-green mr-1 mb-1">React.js</span>' +
                                  '<span class="ios-badge ios-badge-orange mr-1 mb-1">Docker (Intermediate)</span>';
            } else if (roleKey === 'data') {
                btn2.className = "ios-segment-btn active";
                title.textContent = "Data Engineer";
                score.textContent = "76 / 100";
                bar.style.width = "76%";
                bar.style.background = "var(--ios-blue)";
                badge.className = "ios-badge ios-badge-blue";
                badge.textContent = "In Progress (76%)";
                dsa.textContent = "118";
                skills.textContent = "7 / 9";
                chips.innerHTML = '<span class="ios-badge ios-badge-green mr-1 mb-1">Python 3</span>' +
                                  '<span class="ios-badge ios-badge-green mr-1 mb-1">SQL / MySQL</span>' +
                                  '<span class="ios-badge ios-badge-orange mr-1 mb-1">Apache Spark</span>' +
                                  '<span class="ios-badge ios-badge-red mr-1 mb-1">Kafka (Missing)</span>';
            } else if (roleKey === 'cloud') {
                btn3.className = "ios-segment-btn active";
                title.textContent = "Cloud DevOps Architect";
                score.textContent = "64 / 100";
                bar.style.width = "64%";
                bar.style.background = "var(--ios-orange)";
                badge.className = "ios-badge ios-badge-orange";
                badge.textContent = "Needs Prep (64%)";
                dsa.textContent = "94";
                skills.textContent = "5 / 8";
                chips.innerHTML = '<span class="ios-badge ios-badge-green mr-1 mb-1">Linux / Bash</span>' +
                                  '<span class="ios-badge ios-badge-green mr-1 mb-1">Docker Containers</span>' +
                                  '<span class="ios-badge ios-badge-red mr-1 mb-1">Kubernetes (Missing)</span>' +
                                  '<span class="ios-badge ios-badge-orange mr-1 mb-1">Terraform (Basic)</span>';
            }
        }
        </script>
    </body>
    </html>
    </c:otherwise>
</c:choose>
