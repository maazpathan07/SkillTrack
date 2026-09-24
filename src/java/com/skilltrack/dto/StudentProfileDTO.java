package com.skilltrack.dto;

import com.skilltrack.models.Certification;
import com.skilltrack.models.Project;
import com.skilltrack.models.Student;
import com.skilltrack.models.StudentDsaProgress;
import com.skilltrack.models.StudentSkill;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class StudentProfileDTO implements Serializable {
    private static final long serialVersionUID = 1L;

    private Student student;
    private List<StudentSkill> skills = new ArrayList<>();
    private List<Project> projects = new ArrayList<>();
    private List<Certification> certifications = new ArrayList<>();
    private List<StudentDsaProgress> dsaProgressList = new ArrayList<>();
    private int totalDsaProblemsSolved;

    public StudentProfileDTO() {
    }

    public Student getStudent() {
        return student;
    }

    public void setStudent(Student student) {
        this.student = student;
    }

    public List<StudentSkill> getSkills() {
        return skills;
    }

    public void setSkills(List<StudentSkill> skills) {
        this.skills = skills;
    }

    public List<Project> getProjects() {
        return projects;
    }

    public void setProjects(List<Project> projects) {
        this.projects = projects;
    }

    public List<Certification> getCertifications() {
        return certifications;
    }

    public void setCertifications(List<Certification> certifications) {
        this.certifications = certifications;
    }

    public List<StudentDsaProgress> getDsaProgressList() {
        return dsaProgressList;
    }

    public void setDsaProgressList(List<StudentDsaProgress> dsaProgressList) {
        this.dsaProgressList = dsaProgressList;
    }

    public int getTotalDsaProblemsSolved() {
        return totalDsaProblemsSolved;
    }

    public void setTotalDsaProblemsSolved(int totalDsaProblemsSolved) {
        this.totalDsaProblemsSolved = totalDsaProblemsSolved;
    }
}
