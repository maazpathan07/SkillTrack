<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="DSA Progress Tracker" />
<c:set var="activeNav" value="dsa" />
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
                        <span class="ios-badge ios-badge-orange">
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" aria-hidden="true"><polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"></polygon></svg>
                            Algorithms Engine
                        </span>
                    </div>
                    <h1 class="h3 font-weight-bold text-gray-800 mb-0" style="letter-spacing: -0.03em;">Data Structures &amp; Algorithms Tracker</h1>
                    <p class="text-muted small mb-0 mt-1">Systematically track your topic-wise problem solving progress across 18 core DSA topics</p>
                </div>
                <div class="d-flex align-items-center gap-2">
                    <span class="ios-badge ios-badge-blue" style="font-size: 0.85rem; padding: 0.5rem 1rem;">
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" aria-hidden="true"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg>
                        150 Problems Benchmark
                    </span>
                </div>
            </div>

            <!-- Stats Bar -->
            <div class="row mb-4">
                <div class="col-md-4 mb-3">
                    <div class="ios-metric-card ios-metric-orange">
                        <div class="ios-metric-label" style="color: #c2410c;">Total Problems Solved</div>
                        <div class="ios-metric-value"><c:out value="${totalSolved}" default="0" /></div>
                        <div class="d-flex justify-content-between align-items-center small mt-1" style="color: #475569;">
                            <span>Target Benchmark</span>
                            <strong style="color: var(--ios-text-primary);">150 Problems</strong>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-3">
                    <div class="ios-metric-card ios-metric-green">
                        <div class="ios-metric-label" style="color: var(--ios-green-dark);">Topic Coverage</div>
                        <div class="ios-metric-value">
                            <c:out value="${completedTopics}" default="0" /> 
                            <span style="font-size: 1.15rem; font-weight: 600; color: var(--ios-text-secondary);">/ <c:out value="${totalTopics}" default="18" /> topics</span>
                        </div>
                        <div class="d-flex justify-content-between align-items-center small mt-1" style="color: #475569;">
                            <span>In Progress</span>
                            <strong style="color: #b45309;"><c:out value="${inProgressTopics}" default="0" /> active topics</strong>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-3">
                    <div class="ios-metric-card ios-metric-blue">
                        <div class="ios-metric-label" style="color: #005bb5;">DSA Readiness Index</div>
                        <div class="ios-metric-value">
                            <c:out value="${totalSolved >= 150 ? 100 : (totalSolved * 100 / 150)}" default="0" />%
                        </div>
                        <div class="ios-progress-thin mt-2" style="height: 6px; border-radius: var(--ios-radius-full); background: #f1f5f9; overflow: hidden;">
                            <div class="ios-progress-bar" style="width: ${totalSolved >= 150 ? 100 : (totalSolved * 100 / 150)}%; background: linear-gradient(90deg, #0071e3, #32ade6); height: 100%; border-radius: var(--ios-radius-full); transition: width 0.6s ease;"></div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Topic Progress Matrix Card -->
            <div class="ios-card">
                <div class="ios-card-header flex-column flex-md-row align-items-md-center justify-content-between gap-3" style="padding: 1.25rem 1.5rem;">
                    <div>
                        <h2 class="h5 font-weight-bold text-dark mb-0" style="font-size: 1.15rem; letter-spacing: -0.02em;">Topic Progress Matrix</h2>
                        <small class="text-muted">Search topics and filter by completion status in real-time</small>
                    </div>

                    <!-- Search & Filter Controls -->
                    <div class="d-flex flex-wrap align-items-center gap-2">
                        <!-- Search Box -->
                        <div class="position-relative" style="min-width: 220px;">
                            <input type="text" id="topicSearchInput" class="ios-form-control" placeholder="Search DSA topics..." aria-label="Search DSA topics" style="padding-left: 2.25rem; font-size: 0.85rem; height: 38px; border-radius: var(--ios-radius-sm);">
                            <span class="position-absolute" style="left: 10px; top: 10px; color: var(--ios-text-tertiary);" aria-hidden="true">
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                            </span>
                        </div>

                        <!-- Status Filter Pills -->
                        <div class="ios-segmented-control" style="height: 38px; border-radius: var(--ios-radius-sm);">
                            <button type="button" class="ios-segment-btn active filter-status-btn" data-status="ALL">All (18)</button>
                            <button type="button" class="ios-segment-btn filter-status-btn" data-status="COMPLETED">Completed (${completedTopics})</button>
                            <button type="button" class="ios-segment-btn filter-status-btn" data-status="IN_PROGRESS">In Progress (${inProgressTopics})</button>
                            <button type="button" class="ios-segment-btn filter-status-btn" data-status="NOT_STARTED">Not Started</button>
                        </div>
                    </div>
                </div>

                <div class="ios-card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0" id="dsaTopicsTable" style="border-collapse: separate;">
                            <thead class="bg-light">
                                <tr style="border-bottom: 1px solid #e2e8f0;">
                                    <th class="border-top-0 font-weight-bold small text-uppercase py-3 px-4" style="color: #334155; letter-spacing: 0.05em; width: 60px;">#</th>
                                    <th class="border-top-0 font-weight-bold small text-uppercase py-3" style="color: #334155; letter-spacing: 0.05em;">DSA Topic</th>
                                    <th class="border-top-0 font-weight-bold small text-uppercase py-3" style="color: #334155; letter-spacing: 0.05em;">Category</th>
                                    <th class="border-top-0 font-weight-bold small text-uppercase py-3" style="color: #334155; letter-spacing: 0.05em;">Status</th>
                                    <th class="border-top-0 font-weight-bold small text-uppercase py-3" style="color: #334155; letter-spacing: 0.05em;">Problems Solved</th>
                                    <th class="border-top-0 font-weight-bold small text-uppercase py-3" style="color: #334155; letter-spacing: 0.05em;">Study Notes / Patterns</th>
                                    <th class="border-top-0 font-weight-bold small text-uppercase py-3 px-4 text-right" style="color: #334155; letter-spacing: 0.05em; width: 110px;">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${progressList}" var="p" varStatus="loop">
                                    <tr class="dsa-topic-row" 
                                        data-topic-name="${p.topicName.toLowerCase()}" 
                                        data-status="${p.status}"
                                        style="border-bottom: 1px solid #f1f5f9;">
                                        <td class="small py-3 px-4 font-weight-bold" style="color: #64748b; vertical-align: middle;">
                                            <c:out value="${loop.count}" />
                                        </td>
                                        <td class="py-3" style="vertical-align: middle;">
                                            <div class="font-weight-bold text-dark"><c:out value="${p.topicName}" /></div>
                                        </td>
                                        <td style="vertical-align: middle;">
                                            <span class="ios-badge ios-badge-gray">
                                                <c:out value="${p.topicCategory.displayName}" />
                                            </span>
                                        </td>
                                        <td style="vertical-align: middle;">
                                            <c:choose>
                                                <c:when test="${p.status == 'COMPLETED'}">
                                                    <span class="ios-badge ios-badge-green">
                                                        <svg width="10" height="10" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" aria-hidden="true"><polyline points="20 6 9 17 4 12"></polyline></svg>
                                                        Completed
                                                    </span>
                                                </c:when>
                                                <c:when test="${p.status == 'IN_PROGRESS'}">
                                                    <span class="ios-badge ios-badge-orange">
                                                        <svg width="10" height="10" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" aria-hidden="true"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg>
                                                        In Progress
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="ios-badge ios-badge-gray">
                                                        Not Started
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td style="vertical-align: middle;">
                                            <div class="d-flex align-items-center gap-2">
                                                <span class="font-weight-bold text-dark" style="font-size: 1rem;"><c:out value="${p.problemsSolved}" /></span>
                                                <span class="small" style="color: #64748b;">solved</span>
                                            </div>
                                        </td>
                                        <td class="small py-3" style="color: #475569; max-width: 260px; vertical-align: middle;">
                                            <c:choose>
                                                <c:when test="${not empty p.notes}">
                                                    <div class="text-dark" style="display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; line-height: 1.4;">
                                                        <c:out value="${p.notes}" />
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <span style="color: #94a3b8; font-style: italic;">No notes recorded</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-right py-3 px-4" style="vertical-align: middle;">
                                            <button type="button" class="btn btn-sm btn-outline-primary edit-topic-btn d-inline-flex align-items-center" 
                                                style="border-radius: var(--ios-radius-sm); padding: 0.3rem 0.85rem; font-size: 0.8rem; font-weight: 700;"
                                                data-topic-id="${p.topicId}"
                                                data-topic-name="<c:out value='${p.topicName}' />"
                                                data-category="<c:out value='${p.topicCategory.displayName}' />"
                                                data-status="${p.status}"
                                                data-problems="<c:out value='${p.problemsSolved}' />"
                                                data-notes="<c:out value='${p.notes}' />"
                                                aria-label="Update progress for ${p.topicName}">
                                                <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" class="mr-1" aria-hidden="true"><path d="M12 20h9"></path><path d="M16.5 3.5a2.121 2.121 0 0 1 3 3L7 19l-4 1 1-4L16.5 3.5z"></path></svg>
                                                Update
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>

                        <!-- Empty Filter State -->
                        <div id="noMatchMessage" class="text-center py-5 d-none" style="color: #64748b;">
                            <div class="ios-badge ios-badge-gray p-3 mb-2" style="border-radius: var(--ios-radius-full);">
                                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                            </div>
                            <div class="font-weight-bold text-dark">No matching DSA topics found</div>
                            <small class="text-muted">Try adjusting your search query or status filter.</small>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Single Global Update Topic Modal (Apple Sheet Style) -->
            <div class="modal fade" id="editDsaModal" tabindex="-1" role="dialog" aria-labelledby="editDsaModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content" style="border-radius: var(--ios-radius-lg);">
                        <div class="modal-header d-flex align-items-center justify-content-between" style="padding: 1.25rem 1.5rem;">
                            <div class="d-flex align-items-center gap-2">
                                <div class="ios-badge ios-badge-orange p-1">
                                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" aria-hidden="true"><polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"></polygon></svg>
                                </div>
                                <div>
                                    <h2 class="modal-title h5 font-weight-bold mb-0" id="editDsaModalLabel" style="font-size: 1.1rem; letter-spacing: -0.02em;">
                                        Update DSA Topic
                                    </h2>
                                    <small class="text-muted" id="modalTopicCategory">Core DSA</small>
                                </div>
                            </div>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="outline: none;">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <form action="${pageContext.request.contextPath}/app/student/dsa" method="post">
                            <input type="hidden" name="csrfToken" value="${sessionScope.CSRF_TOKEN}" />
                            <input type="hidden" id="modalTopicId" name="topicId" value="" />
                            <div class="modal-body" style="padding: 1.5rem;">
                                <div class="form-group mb-3">
                                    <label for="modalStatus" class="ios-form-label">Topic Preparation Status</label>
                                    <select class="ios-form-control" id="modalStatus" name="status">
                                        <option value="NOT_STARTED">Not Started</option>
                                        <option value="IN_PROGRESS">In Progress</option>
                                        <option value="COMPLETED">Completed</option>
                                    </select>
                                </div>

                                <div class="form-group mb-3">
                                    <div class="d-flex justify-content-between align-items-center mb-1">
                                        <label for="modalProblems" class="ios-form-label mb-0">Problems Solved</label>
                                        <div class="d-flex gap-1" style="gap: 0.35rem;">
                                            <button type="button" class="btn btn-xs btn-outline-secondary quick-add-btn" data-add="1" style="font-size: 0.75rem; padding: 0.2rem 0.55rem; border-radius: var(--ios-radius-sm); font-weight: 600;" aria-label="Add 1 problem">+1</button>
                                            <button type="button" class="btn btn-xs btn-outline-secondary quick-add-btn" data-add="5" style="font-size: 0.75rem; padding: 0.2rem 0.55rem; border-radius: var(--ios-radius-sm); font-weight: 600;" aria-label="Add 5 problems">+5</button>
                                            <button type="button" class="btn btn-xs btn-outline-secondary quick-add-btn" data-add="10" style="font-size: 0.75rem; padding: 0.2rem 0.55rem; border-radius: var(--ios-radius-sm); font-weight: 600;" aria-label="Add 10 problems">+10</button>
                                        </div>
                                    </div>
                                    <input type="number" class="ios-form-control" id="modalProblems" name="problemsSolved" min="0" required placeholder="Number of problems solved">
                                </div>

                                <div class="form-group mb-0">
                                    <label for="modalNotes" class="ios-form-label">Key Patterns &amp; Interview Notes</label>
                                    <textarea class="ios-form-control" id="modalNotes" name="notes" rows="3" placeholder="e.g. Mastered fast/slow pointer, two-pointer convergence, prefix sums, binary search on answer space..."></textarea>
                                </div>
                            </div>
                            <div class="modal-footer d-flex justify-content-end gap-2" style="padding: 1.25rem 1.5rem;">
                                <button type="button" class="ios-btn-secondary" style="padding: 0.55rem 1.35rem; font-size: 0.875rem;" data-dismiss="modal">Cancel</button>
                                <button type="submit" class="ios-btn-primary" style="padding: 0.55rem 1.5rem; font-size: 0.875rem; box-shadow: 0 4px 12px rgba(0, 113, 227, 0.25);">Save Progress</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // 1. Dynamic modal population for DSA Topic update
    $('.edit-topic-btn').on('click', function() {
        var btn = $(this);
        var topicId = btn.data('topic-id');
        var topicName = btn.data('topic-name');
        var category = btn.data('category');
        var status = btn.data('status');
        var problems = btn.data('problems');
        var notes = btn.data('notes');

        $('#modalTopicId').val(topicId);
        $('#editDsaModalLabel').text(topicName);
        $('#modalTopicCategory').text(category || 'Core DSA');
        $('#modalStatus').val(status || 'NOT_STARTED');
        $('#modalProblems').val(problems !== undefined ? problems : '0');
        $('#modalNotes').val(notes || '');

        $('#editDsaModal').modal('show');
    });

    // 2. Quick Increment Buttons in Modal (+1, +5, +10)
    $('.quick-add-btn').on('click', function() {
        var addVal = parseInt($(this).data('add'), 10) || 0;
        var current = parseInt($('#modalProblems').val(), 10) || 0;
        $('#modalProblems').val(current + addVal);
    });

    // 3. Real-time Search and Status Filter
    var currentStatusFilter = 'ALL';

    function filterTopics() {
        var searchQuery = $('#topicSearchInput').val().toLowerCase().trim();
        var visibleCount = 0;

        $('.dsa-topic-row').each(function() {
            var row = $(this);
            var topicName = row.data('topic-name') || '';
            var status = row.data('status') || '';

            var matchesSearch = (searchQuery === '' || topicName.indexOf(searchQuery) !== -1);
            var matchesStatus = (currentStatusFilter === 'ALL' || status === currentStatusFilter);

            if (matchesSearch && matchesStatus) {
                row.show();
                visibleCount++;
            } else {
                row.hide();
            }
        });

        if (visibleCount === 0) {
            $('#noMatchMessage').removeClass('d-none');
        } else {
            $('#noMatchMessage').addClass('d-none');
        }
    }

    $('#topicSearchInput').on('input', filterTopics);

    $('.filter-status-btn').on('click', function() {
        $('.filter-status-btn').removeClass('active');
        $(this).addClass('active');
        currentStatusFilter = $(this).data('status');
        filterTopics();
    });
});
</script>

<%@ include file="/WEB-INF/views/common/footer.jspf" %>
