package com.skilltrack.models;

import com.skilltrack.constants.SkillCategory;
import com.skilltrack.constants.SkillLevel;
import java.io.Serializable;
import java.time.LocalDateTime;

public class CriteriaSkillRequirement implements Serializable {
    private static final long serialVersionUID = 1L;

    private int requirementId;
    private int criteriaId;
    private int skillId;
    private String skillName;
    private SkillCategory skillCategory;
    private SkillLevel minProficiency;
    private boolean mandatory;
    private LocalDateTime createdAt;

    public CriteriaSkillRequirement() {
    }

    public int getRequirementId() {
        return requirementId;
    }

    public void setRequirementId(int requirementId) {
        this.requirementId = requirementId;
    }

    public int getCriteriaId() {
        return criteriaId;
    }

    public void setCriteriaId(int criteriaId) {
        this.criteriaId = criteriaId;
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

    public SkillCategory getSkillCategory() {
        return skillCategory;
    }

    public void setSkillCategory(SkillCategory skillCategory) {
        this.skillCategory = skillCategory;
    }

    public SkillLevel getMinProficiency() {
        return minProficiency;
    }

    public void setMinProficiency(SkillLevel minProficiency) {
        this.minProficiency = minProficiency;
    }

    public boolean isMandatory() {
        return mandatory;
    }

    public void setMandatory(boolean mandatory) {
        this.mandatory = mandatory;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
}
