<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Preparation Tasks" />
<c:set var="activeNav" value="tasks" />
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
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" aria-hidden="true"><polyline points="9 11 12 14 22 4"></polyline><path d="M21 12v7a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11"></path></svg>
                            Roadmap Engine
                        </span>
                    </div>
                    <h1 class="h3 font-weight-bold text-gray-800 mb-0" style="letter-spacing: -0.03em;">Preparation Action Checklist</h1>
                    <p class="text-muted small mb-0 mt-1">Track mock interviews, technical resume revisions, and milestone targets</p>
                </div>
                <div>
                    <span class="ios-badge ios-badge-blue" style="font-size: 0.85rem; padding: 0.5rem 1rem;">
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" aria-hidden="true"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg>
                        15% Readiness Weight
                    </span>
                </div>
            </div>

            <div class="row">
                <!-- Task Form -->
                <div class="col-lg-5 mb-4">
                    <div class="ios-card h-100">
                        <div class="ios-card-header" style="padding: 1.25rem 1.5rem;">
                            <div>
                                <h2 class="h5 font-weight-bold text-dark mb-0" style="font-size: 1.15rem; letter-spacing: -0.02em;">
                                    <c:out value="${not empty editTask ? 'Edit Task' : 'Add Preparation Task'}" />
                                </h2>
                                <small class="text-muted">
                                    <c:out value="${not empty editTask ? 'Update task requirements & deadline' : 'Define actionable milestone target'}" />
                                </small>
                            </div>
                            <c:if test="${not empty editTask}">
                                <span class="ios-badge ios-badge-orange">Editing ID: ${editTask.taskId}</span>
                            </c:if>
                        </div>
                        <div class="ios-card-body" style="padding: 1.5rem 1.5rem 1.75rem 1.5rem;">
                            <form action="${pageContext.request.contextPath}/app/student/tasks" method="post" class="needs-validation" novalidate>
                                <input type="hidden" name="csrfToken" value="${sessionScope.CSRF_TOKEN}" />
                                <input type="hidden" name="taskId" value="<c:out value='${editTask.taskId}' default='0' />" />

                                <div class="form-group mb-3">
                                    <label for="title" class="ios-form-label">Task Title *</label>
                                    <input type="text" class="ios-form-control" id="title" name="title" value="<c:out value='${editTask.title}' />" required placeholder="e.g. Solve 10 LeetCode Medium Trees & Graphs">
                                    <div class="invalid-feedback">Task title is required.</div>
                                </div>

                                <div class="form-group mb-3">
                                    <label for="description" class="ios-form-label">Action Plan &amp; Notes</label>
                                    <textarea class="ios-form-control" id="description" name="description" rows="3" placeholder="Focus on BFS/DFS traversals, topological sorting, and shortest path Dijkstra algorithms..."><c:out value="${editTask.description}" /></textarea>
                                </div>

                                <div class="form-row">
                                    <div class="form-group ${not empty editTask ? 'col-md-6' : 'col-12'} mb-3">
                                        <label for="targetDate" class="ios-form-label">Target Completion Date</label>
                                        <input type="date" class="ios-form-control" id="targetDate" name="targetDate" value="<c:out value='${editTask.targetDate}' />">
                                    </div>
                                    <c:if test="${not empty editTask}">
                                        <div class="form-group col-md-6 mb-3">
                                            <label for="status" class="ios-form-label">Task Status</label>
                                            <select class="ios-form-control" id="status" name="status">
                                                <option value="PENDING" ${editTask.status == 'PENDING' ? 'selected' : ''}>Pending</option>
                                                <option value="COMPLETED" ${editTask.status == 'COMPLETED' ? 'selected' : ''}>Completed</option>
                                            </select>
                                        </div>
                                    </c:if>
                                </div>

                                <div class="d-flex justify-content-between align-items-center pt-3 mt-2 border-top">
                                    <c:choose>
                                        <c:when test="${not empty editTask}">
                                            <a href="${pageContext.request.contextPath}/app/student/tasks" class="ios-btn-secondary" style="padding: 0.65rem 1.25rem; font-size: 0.875rem;">Cancel</a>
                                            <button type="submit" class="ios-btn-primary" style="padding: 0.65rem 1.5rem; font-size: 0.875rem; box-shadow: 0 4px 12px rgba(0, 113, 227, 0.25);">
                                                <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" aria-hidden="true"><polyline points="20 6 9 17 4 12"></polyline></svg>
                                                Update Task
                                            </button>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="small" style="color: #475569; font-weight: 600;">Auto-tracked in score</div>
                                            <button type="submit" class="ios-btn-primary" style="padding: 0.65rem 1.75rem; font-size: 0.875rem; box-shadow: 0 4px 12px rgba(0, 113, 227, 0.25);">
                                                <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" aria-hidden="true"><line x1="12" y1="5" x2="12" y2="19"></line><line x1="5" y1="12" x2="19" y2="12"></line></svg>
                                                Save Task
                                            </button>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Tasks Checklist List -->
                <div class="col-lg-7 mb-4">
                    <div class="ios-card h-100">
                        <div class="ios-card-header" style="padding: 1.25rem 1.5rem;">
                            <div>
                                <h2 class="h5 font-weight-bold text-dark mb-0" style="font-size: 1.15rem; letter-spacing: -0.02em;">
                                    Active Action Checklist (${tasks.size()})
                                </h2>
                                <small class="text-muted">Click the checkbox to immediately mark tasks as completed</small>
                            </div>
                            <span class="ios-badge ios-badge-blue font-weight-bold">
                                ${tasks.size()} Total
                            </span>
                        </div>
                        <div class="ios-card-body p-0">
                            <ul class="list-group list-group-flush mb-0">
                                <c:choose>
                                    <c:when test="${empty tasks}">
                                        <li class="list-group-item text-center text-muted py-5" style="border: none;">
                                            <div class="ios-badge ios-badge-gray p-3 mb-2" style="border-radius: var(--ios-radius-full);">
                                                <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true"><polyline points="9 11 12 14 22 4"></polyline><path d="M21 12v7a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11"></path></svg>
                                            </div>
                                            <h3 class="h5 font-weight-bold text-dark mt-2">No preparation tasks created yet</h3>
                                            <p class="small mb-0" style="color: #475569;">Use the form on the left to set up your roadmap targets and daily study goals.</p>
                                        </li>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach items="${tasks}" var="t">
                                            <li class="list-group-item d-flex justify-content-between align-items-start py-3 px-4" style="border-bottom: 1px solid #f1f5f9; transition: var(--ios-ease);">
                                                <div class="d-flex align-items-start gap-3" style="gap: 0.75rem;">
                                                    <!-- Auto-submit Toggle Checkbox -->
                                                    <form action="${pageContext.request.contextPath}/app/student/tasks" method="post" class="mt-1">
                                                        <input type="hidden" name="csrfToken" value="${sessionScope.CSRF_TOKEN}" />
                                                        <input type="hidden" name="action" value="toggle" />
                                                        <input type="hidden" name="taskId" value="${t.taskId}" />
                                                        <input type="hidden" name="status" value="${t.completed ? 'PENDING' : 'COMPLETED'}" />
                                                        <input type="checkbox" onchange="this.form.submit()" ${t.completed ? 'checked' : ''} style="width: 18px; height: 18px; accent-color: var(--ios-blue); cursor: pointer;" title="Toggle Completion" aria-label="Mark task ${t.title} as ${t.completed ? 'pending' : 'completed'}">
                                                    </form>
                                                    <div>
                                                        <h3 class="h6 mb-1 ${t.completed ? 'text-muted text-decoration-line-through' : 'font-weight-bold text-dark'}" style="font-size: 0.975rem;">
                                                            <c:out value="${t.title}" />
                                                        </h3>
                                                        <c:if test="${not empty t.description}">
                                                            <p class="small mb-1" style="color: #475569; line-height: 1.5;"><c:out value="${t.description}" /></p>
                                                        </c:if>
                                                        <c:if test="${not empty t.formattedTargetDate}">
                                                            <div class="d-flex align-items-center gap-1 small mt-1" style="color: #64748b;">
                                                                <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" class="mr-1" aria-hidden="true"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg>
                                                                <span>Target Due: <strong style="color: var(--ios-text-primary);"><c:out value="${t.formattedTargetDate}" /></strong></span>
                                                            </div>
                                                        </c:if>
                                                    </div>
                                                </div>

                                                <div class="d-flex align-items-center gap-2">
                                                    <a href="${pageContext.request.contextPath}/app/student/tasks?editId=${t.taskId}" class="btn btn-sm btn-outline-secondary d-inline-flex align-items-center" style="border-radius: var(--ios-radius-sm); padding: 0.3rem 0.75rem; font-size: 0.8rem; font-weight: 600;" title="Edit Task" aria-label="Edit task <c:out value='${t.title}' />">
                                                        <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" class="mr-1" aria-hidden="true"><path d="M12 20h9"></path><path d="M16.5 3.5a2.121 2.121 0 0 1 3 3L7 19l-4 1 1-4L16.5 3.5z"></path></svg>
                                                        Edit
                                                    </a>
                                                    <form action="${pageContext.request.contextPath}/app/student/tasks" method="post" class="d-inline">
                                                        <input type="hidden" name="csrfToken" value="${sessionScope.CSRF_TOKEN}" />
                                                        <input type="hidden" name="action" value="delete" />
                                                        <input type="hidden" name="taskId" value="${t.taskId}" />
                                                        <button type="submit" class="btn btn-sm btn-outline-danger confirm-delete d-inline-flex align-items-center" style="border-radius: var(--ios-radius-sm); padding: 0.3rem 0.75rem; font-size: 0.8rem; font-weight: 600;" data-confirm="Delete task '${t.title}'?" aria-label="Delete task <c:out value='${t.title}' />">
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
                                            </li>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jspf" %>
