package com.skilltrack.dto;

import com.skilltrack.models.PreparationTask;
import com.skilltrack.models.Project;
import com.skilltrack.models.Student;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class StudentDashboardDTO implements Serializable {
    private static final long serialVersionUID = 1L;

    private Student student;
    private ReadinessScoreDTO readinessScore;
    private SkillGapDTO skillGap;
    private int skillsCount;
    private int projectsCount;
    private int certsCount;
    private int dsaProblemsSolved;
    private int dsaTopicsCompleted;
    private int totalDsaTopics;
    private int pendingTasksCount;
    private int completedTasksCount;
    private List<PreparationTask> recentTasks = new ArrayList<>();
    private List<Project> recentProjects = new ArrayList<>();

    public StudentDashboardDTO() {
    }

    public Student getStudent() {
        return student;
    }

    public void setStudent(Student student) {
        this.student = student;
    }

    public ReadinessScoreDTO getReadinessScore() {
        return readinessScore;
    }

    public void setReadinessScore(ReadinessScoreDTO readinessScore) {
        this.readinessScore = readinessScore;
    }

    public SkillGapDTO getSkillGap() {
        return skillGap;
    }

    public void setSkillGap(SkillGapDTO skillGap) {
        this.skillGap = skillGap;
    }

    public int getSkillsCount() {
        return skillsCount;
    }

    public void setSkillsCount(int skillsCount) {
        this.skillsCount = skillsCount;
    }

    public int getProjectsCount() {
        return projectsCount;
    }

    public void setProjectsCount(int projectsCount) {
        this.projectsCount = projectsCount;
    }

    public int getCertsCount() {
        return certsCount;
    }

    public void setCertsCount(int certsCount) {
        this.certsCount = certsCount;
    }

    public int getDsaProblemsSolved() {
        return dsaProblemsSolved;
    }

    public void setDsaProblemsSolved(int dsaProblemsSolved) {
        this.dsaProblemsSolved = dsaProblemsSolved;
    }

    public int getDsaTopicsCompleted() {
        return dsaTopicsCompleted;
    }

    public void setDsaTopicsCompleted(int dsaTopicsCompleted) {
        this.dsaTopicsCompleted = dsaTopicsCompleted;
    }

    public int getTotalDsaTopics() {
        return totalDsaTopics;
    }

    public void setTotalDsaTopics(int totalDsaTopics) {
        this.totalDsaTopics = totalDsaTopics;
    }

    public int getPendingTasksCount() {
        return pendingTasksCount;
    }

    public void setPendingTasksCount(int pendingTasksCount) {
        this.pendingTasksCount = pendingTasksCount;
    }

    public int getCompletedTasksCount() {
        return completedTasksCount;
    }

    public void setCompletedTasksCount(int completedTasksCount) {
        this.completedTasksCount = completedTasksCount;
    }

    public List<PreparationTask> getRecentTasks() {
        return recentTasks;
    }

    public void setRecentTasks(List<PreparationTask> recentTasks) {
        this.recentTasks = recentTasks;
    }

    public List<Project> getRecentProjects() {
        return recentProjects;
    }

    public void setRecentProjects(List<Project> recentProjects) {
        this.recentProjects = recentProjects;
    }
}
