package com.skilltrack.dto;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CohortSummaryDTO implements Serializable {
    private static final long serialVersionUID = 1L;

    public static class DeptCohortSummary implements Serializable {
        private static final long serialVersionUID = 1L;

        private String department;
        private int studentCount;
        private double avgCgpa;
        private double avgReadiness;

        public DeptCohortSummary() {
        }

        public DeptCohortSummary(String department, int studentCount, double avgCgpa, double avgReadiness) {
            this.department = department;
            this.studentCount = studentCount;
            this.avgCgpa = avgCgpa;
            this.avgReadiness = avgReadiness;
        }

        public String getDepartment() {
            return department;
        }

        public void setDepartment(String department) {
            this.department = department;
        }

        public int getStudentCount() {
            return studentCount;
        }

        public void setStudentCount(int studentCount) {
            this.studentCount = studentCount;
        }

        public double getAvgCgpa() {
            return avgCgpa;
        }

        public void setAvgCgpa(double avgCgpa) {
            this.avgCgpa = avgCgpa;
        }

        public double getAvgReadiness() {
            return avgReadiness;
        }

        public void setAvgReadiness(double avgReadiness) {
            this.avgReadiness = avgReadiness;
        }

        public String getFormattedAvgCgpa() {
            return String.format("%.2f", avgCgpa);
        }

        public String getFormattedAvgReadiness() {
            return String.format("%.1f", avgReadiness);
        }
    }

    private int totalStudents;
    private double cohortAvgCgpa;
    private double cohortAvgReadiness;
    private double cohortAvgDsaProblems;
    private double cohortAvgProjects;
    private double cohortAvgCerts;

    private int highReadinessCount; // >= 75%
    private int mediumReadinessCount; // 50-74%
    private int lowReadinessCount; // < 50%

    private List<DeptCohortSummary> departmentSummaries = new ArrayList<>();
    private List<StudentDirectoryDTO.DirectoryItem> topReadyStudents = new ArrayList<>();

    public CohortSummaryDTO() {
    }

    public int getTotalStudents() {
        return totalStudents;
    }

    public void setTotalStudents(int totalStudents) {
        this.totalStudents = totalStudents;
    }

    public double getCohortAvgCgpa() {
        return cohortAvgCgpa;
    }

    public void setCohortAvgCgpa(double cohortAvgCgpa) {
        this.cohortAvgCgpa = cohortAvgCgpa;
    }

    public double getCohortAvgReadiness() {
        return cohortAvgReadiness;
    }

    public void setCohortAvgReadiness(double cohortAvgReadiness) {
        this.cohortAvgReadiness = cohortAvgReadiness;
    }

    public double getCohortAvgDsaProblems() {
        return cohortAvgDsaProblems;
    }

    public void setCohortAvgDsaProblems(double cohortAvgDsaProblems) {
        this.cohortAvgDsaProblems = cohortAvgDsaProblems;
    }

    public double getCohortAvgProjects() {
        return cohortAvgProjects;
    }

    public void setCohortAvgProjects(double cohortAvgProjects) {
        this.cohortAvgProjects = cohortAvgProjects;
    }

    public double getCohortAvgCerts() {
        return cohortAvgCerts;
    }

    public void setCohortAvgCerts(double cohortAvgCerts) {
        this.cohortAvgCerts = cohortAvgCerts;
    }

    public int getHighReadinessCount() {
        return highReadinessCount;
    }

    public void setHighReadinessCount(int highReadinessCount) {
        this.highReadinessCount = highReadinessCount;
    }

    public int getMediumReadinessCount() {
        return mediumReadinessCount;
    }

    public void setMediumReadinessCount(int mediumReadinessCount) {
        this.mediumReadinessCount = mediumReadinessCount;
    }

    public int getLowReadinessCount() {
        return lowReadinessCount;
    }

    public void setLowReadinessCount(int lowReadinessCount) {
        this.lowReadinessCount = lowReadinessCount;
    }

    public List<DeptCohortSummary> getDepartmentSummaries() {
        return departmentSummaries;
    }

    public void setDepartmentSummaries(List<DeptCohortSummary> departmentSummaries) {
        this.departmentSummaries = departmentSummaries;
    }

    public List<StudentDirectoryDTO.DirectoryItem> getTopReadyStudents() {
        return topReadyStudents;
    }

    public void setTopReadyStudents(List<StudentDirectoryDTO.DirectoryItem> topReadyStudents) {
        this.topReadyStudents = topReadyStudents;
    }

    public String getFormattedAvgCgpa() {
        return String.format("%.2f", cohortAvgCgpa);
    }

    public String getFormattedAvgReadiness() {
        return String.format("%.1f", cohortAvgReadiness);
    }

    public String getFormattedAvgDsa() {
        return String.format("%.1f", cohortAvgDsaProblems);
    }

    public String getFormattedAvgProjects() {
        return String.format("%.1f", cohortAvgProjects);
    }

    public String getFormattedAvgCerts() {
        return String.format("%.1f", cohortAvgCerts);
    }
}
