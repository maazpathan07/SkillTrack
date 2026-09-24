package com.skilltrack.dto;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

public class AdminDashboardDTO implements Serializable {
    private static final long serialVersionUID = 1L;

    private int totalStudents;
    private int totalRoles;
    private int totalSkills;
    private int totalCriteria;
    private double avgReadiness;
    private int readyStudentsCount;       // >= 75%
    private int inProgressStudentsCount;  // 50% - 74%
    private int needsAttentionCount;     // < 50%

    private Map<String, Integer> departmentDistribution = new HashMap<>();
    private Map<String, Integer> roleDistribution = new HashMap<>();

    public AdminDashboardDTO() {
    }

    public int getTotalStudents() {
        return totalStudents;
    }

    public void setTotalStudents(int totalStudents) {
        this.totalStudents = totalStudents;
    }

    public int getTotalRoles() {
        return totalRoles;
    }

    public void setTotalRoles(int totalRoles) {
        this.totalRoles = totalRoles;
    }

    public int getTotalSkills() {
        return totalSkills;
    }

    public void setTotalSkills(int totalSkills) {
        this.totalSkills = totalSkills;
    }

    public int getTotalCriteria() {
        return totalCriteria;
    }

    public void setTotalCriteria(int totalCriteria) {
        this.totalCriteria = totalCriteria;
    }

    public double getAvgReadiness() {
        return avgReadiness;
    }

    public void setAvgReadiness(double avgReadiness) {
        this.avgReadiness = avgReadiness;
    }

    public int getReadyStudentsCount() {
        return readyStudentsCount;
    }

    public void setReadyStudentsCount(int readyStudentsCount) {
        this.readyStudentsCount = readyStudentsCount;
    }

    public int getInProgressStudentsCount() {
        return inProgressStudentsCount;
    }

    public void setInProgressStudentsCount(int inProgressStudentsCount) {
        this.inProgressStudentsCount = inProgressStudentsCount;
    }

    public int getNeedsAttentionCount() {
        return needsAttentionCount;
    }

    public void setNeedsAttentionCount(int needsAttentionCount) {
        this.needsAttentionCount = needsAttentionCount;
    }

    public Map<String, Integer> getDepartmentDistribution() {
        return departmentDistribution;
    }

    public void setDepartmentDistribution(Map<String, Integer> departmentDistribution) {
        this.departmentDistribution = departmentDistribution;
    }

    public Map<String, Integer> getRoleDistribution() {
        return roleDistribution;
    }

    public void setRoleDistribution(Map<String, Integer> roleDistribution) {
        this.roleDistribution = roleDistribution;
    }

    public String getFormattedAvgReadiness() {
        return String.format("%.1f", avgReadiness);
    }
}
