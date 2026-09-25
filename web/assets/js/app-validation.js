/**
 * SkillTrack — Enterprise Client Helper & Interactive UI Validation
 * Apple iOS 18 Glassmorphism UI Component Logic
 * Authoritative security & logic remains strictly in the Server Layer.
 */

document.addEventListener("DOMContentLoaded", function () {
    // 1. Auto-dismiss alert messages & floating toasts smoothly after 2 seconds (2000ms)
    function dismissAlertSmoothly(alertEl) {
        if (!alertEl || alertEl.dataset.dismissing === 'true') return;
        alertEl.dataset.dismissing = 'true';
        
        var isToast = alertEl.classList.contains('ios-toast') || (alertEl.parentNode && alertEl.parentNode.classList.contains('ios-toast-container'));
        
        if (isToast) {
            alertEl.style.transition = "all 0.35s cubic-bezier(0.2, 0.8, 0.2, 1)";
            alertEl.style.opacity = "0";
            alertEl.style.transform = "translateX(40px) scale(0.95)";
            setTimeout(function () {
                if (alertEl.parentNode) {
                    var container = alertEl.parentNode;
                    container.removeChild(alertEl);
                    if (container.classList && container.classList.contains('ios-toast-container') && container.children.length === 0) {
                        if (container.parentNode) container.parentNode.removeChild(container);
                    }
                }
            }, 360);
        } else {
            alertEl.style.transition = "all 0.4s cubic-bezier(0.2, 0.8, 0.2, 1)";
            alertEl.style.opacity = "0";
            alertEl.style.transform = "translateY(-6px)";
            
            setTimeout(function () {
                alertEl.style.maxHeight = "0px";
                alertEl.style.paddingTop = "0px";
                alertEl.style.paddingBottom = "0px";
                alertEl.style.marginTop = "0px";
                alertEl.style.marginBottom = "0px";
                alertEl.style.borderWidth = "0px";
                alertEl.style.overflow = "hidden";
            }, 100);

            setTimeout(function () {
                if (alertEl.parentNode) {
                    alertEl.parentNode.removeChild(alertEl);
                }
            }, 450);
        }
    }

    setTimeout(function () {
        var alerts = document.querySelectorAll(".alert-dismissible, .ios-alert, .alert, .st-alert");
        alerts.forEach(function (alert) {
            dismissAlertSmoothly(alert);
        });
    }, 2000);

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

    function openConfirmModal(title, message, targetElement, btnText) {
        var elements = getModalElements();
        if (!elements) return;

        activeTarget = targetElement;

        if (elements.title) elements.title.textContent = title || "Confirm Action";
        if (elements.msg) elements.msg.textContent = message || "Are you sure you want to proceed?";
        if (elements.submitBtn) {
            elements.submitBtn.textContent = btnText || (title && title.toLowerCase().indexOf("sign out") !== -1 ? "Sign Out" : "Yes, Proceed");
        }

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

    // Universal click interceptor for .confirm-delete, .confirm-signout, .confirm-logout buttons
    document.addEventListener("click", function (event) {
        var button = event.target.closest(".confirm-delete, .confirm-signout, .confirm-logout");
        if (!button) return;

        event.preventDefault();
        event.stopPropagation();

        var form = button.closest("form");
        var target = form || button;
        var msg = button.getAttribute("data-confirm") || "Are you sure you want to proceed?";
        var title = button.getAttribute("data-title") || "Confirm Action";
        var btnText = button.getAttribute("data-btn") || "Confirm";

        openConfirmModal(title, msg, target, btnText);
    }, true);

    // 4. Navbar Sticky Glassmorphic State Controller
    var navbar = document.querySelector(".ios-navbar");

    function handleNavbarScroll() {
        if (!navbar) return;
        var scrollY = window.pageYOffset || document.documentElement.scrollTop;
        if (scrollY > 20) {
            navbar.classList.add("is-scrolled");
        } else {
            navbar.classList.remove("is-scrolled");
        }
    }

    window.addEventListener("scroll", handleNavbarScroll, { passive: true });
    handleNavbarScroll();
});

// 5. Global Mobile Drawer Controller (Accessible from anywhere)
window.toggleSkillTrackMobileDrawer = function(e) {
    if (e) {
        if (e.preventDefault) e.preventDefault();
        if (e.stopPropagation) e.stopPropagation();
    }
    var drawer = document.getElementById('mobileNavDrawer') || document.getElementById('iosMobileDrawer');
    if (!drawer) return;
    var isCurrentlyOpen = drawer.classList.contains('is-open');
    if (isCurrentlyOpen) {
        drawer.classList.remove('is-open');
        drawer.setAttribute('aria-hidden', 'true');
        document.body.style.overflow = '';
    } else {
        drawer.classList.add('is-open');
        drawer.setAttribute('aria-hidden', 'false');
        document.body.style.overflow = 'hidden';
    }
};

window.closeSkillTrackMobileDrawer = function(e) {
    if (e) {
        if (e.preventDefault) e.preventDefault();
        if (e.stopPropagation) e.stopPropagation();
    }
    var drawer = document.getElementById('mobileNavDrawer') || document.getElementById('iosMobileDrawer');
    if (drawer) {
        drawer.classList.remove('is-open');
        drawer.setAttribute('aria-hidden', 'true');
        document.body.style.overflow = '';
    }
};
