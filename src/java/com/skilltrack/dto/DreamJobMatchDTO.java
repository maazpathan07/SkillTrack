package com.skilltrack.dto;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class DreamJobMatchDTO implements Serializable {
    private static final long serialVersionUID = 1L;

    private int evalId;
    private int criteriaId;
    private String targetCompany;
    private String targetRole;
    private String sourceType; // "PRESET_CRITERIA", "CUSTOM_PASTE", "URL_FETCH"
    private String sourceUrl;
    private String rawJdText;

    // Numerical scores (0 - 100)
    private int overallScore;
    private int dsaScore;
    private int projectScore;
    private int certScore;
    private int skillScore;
    private int academicScore;

    // Status label: "READY", "NEAR_READY", "NEEDS_PREPARATION"
    private String statusBadge;
    private String statusTitle;
    private String statusDescription;

    // Detailed breakdown lists
    private List<String> requiredSkills = new ArrayList<>();
    private List<String> matchedSkills = new ArrayList<>();
    private List<String> missingSkills = new ArrayList<>();

    // Diagnostic summaries
    private String dsaBenchmarkDescription;
    private String studentDsaSummary;
    private String projectBenchmarkDescription;
    private String studentProjectSummary;
    private String certBenchmarkDescription;
    private String studentCertSummary;
    private String academicBenchmarkDescription;
    private String studentAcademicSummary;

    // Gap analysis roadmap
    private List<JobGapRoadmapItemDTO> roadmapItems = new ArrayList<>();

    private LocalDateTime evaluatedAt;

    public DreamJobMatchDTO() {
    }

    public int getEvalId() {
        return evalId;
    }

    public void setEvalId(int evalId) {
        this.evalId = evalId;
    }

    public int getCriteriaId() {
        return criteriaId;
    }

    public void setCriteriaId(int criteriaId) {
        this.criteriaId = criteriaId;
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

    public int getOverallScore() {
        return overallScore;
    }

    public void setOverallScore(int overallScore) {
        this.overallScore = overallScore;
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

    public String getStatusBadge() {
        return statusBadge;
    }

    public void setStatusBadge(String statusBadge) {
        this.statusBadge = statusBadge;
    }

    public String getStatusTitle() {
        return statusTitle;
    }

    public void setStatusTitle(String statusTitle) {
        this.statusTitle = statusTitle;
    }

    public String getStatusDescription() {
        return statusDescription;
    }

    public void setStatusDescription(String statusDescription) {
        this.statusDescription = statusDescription;
    }

    public List<String> getRequiredSkills() {
        return requiredSkills;
    }

    public void setRequiredSkills(List<String> requiredSkills) {
        this.requiredSkills = requiredSkills;
    }

    public List<String> getMatchedSkills() {
        return matchedSkills;
    }

    public void setMatchedSkills(List<String> matchedSkills) {
        this.matchedSkills = matchedSkills;
    }

    public List<String> getMissingSkills() {
        return missingSkills;
    }

    public void setMissingSkills(List<String> missingSkills) {
        this.missingSkills = missingSkills;
    }

    public String getDsaBenchmarkDescription() {
        return dsaBenchmarkDescription;
    }

    public void setDsaBenchmarkDescription(String dsaBenchmarkDescription) {
        this.dsaBenchmarkDescription = dsaBenchmarkDescription;
    }

    public String getStudentDsaSummary() {
        return studentDsaSummary;
    }

    public void setStudentDsaSummary(String studentDsaSummary) {
        this.studentDsaSummary = studentDsaSummary;
    }

    public String getProjectBenchmarkDescription() {
        return projectBenchmarkDescription;
    }

    public void setProjectBenchmarkDescription(String projectBenchmarkDescription) {
        this.projectBenchmarkDescription = projectBenchmarkDescription;
    }

    public String getStudentProjectSummary() {
        return studentProjectSummary;
    }

    public void setStudentProjectSummary(String studentProjectSummary) {
        this.studentProjectSummary = studentProjectSummary;
    }

    public String getCertBenchmarkDescription() {
        return certBenchmarkDescription;
    }

    public void setCertBenchmarkDescription(String certBenchmarkDescription) {
        this.certBenchmarkDescription = certBenchmarkDescription;
    }

    public String getStudentCertSummary() {
        return studentCertSummary;
    }

    public void setStudentCertSummary(String studentCertSummary) {
        this.studentCertSummary = studentCertSummary;
    }

    public String getAcademicBenchmarkDescription() {
        return academicBenchmarkDescription;
    }

    public void setAcademicBenchmarkDescription(String academicBenchmarkDescription) {
        this.academicBenchmarkDescription = academicBenchmarkDescription;
    }

    public String getStudentAcademicSummary() {
        return studentAcademicSummary;
    }

    public void setStudentAcademicSummary(String studentAcademicSummary) {
        this.studentAcademicSummary = studentAcademicSummary;
    }

    public List<JobGapRoadmapItemDTO> getRoadmapItems() {
        return roadmapItems;
    }

    public void setRoadmapItems(List<JobGapRoadmapItemDTO> roadmapItems) {
        this.roadmapItems = roadmapItems;
    }

    public LocalDateTime getEvaluatedAt() {
        return evaluatedAt;
    }

    public void setEvaluatedAt(LocalDateTime evaluatedAt) {
        this.evaluatedAt = evaluatedAt;
    }
}
