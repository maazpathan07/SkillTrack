package com.skilltrack.models;

import com.skilltrack.constants.TaskStatus;
import com.skilltrack.utils.DateUtil;
import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalDateTime;

public class PreparationTask implements Serializable {
    private static final long serialVersionUID = 1L;

    private int taskId;
    private int studentId;
    private String title;
    private String description;
    private TaskStatus status;
    private LocalDate targetDate;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public PreparationTask() {
    }

    public PreparationTask(int taskId, int studentId, String title, String description, TaskStatus status, LocalDate targetDate) {
        this.taskId = taskId;
        this.studentId = studentId;
        this.title = title;
        this.description = description;
        this.status = status;
        this.targetDate = targetDate;
    }

    public int getTaskId() {
        return taskId;
    }

    public void setTaskId(int taskId) {
        this.taskId = taskId;
    }

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public TaskStatus getStatus() {
        return status != null ? status : TaskStatus.PENDING;
    }

    public void setStatus(TaskStatus status) {
        this.status = status;
    }

    public LocalDate getTargetDate() {
        return targetDate;
    }

    public void setTargetDate(LocalDate targetDate) {
        this.targetDate = targetDate;
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

    public boolean isCompleted() {
        return status == TaskStatus.COMPLETED;
    }

    public String getFormattedTargetDate() {
        return DateUtil.formatDate(targetDate);
    }
}
