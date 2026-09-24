package com.skilltrack.constants;

public enum UserRole {
    STUDENT,
    ADMIN;

    public static UserRole fromString(String roleStr) {
        if (roleStr == null) return null;
        for (UserRole role : UserRole.values()) {
            if (role.name().equalsIgnoreCase(roleStr.trim())) {
                return role;
            }
        }
        return null;
    }
}
