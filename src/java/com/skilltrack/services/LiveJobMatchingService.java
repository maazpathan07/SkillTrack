package com.skilltrack.services;

import com.skilltrack.dao.CertificationDAO;
import com.skilltrack.dao.CodingProfileDAO;
import com.skilltrack.dao.CustomJdEvaluationDAO;
import com.skilltrack.dao.DsaProgressDAO;
import com.skilltrack.dao.PlacementCriteriaDAO;
import com.skilltrack.dao.ProjectDAO;
import com.skilltrack.dao.SkillDAO;
import com.skilltrack.dao.StudentDAO;
import com.skilltrack.dto.DreamJobMatchDTO;
import com.skilltrack.dto.JobGapRoadmapItemDTO;
import com.skilltrack.dto.StudentProfileDTO;
import com.skilltrack.models.Certification;
import com.skilltrack.models.CriteriaSkillRequirement;
import com.skilltrack.models.CustomJdEvaluation;
import com.skilltrack.models.PlacementCriteria;
import com.skilltrack.models.Project;
import com.skilltrack.models.Skill;
import com.skilltrack.models.Student;
import com.skilltrack.models.StudentCodingProfile;
import com.skilltrack.models.StudentDsaProgress;
import com.skilltrack.models.StudentSkill;
import com.skilltrack.utils.SimpleJsonParser;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class LiveJobMatchingService {

    private static final Logger LOGGER = Logger.getLogger(LiveJobMatchingService.class.getName());

    private final PlacementCriteriaDAO placementCriteriaDAO;
    private final StudentDAO studentDAO;
    private final SkillDAO skillDAO;
    private final ProjectDAO projectDAO;
    private final CertificationDAO certificationDAO;
    private final DsaProgressDAO dsaProgressDAO;
    private final CodingProfileDAO codingProfileDAO;
    private final CustomJdEvaluationDAO customJdEvaluationDAO;

    // Standard high-tech skill vocabulary for zero-hardcoded dynamic discovery
    private static final List<String> KNOWN_TECH_KEYWORDS = Arrays.asList(
        "Java", "Python", "JavaScript", "TypeScript", "C++", "C#", "Go", "Rust", "Kotlin", "Swift", "PHP", "Ruby",
        "Spring Boot", "Spring MVC", "Hibernate", "React", "React.js", "Next.js", "Vue.js", "Angular", "Node.js", "Express.js",
        "Django", "FastAPI", "Flask", "ASP.NET", "Servlets", "JSP", "HTML5", "CSS3", "Tailwind CSS", "Bootstrap",
        "MySQL", "PostgreSQL", "MongoDB", "Redis", "Oracle", "Cassandra", "DynamoDB", "SQLite", "Firebase",
        "Docker", "Kubernetes", "AWS", "Amazon Web Services", "GCP", "Google Cloud", "Microsoft Azure", "Linux", "Bash",
        "Git", "GitHub", "CI/CD", "Jenkins", "Kafka", "RabbitMQ", "GraphQL", "RESTful APIs", "REST API", "Microservices",
        "Data Structures", "Algorithms", "DSA", "Dynamic Programming", "Graphs", "Trees", "System Design", "OOP", "DBMS",
        "Operating Systems", "Computer Networks", "Pandas", "NumPy", "PyTorch", "TensorFlow", "Machine Learning", "Artificial Intelligence"
    );

    // Tier 1 Companies dictionary for automatic archetype calibration
    private static final Set<String> TIER1_COMPANIES = new HashSet<>(Arrays.asList(
        "google", "amazon", "microsoft", "meta", "facebook", "apple", "netflix", "uber", "adobe", "atlassian",
        "oracle", "salesforce", "cisco", "nvidia", "goldman sachs", "morgan stanley", "deshaw", "flipkart"
    ));

    private static final Set<String> STARTUP_COMPANIES = new HashSet<>(Arrays.asList(
        "swiggy", "zomato", "razorpay", "cred", "zepto", "blinkit", "groww", "phonepe", "zerodha", "postman", "meesho"
    ));

    public LiveJobMatchingService() {
        this.placementCriteriaDAO = new PlacementCriteriaDAO();
        this.studentDAO = new StudentDAO();
        this.skillDAO = new SkillDAO();
        this.projectDAO = new ProjectDAO();
        this.certificationDAO = new CertificationDAO();
        this.dsaProgressDAO = new DsaProgressDAO();
        this.codingProfileDAO = new CodingProfileDAO();
        this.customJdEvaluationDAO = new CustomJdEvaluationDAO();
    }

    /**
     * Matches student against a database Placement Criteria preset.
     */
    public DreamJobMatchDTO matchAgainstCriteria(int studentId, int criteriaId) {
        try {
            PlacementCriteria criteria = placementCriteriaDAO.findById(criteriaId);
            if (criteria == null) {
                return null;
            }

            StringBuilder jdBuilder = new StringBuilder();
            jdBuilder.append("Company: ").append(criteria.getCompanyName()).append("\n");
            jdBuilder.append("Target Role: ").append(criteria.getRoleTitle()).append("\n");
            jdBuilder.append("Minimum CGPA Cutoff: ").append(criteria.getMinCgpa()).append("\n");
            jdBuilder.append("Target DSA Problems: ").append(criteria.getMinDsaProblems()).append(" solved problems\n");
            jdBuilder.append("Portfolio Projects: ").append(criteria.getMinProjects()).append(" verified projects\n");
            jdBuilder.append("Certifications: ").append(criteria.getMinCertifications()).append(" verified certifications\n");
            jdBuilder.append("Eligible Departments: ").append(criteria.getAllowedDepartments()).append("\n");

            if (criteria.getSkillRequirements() != null) {
                jdBuilder.append("Key Skills: ");
                for (CriteriaSkillRequirement req : criteria.getSkillRequirements()) {
                    jdBuilder.append(req.getSkillName()).append(" (").append(req.getMinProficiency()).append("), ");
                }
            }

            DreamJobMatchDTO match = matchAgainstCustomJd(studentId, criteria.getCompanyName(), criteria.getRoleTitle(), jdBuilder.toString(), "PRESET_CRITERIA", null, false);
            match.setCriteriaId(criteriaId);
            return match;

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error matching student " + studentId + " against criteria " + criteriaId, e);
            return null;
        }
    }

    /**
     * Matches student against any raw Job Description text or fetched URL without persisting.
     */
    public DreamJobMatchDTO matchAgainstCustomJd(int studentId, String companyName, String roleTitle, String rawJdText, String sourceType, String sourceUrl) {
        return matchAgainstCustomJd(studentId, companyName, roleTitle, rawJdText, sourceType, sourceUrl, false);
    }

    /**
     * Matches student against any raw Job Description text or fetched URL with optional database persistence.
     */
    public DreamJobMatchDTO matchAgainstCustomJd(int studentId, String companyName, String roleTitle, String rawJdText, String sourceType, String sourceUrl, boolean persistRecord) {
        DreamJobMatchDTO match = new DreamJobMatchDTO();
        match.setTargetCompany(companyName != null && !companyName.trim().isEmpty() ? companyName.trim() : "Target Company");
        match.setTargetRole(roleTitle != null && !roleTitle.trim().isEmpty() ? roleTitle.trim() : "Software Engineer");
        match.setSourceType(sourceType != null ? sourceType : "CUSTOM_PASTE");
        match.setSourceUrl(sourceUrl);
        match.setRawJdText(rawJdText);
        match.setEvaluatedAt(LocalDateTime.now());

        try {
            Student student = studentDAO.findById(studentId);
            if (student == null) {
                return match;
            }

            List<StudentSkill> studentSkills = skillDAO.findByStudentId(studentId);
            List<Project> studentProjects = projectDAO.findByStudentId(studentId);
            List<Certification> studentCerts = certificationDAO.findByStudentId(studentId);
            int dsaProblemsSolved = dsaProgressDAO.getTotalProblemsSolved(studentId);
            List<StudentDsaProgress> dsaProgressList = dsaProgressDAO.getStudentDsaProgress(studentId);
            StudentCodingProfile codingProfile = codingProfileDAO.findByStudentId(studentId);

            // 1. Extract dynamic requirements from raw JD text
            ParsedJdRequirements reqs = parseJdText(companyName, roleTitle, rawJdText);
            match.setRequiredSkills(new ArrayList<>(reqs.requiredSkills));

            // 2. Evaluate Pillar 1: DSA Mastery (0-100)
            int effectiveDsaSolved = dsaProblemsSolved;
            int leetcodeMedHard = 0;
            if (codingProfile != null) {
                if (codingProfile.getLeetcodeTotalSolved() > effectiveDsaSolved) {
                    effectiveDsaSolved = codingProfile.getLeetcodeTotalSolved();
                }
                leetcodeMedHard = codingProfile.getLeetcodeMediumSolved() + codingProfile.getLeetcodeHardSolved();
            }

            int dsaScore;
            if (reqs.targetDsaCount <= 0) {
                dsaScore = 100;
            } else {
                double baseDsaRatio = (double) effectiveDsaSolved / reqs.targetDsaCount;
                if (reqs.isTier1HeavyDsa && codingProfile != null && codingProfile.getLeetcodeTotalSolved() > 0) {
                    // Extra reward for LeetCode Medium/Hard depth
                    double depthBonus = Math.min(20.0, (leetcodeMedHard / 40.0) * 20.0);
                    dsaScore = (int) Math.min(100, Math.round((baseDsaRatio * 80.0) + depthBonus));
                } else {
                    dsaScore = (int) Math.min(100, Math.round(baseDsaRatio * 100.0));
                }
            }
            match.setDsaScore(dsaScore);
            match.setDsaBenchmarkDescription("Benchmark: " + reqs.targetDsaCount + "+ problems (" + reqs.dsaFocusLabel + ")");
            match.setStudentDsaSummary("Solved " + effectiveDsaSolved + " problems" + (codingProfile != null && codingProfile.isLeetCodeSynced() ? " (LeetCode: " + codingProfile.getLeetcodeTotalSolved() + ", Med/Hard: " + leetcodeMedHard + ")" : ""));

            // 3. Evaluate Pillar 2: System Projects (0-100)
            int projectCount = studentProjects.size();
            int matchedProjectKeywords = 0;
            for (Project p : studentProjects) {
                String stack = (p.getTechStack() + " " + p.getDescription()).toLowerCase(Locale.ROOT);
                for (String reqSkill : reqs.requiredSkills) {
                    if (stack.contains(reqSkill.toLowerCase(Locale.ROOT))) {
                        matchedProjectKeywords++;
                    }
                }
            }

            int projectScore;
            if (reqs.targetProjectCount <= 0) {
                projectScore = 100;
            } else {
                double countScore = Math.min(60.0, ((double) projectCount / reqs.targetProjectCount) * 60.0);
                double relevanceScore = Math.min(40.0, (matchedProjectKeywords / (double) Math.max(1, reqs.requiredSkills.size())) * 40.0);
                projectScore = (int) Math.min(100, Math.round(countScore + relevanceScore));
            }
            match.setProjectScore(projectScore);
            match.setProjectBenchmarkDescription("Benchmark: " + reqs.targetProjectCount + "+ Projects aligning with " + reqs.projectFocusLabel);
            match.setStudentProjectSummary(projectCount + " Portfolio Projects" + (codingProfile != null && codingProfile.isGitHubSynced() ? " (" + codingProfile.getGithubReposCount() + " GitHub Repos)" : ""));

            // 4. Evaluate Pillar 3: Verified Industry Certifications (0-100)
            int certCount = studentCerts.size();
            int certScore;
            if (reqs.targetCertCount <= 0) {
                certScore = 100;
            } else {
                certScore = (int) Math.min(100, Math.round(((double) certCount / reqs.targetCertCount) * 100.0));
            }
            match.setCertScore(certScore);
            match.setCertBenchmarkDescription("Benchmark: " + reqs.targetCertCount + "+ Verified Credentials (" + reqs.certFocusLabel + ")");
            match.setStudentCertSummary(certCount + " Verified Certifications");

            // 5. Evaluate Pillar 4: Technical Skills & Proficiencies (0-100)
            Map<String, StudentSkill> studentSkillMap = new HashMap<>();
            for (StudentSkill ss : studentSkills) {
                if (ss.getSkillName() != null) {
                    studentSkillMap.put(ss.getSkillName().toLowerCase(Locale.ROOT).trim(), ss);
                }
            }

            List<String> matchedSkills = new ArrayList<>();
            List<String> missingSkills = new ArrayList<>();
            double totalSkillWeight = 0;
            double earnedSkillWeight = 0;

            for (String reqSkill : reqs.requiredSkills) {
                String key = reqSkill.toLowerCase(Locale.ROOT).trim();
                StudentSkill possessed = studentSkillMap.get(key);
                totalSkillWeight += 1.0;

                if (possessed != null) {
                    matchedSkills.add(reqSkill);
                    switch (possessed.getProficiencyLevel()) {
                        case ADVANCED:
                            earnedSkillWeight += 1.0;
                            break;
                        case INTERMEDIATE:
                            earnedSkillWeight += 0.8;
                            break;
                        default:
                            earnedSkillWeight += 0.5;
                            break;
                    }
                } else {
                    // Check if demonstrated in project tech stack
                    boolean inProject = false;
                    for (Project p : studentProjects) {
                        if ((p.getTechStack() + " " + p.getDescription()).toLowerCase(Locale.ROOT).contains(key)) {
                            inProject = true;
                            break;
                        }
                    }
                    if (inProject) {
                        matchedSkills.add(reqSkill + " (Demonstrated in Project)");
                        earnedSkillWeight += 0.7;
                    } else {
                        missingSkills.add(reqSkill);
                    }
                }
            }

            int skillScore = totalSkillWeight > 0 ? (int) Math.min(100, Math.round((earnedSkillWeight / totalSkillWeight) * 100.0)) : 100;
            match.setSkillScore(skillScore);
            match.setMatchedSkills(matchedSkills);
            match.setMissingSkills(missingSkills);

            // 6. Evaluate Pillar 5: Academic Benchmarks (0-100)
            int academicScore;
            if (student.getCgpa() >= reqs.minCgpaCutoff) {
                academicScore = 100;
            } else if (student.getCgpa() >= (reqs.minCgpaCutoff - 0.5)) {
                academicScore = 75;
            } else {
                academicScore = 40;
            }
            match.setAcademicScore(academicScore);
            match.setAcademicBenchmarkDescription(String.format(Locale.ROOT, "Benchmark: CGPA >= %.2f (%s)", reqs.minCgpaCutoff, reqs.allowedDepts));
            match.setStudentAcademicSummary(String.format(Locale.ROOT, "CGPA: %.2f | Dept: %s", student.getCgpa(), student.getDepartment()));

            // 7. Calculate Composite Match Score
            double composite;
            if (reqs.isTier1HeavyDsa) {
                // Tier-1: 35% DSA, 25% Projects, 20% Skills, 10% Certs, 10% Academics
                composite = (dsaScore * 0.35) + (projectScore * 0.25) + (skillScore * 0.20) + (certScore * 0.10) + (academicScore * 0.10);
            } else if (reqs.isStartupProduct) {
                // Startup: 25% DSA, 35% Projects, 25% Skills, 10% Certs, 5% Academics
                composite = (dsaScore * 0.25) + (projectScore * 0.35) + (skillScore * 0.25) + (certScore * 0.10) + (academicScore * 0.05);
            } else {
                // Enterprise / Services: 20% DSA, 20% Projects, 25% Skills, 15% Certs, 20% Academics
                composite = (dsaScore * 0.20) + (projectScore * 0.20) + (skillScore * 0.25) + (certScore * 0.15) + (academicScore * 0.20);
            }

            int overallScore = (int) Math.max(0, Math.min(100, Math.round(composite)));
            match.setOverallScore(overallScore);

            // Set dynamic status badge & message
            if (overallScore >= 80) {
                match.setStatusBadge("READY");
                match.setStatusTitle("High Match Candidate");
                match.setStatusDescription("You strongly align with " + match.getTargetCompany() + "'s core expectations! You are well-positioned to clear candidate screening.");
            } else if (overallScore >= 55) {
                match.setStatusBadge("NEAR_READY");
                match.setStatusTitle("Competitive Candidate");
                match.setStatusDescription("You are close to the target benchmark. Completing the recommended action items below will bridge your remaining gaps.");
            } else {
                match.setStatusBadge("NEEDS_PREPARATION");
                match.setStatusTitle("Preparation Required");
                match.setStatusDescription("Dedicated skill acquisition and algorithmic problem practice is required to reach " + match.getTargetCompany() + "'s benchmark threshold.");
            }

            // 8. Generate Tailored Dynamic Gap Roadmap
            List<JobGapRoadmapItemDTO> roadmap = generateActionRoadmap(reqs, match, effectiveDsaSolved, projectCount, certCount, studentSkills, missingSkills);
            match.setRoadmapItems(roadmap);

            // 9. Persist evaluation history record into DB if requested
            if (persistRecord) {
                CustomJdEvaluation evalRecord = new CustomJdEvaluation();
                evalRecord.setStudentId(studentId);
                evalRecord.setTargetCompany(match.getTargetCompany());
                evalRecord.setTargetRole(match.getTargetRole());
                evalRecord.setSourceType(match.getSourceType());
                evalRecord.setSourceUrl(match.getSourceUrl());
                evalRecord.setRawJdText(rawJdText != null && rawJdText.length() > 5000 ? rawJdText.substring(0, 5000) : rawJdText);
                evalRecord.setOverallMatchScore(overallScore);
                evalRecord.setDsaScore(dsaScore);
                evalRecord.setProjectScore(projectScore);
                evalRecord.setCertScore(certScore);
                evalRecord.setSkillScore(skillScore);
                evalRecord.setAcademicScore(academicScore);
                evalRecord.setMatchedSkillsJson(buildJsonList(matchedSkills));
                evalRecord.setMissingSkillsJson(buildJsonList(missingSkills));
                evalRecord.setActionItemsJson(buildRoadmapJson(roadmap));

                try {
                    int evalId = customJdEvaluationDAO.saveEvaluation(evalRecord);
                    match.setEvalId(evalId);
                } catch (SQLException e) {
                    LOGGER.log(Level.WARNING, "Failed to persist evaluation record for student: " + studentId, e);
                }
            }

            return match;

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error matching student against custom JD", e);
            return match;
        }
    }

    /**
     * Fetches raw text content from a web URL (e.g. LinkedIn / Career portal job post).
     */
    public String fetchJdFromUrl(String urlString) {
        if (urlString == null || urlString.trim().isEmpty()) return "";
        try {
            URL url = new URL(urlString.trim());
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setConnectTimeout(8000);
            conn.setReadTimeout(10000);
            conn.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36");
            conn.setRequestProperty("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8");

            int responseCode = conn.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) {
                StringBuilder sb = new StringBuilder();
                try (BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"))) {
                    String line;
                    while ((line = reader.readLine()) != null) {
                        sb.append(line).append("\n");
                    }
                }
                String html = sb.toString();
                // Strip scripts, styles, and tags
                String clean = html.replaceAll("(?is)<script.*?</script>", " ")
                                   .replaceAll("(?is)<style.*?</style>", " ")
                                   .replaceAll("<[^>]+>", " ")
                                   .replaceAll("&nbsp;", " ")
                                   .replaceAll("&amp;", "&")
                                   .replaceAll("\\s+", " ")
                                   .trim();
                return clean;
            }
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Error fetching JD content from URL: " + urlString, e);
        }
        return "";
    }

    /**
     * Helper to parse and extract dynamic requirements from JD text.
     */
    private ParsedJdRequirements parseJdText(String companyName, String roleTitle, String rawJdText) {
        ParsedJdRequirements p = new ParsedJdRequirements();
        String text = (companyName + " " + roleTitle + " " + (rawJdText != null ? rawJdText : "")).toLowerCase(Locale.ROOT);
        String compLower = companyName != null ? companyName.toLowerCase(Locale.ROOT).trim() : "";

        // Check company archetype
        for (String c : TIER1_COMPANIES) {
            if (compLower.contains(c) || text.contains(c)) {
                p.isTier1HeavyDsa = true;
                break;
            }
        }
        for (String c : STARTUP_COMPANIES) {
            if (compLower.contains(c) || text.contains(c)) {
                p.isStartupProduct = true;
                break;
            }
        }

        // Detect Technical Skills
        for (String tech : KNOWN_TECH_KEYWORDS) {
            String techLower = tech.toLowerCase(Locale.ROOT);
            if (text.contains(techLower)) {
                p.requiredSkills.add(tech);
            }
        }

        // Fallback core skills if text was very short
        if (p.requiredSkills.isEmpty()) {
            p.requiredSkills.addAll(Arrays.asList("Java", "SQL", "Data Structures", "Algorithms", "Git", "RESTful APIs"));
        }

        // Determine DSA target problems and focus
        if (p.isTier1HeavyDsa || text.contains("leetcode") || text.contains("dynamic programming") || text.contains("system design")) {
            p.targetDsaCount = 150;
            p.dsaFocusLabel = "Dynamic Programming, Trees, Graphs, System Design";
        } else if (p.isStartupProduct || text.contains("react") || text.contains("spring boot") || text.contains("node.js")) {
            p.targetDsaCount = 80;
            p.dsaFocusLabel = "Arrays, HashMaps, Two Pointers, Trees";
        } else {
            p.targetDsaCount = 45;
            p.dsaFocusLabel = "Core Problem Solving & Fundamental Data Structures";
        }

        // Determine Project count & focus
        if (p.isStartupProduct) {
            p.targetProjectCount = 3;
            p.projectFocusLabel = "Full-Stack Microservices & Shipped Production Apps";
        } else if (p.isTier1HeavyDsa) {
            p.targetProjectCount = 3;
            p.projectFocusLabel = "Distributed Systems, Low-Level Architecture or Cloud Workflows";
        } else {
            p.targetProjectCount = 2;
            p.projectFocusLabel = "Full-Stack Web Applications & Database Driven Apps";
        }

        // Determine Certifications count & focus
        p.targetCertCount = 1;
        if (text.contains("aws") || text.contains("cloud") || text.contains("azure") || text.contains("gcp")) {
            p.certFocusLabel = "AWS Certified Developer / Cloud Practitioner / Azure";
            p.targetCertCount = 2;
        } else {
            p.certFocusLabel = "Industry Verified Java / Web / Problem Solving Certification";
        }

        // Minimum CGPA
        if (text.contains("cgpa") || text.contains("gpa")) {
            Matcher m = Pattern.compile("(\\d(?:\\.\\d{1,2})?)\\s*(?:cgpa|gpa)").matcher(text);
            if (m.find()) {
                try {
                    p.minCgpaCutoff = Double.parseDouble(m.group(1));
                } catch (Exception ignored) {}
            }
        }
        if (p.minCgpaCutoff <= 0.0) {
            p.minCgpaCutoff = p.isTier1HeavyDsa ? 7.50 : 6.50;
        }

        return p;
    }

    /**
     * Generates a concrete, personalized step-by-step action roadmap.
     */
    private List<JobGapRoadmapItemDTO> generateActionRoadmap(
            ParsedJdRequirements reqs, DreamJobMatchDTO match, int effectiveDsaSolved, int projectCount,
            int certCount, List<StudentSkill> studentSkills, List<String> missingSkills) {

        List<JobGapRoadmapItemDTO> roadmap = new ArrayList<>();

        // 1. DSA Action Items
        if (effectiveDsaSolved < reqs.targetDsaCount) {
            int gap = reqs.targetDsaCount - effectiveDsaSolved;
            roadmap.add(new JobGapRoadmapItemDTO(
                "DSA",
                "Solve " + gap + " more algorithmic problems in " + reqs.dsaFocusLabel,
                "Advance your problem count on LeetCode / DSA Tracker from " + effectiveDsaSolved + " to " + reqs.targetDsaCount + " to reach 100% DSA readiness for " + match.getTargetCompany() + ".",
                15,
                "LEETCODE",
                "/app/student/dsa",
                "HIGH"
            ));
        }

        // 2. Missing Technical Skills
        if (!missingSkills.isEmpty()) {
            int limit = Math.min(3, missingSkills.size());
            for (int i = 0; i < limit; i++) {
                String missingSkill = missingSkills.get(i);
                roadmap.add(new JobGapRoadmapItemDTO(
                    "SKILL",
                    "Master and add '" + missingSkill + "' to your profile",
                    match.getTargetCompany() + " actively requires " + missingSkill + ". Practice hands-on tutorials, build a proof of concept, and record intermediate proficiency.",
                    10,
                    "SKILL_PRACTICE",
                    "/app/student/skills",
                    "HIGH"
                ));
            }
        }

        // 3. Project Portfolio Action Items
        if (projectCount < reqs.targetProjectCount) {
            int projGap = reqs.targetProjectCount - projectCount;
            roadmap.add(new JobGapRoadmapItemDTO(
                "PROJECT",
                "Build " + projGap + " new project focusing on " + reqs.projectFocusLabel,
                "Create a comprehensive portfolio project incorporating " + (missingSkills.isEmpty() ? "cloud deployment & clean architecture" : missingSkills.get(0)) + " with a live demo and public GitHub repository.",
                15,
                "PROJECT_BUILD",
                "/app/student/projects",
                "HIGH"
            ));
        }

        // 4. Certification Action Items
        if (certCount < reqs.targetCertCount) {
            roadmap.add(new JobGapRoadmapItemDTO(
                "CERTIFICATION",
                "Acquire verified credential in " + reqs.certFocusLabel,
                "Add an industry-verified certificate (e.g. AWS, Coursera, HackerRank, freeCodeCamp) to validate your professional domain competence.",
                10,
                "GET_CERTIFIED",
                "/app/student/certifications",
                "MEDIUM"
            ));
        }

        // 5. If fully ready, celebrate and recommend interview prep
        if (roadmap.isEmpty()) {
            roadmap.add(new JobGapRoadmapItemDTO(
                "DSA",
                "Conduct mock behavioral and system architecture interviews",
                "Your technical fundamentals and problem count meet all criteria! Focus on high-pressure mock rounds and communication clarity.",
                5,
                "LEETCODE",
                "/app/student/dsa",
                "LOW"
            ));
        }

        return roadmap;
    }

    private String buildJsonList(List<String> list) {
        if (list == null || list.isEmpty()) return "[]";
        StringBuilder sb = new StringBuilder("[");
        for (int i = 0; i < list.size(); i++) {
            sb.append("\"").append(list.get(i).replace("\"", "\\\"")).append("\"");
            if (i < list.size() - 1) sb.append(",");
        }
        sb.append("]");
        return sb.toString();
    }

    private String buildRoadmapJson(List<JobGapRoadmapItemDTO> items) {
        if (items == null || items.isEmpty()) return "[]";
        StringBuilder sb = new StringBuilder("[");
        for (int i = 0; i < items.size(); i++) {
            JobGapRoadmapItemDTO item = items.get(i);
            sb.append("{");
            sb.append("\"category\":\"").append(item.getCategory()).append("\",");
            sb.append("\"title\":\"").append(item.getTitle() != null ? item.getTitle().replace("\"", "\\\"") : "").append("\",");
            sb.append("\"description\":\"").append(item.getDescription() != null ? item.getDescription().replace("\"", "\\\"") : "").append("\",");
            sb.append("\"impactWeight\":").append(item.getImpactWeight()).append(",");
            sb.append("\"actionType\":\"").append(item.getActionType()).append("\",");
            sb.append("\"actionLink\":\"").append(item.getActionLink()).append("\",");
            sb.append("\"priority\":\"").append(item.getPriority()).append("\"");
            sb.append("}");
            if (i < items.size() - 1) sb.append(",");
        }
        sb.append("]");
        return sb.toString();
    }

    public static class ParsedJdRequirements {
        public boolean isTier1HeavyDsa = false;
        public boolean isStartupProduct = false;
        public Set<String> requiredSkills = new LinkedHashSet<>();
        public int targetDsaCount = 80;
        public String dsaFocusLabel = "Core Problem Solving";
        public int targetProjectCount = 2;
        public String projectFocusLabel = "Web Architecture";
        public int targetCertCount = 1;
        public String certFocusLabel = "Industry Credential";
        public double minCgpaCutoff = 6.50;
        public String allowedDepts = "All Branches";

        public ParsedJdRequirements() {
        }
    }
}
