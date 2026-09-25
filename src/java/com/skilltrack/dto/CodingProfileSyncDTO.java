package com.skilltrack.dto;

import java.io.Serializable;

public class CodingProfileSyncDTO implements Serializable {
    private static final long serialVersionUID = 1L;

    private boolean success;
    private String message;

    // LeetCode Stats
    private String leetcodeUsername;
    private boolean leetcodeValid;
    private int totalSolved;
    private int easySolved;
    private int mediumSolved;
    private int hardSolved;
    private int ranking;
    private String leetcodeSyncedTime;

    // GitHub Stats
    private String githubUsername;
    private boolean githubValid;
    private int publicRepos;
    private int followers;
    private String githubBio;
    private String avatarUrl;
    private String profileUrl;
    private String githubSyncedTime;

    public CodingProfileSyncDTO() {
    }

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getLeetcodeUsername() {
        return leetcodeUsername;
    }

    public void setLeetcodeUsername(String leetcodeUsername) {
        this.leetcodeUsername = leetcodeUsername;
    }

    public boolean isLeetcodeValid() {
        return leetcodeValid;
    }

    public void setLeetcodeValid(boolean leetcodeValid) {
        this.leetcodeValid = leetcodeValid;
    }

    public int getTotalSolved() {
        return totalSolved;
    }

    public void setTotalSolved(int totalSolved) {
        this.totalSolved = totalSolved;
    }

    public int getEasySolved() {
        return easySolved;
    }

    public void setEasySolved(int easySolved) {
        this.easySolved = easySolved;
    }

    public int getMediumSolved() {
        return mediumSolved;
    }

    public void setMediumSolved(int mediumSolved) {
        this.mediumSolved = mediumSolved;
    }

    public int getHardSolved() {
        return hardSolved;
    }

    public void setHardSolved(int hardSolved) {
        this.hardSolved = hardSolved;
    }

    public int getRanking() {
        return ranking;
    }

    public void setRanking(int ranking) {
        this.ranking = ranking;
    }

    public String getLeetcodeSyncedTime() {
        return leetcodeSyncedTime;
    }

    public void setLeetcodeSyncedTime(String leetcodeSyncedTime) {
        this.leetcodeSyncedTime = leetcodeSyncedTime;
    }

    public String getGithubUsername() {
        return githubUsername;
    }

    public void setGithubUsername(String githubUsername) {
        this.githubUsername = githubUsername;
    }

    public boolean isGithubValid() {
        return githubValid;
    }

    public void setGithubValid(boolean githubValid) {
        this.githubValid = githubValid;
    }

    public int getPublicRepos() {
        return publicRepos;
    }

    public void setPublicRepos(int publicRepos) {
        this.publicRepos = publicRepos;
    }

    public int getFollowers() {
        return followers;
    }

    public void setFollowers(int followers) {
        this.followers = followers;
    }

    public String getGithubBio() {
        return githubBio;
    }

    public void setGithubBio(String githubBio) {
        this.githubBio = githubBio;
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

    public String getGithubSyncedTime() {
        return githubSyncedTime;
    }

    public void setGithubSyncedTime(String githubSyncedTime) {
        this.githubSyncedTime = githubSyncedTime;
    }
}
