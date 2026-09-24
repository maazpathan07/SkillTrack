package com.skilltrack.constants;

public enum SkillCategory {
    PROGRAMMING_LANGUAGES("Programming Languages"),
    FRAMEWORKS("Frameworks & Libraries"),
    DATABASES("Databases"),
    DEV_TOOLS("Developer Tools & DevOps"),
    CORE_CS("Core CS Fundamentals");

    private final String displayName;

    SkillCategory(String displayName) {
        this.displayName = displayName;
    }

    public String getDisplayName() {
        return displayName;
    }

    public static SkillCategory fromString(String str) {
        if (str == null) return null;
        for (SkillCategory cat : SkillCategory.values()) {
            if (cat.name().equalsIgnoreCase(str.trim()) || cat.displayName.equalsIgnoreCase(str.trim())) {
                return cat;
            }
        }
        return null;
    }
}
