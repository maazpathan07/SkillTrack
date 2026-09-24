package com.skilltrack.dto;

import com.skilltrack.constants.SkillCategory;
import com.skilltrack.constants.SkillLevel;
import java.io.Serializable;

public class SkillGapItemDTO implements Serializable {
    private static final long serialVersionUID = 1L;

    private int skillId;
    private String skillName;
    private SkillCategory category;
    private SkillLevel requiredLevel;
    private SkillLevel studentLevel;
    private String status; // MATCHED, NEEDS_IMPROVEMENT, MISSING
    private boolean mandatory;

    public SkillGapItemDTO() {
    }

    public SkillGapItemDTO(int skillId, String skillName, SkillCategory category, SkillLevel requiredLevel, SkillLevel studentLevel, String status, boolean mandatory) {
        this.skillId = skillId;
        this.skillName = skillName;
        this.category = category;
        this.requiredLevel = requiredLevel;
        this.studentLevel = studentLevel;
        this.status = status;
        this.mandatory = mandatory;
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

    public SkillLevel getRequiredLevel() {
        return requiredLevel;
    }

    public void setRequiredLevel(SkillLevel requiredLevel) {
        this.requiredLevel = requiredLevel;
    }

    public SkillLevel getStudentLevel() {
        return studentLevel;
    }

    public void setStudentLevel(SkillLevel studentLevel) {
        this.studentLevel = studentLevel;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public boolean isMandatory() {
        return mandatory;
    }

    public void setMandatory(boolean mandatory) {
        this.mandatory = mandatory;
    }

    public String getStatusBadgeClass() {
        if ("MATCHED".equalsIgnoreCase(status)) return "badge-success";
        if ("NEEDS_IMPROVEMENT".equalsIgnoreCase(status)) return "badge-warning";
        return "badge-danger";
    }

    public String getStatusDisplayName() {
        if ("MATCHED".equalsIgnoreCase(status)) return "Matched";
        if ("NEEDS_IMPROVEMENT".equalsIgnoreCase(status)) return "Needs Improvement";
        return "Missing";
    }
}
