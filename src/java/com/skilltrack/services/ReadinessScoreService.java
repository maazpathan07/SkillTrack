package com.skilltrack.services;

import com.skilltrack.constants.AppConstants;
import com.skilltrack.dao.CertificationDAO;
import com.skilltrack.dao.DsaProgressDAO;
import com.skilltrack.dao.ProjectDAO;
import com.skilltrack.dao.SettingsDAO;
import com.skilltrack.dao.TaskDAO;
import com.skilltrack.dto.ReadinessScoreDTO;
import com.skilltrack.dto.SkillGapDTO;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ReadinessScoreService {

    private static final Logger LOGGER = Logger.getLogger(ReadinessScoreService.class.getName());

    private final SettingsDAO settingsDAO;
    private final SkillGapService skillGapService;
    private final DsaProgressDAO dsaProgressDAO;
    private final ProjectDAO projectDAO;
    private final CertificationDAO certificationDAO;
    private final TaskDAO taskDAO;

    public ReadinessScoreService() {
        this.settingsDAO = new SettingsDAO();
        this.skillGapService = new SkillGapService();
        this.dsaProgressDAO = new DsaProgressDAO();
        this.projectDAO = new ProjectDAO();
        this.certificationDAO = new CertificationDAO();
        this.taskDAO = new TaskDAO();
    }

    public ReadinessScoreService(SettingsDAO settingsDAO, SkillGapService skillGapService,
                                 DsaProgressDAO dsaProgressDAO, ProjectDAO projectDAO,
                                 CertificationDAO certificationDAO, TaskDAO taskDAO) {
        this.settingsDAO = settingsDAO;
        this.skillGapService = skillGapService;
        this.dsaProgressDAO = dsaProgressDAO;
        this.projectDAO = projectDAO;
        this.certificationDAO = certificationDAO;
        this.taskDAO = taskDAO;
    }

    public ReadinessScoreDTO calculateReadiness(int studentId) {
        ReadinessScoreDTO dto = new ReadinessScoreDTO();

        try {
            // Load dynamic weights from settings
            double wSkills = settingsDAO.getDoubleSetting(AppConstants.SETTING_WEIGHT_SKILLS, AppConstants.DEFAULT_WEIGHT_SKILLS);
            double wDsa = settingsDAO.getDoubleSetting(AppConstants.SETTING_WEIGHT_DSA, AppConstants.DEFAULT_WEIGHT_DSA);
            double wProjects = settingsDAO.getDoubleSetting(AppConstants.SETTING_WEIGHT_PROJECTS, AppConstants.DEFAULT_WEIGHT_PROJECTS);
            double wCerts = settingsDAO.getDoubleSetting(AppConstants.SETTING_WEIGHT_CERTS, AppConstants.DEFAULT_WEIGHT_CERTS);
            double wTasks = settingsDAO.getDoubleSetting(AppConstants.SETTING_WEIGHT_TASKS, AppConstants.DEFAULT_WEIGHT_TASKS);

            // Load dynamic benchmarks
            int bDsa = settingsDAO.getIntSetting(AppConstants.SETTING_BENCHMARK_DSA, AppConstants.DEFAULT_BENCHMARK_DSA);
            int bProjects = settingsDAO.getIntSetting(AppConstants.SETTING_BENCHMARK_PROJECTS, AppConstants.DEFAULT_BENCHMARK_PROJECTS);
            int bCerts = settingsDAO.getIntSetting(AppConstants.SETTING_BENCHMARK_CERTS, AppConstants.DEFAULT_BENCHMARK_CERTS);

            dto.setWeightSkills(wSkills);
            dto.setWeightDsa(wDsa);
            dto.setWeightProjects(wProjects);
            dto.setWeightCerts(wCerts);
            dto.setWeightTasks(wTasks);

            dto.setDsaBenchmark(bDsa);
            dto.setProjectBenchmark(bProjects);
            dto.setCertBenchmark(bCerts);

            // 1. Skill Gap Readiness (S)
            SkillGapDTO gapDTO = skillGapService.calculateSkillGap(studentId, null);
            double skillMatchPct = gapDTO.getSkillMatchPercentage();
            double skillReadiness = Math.min(100.0, Math.max(0.0, skillMatchPct));
            dto.setSkillMatchPct(skillMatchPct);
            dto.setSkillReadiness(Math.round(skillReadiness * 10.0) / 10.0);

            // 2. DSA Readiness (D)
            int dsaSolved = dsaProgressDAO.getTotalProblemsSolved(studentId);
            double dsaReadiness = (bDsa > 0) ? Math.min(100.0, ((double) dsaSolved / bDsa) * 100.0) : 0.0;
            dto.setDsaSolved(dsaSolved);
            dto.setDsaReadiness(Math.round(dsaReadiness * 10.0) / 10.0);

            // 3. Project Readiness (P)
            int projectsCount = projectDAO.countByStudentId(studentId);
            double projectReadiness = (bProjects > 0) ? Math.min(100.0, ((double) projectsCount / bProjects) * 100.0) : 0.0;
            dto.setProjectsCompleted(projectsCount);
            dto.setProjectReadiness(Math.round(projectReadiness * 10.0) / 10.0);

            // 4. Certification Readiness (C)
            int certsCount = certificationDAO.countByStudentId(studentId);
            double certReadiness = (bCerts > 0) ? Math.min(100.0, ((double) certsCount / bCerts) * 100.0) : 0.0;
            dto.setCertsCompleted(certsCount);
            dto.setCertReadiness(Math.round(certReadiness * 10.0) / 10.0);

            // 5. Preparation Task Readiness (T)
            int totalTasks = taskDAO.countTotalTasks(studentId);
            int completedTasks = taskDAO.countCompletedTasks(studentId);
            double taskReadiness = (totalTasks > 0) ? Math.min(100.0, ((double) completedTasks / totalTasks) * 100.0) : 0.0;
            dto.setTotalTasks(totalTasks);
            dto.setTasksCompleted(completedTasks);
            dto.setTaskReadiness(Math.round(taskReadiness * 10.0) / 10.0);

            // Overall Readiness Index: (0.35 * S) + (0.25 * D) + (0.20 * P) + (0.10 * C) + (0.10 * T)
            double overall = (wSkills * skillReadiness)
                           + (wDsa * dsaReadiness)
                           + (wProjects * projectReadiness)
                           + (wCerts * certReadiness)
                           + (wTasks * taskReadiness);

            overall = Math.min(100.0, Math.max(0.0, overall));
            dto.setOverallReadiness(Math.round(overall * 10.0) / 10.0);

            return dto;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Database error computing readiness score for student ID: " + studentId, e);
            return dto;
        }
    }
}
