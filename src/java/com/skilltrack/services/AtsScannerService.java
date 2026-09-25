package com.skilltrack.services;

import com.skilltrack.dao.PlacementCriteriaDAO;
import com.skilltrack.dao.SkillDAO;
import com.skilltrack.dao.TargetRoleDAO;
import com.skilltrack.dto.AtsScanResultDTO;
import com.skilltrack.dto.StudentProfileDTO;
import com.skilltrack.models.Certification;
import com.skilltrack.models.CriteriaSkillRequirement;
import com.skilltrack.models.PlacementCriteria;
import com.skilltrack.models.Project;
import com.skilltrack.models.RoleSkillRequirement;
import com.skilltrack.models.Skill;
import com.skilltrack.models.StudentSkill;
import com.skilltrack.models.TargetRole;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Locale;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class AtsScannerService {

    private static final Logger LOGGER = Logger.getLogger(AtsScannerService.class.getName());

    private final TargetRoleDAO targetRoleDAO = new TargetRoleDAO();
    private final PlacementCriteriaDAO placementCriteriaDAO = new PlacementCriteriaDAO();
    private final SkillDAO skillDAO = new SkillDAO();

    // High-impact action verbs that ATS parsers look for
    private static final List<String> ACTION_VERBS = Arrays.asList(
        "architected", "developed", "engineered", "optimized", "implemented", "deployed",
        "automated", "scaled", "streamlined", "integrated", "built", "designed",
        "refactored", "delivered", "accelerated", "spearheaded", "configured", "maintained",
        "orchestrated", "migrated", "executed", "collaborated", "managed", "resolved",
        "solved", "formulated", "established", "reduced", "increased", "boosted"
    );

    // Standard ATS section identifiers
    private static final String[] SECTION_NAMES = {
        "EDUCATION", "TECHNICAL SKILLS", "PROJECTS", "CERTIFICATIONS", "EXPERIENCE", "PROBLEM SOLVING"
    };

    // Metric patterns (e.g. 35%, 10x, 500+ users, 40ms, 99.9% uptime)
    private static final Pattern METRIC_PATTERN = Pattern.compile(
        "\\b(\\d+(?:\\.\\d+)?%|\\d+x|\\d+\\+|\\d+\\s*(?:ms|seconds|users|requests|queries|clients|records|rps|mbps|million|k|stars))\\b",
        Pattern.CASE_INSENSITIVE
    );

    public AtsScanResultDTO scanResume(String resumeText, Integer targetRoleId, Integer criteriaId, StudentProfileDTO studentProfile) {
        AtsScanResultDTO result = new AtsScanResultDTO();

        // If resume text is empty, compile default text from student profile
        if (resumeText == null || resumeText.trim().isEmpty()) {
            resumeText = buildProfileResumeText(studentProfile);
        }

        String rawText = resumeText;
        String lowerText = rawText.toLowerCase(Locale.ROOT);

        // Word count & Char count
        String[] words = rawText.trim().split("\\s+");
        result.setWordCount(rawText.trim().isEmpty() ? 0 : words.length);
        result.setCharacterCount(rawText.length());

        // 1. Gather required target skills
        Set<String> requiredSkillNames = new LinkedHashSet<>();
        String roleTitle = "General Software Engineering";
        String companyName = null;

        try {
            if (criteriaId != null && criteriaId > 0) {
                PlacementCriteria criteria = placementCriteriaDAO.findById(criteriaId);
                if (criteria != null) {
                    companyName = criteria.getCompanyName();
                    roleTitle = criteria.getRoleTitle();
                    result.setCompanyName(companyName);
                    if (criteria.getSkillRequirements() != null) {
                        for (CriteriaSkillRequirement csr : criteria.getSkillRequirements()) {
                            if (csr.getSkillName() != null) {
                                requiredSkillNames.add(csr.getSkillName().trim());
                            }
                        }
                    }
                }
            } else if (targetRoleId != null && targetRoleId > 0) {
                TargetRole role = targetRoleDAO.findById(targetRoleId);
                if (role != null) {
                    roleTitle = role.getRoleTitle();
                    if (role.getRequirements() != null) {
                        for (RoleSkillRequirement rsr : role.getRequirements()) {
                            if (rsr.getSkillName() != null) {
                                requiredSkillNames.add(rsr.getSkillName().trim());
                            }
                        }
                    }
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.WARNING, "Error loading target role / criteria skills for ATS scan", e);
        }

        result.setTargetRoleTitle(roleTitle);

        // Fallback default skills if no specific requirements found
        if (requiredSkillNames.isEmpty()) {
            requiredSkillNames.addAll(Arrays.asList("Java", "Data Structures", "Algorithms", "SQL", "Git", "REST API", "Spring Boot", "Web Development"));
        }

        // 2. Keyword Match Evaluation
        List<String> matched = new ArrayList<>();
        List<String> missing = new ArrayList<>();

        for (String skill : requiredSkillNames) {
            String skillLower = skill.toLowerCase(Locale.ROOT);
            // Check word boundary or substring
            if (containsKeyword(lowerText, skillLower)) {
                matched.add(skill);
            } else {
                missing.add(skill);
            }
        }

        result.setMatchedKeywords(matched);
        result.setMissingKeywords(missing);

        int totalRequired = requiredSkillNames.size();
        int keywordScore = (totalRequired > 0) ? (int) Math.round(((double) matched.size() / totalRequired) * 100.0) : 100;
        result.setKeywordScore(keywordScore);

        // 3. Action Verbs Evaluation
        List<String> detectedVerbs = new ArrayList<>();
        for (String verb : ACTION_VERBS) {
            if (containsKeyword(lowerText, verb)) {
                detectedVerbs.add(verb.substring(0, 1).toUpperCase() + verb.substring(1));
            }
        }
        result.setDetectedActionVerbs(detectedVerbs);
        // Benchmark: 4+ action verbs gives 100%
        int actionVerbScore = Math.min(100, (int) Math.round((detectedVerbs.size() / 4.0) * 100.0));
        result.setActionVerbScore(actionVerbScore);

        // 4. Quantifiable Metrics & Numbers Evaluation
        List<String> detectedMetrics = new ArrayList<>();
        Matcher metricMatcher = METRIC_PATTERN.matcher(rawText);
        while (metricMatcher.find()) {
            String m = metricMatcher.group().trim();
            if (!detectedMetrics.contains(m) && detectedMetrics.size() < 10) {
                detectedMetrics.add(m);
            }
        }
        result.setDetectedMetrics(detectedMetrics);
        // Benchmark: 2+ quantifiable numbers gives 100%
        int metricScore = Math.min(100, (int) Math.round((detectedMetrics.size() / 2.0) * 100.0));
        result.setMetricScore(metricScore);

        // 5. Section Header Compliance Evaluation
        List<String> presentSections = new ArrayList<>();
        List<String> missingSections = new ArrayList<>();
        for (String section : SECTION_NAMES) {
            if (lowerText.contains(section.toLowerCase(Locale.ROOT)) || lowerText.contains(section.toLowerCase(Locale.ROOT).replace(" ", ""))) {
                presentSections.add(section);
            } else {
                missingSections.add(section);
            }
        }
        result.setPresentSections(presentSections);
        result.setMissingSections(missingSections);

        int formatScore = (int) Math.round(((double) presentSections.size() / SECTION_NAMES.length) * 100.0);
        result.setFormatScore(formatScore);

        // 6. Composite ATS Score Calculation
        // Weights: 45% Keyword Match, 25% Action Verbs, 15% Metrics, 15% Section Compliance
        int overallScore = (int) Math.round(
            (keywordScore * 0.45) +
            (actionVerbScore * 0.25) +
            (metricScore * 0.15) +
            (formatScore * 0.15)
        );
        overallScore = Math.max(0, Math.min(100, overallScore));
        result.setOverallScore(overallScore);

        // 7. Generate Smart Actionable Recommendations
        List<String> tips = new ArrayList<>();
        if (!missing.isEmpty()) {
            StringBuilder sb = new StringBuilder("Include missing core keywords in your technical skills or project bullets: ");
            int limit = Math.min(4, missing.size());
            for (int i = 0; i < limit; i++) {
                sb.append(missing.get(i));
                if (i < limit - 1) sb.append(", ");
            }
            if (missing.size() > limit) sb.append(" and ").append(missing.size() - limit).append(" more.");
            tips.add(sb.toString());
        }

        if (detectedVerbs.size() < 3) {
            tips.add("Start your project bullet points with strong active verbs like 'Architected', 'Engineered', 'Optimized', or 'Automated'.");
        }

        if (detectedMetrics.isEmpty()) {
            tips.add("Quantify your impact with measurable metrics (e.g. 'Improved query latency by 35%', 'Handled 500+ requests/sec').");
        }

        if (words.length < 120) {
            tips.add("Your resume text appears too brief. Elaborate on project architecture and algorithmic milestones to improve parser depth.");
        } else if (words.length > 700) {
            tips.add("Your resume text may exceed standard 1-page limits. Keep project descriptions concise and focused on high-impact results.");
        }

        if (tips.isEmpty()) {
            tips.add("Your resume has excellent keyword alignment and formatting! You are well-positioned for automated campus screening.");
        }

        result.setImprovementTips(tips);
        return result;
    }

    private boolean containsKeyword(String text, String keyword) {
        if (text == null || keyword == null) return false;
        String regex = "\\b" + Pattern.quote(keyword) + "\\b";
        return Pattern.compile(regex, Pattern.CASE_INSENSITIVE).matcher(text).find() || text.contains(keyword);
    }

    private String buildProfileResumeText(StudentProfileDTO profile) {
        if (profile == null || profile.getStudent() == null) {
            return "";
        }
        StringBuilder sb = new StringBuilder();
        sb.append(profile.getStudent().getFullName()).append("\n");
        sb.append("Email: ").append(profile.getStudent().getEmail()).append("\n");
        sb.append("Department: ").append(profile.getStudent().getDepartment()).append("\n");
        sb.append("CGPA: ").append(profile.getStudent().getCgpa()).append("\n\n");

        sb.append("EDUCATION\n");
        sb.append("Bachelor of Technology in ").append(profile.getStudent().getDepartment())
          .append(" - Batch ").append(profile.getStudent().getGraduationYear()).append("\n\n");

        sb.append("TECHNICAL SKILLS\n");
        if (profile.getSkills() != null) {
            for (StudentSkill s : profile.getSkills()) {
                sb.append(s.getSkillName()).append(", ");
            }
            sb.append("\n\n");
        }

        sb.append("PROJECTS\n");
        if (profile.getProjects() != null) {
            for (Project p : profile.getProjects()) {
                sb.append(p.getTitle()).append(" | ").append(p.getTechStack()).append("\n");
                sb.append(p.getDescription()).append("\n");
            }
            sb.append("\n");
        }

        sb.append("PROBLEM SOLVING\n");
        sb.append("Data Structures & Algorithms - Solved ").append(profile.getTotalDsaProblemsSolved()).append(" problems\n\n");

        sb.append("CERTIFICATIONS\n");
        if (profile.getCertifications() != null) {
            for (Certification c : profile.getCertifications()) {
                sb.append(c.getTitle()).append(" - ").append(c.getIssuingOrg()).append("\n");
            }
        }
        return sb.toString();
    }
}
