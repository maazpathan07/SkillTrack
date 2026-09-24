/**
 * SkillTrack — Enterprise Client Helper & Interactive UI Validation
 * Apple iOS 18 Glassmorphism UI Component Logic
 * Authoritative security & logic remains strictly in the Server Layer.
 */

document.addEventListener("DOMContentLoaded", function () {
    // 1. Auto-dismiss alert messages smoothly after 6 seconds
    setTimeout(function () {
        var alerts = document.querySelectorAll(".alert-dismissible, .st-alert");
        alerts.forEach(function (alert) {
            if (typeof $ !== 'undefined' && $(alert).alert) {
                $(alert).alert("close");
            } else {
                alert.style.transition = "opacity 0.5s ease";
                alert.style.opacity = "0";
                setTimeout(function() { if (alert.parentNode) alert.parentNode.removeChild(alert); }, 500);
            }
        });
    }, 6000);

    // 2. Bootstrap 4 instant form validation feedback
    var forms = document.querySelectorAll(".needs-validation");
    Array.prototype.slice.call(forms).forEach(function (form) {
        form.addEventListener("submit", function (event) {
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }
            form.classList.add("was-validated");
        }, false);
    });

    // 3. Apple iOS 18 Liquid Glassmorphic Confirmation Modal System
    var activeFormOrLink = null;

    function createOrGetConfirmModal() {
        var existing = document.getElementById("iosConfirmModalBackdrop");
        if (existing) return existing;

        var backdrop = document.createElement("div");
        backdrop.id = "iosConfirmModalBackdrop";
        backdrop.className = "ios-modal-backdrop";
        backdrop.setAttribute("role", "dialog");
        backdrop.setAttribute("aria-modal", "true");
        backdrop.setAttribute("aria-labelledby", "iosConfirmModalTitle");

        backdrop.innerHTML = [
            '<div class="ios-modal-card">',
            '  <div class="ios-modal-icon-badge" aria-hidden="true">',
            '    <svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">',
            '      <polyline points="3 6 5 6 21 6"></polyline>',
            '      <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>',
            '      <line x1="10" y1="11" x2="10" y2="17"></line>',
            '      <line x1="14" y1="11" x2="14" y2="17"></line>',
            '    </svg>',
            '  </div>',
            '  <h3 id="iosConfirmModalTitle" class="ios-modal-title">Confirm Deletion</h3>',
            '  <p id="iosConfirmModalMessage" class="ios-modal-body-text">Are you sure you want to remove this item? This action cannot be undone.</p>',
            '  <div class="ios-modal-actions">',
            '    <button type="button" id="iosConfirmModalCancel" class="ios-modal-btn-cancel">Cancel</button>',
            '    <button type="button" id="iosConfirmModalSubmit" class="ios-modal-btn-confirm">Yes, Remove</button>',
            '  </div>',
            '</div>'
        ].join('\n');

        document.body.appendChild(backdrop);

        // Backdrop click to cancel
        backdrop.addEventListener("click", function (e) {
            if (e.target === backdrop) {
                closeConfirmModal();
            }
        });

        // Cancel button click
        document.getElementById("iosConfirmModalCancel").addEventListener("click", function () {
            closeConfirmModal();
        });

        // Confirm button click
        document.getElementById("iosConfirmModalSubmit").addEventListener("click", function () {
            if (activeFormOrLink) {
                if (activeFormOrLink.tagName === "FORM") {
                    activeFormOrLink.submit();
                } else if (activeFormOrLink.tagName === "A" && activeFormOrLink.href) {
                    window.location.href = activeFormOrLink.href;
                }
            }
            closeConfirmModal();
        });

        // Escape key to close
        document.addEventListener("keydown", function (e) {
            if (e.key === "Escape" && backdrop.classList.contains("is-open")) {
                closeConfirmModal();
            }
        });

        return backdrop;
    }

    function openConfirmModal(title, message, targetElement) {
        var modal = createOrGetConfirmModal();
        activeFormOrLink = targetElement;

        var titleEl = document.getElementById("iosConfirmModalTitle");
        var msgEl = document.getElementById("iosConfirmModalMessage");

        if (titleEl) titleEl.textContent = title || "Confirm Deletion";
        if (msgEl) msgEl.textContent = message || "Are you sure you want to permanently remove this record?";

        modal.classList.add("is-open");
        var cancelBtn = document.getElementById("iosConfirmModalCancel");
        if (cancelBtn) cancelBtn.focus();
    }

    function closeConfirmModal() {
        var modal = document.getElementById("iosConfirmModalBackdrop");
        if (modal) {
            modal.classList.remove("is-open");
        }
        activeFormOrLink = null;
    }

    // Attach delegated click listener to all confirm-delete buttons
    document.addEventListener("click", function (event) {
        var button = event.target.closest(".confirm-delete");
        if (!button) return;

        event.preventDefault();
        event.stopPropagation();

        var form = button.closest("form");
        var target = form || button;
        var msg = button.getAttribute("data-confirm") || "Are you sure you want to permanently delete this item?";
        var title = button.getAttribute("data-title") || "Confirm Removal";

        openConfirmModal(title, msg, target);
    });
});
