package com.skilltrack.constants;

public enum SkillLevel {
    BEGINNER(1, "Beginner"),
    INTERMEDIATE(2, "Intermediate"),
    ADVANCED(3, "Advanced");

    private final int rank;
    private final String displayName;

    SkillLevel(int rank, String displayName) {
        this.rank = rank;
        this.displayName = displayName;
    }

    public int getRank() {
        return rank;
    }

    public String getDisplayName() {
        return displayName;
    }

    public boolean meetsOrExceeds(SkillLevel required) {
        if (required == null) return true;
        return this.rank >= required.rank;
    }

    public static SkillLevel fromString(String str) {
        if (str == null) return null;
        for (SkillLevel level : SkillLevel.values()) {
            if (level.name().equalsIgnoreCase(str.trim()) || level.displayName.equalsIgnoreCase(str.trim())) {
                return level;
            }
        }
        return null;
    }
}
