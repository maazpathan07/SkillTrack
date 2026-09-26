<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="pageTitle" value="AI Placement Readiness Coach" />
<c:set var="activeNav" value="ai-coach" />
<%@ include file="/WEB-INF/views/common/header.jspf" %>
<%@ include file="/WEB-INF/views/common/navbar.jspf" %>

<style>
    /* AI Placement Coach Glassmorphic Styles */
    .chat-container {
        display: flex;
        flex-direction: column;
        height: 650px;
        background: #ffffff;
        border-radius: var(--ios-radius-md, 16px);
        border: 1.5px solid rgba(0, 0, 0, 0.08);
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.04);
        overflow: hidden;
    }
    .chat-header {
        padding: 1rem 1.25rem;
        background: #ffffff;
        border-bottom: 1.5px solid rgba(0, 0, 0, 0.06);
        display: flex;
        align-items: center;
        justify-content: space-between;
    }
    .chat-messages {
        flex: 1;
        padding: 1.25rem;
        overflow-y: auto;
        display: flex;
        flex-direction: column;
        gap: 1.2rem;
        background: #f8fafc;
        scroll-behavior: smooth;
    }
    .chat-bubble-ai {
        align-self: flex-start;
        max-width: 86%;
        background: #ffffff;
        border: 1px solid rgba(0, 0, 0, 0.08);
        border-radius: 18px 18px 18px 4px;
        padding: 1rem 1.25rem;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.03);
        color: #1e293b;
        font-size: 0.9rem;
        line-height: 1.6;
    }
    .chat-bubble-user {
        align-self: flex-end;
        max-width: 80%;
        background: linear-gradient(135deg, #0071e3, #5856d6);
        color: #ffffff;
        border-radius: 18px 18px 4px 18px;
        padding: 0.85rem 1.15rem;
        box-shadow: 0 4px 14px rgba(0, 113, 227, 0.25);
        font-size: 0.9rem;
        line-height: 1.5;
    }
    .chat-input-area {
        padding: 1rem 1.25rem;
        background: #ffffff;
        border-top: 1.5px solid rgba(0, 0, 0, 0.06);
    }
    .prompt-chip {
        display: inline-flex;
        align-items: center;
        font-size: 0.76rem;
        font-weight: 600;
        padding: 0.35rem 0.85rem;
        border-radius: 20px;
        background: #ffffff;
        color: #475569;
        border: 1px solid rgba(0, 0, 0, 0.1);
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.03);
        cursor: pointer;
        transition: all 0.2s ease;
        white-space: nowrap;
    }
    .prompt-chip:hover {
        background: rgba(0, 113, 227, 0.08);
        border-color: rgba(0, 113, 227, 0.3);
        color: #0071e3;
        transform: translateY(-1px);
    }
    .ai-avatar {
        width: 38px;
        height: 38px;
        border-radius: 12px;
        background: linear-gradient(135deg, #0071e3, #8b5cf6);
        color: #ffffff;
        display: flex;
        align-items: center;
        justify-content: center;
        flex-shrink: 0;
        box-shadow: 0 4px 10px rgba(0, 113, 227, 0.3);
    }
    .typing-indicator {
        display: none;
        align-self: flex-start;
        padding: 0.6rem 1rem;
        background: #ffffff;
        border: 1px solid rgba(0, 0, 0, 0.08);
        border-radius: 14px;
        font-size: 0.78rem;
        color: #64748b;
        gap: 0.4rem;
        align-items: center;
    }
    .typing-dot {
        width: 6px;
        height: 6px;
        background: #0071e3;
        border-radius: 50%;
        animation: typingAnimation 1.4s infinite ease-in-out both;
    }
    .typing-dot:nth-child(1) { animation-delay: -0.32s; }
    .typing-dot:nth-child(2) { animation-delay: -0.16s; }
    @keyframes typingAnimation {
        0%, 80%, 100% { transform: scale(0); opacity: 0.4; }
        40% { transform: scale(1); opacity: 1; }
    }
    .study-plan-card {
        border-radius: var(--ios-radius-md, 14px);
        background: #ffffff;
        border: 1px solid rgba(0, 0, 0, 0.08);
        padding: 1rem;
        transition: all 0.2s ease;
    }
    .study-plan-card:hover {
        border-color: rgba(0, 113, 227, 0.3);
        box-shadow: 0 4px 14px rgba(0, 0, 0, 0.05);
    }
</style>

<div class="container-fluid">
    <div class="row">
        <%@ include file="/WEB-INF/views/common/sidebar.jspf" %>

        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4 py-4">
            <%@ include file="/WEB-INF/views/common/alerts.jspf" %>

            <!-- Page Header -->
            <div class="ios-dash-header mb-4">
                <div>
                    <div class="d-flex align-items-center gap-2 mb-1.5 flex-wrap">
                        <span class="ios-badge ios-badge-purple">
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" class="mr-1"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"></polygon></svg>
                            AI Placement Readiness Coach
                        </span>
                        <span class="ios-badge ios-badge-blue">
                            Live Profile Context Aware
                        </span>
                    </div>
                    <h1 class="h3 font-weight-bold text-gray-800 mb-1" style="letter-spacing: -0.03em;">
                        AI Career &amp; Placement Mentor
                    </h1>
                    <p class="text-muted small mb-0" style="max-width: 720px; line-height: 1.5;">
                        Get personalized weak-spot analysis, weekly milestone plans, and 1-on-1 placement guidance tailored to your target company benchmarks.
                    </p>
                </div>
                <div class="d-flex align-items-center flex-wrap gap-2 mt-3 mt-lg-0">
                    <a href="${pageContext.request.contextPath}/app/student/dream-job" class="ios-btn-secondary d-inline-flex align-items-center" style="padding: 0.55rem 1.1rem; font-size: 0.85rem;">
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="mr-1.5"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"></polygon></svg>
                        Dream Job Matcher
                    </a>
                    <a href="${pageContext.request.contextPath}/app/student/dsa" class="ios-btn-primary d-inline-flex align-items-center" style="padding: 0.55rem 1.1rem; font-size: 0.85rem;">
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="mr-1.5"><polyline points="22 12 18 12 15 21 9 3 6 12 2 12"></polyline></svg>
                        LeetCode Tracker
                    </a>
                </div>
            </div>

            <!-- Main Layout: Left (ChatGPT-Style Coach Window) & Right (Weekly Action Plan & Benchmarks) -->
            <div class="row">
                <!-- Left: Interactive Chat Window -->
                <div class="col-lg-7 mb-4">
                    <div class="chat-container">
                        <!-- Chat Header -->
                        <div class="chat-header">
                            <div class="d-flex align-items-center" style="gap: 0.75rem;">
                                <div class="ai-avatar">
                                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><polygon points="10 8 16 12 10 16 10 8"></polygon></svg>
                                </div>
                                <div>
                                    <h2 class="h6 font-weight-bold text-dark mb-0" style="font-size: 0.95rem;">SkillTrack Placement Coach</h2>
                                    <span class="text-muted d-block" style="font-size: 0.74rem;">Coaching Target: <strong class="text-primary"><c:out value="${coachOverview.targetCompany}" /></strong> (<c:out value="${coachOverview.targetRole}" />)</span>
                                </div>
                            </div>
                            <!-- Target Company Switcher Dropdown -->
                            <div class="dropdown">
                                <button class="btn btn-sm btn-light border dropdown-toggle font-weight-semibold" type="button" id="targetCompanyDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="border-radius: 10px; font-size: 0.78rem;">
                                    Target: <c:out value="${coachOverview.targetCompany}" />
                                </button>
                                <div class="dropdown-menu dropdown-menu-right shadow-sm" aria-labelledby="targetCompanyDropdown" style="border-radius: 12px;">
                                    <c:forEach items="${companyPresets}" var="cp">
                                        <a class="dropdown-item small font-weight-500 py-2" href="${pageContext.request.contextPath}/app/student/ai-coach?criteriaId=${cp.criteriaId}">
                                            <c:out value="${cp.companyName}" /> &bull; <span class="text-muted"><c:out value="${cp.roleTitle}" /></span>
                                        </a>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>

                        <!-- Chat Messages Stream -->
                        <div class="chat-messages" id="chatMessagesBox">
                            <c:forEach items="${coachOverview.recentChatHistory}" var="msg">
                                <div class="d-flex align-items-start" style="gap: 0.75rem;">
                                    <div class="ai-avatar" style="width: 32px; height: 32px; border-radius: 10px;">
                                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><polygon points="10 8 16 12 10 16 10 8"></polygon></svg>
                                    </div>
                                    <div class="chat-bubble-ai">
                                        <div class="chat-text" style="white-space: pre-wrap;"><c:out value="${msg.content}" /></div>
                                        <div class="d-flex justify-content-between align-items-center mt-2 pt-1 border-top" style="font-size: 0.7rem; color: #94a3b8;">
                                            <span>AI Coach</span>
                                            <span>${msg.formattedTime}</span>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>

                            <!-- Live Typing Animation Indicator -->
                            <div class="typing-indicator" id="typingIndicator">
                                <div class="d-flex align-items-center" style="gap: 4px;">
                                    <div class="typing-dot"></div>
                                    <div class="typing-dot"></div>
                                    <div class="typing-dot"></div>
                                </div>
                                <span class="ml-1">AI Coach is analyzing your profile...</span>
                            </div>
                        </div>

                        <!-- Quick Prompts Row -->
                        <div class="px-3 pt-2 pb-1 bg-white border-top d-flex align-items-center gap-2 overflow-auto flex-nowrap" id="quickPromptsContainer" style="scrollbar-width: none;">
                            <c:forEach items="${coachOverview.suggestedPrompts}" var="p">
                                <button type="button" class="prompt-chip quick-prompt-btn" data-prompt="${p}">
                                    &plus; <c:out value="${p}" />
                                </button>
                            </c:forEach>
                        </div>

                        <!-- Chat Input Box -->
                        <div class="chat-input-area">
                            <form id="aiChatForm" class="d-flex align-items-center" style="gap: 0.6rem;">
                                <input type="hidden" name="csrfToken" id="coachCsrfToken" value="${sessionScope.CSRF_TOKEN}" />
                                <input type="hidden" name="criteriaId" id="coachCriteriaId" value="${selectedCriteriaId}" />
                                <input type="text" class="ios-form-control flex-grow-1" id="chatInputText" placeholder="Ask anything about ${coachOverview.targetCompany} prep, DSA patterns, or mock questions..." autocomplete="off" style="font-size: 0.88rem; padding: 0.7rem 1.1rem; border-radius: 14px;" />
                                <button type="submit" class="ios-btn-primary d-inline-flex align-items-center justify-content-center shadow-sm" id="sendChatBtn" style="padding: 0.7rem 1.25rem; border-radius: 14px; font-weight: 700;">
                                    <span>Send</span>
                                    <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" class="ml-1.5"><line x1="22" y1="2" x2="11" y2="13"></line><polygon points="22 2 15 22 11 13 2 9 22 2"></polygon></svg>
                                </button>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Right: Actionable Weekly Study Plan & Profile Match Readiness -->
                <div class="col-lg-5 mb-4">
                    <!-- Target Match Gauge Card -->
                    <c:set var="scoreColor" value="${coachOverview.overallReadinessScore >= 80 ? '#34c759' : (coachOverview.overallReadinessScore >= 55 ? '#ff9500' : '#0071e3')}" />
                    <div class="ios-card mb-3.5 shadow-sm p-4" style="border-left: 4.5px solid ${scoreColor}; background: #ffffff;">
                        <div class="d-flex align-items-center justify-content-between">
                            <div>
                                <span class="ios-badge ios-badge-blue mb-1 font-weight-bold" style="font-size: 0.72rem;">
                                    Target: <c:out value="${coachOverview.targetCompany}" />
                                </span>
                                <h3 class="h5 font-weight-bold text-dark mb-1" style="font-size: 1.1rem; letter-spacing: -0.02em;">
                                    Readiness Score
                                </h3>
                                <small class="text-muted d-block" style="font-size: 0.78rem; line-height: 1.35;">
                                    Top Focus: <strong class="text-dark"><c:out value="${coachOverview.topWeaknessTopic}" /></strong>
                                </small>
                            </div>

                            <div class="text-center">
                                <span style="font-size: 1.9rem; font-weight: 800; color: ${scoreColor}; line-height: 1;"><c:out value="${coachOverview.overallReadinessScore}" />%</span>
                                <small class="text-muted d-block font-weight-bold text-uppercase" style="font-size: 0.65rem; letter-spacing: 0.05em; margin-top: 2px;">Match</small>
                            </div>
                        </div>

                        <!-- Mini Benchmarks Progress Row -->
                        <div class="row pt-3 mt-3 border-top g-2 text-center" style="font-size: 0.75rem;">
                            <div class="col-4 border-right">
                                <span class="text-muted d-block" style="font-size: 0.7rem;">DSA Solved</span>
                                <strong class="text-dark">${coachOverview.dsaSolved} / ${coachOverview.dsaTarget}+</strong>
                            </div>
                            <div class="col-4 border-right">
                                <span class="text-muted d-block" style="font-size: 0.7rem;">Projects</span>
                                <strong class="text-dark">${coachOverview.projectsCount} / ${coachOverview.projectsTarget}</strong>
                            </div>
                            <div class="col-4">
                                <span class="text-muted d-block" style="font-size: 0.7rem;">CGPA</span>
                                <strong class="text-dark">${coachOverview.cgpa}</strong>
                            </div>
                        </div>
                    </div>

                    <!-- Weekly Study Plan Checklist Widget -->
                    <div class="ios-card shadow-sm p-4" style="background: #ffffff;">
                        <div class="d-flex align-items-center justify-content-between mb-3 pb-2 border-bottom">
                            <div>
                                <h3 class="h6 font-weight-bold text-dark mb-0.5 d-flex align-items-center" style="font-size: 1.02rem;">
                                    <svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="#0071e3" stroke-width="2.2" class="mr-2"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg>
                                    7-Day Weekly Study Plan
                                </h3>
                                <small class="text-muted">Target milestones generated by AI for this week</small>
                            </div>
                            <span class="badge badge-primary px-2.5 py-1 font-weight-semibold" style="font-size: 0.72rem; border-radius: 12px; background: #0071e3;">
                                ${fn:length(coachOverview.weeklyStudyPlan)} Goals
                            </span>
                        </div>

                        <div class="d-flex flex-column" style="gap: 0.75rem;">
                            <c:forEach items="${coachOverview.weeklyStudyPlan}" var="plan" varStatus="loop">
                                <div class="study-plan-card">
                                    <div class="d-flex align-items-start justify-content-between">
                                        <div class="d-flex align-items-start" style="gap: 0.65rem;">
                                            <div class="rounded-circle d-flex align-items-center justify-content-center font-weight-bold flex-shrink-0 mt-0.5" style="width: 24px; height: 24px; background: rgba(0, 113, 227, 0.1); color: #0071e3; font-size: 0.75rem;">
                                                ${loop.count}
                                            </div>
                                            <div>
                                                <div class="d-flex align-items-center gap-1.5 mb-1 flex-wrap">
                                                    <strong class="text-dark" style="font-size: 0.86rem;"><c:out value="${plan.title}" /></strong>
                                                    <span class="badge ${plan.priority == 'HIGH' ? 'badge-danger' : 'badge-secondary'} px-2 py-0.5" style="font-size: 0.65rem; border-radius: 8px;">
                                                        <c:out value="${plan.priority}" />
                                                    </span>
                                                </div>
                                                <p class="text-muted small mb-2" style="font-size: 0.76rem; line-height: 1.4;"><c:out value="${plan.description}" /></p>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="d-flex align-items-center justify-content-end pt-2 border-top" style="gap: 0.5rem;">
                                        <button type="button" class="btn btn-sm btn-light border font-weight-semibold sync-task-btn d-inline-flex align-items-center"
                                                data-title="${plan.title}"
                                                data-desc="${plan.description}"
                                                data-cat="${plan.category}"
                                                style="border-radius: 12px; font-size: 0.74rem; padding: 0.3rem 0.75rem;">
                                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" class="mr-1"><line x1="12" y1="5" x2="12" y2="19"></line><line x1="5" y1="12" x2="19" y2="12"></line></svg>
                                            Sync to Checklist
                                        </button>
                                        <a href="${pageContext.request.contextPath}${plan.actionUrl}" class="btn btn-sm btn-outline-primary font-weight-semibold" style="border-radius: 12px; font-size: 0.74rem; padding: 0.3rem 0.75rem;">
                                            Practice &rarr;
                                        </a>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>

        </main>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    var chatBox = document.getElementById('chatMessagesBox');
    var chatForm = document.getElementById('aiChatForm');
    var inputField = document.getElementById('chatInputText');
    var typingIndicator = document.getElementById('typingIndicator');
    var quickPromptBtns = document.querySelectorAll('.quick-prompt-btn');
    var syncTaskBtns = document.querySelectorAll('.sync-task-btn');

    function scrollToBottom() {
        chatBox.scrollTop = chatBox.scrollHeight;
    }

    // Quick prompt chip click handler
    quickPromptBtns.forEach(function(btn) {
        btn.addEventListener('click', function() {
            var promptText = this.getAttribute('data-prompt');
            if (promptText) {
                inputField.value = promptText;
                sendMessage(promptText);
            }
        });
    });

    // Form submit
    if (chatForm) {
        chatForm.addEventListener('submit', function(e) {
            e.preventDefault();
            var text = inputField.value.trim();
            if (!text) return;
            sendMessage(text);
        });
    }

    function sendMessage(userText) {
        // Append user bubble to UI
        var userBubbleHtml = 
            '<div class="d-flex align-items-start justify-content-end" style="gap: 0.75rem;">' +
                '<div class="chat-bubble-user">' +
                    '<div>' + escapeHtml(userText) + '</div>' +
                    '<div class="text-right mt-1" style="font-size: 0.68rem; opacity: 0.85;">' + getCurrentTime() + '</div>' +
                '</div>' +
            '</div>';
        
        chatBox.insertAdjacentHTML('beforeend', userBubbleHtml);
        inputField.value = '';
        scrollToBottom();

        // Show typing animation
        typingIndicator.style.display = 'inline-flex';
        chatBox.appendChild(typingIndicator);
        scrollToBottom();

        var csrfToken = document.getElementById('coachCsrfToken').value;
        var criteriaId = document.getElementById('coachCriteriaId').value;

        var params = new URLSearchParams();
        params.append('action', 'chat-query');
        params.append('csrfToken', csrfToken);
        params.append('query', userText);
        if (criteriaId) params.append('criteriaId', criteriaId);

        fetch('${pageContext.request.contextPath}/app/student/ai-coach', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
            },
            body: params.toString()
        })
        .then(function(res) { return res.json(); })
        .then(function(data) {
            typingIndicator.style.display = 'none';
            if (data.status === 'success') {
                var aiBubbleHtml = 
                    '<div class="d-flex align-items-start" style="gap: 0.75rem;">' +
                        '<div class="ai-avatar" style="width: 32px; height: 32px; border-radius: 10px;">' +
                            '<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><polygon points="10 8 16 12 10 16 10 8"></polygon></svg>' +
                        '</div>' +
                        '<div class="chat-bubble-ai">' +
                            '<div class="chat-text" style="white-space: pre-wrap;">' + renderFormattedMarkdown(data.message) + '</div>' +
                            '<div class="d-flex justify-content-between align-items-center mt-2 pt-1 border-top" style="font-size: 0.7rem; color: #94a3b8;">' +
                                '<span>AI Coach</span>' +
                                '<span>' + (data.formattedTime || getCurrentTime()) + '</span>' +
                            '</div>' +
                        '</div>' +
                    '</div>';

                chatBox.insertAdjacentHTML('beforeend', aiBubbleHtml);

                // Update follow-up prompt chips if returned
                if (data.followups && data.followups.length > 0) {
                    var promptsBox = document.getElementById('quickPromptsContainer');
                    if (promptsBox) {
                        var chipsHtml = '';
                        data.followups.forEach(function(f) {
                            chipsHtml += '<button type="button" class="prompt-chip dynamic-prompt-btn" data-prompt="' + escapeHtml(f) + '">&plus; ' + escapeHtml(f) + '</button>';
                        });
                        promptsBox.innerHTML = chipsHtml;
                        attachDynamicPromptListeners();
                    }
                }
            } else {
                appendSystemError("Unable to get response from AI Coach. Please try again.");
            }
            scrollToBottom();
        })
        .catch(function(err) {
            typingIndicator.style.display = 'none';
            appendSystemError("Network error contacting AI Coach.");
            scrollToBottom();
        });
    }

    function attachDynamicPromptListeners() {
        var dynBtns = document.querySelectorAll('.dynamic-prompt-btn');
        dynBtns.forEach(function(btn) {
            btn.addEventListener('click', function() {
                var promptText = this.getAttribute('data-prompt');
                if (promptText) {
                    inputField.value = promptText;
                    sendMessage(promptText);
                }
            });
        });
    }

    function appendSystemError(msg) {
        var errorHtml = '<div class="text-center py-2 text-danger small font-weight-semibold">' + escapeHtml(msg) + '</div>';
        chatBox.insertAdjacentHTML('beforeend', errorHtml);
    }

    function escapeHtml(text) {
        if (!text) return '';
        var div = document.createElement('div');
        div.textContent = text;
        return div.innerHTML;
    }

    function renderFormattedMarkdown(text) {
        if (!text) return '';
        // Bold formatting **text**
        var parsed = text.replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>');
        // Inline backticks `code`
        parsed = parsed.replace(/`([^`]+)`/g, '<code style="background: rgba(0,0,0,0.06); padding: 2px 5px; border-radius: 4px; font-size: 0.85em;">$1</code>');
        return parsed;
    }

    function getCurrentTime() {
        var d = new Date();
        var hours = d.getHours();
        var minutes = d.getMinutes();
        var ampm = hours >= 12 ? 'PM' : 'AM';
        hours = hours % 12;
        hours = hours ? hours : 12;
        minutes = minutes < 10 ? '0' + minutes : minutes;
        return hours + ':' + minutes + ' ' + ampm;
    }

    // Sync task AJAX handler
    syncTaskBtns.forEach(function(btn) {
        btn.addEventListener('click', function(e) {
            e.preventDefault();
            var title = this.getAttribute('data-title');
            var desc = this.getAttribute('data-desc');
            var cat = this.getAttribute('data-cat');
            var buttonEl = this;

            var csrfToken = document.getElementById('coachCsrfToken').value;

            var formData = new URLSearchParams();
            formData.append('csrfToken', csrfToken);
            formData.append('action', 'add-plan-task');
            formData.append('title', title);
            formData.append('description', desc);
            formData.append('category', cat);

            buttonEl.disabled = true;
            buttonEl.innerHTML = '<span class="spinner-border spinner-border-sm mr-1"></span> Syncing...';

            fetch('${pageContext.request.contextPath}/app/student/ai-coach', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
                },
                body: formData.toString()
            })
            .then(function(res) { return res.json(); })
            .then(function(data) {
                if (data.status === 'success') {
                    buttonEl.className = 'btn btn-sm btn-success font-weight-semibold d-inline-flex align-items-center';
                    buttonEl.innerHTML = '&check; Synced to Checklist';
                } else {
                    buttonEl.disabled = false;
                    buttonEl.innerHTML = 'Retry Sync';
                }
            })
            .catch(function() {
                buttonEl.disabled = false;
                buttonEl.innerHTML = 'Retry Sync';
            });
        });
    });
});
</script>

<%@ include file="/WEB-INF/views/common/footer.jspf" %>
