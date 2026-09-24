package com.skilltrack.constants;

public enum RequirementType {
    MANDATORY("Mandatory"),
    OPTIONAL("Optional");

    private final String displayName;

    RequirementType(String displayName) {
        this.displayName = displayName;
    }

    public String getDisplayName() {
        return displayName;
    }
}
