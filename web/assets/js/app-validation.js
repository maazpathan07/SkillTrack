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

    // 4. Apple iOS 18 Smooth Scroll Momentum & Timing System
    var isUserClickScrolling = false;
    var userClickTimer = null;

    function setActiveNavLink(targetId) {
        if (!targetId) return;
        var links = document.querySelectorAll(".ios-navbar .ios-nav-link[href^='#'], .ios-navbar .ios-capsule-link[href^='#'], .ios-mobile-link[href^='#']");
        links.forEach(function (link) {
            var href = link.getAttribute("href");
            if (href === targetId) {
                link.classList.add("active");
            } else {
                link.classList.remove("active");
            }
        });
    }

    function smoothScrollTo(targetY, duration, targetId) {
        var startY = window.pageYOffset || document.documentElement.scrollTop;
        var diff = targetY - startY;
        if (Math.abs(diff) < 2) return;

        isUserClickScrolling = true;
        if (userClickTimer) clearTimeout(userClickTimer);
        if (targetId) setActiveNavLink(targetId);

        var start = null;
        duration = duration || 500;

        function easeInOutQuad(t, b, c, d) {
            t /= d / 2;
            if (t < 1) return c / 2 * t * t + b;
            t--;
            return -c / 2 * (t * (t - 2) - 1) + b;
        }

        function step(timestamp) {
            if (!start) start = timestamp;
            var progress = timestamp - start;
            var current = easeInOutQuad(progress, startY, diff, duration);
            window.scrollTo(0, current);
            if (progress < duration) {
                window.requestAnimationFrame(step);
            } else {
                window.scrollTo(0, targetY);
                userClickTimer = setTimeout(function () {
                    isUserClickScrolling = false;
                }, 100);
            }
        }
        window.requestAnimationFrame(step);
    }

    // Intercept in-page anchor links for fluid scrolling
    document.addEventListener("click", function (event) {
        var anchor = event.target.closest('a[href^="#"]');
        if (!anchor) return;

        var hash = anchor.getAttribute("href");
        if (!hash || hash === "#" || hash === "#!") return;

        var targetEl = document.querySelector(hash);
        if (targetEl) {
            event.preventDefault();
            var nav = document.querySelector(".ios-navbar");
            var navHeight = nav ? nav.offsetHeight : 70;
            var elementPosition = targetEl.getBoundingClientRect().top;
            var offsetPosition = elementPosition + (window.pageYOffset || document.documentElement.scrollTop) - navHeight;
            if (offsetPosition < 0) offsetPosition = 0;

            smoothScrollTo(offsetPosition, 500, hash);

            if (history.pushState) {
                history.pushState(null, null, hash);
            }
        }
    });

    // 5. High-Precision ScrollSpy & Sticky Navbar Glass Controller
    var navbar = document.querySelector(".ios-navbar");
    var scrollTopBtn = document.getElementById("iosScrollTopBtn");
    var navLinks = document.querySelectorAll(".ios-navbar .ios-nav-link[href^='#'], .ios-navbar .ios-capsule-link[href^='#'], .ios-mobile-link[href^='#']");
    var sections = [];

    navLinks.forEach(function (link) {
        var hash = link.getAttribute("href");
        if (hash && hash.length > 1) {
            var el = document.querySelector(hash);
            if (el) {
                sections.push({ id: hash, element: el, link: link });
            }
        }
    });

    var ticking = false;
    function handleScrollState() {
        var scrollY = window.pageYOffset || document.documentElement.scrollTop;

        // Navbar scrolled glassmorphic state
        if (navbar) {
            if (scrollY > 20) {
                navbar.classList.add("is-scrolled");
            } else {
                navbar.classList.remove("is-scrolled");
            }
        }

        // Scroll to top button visibility
        if (scrollTopBtn) {
            if (scrollY > 350) {
                scrollTopBtn.classList.add("is-visible");
            } else {
                scrollTopBtn.classList.remove("is-visible");
            }
        }

        // ScrollSpy active link detection (Dynamic section detection during scroll)
        if (sections.length > 0 && !isUserClickScrolling) {
            var scrollHeight = document.documentElement.scrollHeight || document.body.scrollHeight;
            var clientHeight = window.innerHeight || document.documentElement.clientHeight;
            var isAtBottom = (scrollY + clientHeight) >= (scrollHeight - 60);

            var currentSectionId = null;

            if (isAtBottom) {
                // Bottom of page -> activate last item (e.g. FAQ)
                currentSectionId = sections[sections.length - 1].id;
            } else if (scrollY < 120) {
                // Top of page -> activate first item (e.g. Overview)
                currentSectionId = sections[0].id;
            } else {
                var navHeight = (navbar ? navbar.offsetHeight : 70);
                var activeThreshold = navHeight + 140;

                // Find section whose top has entered active threshold
                for (var i = 0; i < sections.length; i++) {
                    var rect = sections[i].element.getBoundingClientRect();
                    if (rect.top <= activeThreshold && rect.bottom > navHeight + 20) {
                        currentSectionId = sections[i].id;
                    }
                }
            }

            if (currentSectionId) {
                setActiveNavLink(currentSectionId);
            }
        }

        ticking = false;
    }

    window.addEventListener("scroll", function () {
        if (!ticking) {
            window.requestAnimationFrame(handleScrollState);
            ticking = true;
        }
    }, { passive: true });

    // Initial scroll state trigger
    handleScrollState();

    // Scroll to top button click handler
    if (scrollTopBtn) {
        scrollTopBtn.addEventListener("click", function (e) {
            e.preventDefault();
            smoothScrollTo(0, 500, (sections.length > 0 ? sections[0].id : null));
        });
    }

    // 6. Mobile Navigation Drawer Controller
    var mobileNavToggle = document.getElementById("iosMobileNavToggle");
    var mobileDrawer = document.getElementById("iosMobileDrawer");

    if (mobileNavToggle && mobileDrawer) {
        mobileNavToggle.addEventListener("click", function (e) {
            e.preventDefault();
            e.stopPropagation();
            mobileDrawer.classList.toggle("is-open");
        });

        document.addEventListener("click", function (e) {
            if (!mobileDrawer.contains(e.target) && !mobileNavToggle.contains(e.target)) {
                mobileDrawer.classList.remove("is-open");
            }
        });

        var drawerAnchors = mobileDrawer.querySelectorAll("a[href^='#']");
        drawerAnchors.forEach(function (anchor) {
            anchor.addEventListener("click", function () {
                mobileDrawer.classList.remove("is-open");
            });
        });
    }
});
