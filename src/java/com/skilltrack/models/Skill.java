package com.skilltrack.models;

import com.skilltrack.constants.SkillCategory;
import java.io.Serializable;
import java.time.LocalDateTime;

public class Skill implements Serializable {
    private static final long serialVersionUID = 1L;

    private int skillId;
    private String skillName;
    private SkillCategory category;
    private String description;
    private LocalDateTime createdAt;

    public Skill() {
    }

    public Skill(int skillId, String skillName, SkillCategory category, String description) {
        this.skillId = skillId;
        this.skillName = skillName;
        this.category = category;
        this.description = description;
    }

    public int getSkillId() {
        return skillId;
    }

    public void setSkillId(int skillId) {
        this.skillId = skillId;
    }

    public String getSkillName() {
        return skillName;
    }

    public void setSkillName(String skillName) {
        this.skillName = skillName;
    }

    public SkillCategory getCategory() {
        return category;
    }

    public void setCategory(SkillCategory category) {
        this.category = category;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
}
