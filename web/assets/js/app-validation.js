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
    var activeTarget = null;

    function getModalElements() {
        var backdrop = document.getElementById("iosConfirmModalBackdrop");
        if (!backdrop) return null;
        return {
            backdrop: backdrop,
            title: document.getElementById("iosConfirmModalTitle"),
            msg: document.getElementById("iosConfirmModalMessage"),
            cancelBtn: document.getElementById("iosConfirmModalCancel"),
            submitBtn: document.getElementById("iosConfirmModalSubmit")
        };
    }

    function openConfirmModal(title, message, targetElement) {
        var elements = getModalElements();
        if (!elements) return;

        activeTarget = targetElement;

        if (elements.title) elements.title.textContent = title || "Confirm Deletion";
        if (elements.msg) elements.msg.textContent = message || "Are you sure you want to permanently remove this record?";

        elements.backdrop.style.display = "flex";
        // Force reflow for smooth animation
        void elements.backdrop.offsetWidth;
        elements.backdrop.classList.add("is-open");

        if (elements.cancelBtn) elements.cancelBtn.focus();
    }

    function closeConfirmModal() {
        var elements = getModalElements();
        if (!elements) return;

        elements.backdrop.classList.remove("is-open");
        setTimeout(function() {
            if (!elements.backdrop.classList.contains("is-open")) {
                elements.backdrop.style.display = "none";
            }
        }, 200);
        activeTarget = null;
    }

    // Modal button interactions
    var modalElements = getModalElements();
    if (modalElements) {
        // Cancel button click
        if (modalElements.cancelBtn) {
            modalElements.cancelBtn.addEventListener("click", function (e) {
                e.preventDefault();
                closeConfirmModal();
            });
        }

        // Submit/Confirm button click
        if (modalElements.submitBtn) {
            modalElements.submitBtn.addEventListener("click", function (e) {
                e.preventDefault();
                if (activeTarget) {
                    var target = activeTarget;
                    closeConfirmModal();
                    if (target.tagName === "FORM") {
                        target.submit();
                    } else if (target.closest && target.closest("form")) {
                        target.closest("form").submit();
                    } else if (target.tagName === "A" && target.href) {
                        window.location.href = target.href;
                    }
                } else {
                    closeConfirmModal();
                }
            });
        }

        // Backdrop click to dismiss
        modalElements.backdrop.addEventListener("click", function (e) {
            if (e.target === modalElements.backdrop) {
                closeConfirmModal();
            }
        });

        // Escape key to dismiss
        document.addEventListener("keydown", function (e) {
            if (e.key === "Escape" && modalElements.backdrop.classList.contains("is-open")) {
                closeConfirmModal();
            }
        });
    }

    // Universal click interceptor for .confirm-delete buttons
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
    }, true);
});
