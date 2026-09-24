package com.skilltrack.dto;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class SkillGapDTO implements Serializable {
    private static final long serialVersionUID = 1L;

    private Integer roleId;
    private String roleTitle;
    private int totalRequiredSkills;
    private int matchedSkillsCount;
    private int needsImprovementCount;
    private int missingCount;
    private double skillMatchPercentage;
    private List<SkillGapItemDTO> items = new ArrayList<>();

    public SkillGapDTO() {
    }

    public Integer getRoleId() {
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }

    public String getRoleTitle() {
        return roleTitle;
    }

    public void setRoleTitle(String roleTitle) {
        this.roleTitle = roleTitle;
    }

    public int getTotalRequiredSkills() {
        return totalRequiredSkills;
    }

    public void setTotalRequiredSkills(int totalRequiredSkills) {
        this.totalRequiredSkills = totalRequiredSkills;
    }

    public int getMatchedSkillsCount() {
        return matchedSkillsCount;
    }

    public void setMatchedSkillsCount(int matchedSkillsCount) {
        this.matchedSkillsCount = matchedSkillsCount;
    }

    public int getNeedsImprovementCount() {
        return needsImprovementCount;
    }

    public void setNeedsImprovementCount(int needsImprovementCount) {
        this.needsImprovementCount = needsImprovementCount;
    }

    public int getMissingCount() {
        return missingCount;
    }

    public void setMissingCount(int missingCount) {
        this.missingCount = missingCount;
    }

    public double getSkillMatchPercentage() {
        return skillMatchPercentage;
    }

    public void setSkillMatchPercentage(double skillMatchPercentage) {
        this.skillMatchPercentage = skillMatchPercentage;
    }

    public List<SkillGapItemDTO> getItems() {
        return items;
    }

    public void setItems(List<SkillGapItemDTO> items) {
        this.items = items;
    }

    public String getFormattedSkillMatch() {
        return String.format("%.1f", skillMatchPercentage);
    }
}
