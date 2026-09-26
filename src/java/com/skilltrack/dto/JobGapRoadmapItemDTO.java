package com.skilltrack.dto;

import java.io.Serializable;

public class JobGapRoadmapItemDTO implements Serializable {
    private static final long serialVersionUID = 1L;

    private String category; // "DSA", "PROJECT", "CERTIFICATION", "SKILL", "ACADEMIC"
    private String title;
    private String description;
    private int impactWeight; // e.g. 15 for +15%
    private String actionType; // "LEETCODE", "PROJECT_BUILD", "GET_CERTIFIED", "SKILL_PRACTICE", "ACADEMIC_FOCUS"
    private String actionLink; // e.g. "/app/student/dsa"
    private String priority; // "HIGH", "MEDIUM", "LOW"
    private boolean isAddedToTasks;

    public JobGapRoadmapItemDTO() {
    }

    public JobGapRoadmapItemDTO(String category, String title, String description, int impactWeight, String actionType, String actionLink, String priority) {
        this.category = category;
        this.title = title;
        this.description = description;
        this.impactWeight = impactWeight;
        this.actionType = actionType;
        this.actionLink = actionLink;
        this.priority = priority;
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

    public int getImpactWeight() {
        return impactWeight;
    }

    public void setImpactWeight(int impactWeight) {
        this.impactWeight = impactWeight;
    }

    public String getActionType() {
        return actionType;
    }

    public void setActionType(String actionType) {
        this.actionType = actionType;
    }

    public String getActionLink() {
        return actionLink;
    }

    public void setActionLink(String actionLink) {
        this.actionLink = actionLink;
    }

    public String getPriority() {
        return priority;
    }

    public void setPriority(String priority) {
        this.priority = priority;
    }

    public boolean isAddedToTasks() {
        return isAddedToTasks;
    }

    public void setAddedToTasks(boolean addedToTasks) {
        isAddedToTasks = addedToTasks;
    }
}
