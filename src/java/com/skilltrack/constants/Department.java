package com.skilltrack.constants;

public enum Department {
    CSE("Computer Science & Engineering"),
    IT("Information Technology"),
    ECE("Electronics & Communication"),
    EEE("Electrical & Electronics"),
    MECH("Mechanical Engineering"),
    CIVIL("Civil Engineering"),
    OTHER("Other");

    private final String fullName;

    Department(String fullName) {
        this.fullName = fullName;
    }

    public String getFullName() {
        return fullName;
    }

    public static Department fromString(String str) {
        if (str == null) return null;
        for (Department d : Department.values()) {
            if (d.name().equalsIgnoreCase(str.trim()) || d.fullName.equalsIgnoreCase(str.trim())) {
                return d;
            }
        }
        return OTHER;
    }
}
