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
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Locale;
import java.util.logging.Level;
import java.util.logging.Logger;

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
            int leetcodeMedHard = 0;
            if (codingProfile != null && codingProfile.getLeetcodeTotalSolved() > effectiveDsa) {
                effectiveDsa = codingProfile.getLeetcodeTotalSolved();
                leetcodeMedHard = codingProfile.getLeetcodeMediumSolved() + codingProfile.getLeetcodeHardSolved();
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
            double dsaRatio = Math.min(1.0, (double) effectiveDsa / targetDsa);
            double projRatio = Math.min(1.0, (double) overview.getProjectsCount() / targetProjects);
            double certRatio = Math.min(1.0, (double) overview.getCertsCount() / targetCerts);
            double cgpaRatio = Math.min(1.0, student.getCgpa() / Math.max(1.0, targetCgpa));

            int readiness = (int) Math.round((dsaRatio * 0.40 + projRatio * 0.30 + certRatio * 0.15 + cgpaRatio * 0.15) * 100.0);
            overview.setOverallReadinessScore(Math.max(15, Math.min(100, readiness)));

            // Identify primary weak area for smart coaching
            String firstName = student.getFullName() != null ? student.getFullName().split(" ")[0] : "Student";
            if (effectiveDsa < targetDsa * 0.5) {
                overview.setTopWeaknessTopic("Dynamic Programming & Graph Algorithms");
                overview.setTopWeaknessPercent((int) Math.round(dsaRatio * 100.0));
                overview.setCoachGreeting("Hey " + firstName + "! Let's accelerate your placement prep.");
                overview.setOpeningAdvice(
                    firstName + ", your **Problem Solving & DSA readiness** is at **" + overview.getTopWeaknessPercent() + "%** while " + company + " (" + role + ") requires a target of **" + targetDsa + "+ solved problems**.\n\n" +
                    "I have customized a **7-Day Action Plan** below focusing on **Dynamic Programming, Trees, and Graphs**. Solving 15–20 medium problems this week will significantly boost your selection probability!"
                );
            } else if (overview.getProjectsCount() < targetProjects) {
                overview.setTopWeaknessTopic("Full-Stack / Microservices Project Depth");
                overview.setTopWeaknessPercent((int) Math.round(projRatio * 100.0));
                overview.setCoachGreeting("Welcome back " + firstName + "!");
                overview.setOpeningAdvice(
                    firstName + ", your DSA solve count is on track (" + effectiveDsa + " problems), but " + company + " looks for **" + targetProjects + "+ comprehensive portfolio projects** with live deployments and clean architecture.\n\n" +
                    "Let's focus on building and documenting a high-impact project with a public GitHub repo this week."
                );
            } else {
                overview.setTopWeaknessTopic("Mock Technical Interviews & System Scalability");
                overview.setTopWeaknessPercent(85);
                overview.setCoachGreeting("Outstanding progress, " + firstName + "!");
                overview.setOpeningAdvice(
                    firstName + ", you meet the core technical cutoffs for " + company + "! Your overall match score is **" + overview.getOverallReadinessScore() + "%**.\n\n" +
                    "Our focus now shifts to **timed mock interviews, System Design tradeoffs, and behavioral STAR rounds** to secure top-bracket placement offers."
                );
            }

            // Generate Dynamic Weekly Study Plan Items
            List<CoachStudyPlanItemDTO> plan = new ArrayList<>();
            plan.add(new CoachStudyPlanItemDTO(
                "DSA",
                "Graphs & BFS/DFS Traversal",
                "Solve 10 medium problems covering cycle detection, connected components, and topological sort.",
                10,
                "/app/student/dsa",
                "HIGH",
                false
            ));

            plan.add(new CoachStudyPlanItemDTO(
                "DSA",
                "Dynamic Programming (0/1 Knapsack & Trees)",
                "Master subproblem memoization and bottom-up DP transitions on 15 core LeetCode mediums.",
                15,
                "/app/student/dsa",
                "HIGH",
                false
            ));

            plan.add(new CoachStudyPlanItemDTO(
                "SYSTEM_DESIGN",
                "System Architecture & API Scalability",
                "Review caching strategies (Redis), database indexing (B-Trees), and REST API rate limiting.",
                1,
                "/app/student/projects",
                "MEDIUM",
                false
            ));

            plan.add(new CoachStudyPlanItemDTO(
                "PROJECT",
                "Portfolio Project Deployment & GitHub Proof",
                "Add interactive demo links, README architecture diagrams, and Docker containerization.",
                1,
                "/app/student/projects",
                "MEDIUM",
                false
            ));

            overview.setWeeklyStudyPlan(plan);

            // Default suggested prompt chips for chat
            List<String> prompts = Arrays.asList(
                "How can I crack " + company + " " + role + "?",
                "Analyze my DSA weak spots and recommend top 5 questions",
                "Give me a 7-day study schedule for " + company,
                "What System Design concepts should I prepare as a fresher?"
            );
            overview.setSuggestedPrompts(prompts);

            // Initial coach welcome message
            CoachChatMessageDTO welcomeMsg = new CoachChatMessageDTO(
                "AI",
                "👋 **Hi " + firstName + "! I'm your AI Placement Readiness Coach.**\n\n" +
                "I've synchronized your verified LeetCode solves (" + effectiveDsa + "), projects (" + overview.getProjectsCount() + "), and academic profile to help you crack **" + company + " (" + role + ")**.\n\n" +
                overview.getOpeningAdvice()
            );
            welcomeMsg.setQuickFollowups(Arrays.asList(
                "Explain the 7-day plan in detail",
                "What are the most frequent interview topics for " + company + "?",
                "How do I prepare for System Design?"
            ));
            overview.getRecentChatHistory().add(welcomeMsg);

            return overview;

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error building AI Coach overview for student: " + studentId, e);
            return overview;
        }
    }

    /**
     * Processes student chat query and returns an intelligent context-aware coach response.
     */
    public CoachChatMessageDTO processStudentQuery(int studentId, String userQuery, Integer criteriaId) {
        CoachChatMessageDTO response = new CoachChatMessageDTO();
        response.setSender("AI");

        if (userQuery == null || userQuery.trim().isEmpty()) {
            response.setContent("Please ask a question regarding your placement preparation, DSA, target company, or resume!");
            return response;
        }

        String queryLower = userQuery.toLowerCase(Locale.ROOT).trim();

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

            String targetCompany = criteria != null ? criteria.getCompanyName() : "Google / Tier-1 Tech";
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

            StringBuilder reply = new StringBuilder();
            List<String> followups = new ArrayList<>();

            if (queryLower.contains("crack") || queryLower.contains("how to prepare") || queryLower.contains("strategy") || queryLower.contains("prepare for")) {
                reply.append("🎯 **Target Strategy for ").append(targetCompany).append(" (").append(targetRole).append(")**\n\n");
                reply.append("Based on your live profile, here is your customized 3-step action roadmap:\n\n");
                reply.append("1. **DSA Target (Current: ").append(effectiveDsa).append(" / ").append(minDsa).append("+)**:\n");
                if (effectiveDsa < minDsa) {
                    reply.append("   - You need **").append(minDsa - effectiveDsa).append(" more solved problems** to hit the competitive hiring cutoff.\n");
                    reply.append("   - Prioritize **Dynamic Programming, Binary Trees, Graphs, and HashMaps** on LeetCode Medium.\n\n");
                } else {
                    reply.append("   - ✅ Your solve count meets the benchmark! Focus on timed speed tests (under 25 mins per medium problem).\n\n");
                }

                reply.append("2. **Project Portfolio (Current: ").append(projCount).append(" projects)**:\n");
                reply.append("   - Ensure at least 1 project demonstrates **scalable architecture** (e.g. Docker containerization, Redis caching, or Microservices).\n");
                reply.append("   - Push clean code to GitHub with an architectural diagram and live URL.\n\n");

                reply.append("3. **Mock Interviews & CS Fundamentals**:\n");
                reply.append("   - Practice explaining your time/space complexity (`O(V+E)`, `O(N log N)`) out loud before writing code.\n");
                reply.append("   - Review OS (Processes vs Threads, Deadlocks) and DBMS (Indexing & ACID properties).\n");

                followups.add("Give me top 10 interview questions for " + targetCompany);
                followups.add("What is the best 7-day study plan?");
                followups.add("How to explain projects in interview?");

            } else if (queryLower.contains("dp") || queryLower.contains("dynamic programming") || queryLower.contains("weak") || queryLower.contains("dsa")) {
                reply.append("💡 **Deep Dive: Mastering DSA & Dynamic Programming**\n\n");
                reply.append(firstName).append(", DP is one of the highest weighted topics in technical interviews at ").append(targetCompany).append(".\n\n");
                reply.append("Here is the proven framework to conquer DP problems:\n\n");
                reply.append("1. **Identify the Patterns**:\n");
                reply.append("   - **0/1 Knapsack Pattern**: Subset Sum, Target Sum, Partition Equal Subset.\n");
                reply.append("   - **Longest Common Subsequence (LCS)**: Edit Distance, Longest Palindromic Substring.\n");
                reply.append("   - **DP on Trees / Graphs**: House Robber III, Binary Tree Maximum Path Sum.\n\n");
                reply.append("2. **Golden 3-Step Solution Flow**:\n");
                reply.append("   - Step 1: Write the brute force recursive solution.\n");
                reply.append("   - Step 2: Add memoization cache (`dp` array or HashMap).\n");
                reply.append("   - Step 3: Convert to bottom-up iterative DP to optimize space complexity.\n\n");
                reply.append("🎯 **Your Goal This Week**: Solve 3 medium DP problems daily on LeetCode.");

                followups.add("Suggest 5 beginner-friendly DP problems");
                followups.add("How to recognize if a problem needs DP?");
                followups.add("Explain Knapsack pattern with an example");

            } else if (queryLower.contains("plan") || queryLower.contains("schedule") || queryLower.contains("timetable") || queryLower.contains("week")) {
                reply.append("📅 **Your Personalized 7-Day Placement Study Plan**\n\n");
                reply.append("Tailored for **").append(targetCompany).append("** based on your current progress:\n\n");
                reply.append("- **Day 1 & 2 (Graphs & BFS/DFS)**: 6 Medium problems (Number of Islands, Course Schedule, Rotting Oranges).\n");
                reply.append("- **Day 3 & 4 (Dynamic Programming)**: 6 Medium problems (Coin Change, Longest Increasing Subsequence, Word Break).\n");
                reply.append("- **Day 5 (System Design Basics)**: Study Load Balancers, Horizontal vs Vertical scaling, and Database Sharding.\n");
                reply.append("- **Day 6 (Project Code Review)**: Refactor your GitHub README, write unit tests, and add architectural flowcharts.\n");
                reply.append("- **Day 7 (Mock Coding Test)**: Take a 60-minute timed 2-problem mock contest on LeetCode/HackerRank.\n\n");
                reply.append("Would you like me to sync these tasks directly to your **Preparation Checklist**?");

                followups.add("Add this study plan to my checklist");
                followups.add("What questions are asked in Day 1 Graphs?");
                followups.add("How do I practice mock interviews?");

            } else if (queryLower.contains("system design") || queryLower.contains("architecture") || queryLower.contains("scalability")) {
                reply.append("🏗️ **System Design Fundamentals for Freshers & SDE-1**\n\n");
                reply.append(firstName).append(", for entry-level roles at companies like ").append(targetCompany).append(", interviewers focus on High-Level Design (HLD) clarity and clean API contracts:\n\n");
                reply.append("1. **Core Concepts to Master**:\n");
                reply.append("   - **Horizontal vs Vertical Scaling**: When to add more servers vs bigger RAM/CPU.\n");
                reply.append("   - **Caching (Redis / Memcached)**: Reducing database read latency with LRU caching.\n");
                reply.append("   - **Load Balancing**: Round-Robin, Least Connections, and Reverse Proxies (Nginx).\n");
                reply.append("   - **Database Sharding & Replication**: Master-slave setups and read replicas.\n\n");
                reply.append("2. **Standard Interview Case Studies**:\n");
                reply.append("   - Design a URL Shortener (TinyURL)\n");
                reply.append("   - Design a Rate Limiter (Token Bucket Algorithm)\n");
                reply.append("   - Design a Real-time Notification Service\n");

                followups.add("How does Token Bucket rate limiter work?");
                followups.add("Explain Redis caching strategies");
                followups.add("Design TinyURL step by step");

            } else if (queryLower.contains("project") || queryLower.contains("resume") || queryLower.contains("github")) {
                reply.append("💻 **Project Portfolio & Resume Optimization**\n\n");
                reply.append("You currently have **").append(projCount).append(" verified projects** on your profile.\n\n");
                reply.append("To stand out to recruiters at **").append(targetCompany).append("**:\n\n");
                reply.append("1. **Quantify Your Bullet Points (XYZ Formula)**:\n");
                reply.append("   - Instead of *'Built a React app'*, write: *'Architected a responsive full-stack platform using React.js and Spring Boot, optimizing API response times by 35% with Redis caching.'*\n\n");
                reply.append("2. **Essential GitHub Checklist**:\n");
                reply.append("   - Include a live working demo URL (Vercel / Render / Netlify).\n");
                reply.append("   - Add a clean README with architecture diagram, setup commands, and API documentation.\n");
                reply.append("   - Clean commit history showing progressive feature branches.\n");

                followups.add("How to write bullet points for resume?");
                followups.add("Suggest high-impact project ideas for SDE");
                followups.add("Scan my resume with ATS scanner");

            } else {
                // General intelligent conversational response
                reply.append("🤖 **AI Coach Analysis for ").append(firstName).append("**\n\n");
                reply.append("Regarding your query: *\"").append(userQuery).append("\"*\n\n");
                reply.append("For your target role as **").append(targetRole).append("** at **").append(targetCompany).append("**:\n\n");
                reply.append("- Your current problem-solving foundation (**").append(effectiveDsa).append(" solved**) and academic standing (**CGPA: ").append(String.format(Locale.ROOT, "%.2f", cgpa)).append("**) give you a strong baseline.\n");
                reply.append("- The most impactful action you can take today is consistency in solving **2 LeetCode mediums daily** and validating your **core projects**.\n\n");
                reply.append("Feel free to ask me for topic breakdowns, code explanations, or interview questions anytime!");

                followups.add("How can I crack " + targetCompany + "?");
                followups.add("Give me this week's study plan");
                followups.add("Where are my biggest skill gaps?");
            }

            response.setContent(reply.toString());
            response.setQuickFollowups(followups);
            return response;

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error generating AI Coach response for query: " + userQuery, e);
            response.setContent("I encountered an issue processing your query. Please try asking again!");
            return response;
        }
    }
}
