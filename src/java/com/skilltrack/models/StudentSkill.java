package com.skilltrack.models;

import com.skilltrack.constants.SkillCategory;
import com.skilltrack.constants.SkillLevel;
import java.io.Serializable;
import java.time.LocalDateTime;

public class StudentSkill implements Serializable {
    private static final long serialVersionUID = 1L;

    private int studentSkillId;
    private int studentId;
    private int skillId;
    private String skillName;
    private SkillCategory skillCategory;
    private SkillLevel proficiencyLevel;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public StudentSkill() {
    }

    public StudentSkill(int studentSkillId, int studentId, int skillId, SkillLevel proficiencyLevel) {
        this.studentSkillId = studentSkillId;
        this.studentId = studentId;
        this.skillId = skillId;
        this.proficiencyLevel = proficiencyLevel;
    }

    public int getStudentSkillId() {
        return studentSkillId;
    }

    public void setStudentSkillId(int studentSkillId) {
        this.studentSkillId = studentSkillId;
    }

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
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

    public SkillLevel getProficiencyLevel() {
        return proficiencyLevel;
    }

    public void setProficiencyLevel(SkillLevel proficiencyLevel) {
        this.proficiencyLevel = proficiencyLevel;
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
}
