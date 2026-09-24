package com.skilltrack.models;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class TargetRole implements Serializable {
    private static final long serialVersionUID = 1L;

    private int roleId;
    private String roleTitle;
    private String description;
    private boolean active;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    private List<RoleSkillRequirement> requirements = new ArrayList<>();

    public TargetRole() {
    }

    public TargetRole(int roleId, String roleTitle, String description, boolean active) {
        this.roleId = roleId;
        this.roleTitle = roleTitle;
        this.description = description;
        this.active = active;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    public String getRoleTitle() {
        return roleTitle;
    }

    public void setRoleTitle(String roleTitle) {
        this.roleTitle = roleTitle;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
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

    public List<RoleSkillRequirement> getRequirements() {
        return requirements;
    }

    public void setRequirements(List<RoleSkillRequirement> requirements) {
        this.requirements = requirements;
    }
}
