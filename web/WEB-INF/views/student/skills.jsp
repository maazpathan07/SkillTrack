<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Technical Skills Bank" />
<c:set var="activeNav" value="skills" />
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
                        <span class="ios-badge ios-badge-blue">
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" aria-hidden="true"><polyline points="16 18 22 12 16 6"></polyline><polyline points="8 6 2 12 8 18"></polyline></svg>
                            Taxonomy Matrix
                        </span>
                    </div>
                    <h1 class="h3 font-weight-bold text-gray-800 mb-0" style="letter-spacing: -0.03em;">Technical Skills Bank &amp; Proficiency</h1>
                    <p class="text-muted small mb-0 mt-1">Catalog your programming languages, frameworks, cloud stacks, and database competencies</p>
                </div>
                <div>
                    <a href="${pageContext.request.contextPath}/app/student/skill-gap" class="ios-btn-secondary" style="padding: 0.6rem 1.25rem; font-size: 0.875rem;">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" aria-hidden="true"><line x1="18" y1="20" x2="18" y2="10"></line><line x1="12" y1="20" x2="12" y2="4"></line><line x1="6" y1="20" x2="6" y2="14"></line></svg>
                        Analyze Skill Gap
                    </a>
                </div>
            </div>

            <div class="row">
                <!-- Add / Update Skill Form -->
                <div class="col-lg-4 mb-4">
                    <div class="ios-card">
                        <div class="ios-card-header">
                            <div>
                                <h2 class="h5 font-weight-bold text-dark mb-0" style="font-size: 1rem;">Add / Update Skill</h2>
                                <small class="text-muted">Select skill &amp; your proficiency</small>
                            </div>
                        </div>
                        <div class="ios-card-body">
                            <form action="${pageContext.request.contextPath}/app/student/skills" method="post" class="needs-validation" novalidate>
                                <input type="hidden" name="csrfToken" value="${sessionScope.CSRF_TOKEN}" />
                                <input type="hidden" name="action" value="save" />

                                <div class="form-group mb-3">
                                    <label for="skillId" class="ios-form-label">Technical Skill *</label>
                                    <select class="ios-form-control" id="skillId" name="skillId" required>
                                        <option value="">Choose a skill...</option>
                                        <c:forEach items="${allSkills}" var="skill">
                                            <option value="${skill.skillId}">
                                                <c:out value="${skill.skillName}" /> (<c:out value="${skill.category.displayName}" />)
                                            </option>
                                        </c:forEach>
                                    </select>
                                    <div class="invalid-feedback">Please select a technical skill.</div>
                                </div>

                                <div class="form-group mb-4">
                                    <label for="proficiencyLevel" class="ios-form-label">Proficiency Level *</label>
                                    <select class="ios-form-control" id="proficiencyLevel" name="proficiencyLevel" required>
                                        <option value="">Select Level...</option>
                                        <c:forEach items="${skillLevels}" var="lvl">
                                            <option value="${lvl.name()}"><c:out value="${lvl.displayName}" /></option>
                                        </c:forEach>
                                    </select>
                                    <div class="invalid-feedback">Please select your proficiency level.</div>
                                    <small class="text-muted mt-1 d-block">
                                        Advanced &bull; Intermediate &bull; Beginner
                                    </small>
                                </div>

                                <button type="submit" class="ios-btn-primary w-100" style="padding: 0.75rem;">
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" aria-hidden="true"><line x1="12" y1="5" x2="12" y2="19"></line><line x1="5" y1="12" x2="19" y2="12"></line></svg>
                                    Record Skill Proficiency
                                </button>
                            </form>
                        </div>
                    </div>

                    <!-- Informational Box -->
                    <div class="ios-card p-4">
                        <div class="d-flex align-items-center gap-2 mb-2">
                            <div class="ios-badge ios-badge-blue p-1">
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" aria-hidden="true"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="16" x2="12" y2="12"></line><line x1="12" y1="8" x2="12.01" y2="8"></line></svg>
                            </div>
                            <span class="font-weight-bold text-dark" style="font-size: 0.9rem;">Skill Weighting</span>
                        </div>
                        <p class="text-muted small mb-0" style="line-height: 1.6;">
                            Skills matched with your Target Role requirement directly boost your <strong>Role Skill Match (25% Weight)</strong> in the Placement Readiness formula.
                        </p>
                    </div>
                </div>

                <!-- Acquired Skills Table -->
                <div class="col-lg-8 mb-4">
                    <div class="ios-card">
                        <div class="ios-card-header">
                            <div>
                                <h2 class="h5 font-weight-bold text-dark mb-0" style="font-size: 1rem;">Acquired Skills Inventory</h2>
                                <small class="text-muted">Total recorded skills on your profile</small>
                            </div>
                            <span class="ios-badge ios-badge-blue font-weight-bold">
                                ${studentSkills.size()} Skills Active
                            </span>
                        </div>
                        <div class="ios-card-body p-0">
                            <div class="table-responsive">
                                <table class="table table-hover mb-0" style="border-collapse: separate;">
                                    <thead class="bg-light">
                                        <tr style="border-bottom: 1px solid #e2e8f0;">
                                            <th class="border-top-0 font-weight-bold small text-uppercase py-3 px-4" style="color: #334155; letter-spacing: 0.05em;">Skill Name</th>
                                            <th class="border-top-0 font-weight-bold small text-uppercase py-3" style="color: #334155; letter-spacing: 0.05em;">Category</th>
                                            <th class="border-top-0 font-weight-bold small text-uppercase py-3" style="color: #334155; letter-spacing: 0.05em;">Proficiency</th>
                                            <th class="border-top-0 font-weight-bold small text-uppercase py-3 px-4 text-right" style="color: #334155; letter-spacing: 0.05em;">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:choose>
                                            <c:when test="${empty studentSkills}">
                                                <tr>
                                                    <td colspan="4" class="text-center py-5 text-muted">
                                                        <div class="ios-badge ios-badge-gray p-3 mb-2" style="border-radius: 50%;">
                                                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true"><polyline points="16 18 22 12 16 6"></polyline><polyline points="8 6 2 12 8 18"></polyline></svg>
                                                        </div>
                                                        <div class="font-weight-bold text-dark">No skills recorded yet</div>
                                                        <small class="text-muted">Use the form on the left to add your technical skills.</small>
                                                    </td>
                                                </tr>
                                            </c:when>
                                            <c:otherwise>
                                                <c:forEach items="${studentSkills}" var="ss">
                                                    <tr style="border-bottom: 1px solid #f1f5f9;">
                                                        <td class="font-weight-bold text-dark py-3 px-4" style="vertical-align: middle;">
                                                            <c:out value="${ss.skillName}" />
                                                        </td>
                                                        <td style="vertical-align: middle;">
                                                            <span class="ios-badge ios-badge-gray">
                                                                <c:out value="${ss.skillCategory.displayName}" />
                                                            </span>
                                                        </td>
                                                        <td style="vertical-align: middle;">
                                                            <c:choose>
                                                                <c:when test="${ss.proficiencyLevel.name() == 'ADVANCED'}">
                                                                    <span class="ios-badge ios-badge-green">
                                                                        <svg width="10" height="10" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" aria-hidden="true"><polyline points="20 6 9 17 4 12"></polyline></svg>
                                                                        Advanced
                                                                    </span>
                                                                </c:when>
                                                                <c:when test="${ss.proficiencyLevel.name() == 'INTERMEDIATE'}">
                                                                    <span class="ios-badge ios-badge-blue">
                                                                        Intermediate
                                                                    </span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="ios-badge ios-badge-gray">
                                                                        Beginner
                                                                    </span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td class="text-right py-3 px-4" style="vertical-align: middle;">
                                                            <form action="${pageContext.request.contextPath}/app/student/skills" method="post" class="d-inline">
                                                                <input type="hidden" name="csrfToken" value="${sessionScope.CSRF_TOKEN}" />
                                                                <input type="hidden" name="action" value="delete" />
                                                                <input type="hidden" name="skillId" value="${ss.skillId}" />
                                                                <button type="submit" class="btn btn-sm btn-outline-danger confirm-delete d-inline-flex align-items-center" style="border-radius: var(--ios-radius-sm); padding: 0.35rem 0.75rem; font-size: 0.8rem; font-weight: 600;" data-confirm="Remove ${ss.skillName} from your profile?" aria-label="Remove skill <c:out value='${ss.skillName}' />">
                                                                    <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="mr-1" aria-hidden="true">
                                                                        <polyline points="3 6 5 6 21 6"></polyline>
                                                                        <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
                                                                        <line x1="10" y1="11" x2="10" y2="17"></line>
                                                                        <line x1="14" y1="11" x2="14" y2="17"></line>
                                                                    </svg>
                                                                    Remove
                                                                </button>
                                                            </form>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </c:otherwise>
                                        </c:choose>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jspf" %>
