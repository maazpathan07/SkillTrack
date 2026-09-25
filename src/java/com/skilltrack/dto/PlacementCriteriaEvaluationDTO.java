package com.skilltrack.dto;

import com.skilltrack.constants.CriteriaStatus;
import com.skilltrack.models.PlacementCriteria;
import com.skilltrack.models.Student;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class PlacementCriteriaEvaluationDTO implements Serializable {
    private static final long serialVersionUID = 1L;

    private PlacementCriteria criteria;
    private Student student;
    private CriteriaStatus overallStatus;
    private int passedCount;
    private int totalChecks;
    private List<CriteriaResultItemDTO> resultItems = new ArrayList<>();

    public PlacementCriteriaEvaluationDTO() {
    }

    public PlacementCriteria getCriteria() {
        return criteria;
    }

    public void setCriteria(PlacementCriteria criteria) {
        this.criteria = criteria;
    }

    public Student getStudent() {
        return student;
    }

    public void setStudent(Student student) {
        this.student = student;
    }

    public CriteriaStatus getOverallStatus() {
        return overallStatus != null ? overallStatus : CriteriaStatus.NOT_APPLICABLE;
    }

    public void setOverallStatus(CriteriaStatus overallStatus) {
        this.overallStatus = overallStatus;
    }

    public int getPassedCount() {
        return passedCount;
    }

    public void setPassedCount(int passedCount) {
        this.passedCount = passedCount;
    }

    public int getTotalChecks() {
        return totalChecks;
    }

    public void setTotalChecks(int totalChecks) {
        this.totalChecks = totalChecks;
    }

    public List<CriteriaResultItemDTO> getResultItems() {
        return resultItems;
    }

    public void setResultItems(List<CriteriaResultItemDTO> resultItems) {
        this.resultItems = resultItems;
    }

    public double getPassedPercentage() {
        if (totalChecks == 0) return 100.0;
        return ((double) passedCount / totalChecks) * 100.0;
    }

    public String getFormattedPassedPercentage() {
        if (totalChecks == 0) return "100.0";
        double pct = ((double) passedCount / totalChecks) * 100.0;
        return String.format("%.1f", pct);
    }
}
