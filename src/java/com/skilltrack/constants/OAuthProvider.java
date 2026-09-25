package com.skilltrack.constants;

public enum OAuthProvider {
    LOCAL("Local"),
    GOOGLE("Google"),
    GITHUB("GitHub"),
    LINKEDIN("LinkedIn");

    private final String displayName;

    OAuthProvider(String displayName) {
        this.displayName = displayName;
    }

    public String getDisplayName() {
        return displayName;
    }

    public static OAuthProvider fromString(String text) {
        if (text != null) {
            for (OAuthProvider p : OAuthProvider.values()) {
                if (p.name().equalsIgnoreCase(text.trim())) {
                    return p;
                }
            }
        }
        return LOCAL;
    }
}
