package com.skilltrack.services;

import com.skilltrack.dao.AnalyticsDAO;
import com.skilltrack.dao.CertificationDAO;
import com.skilltrack.dao.DsaProgressDAO;
import com.skilltrack.dao.ProjectDAO;
import com.skilltrack.dao.SkillDAO;
import com.skilltrack.dao.StudentDAO;
import com.skilltrack.dto.AdminDashboardDTO;
import com.skilltrack.dto.CohortSummaryDTO;
import com.skilltrack.dto.ReadinessScoreDTO;
import com.skilltrack.dto.StudentDirectoryDTO;
import com.skilltrack.models.Student;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

public class AnalyticsService {

    private static final Logger LOGGER = Logger.getLogger(AnalyticsService.class.getName());

    private final AnalyticsDAO analyticsDAO;
    private final StudentDAO studentDAO;
    private final SkillDAO skillDAO;
    private final ProjectDAO projectDAO;
    private final CertificationDAO certificationDAO;
    private final DsaProgressDAO dsaProgressDAO;
    private final ReadinessScoreService readinessScoreService;

    public AnalyticsService() {
        this.analyticsDAO = new AnalyticsDAO();
        this.studentDAO = new StudentDAO();
        this.skillDAO = new SkillDAO();
        this.projectDAO = new ProjectDAO();
        this.certificationDAO = new CertificationDAO();
        this.dsaProgressDAO = new DsaProgressDAO();
        this.readinessScoreService = new ReadinessScoreService();
    }

    public AdminDashboardDTO getAdminDashboardStats() {
        AdminDashboardDTO dto = new AdminDashboardDTO();

        try {
            dto.setTotalStudents(analyticsDAO.getTotalStudents());
            dto.setTotalRoles(analyticsDAO.getTotalRoles());
            dto.setTotalSkills(analyticsDAO.getTotalSkills());
            dto.setTotalCriteria(analyticsDAO.getTotalCriteria());
            dto.setDepartmentDistribution(analyticsDAO.getDepartmentDistribution());
            dto.setRoleDistribution(analyticsDAO.getRoleDistribution());

            List<Student> allStudents = studentDAO.findAll();
            if (!allStudents.isEmpty()) {
                double totalReadiness = 0.0;
                int ready = 0;
                int inProg = 0;
                int needsAttn = 0;

                for (Student s : allStudents) {
                    ReadinessScoreDTO r = readinessScoreService.calculateReadiness(s.getStudentId());
                    double score = r.getOverallReadiness();
                    totalReadiness += score;

                    if (score >= 75.0) {
                        ready++;
                    } else if (score >= 50.0) {
                        inProg++;
                    } else {
                        needsAttn++;
                    }
                }

                double avg = totalReadiness / allStudents.size();
                dto.setAvgReadiness(Math.round(avg * 10.0) / 10.0);
                dto.setReadyStudentsCount(ready);
                dto.setInProgressStudentsCount(inProg);
                dto.setNeedsAttentionCount(needsAttn);
            }

            return dto;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error building admin dashboard stats", e);
            return dto;
        }
    }

    public StudentDirectoryDTO getStudentDirectory(String search, String dept, Integer gradYear, Integer targetRoleId,
                                                  Double minCgpa, Double minReadiness, Integer skillId, String skillLevel,
                                                  int page, int pageSize) {
        StudentDirectoryDTO directory = new StudentDirectoryDTO();
        directory.setCurrentPage(page > 0 ? page : 1);
        directory.setPageSize(pageSize > 0 ? pageSize : 10);
        directory.setSearchKeyword(search);
        directory.setDepartmentFilter(dept);
        directory.setGradYearFilter(gradYear);
        directory.setTargetRoleIdFilter(targetRoleId);
        directory.setMinCgpaFilter(minCgpa);
        directory.setMinReadinessFilter(minReadiness);
        directory.setSkillIdFilter(skillId);
        directory.setSkillLevelFilter(skillLevel);

        try {
            int offset = (directory.getCurrentPage() - 1) * directory.getPageSize();
            List<Student> students = studentDAO.findAllStudents(search, dept, gradYear, targetRoleId, minCgpa, skillId, skillLevel, offset, directory.getPageSize());
            int totalCount = studentDAO.countStudents(search, dept, gradYear, targetRoleId, minCgpa, skillId, skillLevel);

            List<StudentDirectoryDTO.DirectoryItem> items = new ArrayList<>();
            for (Student s : students) {
                ReadinessScoreDTO r = readinessScoreService.calculateReadiness(s.getStudentId());

                if (minReadiness != null && minReadiness > 0.0 && r.getOverallReadiness() < minReadiness) {
                    continue;
                }

                int skillCount = skillDAO.findByStudentId(s.getStudentId()).size();
                int projCount = projectDAO.countByStudentId(s.getStudentId());
                int certCount = certificationDAO.countByStudentId(s.getStudentId());
                int dsaCount = dsaProgressDAO.getTotalProblemsSolved(s.getStudentId());

                items.add(new StudentDirectoryDTO.DirectoryItem(s, r, skillCount, projCount, certCount, dsaCount));
            }

            directory.setItems(items);
            directory.setTotalRecords(totalCount);

            return directory;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error retrieving student directory", e);
            return directory;
        }
    }

    public CohortSummaryDTO getCohortSummary() {
        CohortSummaryDTO summary = new CohortSummaryDTO();

        try {
            List<Student> allStudents = studentDAO.findAll();
            summary.setTotalStudents(allStudents.size());

            if (allStudents.isEmpty()) {
                return summary;
            }

            double sumCgpa = 0.0;
            double sumReadiness = 0.0;
            double sumDsa = 0.0;
            double sumProj = 0.0;
            double sumCerts = 0.0;

            int highReady = 0;
            int medReady = 0;
            int lowReady = 0;

            Map<String, List<Student>> deptStudents = new HashMap<>();
            List<StudentDirectoryDTO.DirectoryItem> allItems = new ArrayList<>();

            for (Student s : allStudents) {
                sumCgpa += s.getCgpa();
                ReadinessScoreDTO r = readinessScoreService.calculateReadiness(s.getStudentId());
                double score = r.getOverallReadiness();
                sumReadiness += score;

                if (score >= 75.0) highReady++;
                else if (score >= 50.0) medReady++;
                else lowReady++;

                int dsa = dsaProgressDAO.getTotalProblemsSolved(s.getStudentId());
                int projs = projectDAO.countByStudentId(s.getStudentId());
                int certs = certificationDAO.countByStudentId(s.getStudentId());
                int skills = skillDAO.findByStudentId(s.getStudentId()).size();

                sumDsa += dsa;
                sumProj += projs;
                sumCerts += certs;

                deptStudents.computeIfAbsent(s.getDepartment(), k -> new ArrayList<>()).add(s);
                allItems.add(new StudentDirectoryDTO.DirectoryItem(s, r, skills, projs, certs, dsa));
            }

            int n = allStudents.size();
            summary.setCohortAvgCgpa(Math.round((sumCgpa / n) * 100.0) / 100.0);
            summary.setCohortAvgReadiness(Math.round((sumReadiness / n) * 10.0) / 10.0);
            summary.setCohortAvgDsaProblems(Math.round((sumDsa / n) * 10.0) / 10.0);
            summary.setCohortAvgProjects(Math.round((sumProj / n) * 10.0) / 10.0);
            summary.setCohortAvgCerts(Math.round((sumCerts / n) * 10.0) / 10.0);

            summary.setHighReadinessCount(highReady);
            summary.setMediumReadinessCount(medReady);
            summary.setLowReadinessCount(lowReady);

            // Department Summaries
            List<CohortSummaryDTO.DeptCohortSummary> deptList = new ArrayList<>();
            for (Map.Entry<String, List<Student>> entry : deptStudents.entrySet()) {
                String dept = entry.getKey();
                List<Student> list = entry.getValue();
                double dCgpa = 0.0;
                double dReadiness = 0.0;
                for (Student st : list) {
                    dCgpa += st.getCgpa();
                    dReadiness += readinessScoreService.calculateReadiness(st.getStudentId()).getOverallReadiness();
                }
                deptList.add(new CohortSummaryDTO.DeptCohortSummary(
                    dept,
                    list.size(),
                    Math.round((dCgpa / list.size()) * 100.0) / 100.0,
                    Math.round((dReadiness / list.size()) * 10.0) / 10.0
                ));
            }
            summary.setDepartmentSummaries(deptList);

            // Sort top ready students descending by readiness
            Collections.sort(allItems, (a, b) -> Double.compare(
                b.getReadinessScore().getOverallReadiness(),
                a.getReadinessScore().getOverallReadiness()
            ));

            List<StudentDirectoryDTO.DirectoryItem> topList = allItems.size() > 10 ? allItems.subList(0, 10) : allItems;
            summary.setTopReadyStudents(topList);

            return summary;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error building cohort summary", e);
            return summary;
        }
    }
}
