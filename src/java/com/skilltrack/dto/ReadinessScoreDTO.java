package com.skilltrack.dto;

import java.io.Serializable;

public class ReadinessScoreDTO implements Serializable {
    private static final long serialVersionUID = 1L;

    private double overallReadiness;
    private double skillReadiness;
    private double dsaReadiness;
    private double projectReadiness;
    private double certReadiness;
    private double taskReadiness;

    private double weightSkills;
    private double weightDsa;
    private double weightProjects;
    private double weightCerts;
    private double weightTasks;

    private int dsaBenchmark;
    private int projectBenchmark;
    private int certBenchmark;

    private int dsaSolved;
    private int projectsCompleted;
    private int certsCompleted;
    private int tasksCompleted;
    private int totalTasks;
    private double skillMatchPct;

    public ReadinessScoreDTO() {
    }

    public double getOverallReadiness() {
        return overallReadiness;
    }

    public void setOverallReadiness(double overallReadiness) {
        this.overallReadiness = overallReadiness;
    }

    public double getSkillReadiness() {
        return skillReadiness;
    }

    public void setSkillReadiness(double skillReadiness) {
        this.skillReadiness = skillReadiness;
    }

    public double getDsaReadiness() {
        return dsaReadiness;
    }

    public void setDsaReadiness(double dsaReadiness) {
        this.dsaReadiness = dsaReadiness;
    }

    public double getProjectReadiness() {
        return projectReadiness;
    }

    public void setProjectReadiness(double projectReadiness) {
        this.projectReadiness = projectReadiness;
    }

    public double getCertReadiness() {
        return certReadiness;
    }

    public void setCertReadiness(double certReadiness) {
        this.certReadiness = certReadiness;
    }

    public double getTaskReadiness() {
        return taskReadiness;
    }

    public void setTaskReadiness(double taskReadiness) {
        this.taskReadiness = taskReadiness;
    }

    public double getWeightSkills() {
        return weightSkills;
    }

    public void setWeightSkills(double weightSkills) {
        this.weightSkills = weightSkills;
    }

    public double getWeightDsa() {
        return weightDsa;
    }

    public void setWeightDsa(double weightDsa) {
        this.weightDsa = weightDsa;
    }

    public double getWeightProjects() {
        return weightProjects;
    }

    public void setWeightProjects(double weightProjects) {
        this.weightProjects = weightProjects;
    }

    public double getWeightCerts() {
        return weightCerts;
    }

    public void setWeightCerts(double weightCerts) {
        this.weightCerts = weightCerts;
    }

    public double getWeightTasks() {
        return weightTasks;
    }

    public void setWeightTasks(double weightTasks) {
        this.weightTasks = weightTasks;
    }

    public int getDsaBenchmark() {
        return dsaBenchmark;
    }

    public void setDsaBenchmark(int dsaBenchmark) {
        this.dsaBenchmark = dsaBenchmark;
    }

    public int getProjectBenchmark() {
        return projectBenchmark;
    }

    public void setProjectBenchmark(int projectBenchmark) {
        this.projectBenchmark = projectBenchmark;
    }

    public int getCertBenchmark() {
        return certBenchmark;
    }

    public void setCertBenchmark(int certBenchmark) {
        this.certBenchmark = certBenchmark;
    }

    public int getDsaSolved() {
        return dsaSolved;
    }

    public void setDsaSolved(int dsaSolved) {
        this.dsaSolved = dsaSolved;
    }

    public int getProjectsCompleted() {
        return projectsCompleted;
    }

    public void setProjectsCompleted(int projectsCompleted) {
        this.projectsCompleted = projectsCompleted;
    }

    public int getCertsCompleted() {
        return certsCompleted;
    }

    public void setCertsCompleted(int certsCompleted) {
        this.certsCompleted = certsCompleted;
    }

    public int getTasksCompleted() {
        return tasksCompleted;
    }

    public void setTasksCompleted(int tasksCompleted) {
        this.tasksCompleted = tasksCompleted;
    }

    public int getTotalTasks() {
        return totalTasks;
    }

    public void setTotalTasks(int totalTasks) {
        this.totalTasks = totalTasks;
    }

    public double getSkillMatchPct() {
        return skillMatchPct;
    }

    public void setSkillMatchPct(double skillMatchPct) {
        this.skillMatchPct = skillMatchPct;
    }

    public String getFormattedOverall() {
        return String.format("%.1f", overallReadiness);
    }

    public String getFormattedSkill() {
        return String.format("%.1f", skillReadiness);
    }

    public String getFormattedDsa() {
        return String.format("%.1f", dsaReadiness);
    }

    public String getFormattedProject() {
        return String.format("%.1f", projectReadiness);
    }

    public String getFormattedCert() {
        return String.format("%.1f", certReadiness);
    }

    public String getFormattedTask() {
        return String.format("%.1f", taskReadiness);
    }

    public String getReadinessBadgeClass() {
        if (overallReadiness >= 75.0) return "badge-success";
        if (overallReadiness >= 50.0) return "badge-warning";
        return "badge-danger";
    }

    public String getProgressBarClass() {
        if (overallReadiness >= 75.0) return "bg-success";
        if (overallReadiness >= 50.0) return "bg-warning";
        return "bg-danger";
    }
}
