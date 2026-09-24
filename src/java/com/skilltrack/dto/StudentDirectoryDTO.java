package com.skilltrack.dto;

import com.skilltrack.models.Student;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class StudentDirectoryDTO implements Serializable {
    private static final long serialVersionUID = 1L;

    public static class DirectoryItem implements Serializable {
        private static final long serialVersionUID = 1L;

        private Student student;
        private ReadinessScoreDTO readinessScore;
        private int skillsCount;
        private int projectsCount;
        private int certsCount;
        private int dsaSolved;

        public DirectoryItem() {
        }

        public DirectoryItem(Student student, ReadinessScoreDTO readinessScore, int skillsCount, int projectsCount, int certsCount, int dsaSolved) {
            this.student = student;
            this.readinessScore = readinessScore;
            this.skillsCount = skillsCount;
            this.projectsCount = projectsCount;
            this.certsCount = certsCount;
            this.dsaSolved = dsaSolved;
        }

        public Student getStudent() {
            return student;
        }

        public void setStudent(Student student) {
            this.student = student;
        }

        public ReadinessScoreDTO getReadinessScore() {
            return readinessScore;
        }

        public void setReadinessScore(ReadinessScoreDTO readinessScore) {
            this.readinessScore = readinessScore;
        }

        public int getSkillsCount() {
            return skillsCount;
        }

        public void setSkillsCount(int skillsCount) {
            this.skillsCount = skillsCount;
        }

        public int getProjectsCount() {
            return projectsCount;
        }

        public void setProjectsCount(int projectsCount) {
            this.projectsCount = projectsCount;
        }

        public int getCertsCount() {
            return certsCount;
        }

        public void setCertsCount(int certsCount) {
            this.certsCount = certsCount;
        }

        public int getDsaSolved() {
            return dsaSolved;
        }

        public void setDsaSolved(int dsaSolved) {
            this.dsaSolved = dsaSolved;
        }
    }

    private List<DirectoryItem> items = new ArrayList<>();
    private int currentPage = 1;
    private int pageSize = 10;
    private int totalRecords = 0;
    private int totalPages = 1;

    // Echo Filter parameters
    private String departmentFilter;
    private Integer gradYearFilter;
    private Integer targetRoleIdFilter;
    private Double minCgpaFilter;
    private Double minReadinessFilter;
    private Integer skillIdFilter;
    private String skillLevelFilter;
    private String searchKeyword;

    public StudentDirectoryDTO() {
    }

    public List<DirectoryItem> getItems() {
        return items;
    }

    public void setItems(List<DirectoryItem> items) {
        this.items = items;
    }

    public int getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getTotalRecords() {
        return totalRecords;
    }

    public void setTotalRecords(int totalRecords) {
        this.totalRecords = totalRecords;
        this.totalPages = (int) Math.ceil((double) totalRecords / pageSize);
        if (this.totalPages == 0) this.totalPages = 1;
    }

    public int getTotalPages() {
        return totalPages;
    }

    public void setTotalPages(int totalPages) {
        this.totalPages = totalPages;
    }

    public String getDepartmentFilter() {
        return departmentFilter;
    }

    public void setDepartmentFilter(String departmentFilter) {
        this.departmentFilter = departmentFilter;
    }

    public Integer getGradYearFilter() {
        return gradYearFilter;
    }

    public void setGradYearFilter(Integer gradYearFilter) {
        this.gradYearFilter = gradYearFilter;
    }

    public Integer getTargetRoleIdFilter() {
        return targetRoleIdFilter;
    }

    public void setTargetRoleIdFilter(Integer targetRoleIdFilter) {
        this.targetRoleIdFilter = targetRoleIdFilter;
    }

    public Double getMinCgpaFilter() {
        return minCgpaFilter;
    }

    public void setMinCgpaFilter(Double minCgpaFilter) {
        this.minCgpaFilter = minCgpaFilter;
    }

    public Double getMinReadinessFilter() {
        return minReadinessFilter;
    }

    public void setMinReadinessFilter(Double minReadinessFilter) {
        this.minReadinessFilter = minReadinessFilter;
    }

    public Integer getSkillIdFilter() {
        return skillIdFilter;
    }

    public void setSkillIdFilter(Integer skillIdFilter) {
        this.skillIdFilter = skillIdFilter;
    }

    public String getSkillLevelFilter() {
        return skillLevelFilter;
    }

    public void setSkillLevelFilter(String skillLevelFilter) {
        this.skillLevelFilter = skillLevelFilter;
    }

    public String getSearchKeyword() {
        return searchKeyword;
    }

    public void setSearchKeyword(String searchKeyword) {
        this.searchKeyword = searchKeyword;
    }
}
