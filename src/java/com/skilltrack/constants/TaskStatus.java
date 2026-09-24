package com.skilltrack.constants;

public enum TaskStatus {
    PENDING("Pending"),
    COMPLETED("Completed");

    private final String displayName;

    TaskStatus(String displayName) {
        this.displayName = displayName;
    }

    public String getDisplayName() {
        return displayName;
    }

    public static TaskStatus fromString(String str) {
        if (str == null) return null;
        for (TaskStatus status : TaskStatus.values()) {
            if (status.name().equalsIgnoreCase(str.trim()) || status.displayName.equalsIgnoreCase(str.trim())) {
                return status;
            }
        }
        return null;
    }
}
