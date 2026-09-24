package com.skilltrack.constants;

public enum TopicCategory {
    CORE_DSA("Core DSA"),
    ADVANCED_DSA("Advanced DSA");

    private final String displayName;

    TopicCategory(String displayName) {
        this.displayName = displayName;
    }

    public String getDisplayName() {
        return displayName;
    }

    public static TopicCategory fromString(String str) {
        if (str == null) return null;
        for (TopicCategory cat : TopicCategory.values()) {
            if (cat.name().equalsIgnoreCase(str.trim()) || cat.displayName.equalsIgnoreCase(str.trim())) {
                return cat;
            }
        }
        return null;
    }
}
