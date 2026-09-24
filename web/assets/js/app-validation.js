/**
 * SkillTrack — Enterprise Client Helper & Interactive UI Validation
 * Authoritative security & logic remains strictly in the Server Layer.
 */

document.addEventListener("DOMContentLoaded", function () {
    // Auto-dismiss alert messages smoothly after 6 seconds
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

    // Bootstrap 4 instant form validation feedback
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

    // Universal delete/destructive confirmation prompt
    var deleteButtons = document.querySelectorAll(".confirm-delete");
    deleteButtons.forEach(function (button) {
        button.addEventListener("click", function (event) {
            var msg = button.getAttribute("data-confirm") || "Are you sure you want to permanently delete this item?";
            if (!confirm(msg)) {
                event.preventDefault();
            }
        });
    });
});
