package com.skilltrack.models;

import com.skilltrack.utils.DateUtil;
import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalDateTime;

public class Certification implements Serializable {
    private static final long serialVersionUID = 1L;

    private int certId;
    private int studentId;
    private String title;
    private String issuingOrg;
    private LocalDate issueDate;
    private String credentialUrl;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public Certification() {
    }

    public Certification(int certId, int studentId, String title, String issuingOrg, LocalDate issueDate, String credentialUrl) {
        this.certId = certId;
        this.studentId = studentId;
        this.title = title;
        this.issuingOrg = issuingOrg;
        this.issueDate = issueDate;
        this.credentialUrl = credentialUrl;
    }

    public int getCertId() {
        return certId;
    }

    public void setCertId(int certId) {
        this.certId = certId;
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

    public String getCertificateName() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getIssuingOrg() {
        return issuingOrg;
    }

    public String getIssuingOrganization() {
        return issuingOrg;
    }

    public void setIssuingOrg(String issuingOrg) {
        this.issuingOrg = issuingOrg;
    }

    public LocalDate getIssueDate() {
        return issueDate;
    }

    public void setIssueDate(LocalDate issueDate) {
        this.issueDate = issueDate;
    }

    public String getCredentialUrl() {
        return credentialUrl;
    }

    public void setCredentialUrl(String credentialUrl) {
        this.credentialUrl = credentialUrl;
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

    public String getFormattedIssueDate() {
        return DateUtil.formatDate(issueDate);
    }
}
