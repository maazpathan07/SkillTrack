package com.skilltrack.constants;

public enum CriteriaStatus {
    MEETS_REQUIREMENT("Meets Requirement", "badge-success", "text-success"),
    NEEDS_IMPROVEMENT("Needs Improvement", "badge-warning", "text-warning"),
    DOES_NOT_MEET_REQUIREMENT("Does Not Meet", "badge-danger", "text-danger"),
    NOT_APPLICABLE("N/A", "badge-secondary", "text-secondary");

    private final String displayName;
    private final String badgeClass;
    private final String textClass;

    CriteriaStatus(String displayName, String badgeClass, String textClass) {
        this.displayName = displayName;
        this.badgeClass = badgeClass;
        this.textClass = textClass;
    }

    public String getDisplayName() {
        return displayName;
    }

    public String getBadgeClass() {
        return badgeClass;
    }

    public String getTextClass() {
        return textClass;
    }
}
