package com.skilltrack.models;

import com.skilltrack.constants.TopicCategory;
import java.io.Serializable;
import java.time.LocalDateTime;

public class StudentDsaProgress implements Serializable {
    private static final long serialVersionUID = 1L;

    private int progressId;
    private int studentId;
    private int topicId;
    private String topicName;
    private TopicCategory topicCategory;
    private String status; // NOT_STARTED, IN_PROGRESS, COMPLETED
    private int problemsSolved;
    private String notes;
    private LocalDateTime updatedAt;

    public StudentDsaProgress() {
    }

    public int getProgressId() {
        return progressId;
    }

    public void setProgressId(int progressId) {
        this.progressId = progressId;
    }

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public int getTopicId() {
        return topicId;
    }

    public void setTopicId(int topicId) {
        this.topicId = topicId;
    }

    public String getTopicName() {
        return topicName;
    }

    public void setTopicName(String topicName) {
        this.topicName = topicName;
    }

    public TopicCategory getTopicCategory() {
        return topicCategory;
    }

    public void setTopicCategory(TopicCategory topicCategory) {
        this.topicCategory = topicCategory;
    }

    public String getStatus() {
        return status != null ? status : "NOT_STARTED";
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getProblemsSolved() {
        return problemsSolved;
    }

    public void setProblemsSolved(int problemsSolved) {
        this.problemsSolved = problemsSolved;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    public String getStatusBadgeClass() {
        if ("COMPLETED".equalsIgnoreCase(status)) return "badge-success";
        if ("IN_PROGRESS".equalsIgnoreCase(status)) return "badge-warning";
        return "badge-secondary";
    }

    public String getStatusDisplayName() {
        if ("COMPLETED".equalsIgnoreCase(status)) return "Completed";
        if ("IN_PROGRESS".equalsIgnoreCase(status)) return "In Progress";
        return "Not Started";
    }
}
