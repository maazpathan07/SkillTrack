package com.skilltrack.services;

import com.skilltrack.constants.CriteriaStatus;
import com.skilltrack.constants.SkillLevel;
import com.skilltrack.dao.CertificationDAO;
import com.skilltrack.dao.DsaProgressDAO;
import com.skilltrack.dao.PlacementCriteriaDAO;
import com.skilltrack.dao.ProjectDAO;
import com.skilltrack.dao.SkillDAO;
import com.skilltrack.dao.StudentDAO;
import com.skilltrack.dto.CriteriaResultItemDTO;
import com.skilltrack.dto.DriveShortlistDTO;
import com.skilltrack.dto.PlacementCriteriaEvaluationDTO;
import com.skilltrack.models.CriteriaSkillRequirement;
import com.skilltrack.models.PlacementCriteria;
import com.skilltrack.models.Student;
import com.skilltrack.models.StudentSkill;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

public class PlacementCriteriaService {

    private static final Logger LOGGER = Logger.getLogger(PlacementCriteriaService.class.getName());

    private final PlacementCriteriaDAO criteriaDAO;
    private final StudentDAO studentDAO;
    private final SkillDAO skillDAO;
    private final ProjectDAO projectDAO;
    private final CertificationDAO certificationDAO;
    private final DsaProgressDAO dsaProgressDAO;

    public PlacementCriteriaService() {
        this.criteriaDAO = new PlacementCriteriaDAO();
        this.studentDAO = new StudentDAO();
        this.skillDAO = new SkillDAO();
        this.projectDAO = new ProjectDAO();
        this.certificationDAO = new CertificationDAO();
        this.dsaProgressDAO = new DsaProgressDAO();
    }

    public List<PlacementCriteria> getAllCriteria(boolean activeOnly) {
        try {
            return criteriaDAO.findAll(activeOnly);
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching all criteria", e);
            return new ArrayList<>();
        }
    }

    public PlacementCriteria getCriteriaById(int criteriaId) {
        try {
            return criteriaDAO.findById(criteriaId);
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error finding criteria by ID: " + criteriaId, e);
            return null;
        }
    }

    public int createCriteria(PlacementCriteria criteria, List<CriteriaSkillRequirement> requirements) throws SQLException {
        int id = criteriaDAO.createCriteria(criteria);
        if (requirements != null && !requirements.isEmpty()) {
            criteriaDAO.saveCriteriaRequirements(id, requirements);
        }
        return id;
    }

    public boolean updateCriteria(PlacementCriteria criteria, List<CriteriaSkillRequirement> requirements) throws SQLException {
        boolean updated = criteriaDAO.updateCriteria(criteria);
        if (updated && requirements != null) {
            criteriaDAO.saveCriteriaRequirements(criteria.getCriteriaId(), requirements);
        }
        return updated;
    }

    public boolean deleteCriteria(int criteriaId) throws SQLException {
        return criteriaDAO.deleteCriteria(criteriaId);
    }

    public List<PlacementCriteriaEvaluationDTO> evaluateStudentAgainstAllCriteria(int studentId) {
        List<PlacementCriteriaEvaluationDTO> list = new ArrayList<>();
        try {
            List<PlacementCriteria> allCriteria = criteriaDAO.findAll(true);
            for (PlacementCriteria c : allCriteria) {
                list.add(evaluateStudentAgainstCriteria(studentId, c.getCriteriaId()));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error evaluating student against all criteria: " + studentId, e);
        }
        return list;
    }

    public PlacementCriteriaEvaluationDTO evaluateStudentAgainstCriteria(int studentId, int criteriaId) {
        PlacementCriteriaEvaluationDTO eval = new PlacementCriteriaEvaluationDTO();

        try {
            Student student = studentDAO.findById(studentId);
            PlacementCriteria criteria = criteriaDAO.findById(criteriaId);

            if (student == null || criteria == null) {
                eval.setOverallStatus(CriteriaStatus.NOT_APPLICABLE);
                return eval;
            }

            eval.setStudent(student);
            eval.setCriteria(criteria);

            List<StudentSkill> studentSkills = skillDAO.findByStudentId(studentId);
            Map<Integer, StudentSkill> skillMap = new HashMap<>();
            for (StudentSkill ss : studentSkills) {
                skillMap.put(ss.getSkillId(), ss);
            }

            int dsaSolved = dsaProgressDAO.getTotalProblemsSolved(studentId);
            int projectCount = projectDAO.countByStudentId(studentId);
            int certCount = certificationDAO.countByStudentId(studentId);

            List<CriteriaResultItemDTO> results = new ArrayList<>();
            int passedCount = 0;
            int totalChecks = 0;
            int severeFailures = 0;

            // 1. Department Check
            totalChecks++;
            boolean deptAllowed = criteria.isDepartmentAllowed(student.getDepartment());
            if (deptAllowed) {
                passedCount++;
                results.add(new CriteriaResultItemDTO(
                    "Eligible Department",
                    criteria.getAllowedDepartments(),
                    student.getDepartment(),
                    CriteriaStatus.MEETS_REQUIREMENT,
                    "Department is eligible"
                ));
            } else {
                severeFailures++;
                results.add(new CriteriaResultItemDTO(
                    "Eligible Department",
                    criteria.getAllowedDepartments(),
                    student.getDepartment(),
                    CriteriaStatus.DOES_NOT_MEET_REQUIREMENT,
                    "Department not listed in eligible branches"
                ));
            }

            // 2. CGPA Check
            totalChecks++;
            if (student.getCgpa() >= criteria.getMinCgpa()) {
                passedCount++;
                results.add(new CriteriaResultItemDTO(
                    "Minimum CGPA",
                    String.format(">= %.2f", criteria.getMinCgpa()),
                    String.format("%.2f", student.getCgpa()),
                    CriteriaStatus.MEETS_REQUIREMENT,
                    "CGPA benchmark satisfied"
                ));
            } else if (student.getCgpa() >= (criteria.getMinCgpa() - 0.5)) {
                results.add(new CriteriaResultItemDTO(
                    "Minimum CGPA",
                    String.format(">= %.2f", criteria.getMinCgpa()),
                    String.format("%.2f", student.getCgpa()),
                    CriteriaStatus.NEEDS_IMPROVEMENT,
                    "Slightly below benchmark threshold"
                ));
            } else {
                severeFailures++;
                results.add(new CriteriaResultItemDTO(
                    "Minimum CGPA",
                    String.format(">= %.2f", criteria.getMinCgpa()),
                    String.format("%.2f", student.getCgpa()),
                    CriteriaStatus.DOES_NOT_MEET_REQUIREMENT,
                    "Below minimum required cutoff"
                ));
            }

            // 3. DSA Problems Check
            if (criteria.getMinDsaProblems() > 0) {
                totalChecks++;
                if (dsaSolved >= criteria.getMinDsaProblems()) {
                    passedCount++;
                    results.add(new CriteriaResultItemDTO(
                        "DSA Problems Solved",
                        ">= " + criteria.getMinDsaProblems(),
                        String.valueOf(dsaSolved),
                        CriteriaStatus.MEETS_REQUIREMENT,
                        "Target problem threshold reached"
                    ));
                } else if (dsaSolved >= (criteria.getMinDsaProblems() * 0.7)) {
                    results.add(new CriteriaResultItemDTO(
                        "DSA Problems Solved",
                        ">= " + criteria.getMinDsaProblems(),
                        String.valueOf(dsaSolved),
                        CriteriaStatus.NEEDS_IMPROVEMENT,
                        "Progressing well towards threshold"
                    ));
                } else {
                    results.add(new CriteriaResultItemDTO(
                        "DSA Problems Solved",
                        ">= " + criteria.getMinDsaProblems(),
                        String.valueOf(dsaSolved),
                        CriteriaStatus.DOES_NOT_MEET_REQUIREMENT,
                        "Requires further practice"
                    ));
                }
            }

            // 4. Projects Check
            if (criteria.getMinProjects() > 0) {
                totalChecks++;
                if (projectCount >= criteria.getMinProjects()) {
                    passedCount++;
                    results.add(new CriteriaResultItemDTO(
                        "Completed Projects",
                        ">= " + criteria.getMinProjects(),
                        String.valueOf(projectCount),
                        CriteriaStatus.MEETS_REQUIREMENT,
                        "Project count satisfied"
                    ));
                } else {
                    results.add(new CriteriaResultItemDTO(
                        "Completed Projects",
                        ">= " + criteria.getMinProjects(),
                        String.valueOf(projectCount),
                        CriteriaStatus.NEEDS_IMPROVEMENT,
                        "Additional portfolio projects recommended"
                    ));
                }
            }

            // 5. Certifications Check
            if (criteria.getMinCertifications() > 0) {
                totalChecks++;
                if (certCount >= criteria.getMinCertifications()) {
                    passedCount++;
                    results.add(new CriteriaResultItemDTO(
                        "Verified Certifications",
                        ">= " + criteria.getMinCertifications(),
                        String.valueOf(certCount),
                        CriteriaStatus.MEETS_REQUIREMENT,
                        "Certification threshold met"
                    ));
                } else {
                    results.add(new CriteriaResultItemDTO(
                        "Verified Certifications",
                        ">= " + criteria.getMinCertifications(),
                        String.valueOf(certCount),
                        CriteriaStatus.NEEDS_IMPROVEMENT,
                        "Industry certification recommended"
                    ));
                }
            }

            // 6. Skill Benchmark Checks
            List<CriteriaSkillRequirement> skillReqs = criteria.getSkillRequirements();
            if (skillReqs != null) {
                for (CriteriaSkillRequirement req : skillReqs) {
                    totalChecks++;
                    StudentSkill possessed = skillMap.get(req.getSkillId());
                    SkillLevel studentLevel = (possessed != null) ? possessed.getProficiencyLevel() : null;

                    if (possessed != null && studentLevel.meetsOrExceeds(req.getMinProficiency())) {
                        passedCount++;
                        results.add(new CriteriaResultItemDTO(
                            "Skill: " + req.getSkillName(),
                            req.getMinProficiency().getDisplayName(),
                            studentLevel.getDisplayName(),
                            CriteriaStatus.MEETS_REQUIREMENT,
                            "Skill requirement met"
                        ));
                    } else if (possessed != null) {
                        results.add(new CriteriaResultItemDTO(
                            "Skill: " + req.getSkillName(),
                            req.getMinProficiency().getDisplayName(),
                            studentLevel.getDisplayName(),
                            CriteriaStatus.NEEDS_IMPROVEMENT,
                            "Proficiency level needs advancement"
                        ));
                    } else {
                        if (req.isMandatory()) {
                            severeFailures++;
                        }
                        results.add(new CriteriaResultItemDTO(
                            "Skill: " + req.getSkillName(),
                            req.getMinProficiency().getDisplayName(),
                            "None",
                            CriteriaStatus.DOES_NOT_MEET_REQUIREMENT,
                            "Mandatory skill missing from profile"
                        ));
                    }
                }
            }

            eval.setResultItems(results);
            eval.setTotalChecks(totalChecks);
            eval.setPassedCount(passedCount);

            // Compute overall assessment status
            if (severeFailures > 0) {
                eval.setOverallStatus(CriteriaStatus.DOES_NOT_MEET_REQUIREMENT);
            } else if (passedCount == totalChecks) {
                eval.setOverallStatus(CriteriaStatus.MEETS_REQUIREMENT);
            } else {
                eval.setOverallStatus(CriteriaStatus.NEEDS_IMPROVEMENT);
            }

            return eval;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Database error evaluating placement criteria " + criteriaId + " for student " + studentId, e);
            eval.setOverallStatus(CriteriaStatus.NOT_APPLICABLE);
            return eval;
        }
    }

    public DriveShortlistDTO generateDriveShortlist(int criteriaId) {
        DriveShortlistDTO shortlist = new DriveShortlistDTO();
        try {
            PlacementCriteria criteria = criteriaDAO.findById(criteriaId);
            if (criteria == null) {
                return shortlist;
            }
            shortlist.setCriteria(criteria);

            List<Student> allStudents = studentDAO.findAllStudents(null, null, null, null, null, null, null, 0, 2000);
            List<PlacementCriteriaEvaluationDTO> allEvals = new ArrayList<>();
            List<PlacementCriteriaEvaluationDTO> eligible = new ArrayList<>();
            List<PlacementCriteriaEvaluationDTO> nearEligible = new ArrayList<>();
            List<PlacementCriteriaEvaluationDTO> nonEligible = new ArrayList<>();
            Map<String, Integer> deptMap = new HashMap<>();

            double totalEligibleCgpa = 0.0;

            for (Student s : allStudents) {
                PlacementCriteriaEvaluationDTO eval = evaluateStudentAgainstCriteria(s.getStudentId(), criteriaId);
                allEvals.add(eval);

                if (eval.getOverallStatus() == CriteriaStatus.MEETS_REQUIREMENT) {
                    eligible.add(eval);
                    totalEligibleCgpa += s.getCgpa();
                    deptMap.put(s.getDepartment(), deptMap.getOrDefault(s.getDepartment(), 0) + 1);
                } else if (eval.getOverallStatus() == CriteriaStatus.NEEDS_IMPROVEMENT) {
                    nearEligible.add(eval);
                } else {
                    nonEligible.add(eval);
                }
            }

            shortlist.setAllEvaluations(allEvals);
            shortlist.setEligibleCandidates(eligible);
            shortlist.setNearEligibleCandidates(nearEligible);
            shortlist.setNonEligibleCandidates(nonEligible);
            shortlist.setTotalEvaluated(allStudents.size());
            shortlist.setEligibleCount(eligible.size());
            shortlist.setNearEligibleCount(nearEligible.size());
            shortlist.setNonEligibleCount(nonEligible.size());
            shortlist.setDeptBreakdown(deptMap);

            if (!allStudents.isEmpty()) {
                shortlist.setEligibilityRate(((double) eligible.size() / allStudents.size()) * 100.0);
            }
            if (!eligible.isEmpty()) {
                shortlist.setAvgEligibleCgpa(totalEligibleCgpa / eligible.size());
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error generating drive shortlist for criteriaId: " + criteriaId, e);
        }
        return shortlist;
    }

    public Map<Integer, Integer> getEligibleCountMapForAllCriteria() {
        Map<Integer, Integer> countMap = new HashMap<>();
        try {
            List<PlacementCriteria> allCriteria = criteriaDAO.findAll(false);
            List<Student> allStudents = studentDAO.findAllStudents(null, null, null, null, null, null, null, 0, 2000);

            for (PlacementCriteria c : allCriteria) {
                int eligibleCount = 0;
                for (Student s : allStudents) {
                    PlacementCriteriaEvaluationDTO eval = evaluateStudentAgainstCriteria(s.getStudentId(), c.getCriteriaId());
                    if (eval.getOverallStatus() == CriteriaStatus.MEETS_REQUIREMENT) {
                        eligibleCount++;
                    }
                }
                countMap.put(c.getCriteriaId(), eligibleCount);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error computing eligible counts map", e);
        }
        return countMap;
    }
}
