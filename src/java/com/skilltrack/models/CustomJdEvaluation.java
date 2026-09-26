package com.skilltrack.models;

import java.io.Serializable;
import java.time.LocalDateTime;

public class CustomJdEvaluation implements Serializable {
    private static final long serialVersionUID = 1L;

    private int evalId;
    private int studentId;
    private String targetCompany;
    private String targetRole;
    private String sourceType; // 'PRESET_CRITERIA', 'CUSTOM_PASTE', 'URL_FETCH'
    private String sourceUrl;
    private String rawJdText;
    private int overallMatchScore;
    private int dsaScore;
    private int projectScore;
    private int certScore;
    private int skillScore;
    private int academicScore;
    private String matchedSkillsJson;
    private String missingSkillsJson;
    private String actionItemsJson;
    private LocalDateTime evaluatedAt;

    public CustomJdEvaluation() {
    }

    public int getEvalId() {
        return evalId;
    }

    public void setEvalId(int evalId) {
        this.evalId = evalId;
    }

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
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

    public String getSourceType() {
        return sourceType;
    }

    public void setSourceType(String sourceType) {
        this.sourceType = sourceType;
    }

    public String getSourceUrl() {
        return sourceUrl;
    }

    public void setSourceUrl(String sourceUrl) {
        this.sourceUrl = sourceUrl;
    }

    public String getRawJdText() {
        return rawJdText;
    }

    public void setRawJdText(String rawJdText) {
        this.rawJdText = rawJdText;
    }

    public int getOverallMatchScore() {
        return overallMatchScore;
    }

    public void setOverallMatchScore(int overallMatchScore) {
        this.overallMatchScore = overallMatchScore;
    }

    public int getDsaScore() {
        return dsaScore;
    }

    public void setDsaScore(int dsaScore) {
        this.dsaScore = dsaScore;
    }

    public int getProjectScore() {
        return projectScore;
    }

    public void setProjectScore(int projectScore) {
        this.projectScore = projectScore;
    }

    public int getCertScore() {
        return certScore;
    }

    public void setCertScore(int certScore) {
        this.certScore = certScore;
    }

    public int getSkillScore() {
        return skillScore;
    }

    public void setSkillScore(int skillScore) {
        this.skillScore = skillScore;
    }

    public int getAcademicScore() {
        return academicScore;
    }

    public void setAcademicScore(int academicScore) {
        this.academicScore = academicScore;
    }

    public String getMatchedSkillsJson() {
        return matchedSkillsJson;
    }

    public void setMatchedSkillsJson(String matchedSkillsJson) {
        this.matchedSkillsJson = matchedSkillsJson;
    }

    public String getMissingSkillsJson() {
        return missingSkillsJson;
    }

    public void setMissingSkillsJson(String missingSkillsJson) {
        this.missingSkillsJson = missingSkillsJson;
    }

    public String getActionItemsJson() {
        return actionItemsJson;
    }

    public void setActionItemsJson(String actionItemsJson) {
        this.actionItemsJson = actionItemsJson;
    }

    public LocalDateTime getEvaluatedAt() {
        return evaluatedAt;
    }

    public void setEvaluatedAt(LocalDateTime evaluatedAt) {
        this.evaluatedAt = evaluatedAt;
    }
}
