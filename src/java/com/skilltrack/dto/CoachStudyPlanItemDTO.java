package com.skilltrack.dto;

import java.io.Serializable;

public class CoachStudyPlanItemDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    private String category; // "DSA", "SYSTEM_DESIGN", "PROJECT", "CORE_CS", "CERT"
    private String title;
    private String description;
    private int targetCount;
    private String actionUrl;
    private String priority; // "HIGH", "MEDIUM", "LOW"
    private boolean completed;

    public CoachStudyPlanItemDTO() {}

    public CoachStudyPlanItemDTO(String category, String title, String description, int targetCount, String actionUrl, String priority, boolean completed) {
        this.category = category;
        this.title = title;
        this.description = description;
        this.targetCount = targetCount;
        this.actionUrl = actionUrl;
        this.priority = priority;
        this.completed = completed;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getTargetCount() {
        return targetCount;
    }

    public void setTargetCount(int targetCount) {
        this.targetCount = targetCount;
    }

    public String getActionUrl() {
        return actionUrl;
    }

    public void setActionUrl(String actionUrl) {
        this.actionUrl = actionUrl;
    }

    public String getPriority() {
        return priority;
    }

    public void setPriority(String priority) {
        this.priority = priority;
    }

    public boolean isCompleted() {
        return completed;
    }

    public void setCompleted(boolean completed) {
        this.completed = completed;
    }
}
