package com.skilltrack.dto;

import com.skilltrack.constants.OAuthProvider;
import java.io.Serializable;

public class OAuthUserInfo implements Serializable {
    private static final long serialVersionUID = 1L;

    private OAuthProvider provider;
    private String providerId;
    private String email;
    private String name;
    private String avatarUrl;
    private String profileUrl;

    public OAuthUserInfo() {
    }

    public OAuthUserInfo(OAuthProvider provider, String providerId, String email, String name, String avatarUrl, String profileUrl) {
        this.provider = provider;
        this.providerId = providerId;
        this.email = email;
        this.name = name;
        this.avatarUrl = avatarUrl;
        this.profileUrl = profileUrl;
    }

    public OAuthProvider getProvider() {
        return provider;
    }

    public void setProvider(OAuthProvider provider) {
        this.provider = provider;
    }

    public String getProviderId() {
        return providerId;
    }

    public void setProviderId(String providerId) {
        this.providerId = providerId;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAvatarUrl() {
        return avatarUrl;
    }

    public void setAvatarUrl(String avatarUrl) {
        this.avatarUrl = avatarUrl;
    }

    public String getProfileUrl() {
        return profileUrl;
    }

    public void setProfileUrl(String profileUrl) {
        this.profileUrl = profileUrl;
    }
}
