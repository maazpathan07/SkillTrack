package com.skilltrack.models;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class PlacementCriteria implements Serializable {
    private static final long serialVersionUID = 1L;

    private int criteriaId;
    private String companyName;
    private String roleTitle;
    private double minCgpa;
    private int minDsaProblems;
    private int minProjects;
    private int minCertifications;
    private String allowedDepartments;
    private boolean active;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    private List<CriteriaSkillRequirement> skillRequirements = new ArrayList<>();

    public PlacementCriteria() {
    }

    public int getCriteriaId() {
        return criteriaId;
    }

    public void setCriteriaId(int criteriaId) {
        this.criteriaId = criteriaId;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public String getRoleTitle() {
        return roleTitle;
    }

    public void setRoleTitle(String roleTitle) {
        this.roleTitle = roleTitle;
    }

    public double getMinCgpa() {
        return minCgpa;
    }

    public void setMinCgpa(double minCgpa) {
        this.minCgpa = minCgpa;
    }

    public int getMinDsaProblems() {
        return minDsaProblems;
    }

    public void setMinDsaProblems(int minDsaProblems) {
        this.minDsaProblems = minDsaProblems;
    }

    public int getMinProjects() {
        return minProjects;
    }

    public void setMinProjects(int minProjects) {
        this.minProjects = minProjects;
    }

    public int getMinCertifications() {
        return minCertifications;
    }

    public void setMinCertifications(int minCertifications) {
        this.minCertifications = minCertifications;
    }

    public String getAllowedDepartments() {
        return allowedDepartments != null ? allowedDepartments : "ALL";
    }

    public void setAllowedDepartments(String allowedDepartments) {
        this.allowedDepartments = allowedDepartments;
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

    public List<CriteriaSkillRequirement> getSkillRequirements() {
        return skillRequirements;
    }

    public void setSkillRequirements(List<CriteriaSkillRequirement> skillRequirements) {
        this.skillRequirements = skillRequirements;
    }

    public boolean isDepartmentAllowed(String dept) {
        if (allowedDepartments == null || "ALL".equalsIgnoreCase(allowedDepartments.trim())) {
            return true;
        }
        if (dept == null || dept.trim().isEmpty()) {
            return false;
        }
        String[] depts = allowedDepartments.split(",");
        for (String d : depts) {
            if (d.trim().equalsIgnoreCase(dept.trim())) {
                return true;
            }
        }
        return false;
    }

    public String getFormattedMinCgpa() {
        return String.format("%.2f", minCgpa);
    }
}
