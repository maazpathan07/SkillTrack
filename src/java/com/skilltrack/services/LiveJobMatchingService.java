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
import com.skilltrack.models.Certification;
import com.skilltrack.models.CriteriaSkillRequirement;
import com.skilltrack.models.CustomJdEvaluation;
import com.skilltrack.models.PlacementCriteria;
import com.skilltrack.models.Project;
import com.skilltrack.models.Student;
import com.skilltrack.models.StudentCodingProfile;
import com.skilltrack.models.StudentDsaProgress;
import com.skilltrack.models.StudentSkill;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
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

    // Canonical skill aliases map to prevent duplicates (e.g. React vs React.js)
    private static final Map<String, List<String>> CANONICAL_SKILL_ALIASES = new LinkedHashMap<>();

    static {
        // Programming Languages
        registerSkillAlias("Java", "java", "core java", "advanced java");
        registerSkillAlias("Python", "python", "python3", "py");
        registerSkillAlias("JavaScript", "javascript", "js", "ecmascript", "es6");
        registerSkillAlias("TypeScript", "typescript", "ts");
        registerSkillAlias("C++", "c++", "cpp");
        registerSkillAlias("C#", "c#", "csharp", ".net c#");
        registerSkillAlias("Go", "go", "golang");
        registerSkillAlias("Rust", "rust");
        registerSkillAlias("Kotlin", "kotlin");
        registerSkillAlias("Swift", "swift");
        registerSkillAlias("PHP", "php");
        registerSkillAlias("Ruby", "ruby", "ruby on rails");

        // Frontend & UI
        registerSkillAlias("React.js", "react", "react.js", "reactjs");
        registerSkillAlias("Next.js", "next.js", "nextjs", "next");
        registerSkillAlias("Vue.js", "vue", "vue.js", "vuejs");
        registerSkillAlias("Angular", "angular", "angularjs", "angular 2+");
        registerSkillAlias("HTML5", "html", "html5");
        registerSkillAlias("CSS3", "css", "css3");
        registerSkillAlias("Tailwind CSS", "tailwind", "tailwind css", "tailwindcss");
        registerSkillAlias("Bootstrap", "bootstrap", "bootstrap 5");
        registerSkillAlias("Redux", "redux", "redux toolkit");

        // Backend & Frameworks
        registerSkillAlias("Spring Boot", "spring boot", "springboot", "spring framework", "spring mvc");
        registerSkillAlias("Node.js", "node", "node.js", "nodejs");
        registerSkillAlias("Express.js", "express", "express.js", "expressjs");
        registerSkillAlias("Django", "django");
        registerSkillAlias("FastAPI", "fastapi");
        registerSkillAlias("Flask", "flask");
        registerSkillAlias("ASP.NET", "asp.net", "asp.net core", ".net core");
        registerSkillAlias("RESTful APIs", "restful apis", "rest api", "rest apis", "restful api", "rest");
        registerSkillAlias("GraphQL", "graphql");
        registerSkillAlias("Microservices", "microservices", "microservice architecture");

        // Databases & Storage
        registerSkillAlias("MySQL", "mysql");
        registerSkillAlias("PostgreSQL", "postgresql", "postgres");
        registerSkillAlias("MongoDB", "mongodb", "mongo");
        registerSkillAlias("Redis", "redis", "redis cache");
        registerSkillAlias("Oracle", "oracle db", "oracle sql");
        registerSkillAlias("SQL", "sql", "rdbms", "relational database");
        registerSkillAlias("DBMS", "dbms", "database management");

        // Cloud & DevOps
        registerSkillAlias("AWS", "aws", "amazon web services", "ec2", "s3", "lambda");
        registerSkillAlias("GCP", "gcp", "google cloud", "google cloud platform");
        registerSkillAlias("Microsoft Azure", "azure", "microsoft azure");
        registerSkillAlias("Docker", "docker", "containerization", "containers");
        registerSkillAlias("Kubernetes", "kubernetes", "k8s");
        registerSkillAlias("CI/CD", "ci/cd", "continuous integration", "jenkins", "github actions");
        registerSkillAlias("Linux", "linux", "ubuntu", "bash", "shell scripting");
        registerSkillAlias("Git / GitHub", "git", "github", "version control", "gitlab");

        // Core CS & Problem Solving
        registerSkillAlias("DSA", "dsa", "data structures", "algorithms", "data structures and algorithms", "problem solving");
        registerSkillAlias("System Design", "system design", "distributed systems", "system architecture", "low-level design", "high-level design");
        registerSkillAlias("OOP", "oop", "oops", "object oriented programming");
        registerSkillAlias("Operating Systems", "operating systems", "os concepts");
        registerSkillAlias("Computer Networks", "computer networks", "networking", "tcp/ip");

        // AI / ML & Data Science
        registerSkillAlias("Machine Learning", "machine learning", "ml", "supervised learning", "unsupervised learning");
        registerSkillAlias("Artificial Intelligence", "artificial intelligence", "ai", "genai", "generative ai");
        registerSkillAlias("Deep Learning", "deep learning", "neural networks", "cnn", "rnn", "transformer");
        registerSkillAlias("TensorFlow", "tensorflow", "tf");
        registerSkillAlias("PyTorch", "pytorch", "torch");
        registerSkillAlias("Pandas", "pandas");
        registerSkillAlias("NumPy", "numpy");
        registerSkillAlias("Data Analysis", "data analysis", "data science", "data visualization");
        registerSkillAlias("NLP", "nlp", "natural language processing", "llm", "large language models");
        registerSkillAlias("Computer Vision", "computer vision", "opencv", "cv");

        // Mobile
        registerSkillAlias("Flutter", "flutter", "dart");
        registerSkillAlias("React Native", "react native", "react-native");
        registerSkillAlias("Android Development", "android", "android sdk");
        registerSkillAlias("iOS Development", "ios", "ios development");

        // Security
        registerSkillAlias("Cybersecurity", "cybersecurity", "information security", "infosec", "network security", "ethical hacking");
    }

    private static void registerSkillAlias(String canonicalName, String... aliases) {
        List<String> list = new ArrayList<>();
        list.add(canonicalName.toLowerCase(Locale.ROOT));
        for (String alias : aliases) {
            list.add(alias.toLowerCase(Locale.ROOT));
        }
        CANONICAL_SKILL_ALIASES.put(canonicalName, list);
    }

    // Top tier tech companies for deep problem solving benchmark calibration
    private static final Set<String> BIG_TECH_COMPANIES = new HashSet<>(Arrays.asList(
        "google", "amazon", "microsoft", "meta", "facebook", "apple", "netflix", "uber", "adobe", "atlassian",
        "salesforce", "oracle", "nvidia", "goldman sachs", "morgan stanley", "deshaw", "flipkart", "stripe"
    ));

    private static final Set<String> SERVICES_ENTERPRISE_COMPANIES = new HashSet<>(Arrays.asList(
        "tcs", "infosys", "wipro", "accenture", "cognizant", "deloitte", "capgemini", "hcl", "tech mahindra", "l&t"
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
     * Matches student directly against an active Database Placement Criteria preset.
     */
    public DreamJobMatchDTO matchAgainstCriteria(int studentId, int criteriaId) {
        try {
            PlacementCriteria criteria = placementCriteriaDAO.findById(criteriaId);
            if (criteria == null) {
                return null;
            }

            ParsedJdRequirements reqs = new ParsedJdRequirements();
            reqs.targetDsaCount = Math.max(20, criteria.getMinDsaProblems());
            reqs.targetProjectCount = Math.max(1, criteria.getMinProjects());
            reqs.targetCertCount = Math.max(1, criteria.getMinCertifications());
            reqs.minCgpaCutoff = criteria.getMinCgpa() > 0 ? criteria.getMinCgpa() : 6.0;
            reqs.allowedDepts = criteria.getAllowedDepartments() != null ? criteria.getAllowedDepartments() : "All Departments";

            String compLower = criteria.getCompanyName() != null ? criteria.getCompanyName().toLowerCase(Locale.ROOT) : "";
            String roleLower = criteria.getRoleTitle() != null ? criteria.getRoleTitle().toLowerCase(Locale.ROOT) : "";

            // Check archetype
            for (String bg : BIG_TECH_COMPANIES) {
                if (compLower.contains(bg)) {
                    reqs.isTier1HeavyDsa = true;
                    break;
                }
            }

            if (reqs.targetDsaCount >= 100 || reqs.isTier1HeavyDsa) {
                reqs.dsaFocusLabel = "Dynamic Programming, Trees, Graphs, System Scalability";
                reqs.projectFocusLabel = "Distributed Systems, Clean Architecture & Cloud Services";
                reqs.certFocusLabel = "AWS Developer / Problem Solving / Cloud Certification";
            } else if (reqs.targetDsaCount >= 60) {
                reqs.dsaFocusLabel = "Arrays, Strings, HashMaps, Two Pointers, Trees";
                reqs.projectFocusLabel = "Full-Stack Web Applications & Microservices";
                reqs.certFocusLabel = "Industry Verified Web / Database / Cloud Credential";
            } else {
                reqs.dsaFocusLabel = "Core Problem Solving & Fundamental Data Structures";
                reqs.projectFocusLabel = "Portfolio Web / Database Projects with Live Demo";
                reqs.certFocusLabel = "Industry Technical Certification (Coursera / HackerRank / AWS)";
            }

            // Populate skills directly from criteria_skills in database
            if (criteria.getSkillRequirements() != null && !criteria.getSkillRequirements().isEmpty()) {
                for (CriteriaSkillRequirement r : criteria.getSkillRequirements()) {
                    String canonical = findCanonicalSkillName(r.getSkillName());
                    reqs.requiredSkills.add(canonical != null ? canonical : r.getSkillName().trim());
                }
            } else {
                // If no specific skills attached, parse from role
                reqs.requiredSkills.addAll(extractDefaultSkillsForRole(roleLower));
            }

            StringBuilder jdSummary = new StringBuilder();
            jdSummary.append("Placement Drive: ").append(criteria.getCompanyName()).append(" - ").append(criteria.getRoleTitle()).append("\n");
            jdSummary.append("Minimum Eligibility: CGPA >= ").append(criteria.getMinCgpa()).append(", Allowed Branches: ").append(criteria.getAllowedDepartments()).append("\n");
            jdSummary.append("Technical Cutoffs: DSA Problems >= ").append(criteria.getMinDsaProblems()).append(", Projects >= ").append(criteria.getMinProjects()).append(", Certifications >= ").append(criteria.getMinCertifications()).append("\n");
            jdSummary.append("Key Required Skills: ").append(String.join(", ", reqs.requiredSkills));

            DreamJobMatchDTO match = evaluateProfileAgainstRequirements(
                studentId,
                criteria.getCompanyName(),
                criteria.getRoleTitle(),
                jdSummary.toString(),
                "PRESET_CRITERIA",
                null,
                reqs,
                false
            );

            match.setCriteriaId(criteriaId);
            return match;

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error matching student against placement criteria: " + criteriaId, e);
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
        ParsedJdRequirements reqs = parseJdText(companyName, roleTitle, rawJdText);
        return evaluateProfileAgainstRequirements(studentId, companyName, roleTitle, rawJdText, sourceType, sourceUrl, reqs, persistRecord);
    }

    /**
     * Comprehensive multi-pillar evaluation engine.
     */
    private DreamJobMatchDTO evaluateProfileAgainstRequirements(
            int studentId, String companyName, String roleTitle, String rawJdText,
            String sourceType, String sourceUrl, ParsedJdRequirements reqs, boolean persistRecord) {

        DreamJobMatchDTO match = new DreamJobMatchDTO();
        match.setTargetCompany(companyName != null && !companyName.trim().isEmpty() ? companyName.trim() : "Target Company");
        match.setTargetRole(roleTitle != null && !roleTitle.trim().isEmpty() ? roleTitle.trim() : "Software Engineer");
        match.setSourceType(sourceType != null ? sourceType : "CUSTOM_PASTE");
        match.setSourceUrl(sourceUrl);
        match.setRawJdText(rawJdText);
        match.setEvaluatedAt(LocalDateTime.now());
        match.setRequiredSkills(new ArrayList<>(reqs.requiredSkills));

        try {
            Student student = studentDAO.findById(studentId);
            if (student == null) {
                return match;
            }

            List<StudentSkill> studentSkills = skillDAO.findByStudentId(studentId);
            List<Project> studentProjects = projectDAO.findByStudentId(studentId);
            List<Certification> studentCerts = certificationDAO.findByStudentId(studentId);
            int dsaProblemsSolved = dsaProgressDAO.getTotalProblemsSolved(studentId);
            StudentCodingProfile codingProfile = codingProfileDAO.findByStudentId(studentId);

            // 1. Evaluate Pillar 1: DSA Mastery (0-100)
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
                double baseRatio = (double) effectiveDsaSolved / reqs.targetDsaCount;
                if (reqs.isTier1HeavyDsa && codingProfile != null && codingProfile.getLeetcodeTotalSolved() > 0) {
                    double depthBonus = Math.min(20.0, (leetcodeMedHard / 40.0) * 20.0);
                    dsaScore = (int) Math.min(100, Math.round((baseRatio * 80.0) + depthBonus));
                } else {
                    dsaScore = (int) Math.min(100, Math.round(baseRatio * 100.0));
                }
            }
            match.setDsaScore(dsaScore);
            match.setDsaBenchmarkDescription("Benchmark: " + reqs.targetDsaCount + "+ problems (" + reqs.dsaFocusLabel + ")");
            match.setStudentDsaSummary("Solved " + effectiveDsaSolved + " problems" + (codingProfile != null && codingProfile.isLeetCodeSynced() ? " (LeetCode: " + codingProfile.getLeetcodeTotalSolved() + ", Med/Hard: " + leetcodeMedHard + ")" : ""));

            // 2. Evaluate Pillar 2: System Projects (0-100)
            int projectCount = studentProjects != null ? studentProjects.size() : 0;
            int matchedProjectKeywords = 0;
            if (studentProjects != null) {
                for (Project p : studentProjects) {
                    String stack = ((p.getTechStack() != null ? p.getTechStack() : "") + " " + (p.getDescription() != null ? p.getDescription() : "")).toLowerCase(Locale.ROOT);
                    for (String reqSkill : reqs.requiredSkills) {
                        if (isSkillMentionedInText(reqSkill, stack)) {
                            matchedProjectKeywords++;
                        }
                    }
                }
            }

            int projectScore;
            if (reqs.targetProjectCount <= 0) {
                projectScore = 100;
            } else {
                double countScore = Math.min(65.0, ((double) projectCount / reqs.targetProjectCount) * 65.0);
                double relevanceScore = Math.min(35.0, (matchedProjectKeywords / (double) Math.max(1, reqs.requiredSkills.size())) * 35.0);
                projectScore = (int) Math.min(100, Math.round(countScore + relevanceScore));
            }
            match.setProjectScore(projectScore);
            match.setProjectBenchmarkDescription("Benchmark: " + reqs.targetProjectCount + "+ Projects (" + reqs.projectFocusLabel + ")");
            match.setStudentProjectSummary(projectCount + " Portfolio Projects" + (codingProfile != null && codingProfile.isGitHubSynced() ? " (" + codingProfile.getGithubReposCount() + " GitHub Repos)" : ""));

            // 3. Evaluate Pillar 3: Verified Industry Certifications (0-100)
            int certCount = studentCerts != null ? studentCerts.size() : 0;
            int certScore;
            if (reqs.targetCertCount <= 0) {
                certScore = 100;
            } else {
                certScore = (int) Math.min(100, Math.round(((double) certCount / reqs.targetCertCount) * 100.0));
            }
            match.setCertScore(certScore);
            match.setCertBenchmarkDescription("Benchmark: " + reqs.targetCertCount + "+ Verified Credentials (" + reqs.certFocusLabel + ")");
            match.setStudentCertSummary(certCount + " Verified Certifications");

            // 4. Evaluate Pillar 4: Technical Skills & Proficiencies with Canonical Mapping (0-100)
            Set<String> matchedSkills = new LinkedHashSet<>();
            Set<String> missingSkills = new LinkedHashSet<>();
            double totalSkillWeight = 0;
            double earnedSkillWeight = 0;

            for (String reqSkill : reqs.requiredSkills) {
                totalSkillWeight += 1.0;
                StudentSkill possessedSkill = findMatchingStudentSkill(reqSkill, studentSkills);

                if (possessedSkill != null) {
                    matchedSkills.add(reqSkill);
                    switch (possessedSkill.getProficiencyLevel()) {
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
                    // Check if demonstrated in student projects
                    boolean inProject = false;
                    if (studentProjects != null) {
                        for (Project p : studentProjects) {
                            String stack = ((p.getTechStack() != null ? p.getTechStack() : "") + " " + (p.getDescription() != null ? p.getDescription() : "")).toLowerCase(Locale.ROOT);
                            if (isSkillMentionedInText(reqSkill, stack)) {
                                inProject = true;
                                break;
                            }
                        }
                    }

                    if (inProject) {
                        matchedSkills.add(reqSkill + " (Project Proof)");
                        earnedSkillWeight += 0.75;
                    } else {
                        missingSkills.add(reqSkill);
                    }
                }
            }

            int skillScore = totalSkillWeight > 0 ? (int) Math.min(100, Math.round((earnedSkillWeight / totalSkillWeight) * 100.0)) : 100;
            match.setSkillScore(skillScore);
            match.setMatchedSkills(new ArrayList<>(matchedSkills));
            match.setMissingSkills(new ArrayList<>(missingSkills));

            // 5. Evaluate Pillar 5: Academic Benchmarks (0-100)
            int academicScore;
            double cgpa = student.getCgpa();
            if (cgpa >= reqs.minCgpaCutoff) {
                academicScore = 100;
            } else if (cgpa >= (reqs.minCgpaCutoff - 0.50)) {
                academicScore = 75;
            } else if (cgpa >= (reqs.minCgpaCutoff - 1.0)) {
                academicScore = 50;
            } else {
                academicScore = 25;
            }
            match.setAcademicScore(academicScore);
            match.setAcademicBenchmarkDescription(String.format(Locale.ROOT, "Benchmark: CGPA >= %.2f (%s)", reqs.minCgpaCutoff, reqs.allowedDepts));
            match.setStudentAcademicSummary(String.format(Locale.ROOT, "CGPA: %.2f | Dept: %s", student.getCgpa(), student.getDepartment()));

            // 6. Dynamic Composite Match Score Calculation based on Role / Archetype
            double composite;
            if (reqs.isTier1HeavyDsa) {
                // Tier-1 Big Tech: 35% DSA, 25% Projects, 20% Skills, 10% Certs, 10% Academics
                composite = (dsaScore * 0.35) + (projectScore * 0.25) + (skillScore * 0.20) + (certScore * 0.10) + (academicScore * 0.10);
            } else if (reqs.domainType == DomainType.AI_ML || reqs.domainType == DomainType.DATA_SCIENCE) {
                // AI/ML: 20% DSA, 35% Projects, 30% Skills, 10% Certs, 5% Academics
                composite = (dsaScore * 0.20) + (projectScore * 0.35) + (skillScore * 0.30) + (certScore * 0.10) + (academicScore * 0.05);
            } else if (reqs.domainType == DomainType.FRONTEND || reqs.domainType == DomainType.MOBILE) {
                // Frontend/Mobile: 15% DSA, 40% Projects, 35% Skills, 5% Certs, 5% Academics
                composite = (dsaScore * 0.15) + (projectScore * 0.40) + (skillScore * 0.35) + (certScore * 0.05) + (academicScore * 0.05);
            } else if (reqs.domainType == DomainType.DEVOPS_CLOUD || reqs.domainType == DomainType.CYBERSECURITY) {
                // Cloud/DevOps: 15% DSA, 30% Projects, 30% Skills, 20% Certs, 5% Academics
                composite = (dsaScore * 0.15) + (projectScore * 0.30) + (skillScore * 0.30) + (certScore * 0.20) + (academicScore * 0.05);
            } else if (reqs.isStartupProduct) {
                // Startup: 20% DSA, 35% Projects, 30% Skills, 10% Certs, 5% Academics
                composite = (dsaScore * 0.20) + (projectScore * 0.35) + (skillScore * 0.30) + (certScore * 0.10) + (academicScore * 0.05);
            } else {
                // Enterprise / Services: 20% DSA, 20% Projects, 25% Skills, 15% Certs, 20% Academics
                composite = (dsaScore * 0.20) + (projectScore * 0.20) + (skillScore * 0.25) + (certScore * 0.15) + (academicScore * 0.20);
            }

            int overallScore = (int) Math.max(0, Math.min(100, Math.round(composite)));
            match.setOverallScore(overallScore);

            // Set dynamic status badge & description
            if (overallScore >= 80) {
                match.setStatusBadge("READY");
                match.setStatusTitle("High Match Candidate");
                match.setStatusDescription("You strongly align with " + match.getTargetCompany() + "'s core requirements for " + match.getTargetRole() + "! You are well-positioned for shortlisting.");
            } else if (overallScore >= 55) {
                match.setStatusBadge("NEAR_READY");
                match.setStatusTitle("Competitive Candidate");
                match.setStatusDescription("You have a strong base for " + match.getTargetCompany() + ". Completing the personalized gap-bridging milestones below will make you 100% ready.");
            } else {
                match.setStatusBadge("NEEDS_PREPARATION");
                match.setStatusTitle("Preparation Required");
                match.setStatusDescription("Focused skill acquisition and practical portfolio development is recommended to reach " + match.getTargetCompany() + "'s threshold for this role.");
            }

            // 7. Generate Personalized Action Roadmap
            List<JobGapRoadmapItemDTO> roadmap = generateActionRoadmap(reqs, match, effectiveDsaSolved, projectCount, certCount, new ArrayList<>(missingSkills));
            match.setRoadmapItems(roadmap);

            // 8. Persist to Database if requested
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
                evalRecord.setMatchedSkillsJson(buildJsonList(match.getMatchedSkills()));
                evalRecord.setMissingSkillsJson(buildJsonList(match.getMissingSkills()));
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
            LOGGER.log(Level.SEVERE, "Error matching student against JD", e);
            return match;
        }
    }

    /**
     * Parses raw Job Description text or extracts domain requirements from Role & Company.
     */
    public ParsedJdRequirements parseJdText(String companyName, String roleTitle, String rawJdText) {
        ParsedJdRequirements p = new ParsedJdRequirements();
        String combined = ((companyName != null ? companyName : "") + " " +
                           (roleTitle != null ? roleTitle : "") + " " +
                           (rawJdText != null ? rawJdText : "")).toLowerCase(Locale.ROOT);

        String compLower = companyName != null ? companyName.toLowerCase(Locale.ROOT).trim() : "";
        String roleLower = roleTitle != null ? roleTitle.toLowerCase(Locale.ROOT).trim() : "";
        String jdLower = rawJdText != null ? rawJdText.toLowerCase(Locale.ROOT).trim() : "";

        // 1. Detect Company Tier
        for (String bg : BIG_TECH_COMPANIES) {
            if (compLower.contains(bg) || combined.contains(bg)) {
                p.isTier1HeavyDsa = true;
                break;
            }
        }
        for (String sv : SERVICES_ENTERPRISE_COMPANIES) {
            if (compLower.contains(sv)) {
                p.isEnterpriseServices = true;
                break;
            }
        }

        // 2. Detect Domain Type from Role and JD content
        p.domainType = detectDomainType(roleLower, jdLower);

        // 3. Dynamically Extract Skills using Canonical Aliases
        Set<String> detectedSkills = new LinkedHashSet<>();
        for (Map.Entry<String, List<String>> entry : CANONICAL_SKILL_ALIASES.entrySet()) {
            String canonical = entry.getKey();
            for (String alias : entry.getValue()) {
                if (isWordPresentInText(alias, combined)) {
                    detectedSkills.add(canonical);
                    break;
                }
            }
        }

        // If no or very few skills found in text, supply domain-appropriate default skills
        if (detectedSkills.isEmpty() || detectedSkills.size() < 2) {
            detectedSkills.addAll(extractDefaultSkillsForRole(roleLower));
        }

        p.requiredSkills = detectedSkills;

        // 4. Dynamic Target DSA Problems Calibration
        if (p.isTier1HeavyDsa) {
            if (p.domainType == DomainType.FRONTEND || p.domainType == DomainType.MOBILE) {
                p.targetDsaCount = 80;
                p.dsaFocusLabel = "Arrays, HashMaps, Two Pointers, Trees";
            } else if (p.domainType == DomainType.AI_ML || p.domainType == DomainType.DATA_SCIENCE) {
                p.targetDsaCount = 60;
                p.dsaFocusLabel = "Algorithms, Math, Matrix Manipulation & Optimizations";
            } else if (p.domainType == DomainType.DEVOPS_CLOUD || p.domainType == DomainType.CYBERSECURITY) {
                p.targetDsaCount = 40;
                p.dsaFocusLabel = "Scripting, Strings & System Level Problem Solving";
            } else {
                p.targetDsaCount = 140;
                p.dsaFocusLabel = "Dynamic Programming, Trees, Graphs, System Scalability";
            }
        } else if (p.isEnterpriseServices) {
            p.targetDsaCount = 50;
            p.dsaFocusLabel = "Core Problem Solving & Fundamental Data Structures";
        } else {
            // General / Startup / Mid-tier
            switch (p.domainType) {
                case AI_ML:
                case DATA_SCIENCE:
                    p.targetDsaCount = 50;
                    p.dsaFocusLabel = "Algorithms, Math, HashMaps & Data Structures";
                    break;
                case FRONTEND:
                case MOBILE:
                    p.targetDsaCount = 50;
                    p.dsaFocusLabel = "Arrays, Strings, HashMaps & DOM Tree Logic";
                    break;
                case DEVOPS_CLOUD:
                case CYBERSECURITY:
                    p.targetDsaCount = 35;
                    p.dsaFocusLabel = "Scripting, Network Logic & Practical Problem Solving";
                    break;
                case FULLSTACK:
                case BACKEND:
                default:
                    p.targetDsaCount = 75;
                    p.dsaFocusLabel = "Arrays, HashMaps, Two Pointers, Trees, Basic Graphs";
                    break;
            }
        }

        // 5. Dynamic Target Projects & Focus Calibration
        switch (p.domainType) {
            case AI_ML:
            case DATA_SCIENCE:
                p.targetProjectCount = 2;
                p.projectFocusLabel = "Machine Learning Models, FastAPI/Flask Endpoints & Data Pipelines";
                break;
            case FRONTEND:
                p.targetProjectCount = 3;
                p.projectFocusLabel = "Responsive UI Applications, State Management & Live Interactive Demos";
                break;
            case MOBILE:
                p.targetProjectCount = 2;
                p.projectFocusLabel = "Cross-Platform / Native Mobile Apps with Clean UI and API Sync";
                break;
            case DEVOPS_CLOUD:
                p.targetProjectCount = 2;
                p.projectFocusLabel = "Containerized Microservices, CI/CD Pipelines & Cloud Deployment";
                break;
            case CYBERSECURITY:
                p.targetProjectCount = 2;
                p.projectFocusLabel = "Security Auditing Labs, Network Tools & Vulnerability Assessments";
                break;
            case FULLSTACK:
            case BACKEND:
            default:
                p.targetProjectCount = p.isTier1HeavyDsa ? 3 : 2;
                p.projectFocusLabel = "Full-Stack Microservices, Database Schema & Shipped Web Apps";
                break;
        }

        // 6. Dynamic Target Certifications Calibration
        switch (p.domainType) {
            case AI_ML:
            case DATA_SCIENCE:
                p.targetCertCount = 1;
                p.certFocusLabel = "TensorFlow / AWS Machine Learning / DeepLearning.AI Credential";
                break;
            case DEVOPS_CLOUD:
                p.targetCertCount = 2;
                p.certFocusLabel = "AWS Certified Solutions Architect / Azure Administrator / Docker";
                break;
            case CYBERSECURITY:
                p.targetCertCount = 2;
                p.certFocusLabel = "CompTIA Security+ / CEH / AWS Certified Security";
                break;
            case FRONTEND:
                p.targetCertCount = 1;
                p.certFocusLabel = "Meta Frontend Developer / Verified React Credential";
                break;
            default:
                p.targetCertCount = 1;
                p.certFocusLabel = "Industry-Recognized Technical Certification (AWS / Java / Problem Solving)";
                break;
        }

        // 7. Minimum CGPA Cutoff Extraction
        if (combined.contains("cgpa") || combined.contains("gpa")) {
            Matcher m = Pattern.compile("(\\d(?:\\.\\d{1,2})?)\\s*(?:cgpa|gpa)").matcher(combined);
            if (m.find()) {
                try {
                    p.minCgpaCutoff = Double.parseDouble(m.group(1));
                } catch (Exception ignored) {}
            }
        }
        if (p.minCgpaCutoff <= 0.0) {
            p.minCgpaCutoff = p.isTier1HeavyDsa ? 7.00 : 6.00;
        }

        return p;
    }

    /**
     * Checks if a specific word/alias exists in the text as a distinct token or keyword.
     * Uses precise regex word boundaries to prevent false substring matches (e.g. 'mongodb' triggering 'go').
     */
    private static boolean isWordPresentInText(String word, String text) {
        if (word == null || text == null || word.trim().isEmpty()) return false;
        String trimmed = word.trim().toLowerCase(Locale.ROOT);
        try {
            Pattern p = Pattern.compile("(?i)(?<=^|[^a-zA-Z0-9_#+])" + Pattern.quote(trimmed) + "(?=[^a-zA-Z0-9_#+]|$)");
            return p.matcher(text).find();
        } catch (Exception e) {
            return text.toLowerCase(Locale.ROOT).contains(trimmed);
        }
    }

    /**
     * Matches a required skill against a student's possessed skills using canonical alias awareness.
     */
    private StudentSkill findMatchingStudentSkill(String reqSkill, List<StudentSkill> studentSkills) {
        if (studentSkills == null || reqSkill == null) return null;
        String reqCanonical = findCanonicalSkillName(reqSkill);
        if (reqCanonical == null) reqCanonical = reqSkill.trim();

        for (StudentSkill ss : studentSkills) {
            if (ss.getSkillName() == null) continue;
            String studentCanonical = findCanonicalSkillName(ss.getSkillName());
            if (studentCanonical == null) studentCanonical = ss.getSkillName().trim();

            if (reqCanonical.equalsIgnoreCase(studentCanonical)) {
                return ss;
            }
        }
        return null;
    }

    /**
     * Returns canonical name for any skill variant (e.g. "react" -> "React.js", "python3" -> "Python").
     */
    private String findCanonicalSkillName(String name) {
        if (name == null) return null;
        String lower = name.toLowerCase(Locale.ROOT).trim();
        for (Map.Entry<String, List<String>> entry : CANONICAL_SKILL_ALIASES.entrySet()) {
            for (String alias : entry.getValue()) {
                if (alias.equalsIgnoreCase(lower)) {
                    return entry.getKey();
                }
            }
        }
        return name;
    }

    private boolean isSkillMentionedInText(String skillName, String text) {
        if (skillName == null || text == null) return false;
        String canonical = findCanonicalSkillName(skillName);
        List<String> aliases = CANONICAL_SKILL_ALIASES.get(canonical != null ? canonical : skillName);
        if (aliases != null) {
            for (String alias : aliases) {
                if (isWordPresentInText(alias, text)) {
                    return true;
                }
            }
        }
        return text.contains(skillName.toLowerCase(Locale.ROOT));
    }

    private DomainType detectDomainType(String roleLower, String jdLower) {
        String combined = roleLower + " " + jdLower;
        if (combined.contains("machine learning") || combined.contains("ai/ml") || combined.contains("artificial intelligence") || combined.contains("data scientist") || combined.contains("deep learning") || combined.contains("nlp")) {
            return DomainType.AI_ML;
        }
        if (combined.contains("data analyst") || combined.contains("data engineer") || combined.contains("data science")) {
            return DomainType.DATA_SCIENCE;
        }
        if (combined.contains("frontend") || combined.contains("front-end") || combined.contains("ui developer") || combined.contains("react developer") || combined.contains("angular developer")) {
            return DomainType.FRONTEND;
        }
        if (combined.contains("devops") || combined.contains("cloud engineer") || combined.contains("sre") || combined.contains("infrastructure")) {
            return DomainType.DEVOPS_CLOUD;
        }
        if (combined.contains("cybersecurity") || combined.contains("security engineer") || combined.contains("infosec") || combined.contains("ethical hacking")) {
            return DomainType.CYBERSECURITY;
        }
        if (combined.contains("android") || combined.contains("ios") || combined.contains("flutter") || combined.contains("mobile app") || combined.contains("react native")) {
            return DomainType.MOBILE;
        }
        if (combined.contains("backend") || combined.contains("back-end") || combined.contains("java developer") || combined.contains("spring boot developer") || combined.contains("node developer")) {
            return DomainType.BACKEND;
        }
        if (combined.contains("full stack") || combined.contains("fullstack") || combined.contains("web developer")) {
            return DomainType.FULLSTACK;
        }
        return DomainType.GENERAL_SDE;
    }

    private List<String> extractDefaultSkillsForRole(String roleLower) {
        if (roleLower == null) roleLower = "";
        if (roleLower.contains("ai") || roleLower.contains("ml") || roleLower.contains("machine learning") || roleLower.contains("data science")) {
            return Arrays.asList("Python", "Machine Learning", "Pandas", "NumPy", "SQL", "Deep Learning");
        }
        if (roleLower.contains("frontend") || roleLower.contains("ui")) {
            return Arrays.asList("JavaScript", "TypeScript", "React.js", "HTML5", "CSS3", "Tailwind CSS", "RESTful APIs");
        }
        if (roleLower.contains("devops") || roleLower.contains("cloud")) {
            return Arrays.asList("AWS", "Docker", "Kubernetes", "Linux", "CI/CD", "Python");
        }
        if (roleLower.contains("security") || roleLower.contains("cyber")) {
            return Arrays.asList("Cybersecurity", "Computer Networks", "Linux", "Python", "Operating Systems");
        }
        if (roleLower.contains("mobile") || roleLower.contains("android") || roleLower.contains("flutter")) {
            return Arrays.asList("Flutter", "Kotlin", "Java", "RESTful APIs", "Git / GitHub");
        }
        if (roleLower.contains("full stack") || roleLower.contains("fullstack")) {
            return Arrays.asList("JavaScript", "React.js", "Node.js", "SQL", "Git / GitHub", "RESTful APIs");
        }
        return Arrays.asList("Java", "Data Structures", "Algorithms", "SQL", "Git / GitHub", "RESTful APIs");
    }

    /**
     * Generates concrete, personalized step-by-step action roadmap.
     */
    private List<JobGapRoadmapItemDTO> generateActionRoadmap(
            ParsedJdRequirements reqs, DreamJobMatchDTO match, int effectiveDsaSolved, int projectCount,
            int certCount, List<String> missingSkills) {

        List<JobGapRoadmapItemDTO> roadmap = new ArrayList<>();

        // 1. DSA Action Item
        if (effectiveDsaSolved < reqs.targetDsaCount) {
            int gap = reqs.targetDsaCount - effectiveDsaSolved;
            roadmap.add(new JobGapRoadmapItemDTO(
                "DSA",
                "Solve " + gap + " more algorithmic problems in " + reqs.dsaFocusLabel,
                "Advance your solved problem count from " + effectiveDsaSolved + " to " + reqs.targetDsaCount + " to achieve 100% DSA readiness for " + match.getTargetCompany() + " " + match.getTargetRole() + ".",
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
                    match.getTargetCompany() + " " + match.getTargetRole() + " actively requires " + missingSkill + ". Practice hands-on tutorials, build a proof of concept, and verify proficiency.",
                    10,
                    "SKILL_PRACTICE",
                    "/app/student/skills",
                    "HIGH"
                ));
            }
        }

        // 3. Project Portfolio Action Item
        if (projectCount < reqs.targetProjectCount) {
            int projGap = reqs.targetProjectCount - projectCount;
            String suggestedStack = !missingSkills.isEmpty() ? missingSkills.get(0) : "Cloud Deployment";
            roadmap.add(new JobGapRoadmapItemDTO(
                "PROJECT",
                "Build " + projGap + " new project focusing on " + reqs.projectFocusLabel,
                "Create a comprehensive portfolio project incorporating " + suggestedStack + " with a live demo and public GitHub repository.",
                15,
                "PROJECT_BUILD",
                "/app/student/projects",
                "HIGH"
            ));
        }

        // 4. Certification Action Item
        if (certCount < reqs.targetCertCount) {
            roadmap.add(new JobGapRoadmapItemDTO(
                "CERTIFICATION",
                "Acquire verified credential in " + reqs.certFocusLabel,
                "Add an industry-verified certificate to validate your domain competence for " + match.getTargetCompany() + ".",
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
                "Conduct mock behavioral and technical rounds",
                "Your technical fundamentals and problem count meet all criteria for " + match.getTargetCompany() + "! Focus on timed mock interviews and communication clarity.",
                5,
                "LEETCODE",
                "/app/student/dsa",
                "LOW"
            ));
        }

        return roadmap;
    }

    /**
     * Fetches raw text content from a web URL.
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
                return html.replaceAll("(?is)<script.*?</script>", " ")
                           .replaceAll("(?is)<style.*?</style>", " ")
                           .replaceAll("<[^>]+>", " ")
                           .replaceAll("&nbsp;", " ")
                           .replaceAll("&amp;", "&")
                           .replaceAll("\\s+", " ")
                           .trim();
            }
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Error fetching JD content from URL: " + urlString, e);
        }
        return "";
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

    public enum DomainType {
        GENERAL_SDE,
        AI_ML,
        DATA_SCIENCE,
        FRONTEND,
        BACKEND,
        FULLSTACK,
        DEVOPS_CLOUD,
        CYBERSECURITY,
        MOBILE
    }

    public static class ParsedJdRequirements {
        public boolean isTier1HeavyDsa = false;
        public boolean isEnterpriseServices = false;
        public boolean isStartupProduct = false;
        public DomainType domainType = DomainType.GENERAL_SDE;
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
