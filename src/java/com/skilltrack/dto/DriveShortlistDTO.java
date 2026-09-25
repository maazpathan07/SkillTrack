package com.skilltrack.dto;

import com.skilltrack.models.PlacementCriteria;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * DTO encapsulating the evaluation and shortlisting results of an entire student cohort
 * against a specific campus placement drive / criteria profile.
 */
public class DriveShortlistDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    private PlacementCriteria criteria;
    private List<PlacementCriteriaEvaluationDTO> allEvaluations = new ArrayList<>();
    private List<PlacementCriteriaEvaluationDTO> eligibleCandidates = new ArrayList<>();
    private List<PlacementCriteriaEvaluationDTO> nearEligibleCandidates = new ArrayList<>();
    private List<PlacementCriteriaEvaluationDTO> nonEligibleCandidates = new ArrayList<>();

    private int totalEvaluated;
    private int eligibleCount;
    private int nearEligibleCount;
    private int nonEligibleCount;
    private double eligibilityRate;
    private double avgEligibleCgpa;
    private Map<String, Integer> deptBreakdown = new HashMap<>();

    public DriveShortlistDTO() {
    }

    public PlacementCriteria getCriteria() {
        return criteria;
    }

    public void setCriteria(PlacementCriteria criteria) {
        this.criteria = criteria;
    }

    public List<PlacementCriteriaEvaluationDTO> getAllEvaluations() {
        return allEvaluations;
    }

    public void setAllEvaluations(List<PlacementCriteriaEvaluationDTO> allEvaluations) {
        this.allEvaluations = allEvaluations;
    }

    public List<PlacementCriteriaEvaluationDTO> getEligibleCandidates() {
        return eligibleCandidates;
    }

    public void setEligibleCandidates(List<PlacementCriteriaEvaluationDTO> eligibleCandidates) {
        this.eligibleCandidates = eligibleCandidates;
    }

    public List<PlacementCriteriaEvaluationDTO> getNearEligibleCandidates() {
        return nearEligibleCandidates;
    }

    public void setNearEligibleCandidates(List<PlacementCriteriaEvaluationDTO> nearEligibleCandidates) {
        this.nearEligibleCandidates = nearEligibleCandidates;
    }

    public List<PlacementCriteriaEvaluationDTO> getNonEligibleCandidates() {
        return nonEligibleCandidates;
    }

    public void setNonEligibleCandidates(List<PlacementCriteriaEvaluationDTO> nonEligibleCandidates) {
        this.nonEligibleCandidates = nonEligibleCandidates;
    }

    public int getTotalEvaluated() {
        return totalEvaluated;
    }

    public void setTotalEvaluated(int totalEvaluated) {
        this.totalEvaluated = totalEvaluated;
    }

    public int getEligibleCount() {
        return eligibleCount;
    }

    public void setEligibleCount(int eligibleCount) {
        this.eligibleCount = eligibleCount;
    }

    public int getNearEligibleCount() {
        return nearEligibleCount;
    }

    public void setNearEligibleCount(int nearEligibleCount) {
        this.nearEligibleCount = nearEligibleCount;
    }

    public int getNonEligibleCount() {
        return nonEligibleCount;
    }

    public void setNonEligibleCount(int nonEligibleCount) {
        this.nonEligibleCount = nonEligibleCount;
    }

    public double getEligibilityRate() {
        return eligibilityRate;
    }

    public void setEligibilityRate(double eligibilityRate) {
        this.eligibilityRate = eligibilityRate;
    }

    public double getAvgEligibleCgpa() {
        return avgEligibleCgpa;
    }

    public void setAvgEligibleCgpa(double avgEligibleCgpa) {
        this.avgEligibleCgpa = avgEligibleCgpa;
    }

    public String getFormattedAvgEligibleCgpa() {
        return String.format("%.2f", avgEligibleCgpa);
    }

    public String getFormattedEligibilityRate() {
        return String.format("%.1f", eligibilityRate);
    }

    public Map<String, Integer> getDeptBreakdown() {
        return deptBreakdown;
    }

    public void setDeptBreakdown(Map<String, Integer> deptBreakdown) {
        this.deptBreakdown = deptBreakdown;
    }
}
