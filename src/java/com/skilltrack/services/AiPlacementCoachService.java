package com.skilltrack.services;

import com.skilltrack.dao.CertificationDAO;
import com.skilltrack.dao.CodingProfileDAO;
import com.skilltrack.dao.DsaProgressDAO;
import com.skilltrack.dao.PlacementCriteriaDAO;
import com.skilltrack.dao.ProjectDAO;
import com.skilltrack.dao.SkillDAO;
import com.skilltrack.dao.StudentDAO;
import com.skilltrack.dto.AiCoachOverviewDTO;
import com.skilltrack.dto.CoachChatMessageDTO;
import com.skilltrack.dto.CoachStudyPlanItemDTO;
import com.skilltrack.models.Certification;
import com.skilltrack.models.PlacementCriteria;
import com.skilltrack.models.Project;
import com.skilltrack.models.Student;
import com.skilltrack.models.StudentCodingProfile;
import com.skilltrack.models.StudentSkill;
import com.skilltrack.utils.GeminiAiClient;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Locale;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Intelligent Conversational AI Assistant Service for SkillTrack.
 * Integrates directly with Google Gemini 3.8 Flash Generative AI for real-time,
 * unbounded intelligence across technical, non-technical, and placement queries.
 */
public class AiPlacementCoachService {

    private static final Logger LOGGER = Logger.getLogger(AiPlacementCoachService.class.getName());

    private final StudentDAO studentDAO = new StudentDAO();
    private final SkillDAO skillDAO = new SkillDAO();
    private final ProjectDAO projectDAO = new ProjectDAO();
    private final CertificationDAO certificationDAO = new CertificationDAO();
    private final DsaProgressDAO dsaProgressDAO = new DsaProgressDAO();
    private final CodingProfileDAO codingProfileDAO = new CodingProfileDAO();
    private final PlacementCriteriaDAO criteriaDAO = new PlacementCriteriaDAO();

    /**
     * Generates a complete AI Coach overview and contextual study plan for the student.
     */
    public AiCoachOverviewDTO getCoachOverview(int studentId, Integer criteriaId) {
        AiCoachOverviewDTO overview = new AiCoachOverviewDTO();
        overview.setStudentId(studentId);

        try {
            Student student = studentDAO.findById(studentId);
            if (student == null) {
                return overview;
            }

            overview.setStudentName(student.getFullName() != null ? student.getFullName() : "Student");
            overview.setCgpa(student.getCgpa());

            // Target Criteria / Company selection
            PlacementCriteria targetCriteria = null;
            if (criteriaId != null && criteriaId > 0) {
                targetCriteria = criteriaDAO.findById(criteriaId);
            }
            if (targetCriteria == null) {
                List<PlacementCriteria> presets = criteriaDAO.findAll(true);
                if (!presets.isEmpty()) {
                    targetCriteria = presets.get(0);
                }
            }

            String company = targetCriteria != null ? targetCriteria.getCompanyName() : "Top Tier Tech";
            String role = targetCriteria != null ? targetCriteria.getRoleTitle() : (student.getTargetRoleTitle() != null ? student.getTargetRoleTitle() : "Software Development Engineer (SDE)");
            overview.setTargetCompany(company);
            overview.setTargetRole(role);

            // Fetch live student metrics
            List<StudentSkill> skills = skillDAO.findByStudentId(studentId);
            List<Project> projects = projectDAO.findByStudentId(studentId);
            List<Certification> certs = certificationDAO.findByStudentId(studentId);
            int localDsaSolved = dsaProgressDAO.getTotalProblemsSolved(studentId);
            StudentCodingProfile codingProfile = codingProfileDAO.findByStudentId(studentId);

            int effectiveDsa = localDsaSolved;
            if (codingProfile != null && codingProfile.getLeetcodeTotalSolved() > effectiveDsa) {
                effectiveDsa = codingProfile.getLeetcodeTotalSolved();
            }

            overview.setDsaSolved(effectiveDsa);
            overview.setProjectsCount(projects != null ? projects.size() : 0);
            overview.setCertsCount(certs != null ? certs.size() : 0);

            // Targets based on criteria
            int targetDsa = targetCriteria != null && targetCriteria.getMinDsaProblems() > 0 ? targetCriteria.getMinDsaProblems() : 120;
            int targetProjects = targetCriteria != null && targetCriteria.getMinProjects() > 0 ? targetCriteria.getMinProjects() : 3;
            int targetCerts = targetCriteria != null && targetCriteria.getMinCertifications() > 0 ? targetCriteria.getMinCertifications() : 2;
            double targetCgpa = targetCriteria != null && targetCriteria.getMinCgpa() > 0 ? targetCriteria.getMinCgpa() : 7.0;

            overview.setDsaTarget(targetDsa);
            overview.setProjectsTarget(targetProjects);
            overview.setCertsTarget(targetCerts);
            overview.setCgpaTarget(targetCgpa);

            // Calculate overall readiness percentage
            double dsaPct = Math.min(100.0, (effectiveDsa * 100.0) / Math.max(1, targetDsa));
            double projPct = Math.min(100.0, (overview.getProjectsCount() * 100.0) / Math.max(1, targetProjects));
            double certPct = Math.min(100.0, (overview.getCertsCount() * 100.0) / Math.max(1, targetCerts));
            double cgpaPct = Math.min(100.0, (student.getCgpa() * 100.0) / Math.max(1, targetCgpa));

            int overall = (int) Math.round((dsaPct * 0.40) + (projPct * 0.25) + (certPct * 0.15) + (cgpaPct * 0.20));
            overview.setOverallReadinessScore(Math.min(100, Math.max(0, overall)));

            overview.setTopWeaknessTopic("Dynamic Programming & Graph Algorithms");
            overview.setTopWeaknessPercent(Math.max(0, 100 - (int) dsaPct));

            String firstName = student.getFullName() != null ? student.getFullName().split(" ")[0] : "Student";
            overview.setCoachGreeting("Hello " + firstName + "! How can I assist you today?");

            // Suggested prompt chips for chat
            List<String> prompts = Arrays.asList(
                "Explain Object-Oriented Programming (OOPs)",
                "How to reverse a Linked List in Java?",
                "What is Dynamic Programming?",
                "Tips for cracking " + company,
                "Explain ACID properties in DBMS"
            );
            overview.setSuggestedPrompts(prompts);

            // Initial welcome message
            CoachChatMessageDTO welcomeMsg = new CoachChatMessageDTO(
                "AI",
                "👋 **Hi " + firstName + "! I'm your SkillTrack AI Assistant (Powered by Gemini AI).**\n\n" +
                "You can ask me **anything in the world** — whether it's solving coding problems, explaining concepts (OOPs, DBMS, OS, Networks), debugging code, system design, resume tips, or general interview prep!\n\n" +
                "How can I help you right now?"
            );
            welcomeMsg.setQuickFollowups(Arrays.asList(
                "Explain OOPs Concepts with code",
                "How to reverse a Linked List?",
                "What is Dynamic Programming?",
                "How to prepare for " + company + "?"
            ));
            overview.getRecentChatHistory().add(welcomeMsg);

            return overview;

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error building AI Coach overview for student: " + studentId, e);
            return overview;
        }
    }

    /**
     * Processes any student query through Real Google Gemini 3.8 Flash Generative AI.
     */
    public CoachChatMessageDTO processStudentQuery(int studentId, String userQuery, Integer criteriaId) {
        CoachChatMessageDTO response = new CoachChatMessageDTO();
        response.setSender("AI");

        if (userQuery == null || userQuery.trim().isEmpty()) {
            response.setContent("Hello! How can I assist you today? Feel free to ask any coding, interview, or general question.");
            response.setQuickFollowups(Arrays.asList("Explain OOPs Concepts", "Top DSA Patterns", "System Design Basics"));
            return response;
        }

        String rawQuery = userQuery.trim();

        try {
            Student student = studentDAO.findById(studentId);
            String firstName = (student != null && student.getFullName() != null) ? student.getFullName().split(" ")[0] : "Student";
            double cgpa = student != null ? student.getCgpa() : 7.5;

            PlacementCriteria criteria = null;
            if (criteriaId != null && criteriaId > 0) {
                criteria = criteriaDAO.findById(criteriaId);
            }
            if (criteria == null) {
                List<PlacementCriteria> presets = criteriaDAO.findAll(true);
                if (!presets.isEmpty()) criteria = presets.get(0);
            }

            String targetCompany = criteria != null ? criteria.getCompanyName() : "Tech Companies";
            String targetRole = criteria != null ? criteria.getRoleTitle() : "Software Development Engineer";
            int minDsa = criteria != null ? criteria.getMinDsaProblems() : 120;

            int localDsa = dsaProgressDAO.getTotalProblemsSolved(studentId);
            StudentCodingProfile codingProfile = codingProfileDAO.findByStudentId(studentId);
            int effectiveDsa = localDsa;
            if (codingProfile != null && codingProfile.getLeetcodeTotalSolved() > effectiveDsa) {
                effectiveDsa = codingProfile.getLeetcodeTotalSolved();
            }

            List<Project> projects = projectDAO.findByStudentId(studentId);
            int projCount = projects != null ? projects.size() : 0;

            // 1. ATTEMPT REAL GENERATIVE AI (Google Gemini 3.8 Flash)
            if (GeminiAiClient.isAvailable()) {
                StringBuilder systemPrompt = new StringBuilder();
                systemPrompt.append("You are SkillTrack AI Assistant, an expert, friendly, and highly knowledgeable AI coding and placement mentor on the SkillTrack platform.\n");
                systemPrompt.append("Student Name: ").append(firstName).append("\n");
                systemPrompt.append("Target Role: ").append(targetRole).append(" at ").append(targetCompany).append("\n");
                systemPrompt.append("CGPA: ").append(String.format(Locale.ROOT, "%.2f", cgpa)).append("\n");
                systemPrompt.append("Verified DSA Solves: ").append(effectiveDsa).append(" / ").append(minDsa).append(" (Target benchmark)\n");
                systemPrompt.append("Projects: ").append(projCount).append("\n\n");
                systemPrompt.append("Guidelines for Your Response:\n");
                systemPrompt.append("1. Answer ANY question the student asks (technical, non-technical, coding problems, math, physics, general knowledge, career advice, casual conversation, jokes) accurately, naturally, and politely.\n");
                systemPrompt.append("2. If the user asks for code, provide clean, idiomatic code (in Java, Python, C++, or JavaScript) with brief, insightful explanations and complexity analysis.\n");
                systemPrompt.append("3. If the user asks in Hindi or Hinglish, reply in a warm, natural Hinglish/English blend.\n");
                systemPrompt.append("4. Structure your response with clean Markdown headers (###), bullet points, and code blocks (` ``` `).\n");
                systemPrompt.append("5. Be encouraging, concise, and helpful.");

                String geminiReply = GeminiAiClient.generateResponse(systemPrompt.toString(), rawQuery);

                if (geminiReply != null && !geminiReply.trim().isEmpty()) {
                    response.setContent(geminiReply.trim());
                    response.setQuickFollowups(generateDynamicFollowups(rawQuery, targetCompany));
                    return response;
                }
            }

            // 2. RESILIENT FALLBACK ENGINE (If Gemini API is offline)
            String fallbackReply = generateFallbackResponse(rawQuery, firstName, targetCompany, targetRole, effectiveDsa, minDsa, cgpa, projCount);
            response.setContent(fallbackReply);
            response.setQuickFollowups(generateDynamicFollowups(rawQuery, targetCompany));
            return response;

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error generating AI response for query: " + userQuery, e);
            response.setContent("I encountered an issue processing your query. Please try asking again!");
            response.setQuickFollowups(Arrays.asList("Explain OOPs Concepts", "How to reverse a Linked List?", "What is Dynamic Programming?"));
            return response;
        }
    }

    private List<String> generateDynamicFollowups(String query, String targetCompany) {
        String q = query.toLowerCase(Locale.ROOT);
        if (q.contains("hello") || q.contains("hi") || q.contains("hey")) {
            return Arrays.asList("Explain 4 Pillars of OOPs", "How to reverse a Linked List?", "What is Dynamic Programming?", "Tips for " + targetCompany);
        } else if (q.contains("oop") || q.contains("polymorphism") || q.contains("inheritance")) {
            return Arrays.asList("Explain Abstract Class vs Interface", "What is Method Overloading vs Overriding?", "Show OOPs in Python", "Explain Encapsulation");
        } else if (q.contains("linked list") || q.contains("array") || q.contains("tree") || q.contains("graph") || q.contains("dsa")) {
            return Arrays.asList("How to detect a cycle in Linked List?", "Explain Sliding Window Algorithm", "What is Dijkstra Algorithm?", "How to solve DP Knapsack?");
        } else if (q.contains("dbms") || q.contains("sql") || q.contains("acid")) {
            return Arrays.asList("Explain 1NF, 2NF, 3NF Normalization", "SQL vs NoSQL differences", "What is Database Indexing?", "Explain SQL Joins");
        } else if (q.contains("system design") || q.contains("scale") || q.contains("redis")) {
            return Arrays.asList("How does Token Bucket rate limiter work?", "Design TinyURL step by step", "Explain Redis Caching Strategies", "Horizontal vs Vertical Scaling");
        } else if (q.contains("interview") || q.contains("hr") || q.contains("crack") || q.contains("resume")) {
            return Arrays.asList("How to answer 'What is your weakness?'", "How to explain projects in interview?", "Top questions for " + targetCompany, "STAR Method example");
        } else {
            return Arrays.asList("Explain with code example", "What are common interview questions on this?", "Give me practice problems", "Explain OOPs Concepts");
        }
    }

    private String generateFallbackResponse(String userQuery, String firstName, String targetCompany, String targetRole, int effectiveDsa, int minDsa, double cgpa, int projCount) {
        String queryLower = userQuery.toLowerCase(Locale.ROOT).trim();
        StringBuilder reply = new StringBuilder();

        if (queryLower.equals("hello") || queryLower.equals("hi") || queryLower.equals("hey") || queryLower.startsWith("hello ") || queryLower.startsWith("hi ")) {
            reply.append("👋 **Hello ").append(firstName).append("!**\n\n");
            reply.append("I'm your SkillTrack AI Assistant. You can ask me **anything** — whether it's coding walkthroughs, computer science concepts (OOPs, DBMS, OS, Networks), system design, or interview preparation.\n\n");
            reply.append("What would you like to explore today?");
        } else if (queryLower.contains("oop") || queryLower.contains("polymorphism")) {
            reply.append("📚 **Object-Oriented Programming (OOPs) Fundamentals**\n\n");
            reply.append("1. **Encapsulation**: Data hiding using `private` fields and public getters/setters.\n");
            reply.append("2. **Abstraction**: Exposing interfaces while hiding complex implementation details.\n");
            reply.append("3. **Inheritance**: Code reusability where child class inherits parent properties.\n");
            reply.append("4. **Polymorphism**: Compile-time (Overloading) and Runtime (Overriding).\n\n");
            reply.append("```java\n");
            reply.append("// Java Example\n");
            reply.append("class Animal { void sound() { System.out.println(\"Animal sound\"); } }\n");
            reply.append("class Dog extends Animal { void sound() { System.out.println(\"Bark\"); } }\n");
            reply.append("```");
        } else {
            reply.append("💡 **Insight on: \"").append(userQuery).append("\"**\n\n");
            reply.append("Here is a structured overview:\n\n");
            reply.append("- **Core Concept**: Focus on understanding the underlying fundamental principles.\n");
            reply.append("- **Best Practice**: Analyze time & space complexity, and keep code modular.\n");
            reply.append("- **Interview Application**: Explain your thought process step-by-step out loud.\n\n");
            reply.append("Feel free to ask for a full code implementation or deeper breakdown!");
        }

        return reply.toString();
    }
}
