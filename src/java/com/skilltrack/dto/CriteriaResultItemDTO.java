package com.skilltrack.dto;

import com.skilltrack.constants.CriteriaStatus;
import java.io.Serializable;

public class CriteriaResultItemDTO implements Serializable {
    private static final long serialVersionUID = 1L;

    private String criterionName;
    private String requiredValue;
    private String studentValue;
    private CriteriaStatus status;
    private String remarks;

    public CriteriaResultItemDTO() {
    }

    public CriteriaResultItemDTO(String criterionName, String requiredValue, String studentValue, CriteriaStatus status, String remarks) {
        this.criterionName = criterionName;
        this.requiredValue = requiredValue;
        this.studentValue = studentValue;
        this.status = status;
        this.remarks = remarks;
    }

    public String getCriterionName() {
        return criterionName;
    }

    public void setCriterionName(String criterionName) {
        this.criterionName = criterionName;
    }

    public String getRequiredValue() {
        return requiredValue;
    }

    public void setRequiredValue(String requiredValue) {
        this.requiredValue = requiredValue;
    }

    public String getStudentValue() {
        return studentValue;
    }

    public void setStudentValue(String studentValue) {
        this.studentValue = studentValue;
    }

    public CriteriaStatus getStatus() {
        return status != null ? status : CriteriaStatus.NOT_APPLICABLE;
    }

    public void setStatus(CriteriaStatus status) {
        this.status = status;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }
}
