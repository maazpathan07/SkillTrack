package com.skilltrack.dto;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class AiCoachOverviewDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    private int studentId;
    private String studentName;
    private String targetCompany;
    private String targetRole;
    private int overallReadinessScore;

    // Benchmarks vs Actuals
    private int dsaSolved;
    private int dsaTarget;
    private int projectsCount;
    private int projectsTarget;
    private int certsCount;
    private int certsTarget;
    private double cgpa;
    private double cgpaTarget;

    // Coach Insights
    private String topWeaknessTopic;
    private int topWeaknessPercent;
    private String coachGreeting;
    private String openingAdvice;

    // Study Plan & Recommendations
    private List<CoachStudyPlanItemDTO> weeklyStudyPlan = new ArrayList<>();
    private List<String> suggestedPrompts = new ArrayList<>();
    private List<CoachChatMessageDTO> recentChatHistory = new ArrayList<>();

    public AiCoachOverviewDTO() {}

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public String getTargetCompany() {
        return targetCompany;
    }

    public void setTargetCompany(String targetCompany) {
        this.targetCompany = targetCompany;
    }

    public String getTargetRole() {
        return targetRole;
    }

    public void setTargetRole(String targetRole) {
        this.targetRole = targetRole;
    }

    public int getOverallReadinessScore() {
        return overallReadinessScore;
    }

    public void setOverallReadinessScore(int overallReadinessScore) {
        this.overallReadinessScore = overallReadinessScore;
    }

    public int getDsaSolved() {
        return dsaSolved;
    }

    public void setDsaSolved(int dsaSolved) {
        this.dsaSolved = dsaSolved;
    }

    public int getDsaTarget() {
        return dsaTarget;
    }

    public void setDsaTarget(int dsaTarget) {
        this.dsaTarget = dsaTarget;
    }

    public int getProjectsCount() {
        return projectsCount;
    }

    public void setProjectsCount(int projectsCount) {
        this.projectsCount = projectsCount;
    }

    public int getProjectsTarget() {
        return projectsTarget;
    }

    public void setProjectsTarget(int projectsTarget) {
        this.projectsTarget = projectsTarget;
    }

    public int getCertsCount() {
        return certsCount;
    }

    public void setCertsCount(int certsCount) {
        this.certsCount = certsCount;
    }

    public int getCertsTarget() {
        return certsTarget;
    }

    public void setCertsTarget(int certsTarget) {
        this.certsTarget = certsTarget;
    }

    public double getCgpa() {
        return cgpa;
    }

    public void setCgpa(double cgpa) {
        this.cgpa = cgpa;
    }

    public double getCgpaTarget() {
        return cgpaTarget;
    }

    public void setCgpaTarget(double cgpaTarget) {
        this.cgpaTarget = cgpaTarget;
    }

    public String getTopWeaknessTopic() {
        return topWeaknessTopic;
    }

    public void setTopWeaknessTopic(String topWeaknessTopic) {
        this.topWeaknessTopic = topWeaknessTopic;
    }

    public int getTopWeaknessPercent() {
        return topWeaknessPercent;
    }

    public void setTopWeaknessPercent(int topWeaknessPercent) {
        this.topWeaknessPercent = topWeaknessPercent;
    }

    public String getCoachGreeting() {
        return coachGreeting;
    }

    public void setCoachGreeting(String coachGreeting) {
        this.coachGreeting = coachGreeting;
    }

    public String getOpeningAdvice() {
        return openingAdvice;
    }

    public void setOpeningAdvice(String openingAdvice) {
        this.openingAdvice = openingAdvice;
    }

    public List<CoachStudyPlanItemDTO> getWeeklyStudyPlan() {
        return weeklyStudyPlan;
    }

    public void setWeeklyStudyPlan(List<CoachStudyPlanItemDTO> weeklyStudyPlan) {
        this.weeklyStudyPlan = weeklyStudyPlan;
    }

    public List<String> getSuggestedPrompts() {
        return suggestedPrompts;
    }

    public void setSuggestedPrompts(List<String> suggestedPrompts) {
        this.suggestedPrompts = suggestedPrompts;
    }

    public List<CoachChatMessageDTO> getRecentChatHistory() {
        return recentChatHistory;
    }

    public void setRecentChatHistory(List<CoachChatMessageDTO> recentChatHistory) {
        this.recentChatHistory = recentChatHistory;
    }
}
