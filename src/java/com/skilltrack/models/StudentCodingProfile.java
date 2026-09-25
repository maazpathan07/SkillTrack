package com.skilltrack.models;

import java.io.Serializable;
import java.time.LocalDateTime;

public class StudentCodingProfile implements Serializable {
    private static final long serialVersionUID = 1L;

    private int studentId;
    private String leetcodeUsername;
    private int leetcodeTotalSolved;
    private int leetcodeEasySolved;
    private int leetcodeMediumSolved;
    private int leetcodeHardSolved;
    private int leetcodeRanking;
    private String leetcodeContestRating;
    private LocalDateTime leetcodeSyncedAt;

    private String githubUsername;
    private int githubReposCount;
    private int githubFollowers;
    private String githubBio;
    private String githubAvatarUrl;
    private String githubProfileUrl;
    private LocalDateTime githubSyncedAt;

    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public StudentCodingProfile() {
    }

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public String getLeetcodeUsername() {
        return leetcodeUsername;
    }

    public void setLeetcodeUsername(String leetcodeUsername) {
        this.leetcodeUsername = leetcodeUsername;
    }

    public int getLeetcodeTotalSolved() {
        return leetcodeTotalSolved;
    }

    public void setLeetcodeTotalSolved(int leetcodeTotalSolved) {
        this.leetcodeTotalSolved = leetcodeTotalSolved;
    }

    public int getLeetcodeEasySolved() {
        return leetcodeEasySolved;
    }

    public void setLeetcodeEasySolved(int leetcodeEasySolved) {
        this.leetcodeEasySolved = leetcodeEasySolved;
    }

    public int getLeetcodeMediumSolved() {
        return leetcodeMediumSolved;
    }

    public void setLeetcodeMediumSolved(int leetcodeMediumSolved) {
        this.leetcodeMediumSolved = leetcodeMediumSolved;
    }

    public int getLeetcodeHardSolved() {
        return leetcodeHardSolved;
    }

    public void setLeetcodeHardSolved(int leetcodeHardSolved) {
        this.leetcodeHardSolved = leetcodeHardSolved;
    }

    public int getLeetcodeRanking() {
        return leetcodeRanking;
    }

    public void setLeetcodeRanking(int leetcodeRanking) {
        this.leetcodeRanking = leetcodeRanking;
    }

    public String getLeetcodeContestRating() {
        return leetcodeContestRating;
    }

    public void setLeetcodeContestRating(String leetcodeContestRating) {
        this.leetcodeContestRating = leetcodeContestRating;
    }

    public LocalDateTime getLeetcodeSyncedAt() {
        return leetcodeSyncedAt;
    }

    public void setLeetcodeSyncedAt(LocalDateTime leetcodeSyncedAt) {
        this.leetcodeSyncedAt = leetcodeSyncedAt;
    }

    public String getGithubUsername() {
        return githubUsername;
    }

    public void setGithubUsername(String githubUsername) {
        this.githubUsername = githubUsername;
    }

    public int getGithubReposCount() {
        return githubReposCount;
    }

    public void setGithubReposCount(int githubReposCount) {
        this.githubReposCount = githubReposCount;
    }

    public int getGithubFollowers() {
        return githubFollowers;
    }

    public void setGithubFollowers(int githubFollowers) {
        this.githubFollowers = githubFollowers;
    }

    public String getGithubBio() {
        return githubBio;
    }

    public void setGithubBio(String githubBio) {
        this.githubBio = githubBio;
    }

    public String getGithubAvatarUrl() {
        return githubAvatarUrl;
    }

    public void setGithubAvatarUrl(String githubAvatarUrl) {
        this.githubAvatarUrl = githubAvatarUrl;
    }

    public String getGithubProfileUrl() {
        return githubProfileUrl;
    }

    public void setGithubProfileUrl(String githubProfileUrl) {
        this.githubProfileUrl = githubProfileUrl;
    }

    public LocalDateTime getGithubSyncedAt() {
        return githubSyncedAt;
    }

    public void setGithubSyncedAt(LocalDateTime githubSyncedAt) {
        this.githubSyncedAt = githubSyncedAt;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    public boolean isLeetCodeSynced() {
        return leetcodeUsername != null && !leetcodeUsername.trim().isEmpty() && leetcodeSyncedAt != null;
    }

    public boolean isGitHubSynced() {
        return githubUsername != null && !githubUsername.trim().isEmpty() && githubSyncedAt != null;
    }
}
