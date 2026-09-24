package com.skilltrack.services;

import com.skilltrack.constants.SkillLevel;
import com.skilltrack.dao.SkillDAO;
import com.skilltrack.dao.StudentDAO;
import com.skilltrack.dao.TargetRoleDAO;
import com.skilltrack.dto.SkillGapDTO;
import com.skilltrack.dto.SkillGapItemDTO;
import com.skilltrack.models.RoleSkillRequirement;
import com.skilltrack.models.Student;
import com.skilltrack.models.StudentSkill;
import com.skilltrack.models.TargetRole;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

public class SkillGapService {

    private static final Logger LOGGER = Logger.getLogger(SkillGapService.class.getName());

    private final TargetRoleDAO targetRoleDAO;
    private final SkillDAO skillDAO;
    private final StudentDAO studentDAO;

    public SkillGapService() {
        this.targetRoleDAO = new TargetRoleDAO();
        this.skillDAO = new SkillDAO();
        this.studentDAO = new StudentDAO();
    }

    public SkillGapService(TargetRoleDAO targetRoleDAO, SkillDAO skillDAO, StudentDAO studentDAO) {
        this.targetRoleDAO = targetRoleDAO;
        this.skillDAO = skillDAO;
        this.studentDAO = studentDAO;
    }

    public SkillGapDTO calculateSkillGap(int studentId, Integer roleId) {
        SkillGapDTO dto = new SkillGapDTO();

        try {
            if (roleId == null || roleId <= 0) {
                Student student = studentDAO.findById(studentId);
                if (student != null && student.getTargetRoleId() != null && student.getTargetRoleId() > 0) {
                    roleId = student.getTargetRoleId();
                }
            }

            if (roleId == null || roleId <= 0) {
                dto.setRoleId(null);
                dto.setRoleTitle("No Target Role Selected");
                dto.setTotalRequiredSkills(0);
                dto.setMatchedSkillsCount(0);
                dto.setNeedsImprovementCount(0);
                dto.setMissingCount(0);
                dto.setSkillMatchPercentage(0.0);
                return dto;
            }

            TargetRole role = targetRoleDAO.findById(roleId);
            if (role == null) {
                dto.setRoleId(roleId);
                dto.setRoleTitle("Unknown Role");
                return dto;
            }

            dto.setRoleId(role.getRoleId());
            dto.setRoleTitle(role.getRoleTitle());

            List<RoleSkillRequirement> requirements = targetRoleDAO.getRoleRequirements(roleId);
            List<StudentSkill> studentSkills = skillDAO.findByStudentId(studentId);

            Map<Integer, StudentSkill> studentSkillMap = new HashMap<>();
            for (StudentSkill ss : studentSkills) {
                studentSkillMap.put(ss.getSkillId(), ss);
            }

            int matchedCount = 0;
            int needsImprovementCount = 0;
            int missingCount = 0;

            for (RoleSkillRequirement req : requirements) {
                StudentSkill possessed = studentSkillMap.get(req.getSkillId());
                SkillLevel studentLevel = (possessed != null) ? possessed.getProficiencyLevel() : null;
                String status;

                if (possessed == null) {
                    status = "MISSING";
                    missingCount++;
                } else if (studentLevel.meetsOrExceeds(req.getMinProficiency())) {
                    status = "MATCHED";
                    matchedCount++;
                } else {
                    status = "NEEDS_IMPROVEMENT";
                    needsImprovementCount++;
                }

                SkillGapItemDTO item = new SkillGapItemDTO(
                    req.getSkillId(),
                    req.getSkillName(),
                    req.getSkillCategory(),
                    req.getMinProficiency(),
                    studentLevel,
                    status,
                    req.isMandatory()
                );
                dto.getItems().add(item);
            }

            dto.setTotalRequiredSkills(requirements.size());
            dto.setMatchedSkillsCount(matchedCount);
            dto.setNeedsImprovementCount(needsImprovementCount);
            dto.setMissingCount(missingCount);

            if (requirements.isEmpty()) {
                dto.setSkillMatchPercentage(100.0);
            } else {
                double matchPct = ((double) matchedCount / requirements.size()) * 100.0;
                dto.setSkillMatchPercentage(Math.round(matchPct * 10.0) / 10.0);
            }

            return dto;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error calculating skill gap for student: " + studentId + ", role: " + roleId, e);
            dto.setRoleTitle("Calculation Error");
            return dto;
        }
    }
}
