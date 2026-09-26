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

/**
 * Intelligent Conversational AI Assistant Service for SkillTrack.
 * Handles general chit-chat, computer science fundamentals, DSA & coding questions,
 * system design, placement guidance, and profile-aware recommendations.
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
            overview.setCoachGreeting("Hello " + firstName + "! How can I assist your preparation today?");

            // Suggested prompt chips for chat
            List<String> prompts = Arrays.asList(
                "How to prepare for " + company + " " + role + "?",
                "Explain Object-Oriented Programming (OOPs)",
                "How to reverse a Linked List in Java?",
                "What is Dynamic Programming?",
                "Give me top interview questions for " + company
            );
            overview.setSuggestedPrompts(prompts);

            // Initial welcome message
            CoachChatMessageDTO welcomeMsg = new CoachChatMessageDTO(
                "AI",
                "👋 **Hi " + firstName + "! I'm your SkillTrack AI Assistant.**\n\n" +
                "I can help you with anything — **coding & DSA**, computer science concepts (**OOPs, DBMS, OS, Networks**), system design, resume tips, or general interview prep.\n\n" +
                "Feel free to ask me any question or type a topic you'd like to explore!"
            );
            welcomeMsg.setQuickFollowups(Arrays.asList(
                "Explain OOPs Concepts with code",
                "How to reverse a Linked List?",
                "Top questions for " + company,
                "What is Dynamic Programming?"
            ));
            overview.getRecentChatHistory().add(welcomeMsg);

            return overview;

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error building AI Coach overview for student: " + studentId, e);
            return overview;
        }
    }

    /**
     * Processes any student query and returns an intelligent, natural conversational AI response.
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
        String queryLower = rawQuery.toLowerCase(Locale.ROOT);

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

            StringBuilder reply = new StringBuilder();
            List<String> followups = new ArrayList<>();

            // 1. GREETINGS & CASUAL CHIT-CHAT
            if (isGreeting(queryLower)) {
                reply.append("👋 **Hello ").append(firstName).append("!**\n\n");
                reply.append("I'm your SkillTrack AI Assistant. I can help you with:\n\n");
                reply.append("- 💻 **Coding & DSA**: Problem walkthroughs, algorithmic patterns, code explanations in Java, Python, C++.\n");
                reply.append("- 📚 **Core CS Subjects**: OOPs, DBMS, Operating Systems, Computer Networks, SQL.\n");
                reply.append("- 🏗️ **System Design & Web**: Scalability, REST APIs, Microservices, Caching.\n");
                reply.append("- 🎯 **Placement & Interviews**: Behavioral HR questions, mock questions, resume tips, and strategy for **").append(targetCompany).append("**.\n\n");
                reply.append("What would you like to work on today?");

                followups.add("Explain OOPs Concepts with examples");
                followups.add("How to reverse a Linked List?");
                followups.add("What are top questions for " + targetCompany + "?");
                followups.add("What is Dynamic Programming?");

            // 2. GRATITUDE / FAREWELL
            } else if (isGratitudeOrFarewell(queryLower)) {
                if (queryLower.contains("thank") || queryLower.contains("thx") || queryLower.contains("dhanyawad") || queryLower.contains("shukriya")) {
                    reply.append("You're very welcome, ").append(firstName).append("! 😊\n\n");
                    reply.append("I'm always here to help you learn and prepare. Let me know if you have any other questions or need help solving a problem!");
                    followups.add("Explain Sliding Window algorithm");
                    followups.add("How to optimize my resume?");
                    followups.add("What is Big-O notation?");
                } else {
                    reply.append("Goodbye ").append(firstName).append("! Keep coding and practicing consistently. You've got this! 🚀");
                    followups.add("How to stay consistent in DSA?");
                    followups.add("Quick 5-minute DSA tip");
                }

            // 3. IDENTITY / WHAT CAN YOU DO
            } else if (queryLower.contains("who are you") || queryLower.contains("what can you do") || queryLower.contains("your name") || queryLower.equals("help")) {
                reply.append("🤖 **I am SkillTrack AI Assistant** — your 24/7 intelligent mentor built into the SkillTrack platform.\n\n");
                reply.append("Here are some of the things you can ask me:\n\n");
                reply.append("1. **Write & Debug Code**: Ask me to write code for any DSA problem or explain complex algorithms.\n");
                reply.append("2. **Core CS Fundamentals**: Ask about Polymorphism, ACID properties, Paging, Virtual Memory, TCP 3-way handshake.\n");
                reply.append("3. **System Design**: Learn how to design TinyURL, Rate Limiters, or scale web applications.\n");
                reply.append("4. **Company-Specific Prep**: Get interview question sets for Google, Amazon, Microsoft, TCS, Infosys.\n");
                reply.append("5. **Resume & Profile Guidance**: Tailored advice based on your CGPA (").append(String.format(Locale.ROOT, "%.2f", cgpa)).append(") and DSA solves (").append(effectiveDsa).append(").\n\n");
                reply.append("Go ahead and ask me anything!");

                followups.add("Explain 4 Pillars of OOPs");
                followups.add("How does Binary Search work?");
                followups.add("What is Normalization in DBMS?");
                followups.add("Explain TCP vs UDP");

            // 4. OOPS (OBJECT ORIENTED PROGRAMMING)
            } else if (queryLower.contains("oop") || queryLower.contains("polymorphism") || queryLower.contains("inheritance") || queryLower.contains("encapsulation") || queryLower.contains("abstraction")) {
                reply.append("📚 **The 4 Core Pillars of Object-Oriented Programming (OOPs)**\n\n");
                reply.append("1. **Encapsulation**: Bundling data (variables) and methods into a single unit (class) and restricting direct access using `private` fields with getters/setters.\n\n");
                reply.append("2. **Abstraction**: Hiding internal implementation details and showing only essential functionality (e.g. `interface` or `abstract class`).\n\n");
                reply.append("3. **Inheritance**: Mechanism where a child class acquires properties and behaviors of a parent class (`extends` keyword) to enable code reuse.\n\n");
                reply.append("4. **Polymorphism**: Ability of an object to take many forms:\n");
                reply.append("   - **Compile-time (Static)**: Method Overloading (same name, different parameter signature).\n");
                reply.append("   - **Runtime (Dynamic)**: Method Overriding (subclass provides specific implementation of parent method).\n\n");
                reply.append("```java\n");
                reply.append("// Java Example: Polymorphism & Abstraction\n");
                reply.append("interface Payment {\n");
                reply.append("    void pay(double amount);\n");
                reply.append("}\n\n");
                reply.append("class UpiPayment implements Payment {\n");
                reply.append("    @Override\n");
                reply.append("    public void pay(double amount) {\n");
                reply.append("        System.out.println(\"Paid ₹\" + amount + \" via UPI\");\n");
                reply.append("    }\n");
                reply.append("}\n");
                reply.append("```\n");

                followups.add("Explain Difference between Abstract Class and Interface");
                followups.add("What is Method Overloading vs Overriding?");
                followups.add("Explain Encapsulation with real-world example");

            // 5. LINKED LIST & DSA DATA STRUCTURES
            } else if (queryLower.contains("linked list") || queryLower.contains("reverse a linked list") || queryLower.contains("reverse linked list")) {
                reply.append("🔗 **How to Reverse a Singly Linked List**\n\n");
                reply.append("The standard iterative approach uses **3 Pointers** (`prev`, `curr`, `next`) with `O(N)` Time and `O(1)` Space complexity.\n\n");
                reply.append("### **Algorithm**:\n");
                reply.append("1. Initialize `prev = null`, `curr = head`.\n");
                reply.append("2. While `curr != null`:\n");
                reply.append("   - Store next node: `next = curr.next`\n");
                reply.append("   - Reverse pointer: `curr.next = prev`\n");
                reply.append("   - Move forward: `prev = curr`, `curr = next`\n");
                reply.append("3. Return `prev` as new head.\n\n");
                reply.append("```java\n");
                reply.append("class ListNode {\n");
                reply.append("    int val;\n");
                reply.append("    ListNode next;\n");
                reply.append("    ListNode(int val) { this.val = val; }\n");
                reply.append("}\n\n");
                reply.append("public ListNode reverseList(ListNode head) {\n");
                reply.append("    ListNode prev = null;\n");
                reply.append("    ListNode curr = head;\n");
                reply.append("    while (curr != null) {\n");
                reply.append("        ListNode next = curr.next;\n");
                reply.append("        curr.next = prev;\n");
                reply.append("        prev = curr;\n");
                reply.append("        curr = next;\n");
                reply.append("    }\n");
                reply.append("    return prev;\n");
                reply.append("}\n");
                reply.append("```\n\n");
                reply.append("**Time Complexity**: `O(N)` — Single traversal\n");
                reply.append("**Space Complexity**: `O(1)` — In-place reversal");

                followups.add("How to detect a cycle in Linked List (Floyd's Algorithm)?");
                followups.add("How to find middle element of Linked List?");
                followups.add("Explain Doubly Linked List advantages");

            // 6. DYNAMIC PROGRAMMING & DSA ALGORITHMS
            } else if (queryLower.contains("dp") || queryLower.contains("dynamic programming") || queryLower.contains("knapsack")) {
                reply.append("💡 **Mastering Dynamic Programming (DP)**\n\n");
                reply.append("Dynamic Programming is an optimization technique that solves subproblems once and stores their results (memoization/tabulation) to avoid redundant computations.\n\n");
                reply.append("### **Two Main Approaches**:\n");
                reply.append("1. **Top-Down (Memoization)**: Recursion + Cache (Store results in an array/HashMap).\n");
                reply.append("2. **Bottom-Up (Tabulation)**: Iterative computation starting from base cases up to `N`.\n\n");
                reply.append("### **Top 5 Must-Do DP Patterns**:\n");
                reply.append("- **0/1 Knapsack**: Subset Sum, Target Sum, Equal Partition.\n");
                reply.append("- **Longest Common Subsequence (LCS)**: Edit Distance, Longest Palindromic Subsequence.\n");
                reply.append("- **Fibonacci Style**: Climbing Stairs, House Robber, Decode Ways.\n");
                reply.append("- **Matrix DP**: Unique Paths, Minimum Path Sum.\n");
                reply.append("- **DP on Trees / Graphs**: Binary Tree Maximum Path Sum.\n\n");
                reply.append("```java\n");
                reply.append("// Example: Climbing Stairs (Bottom-Up Tabulation in O(1) Space)\n");
                reply.append("public int climbStairs(int n) {\n");
                reply.append("    if (n <= 2) return n;\n");
                reply.append("    int prev2 = 1, prev1 = 2;\n");
                reply.append("    for (int i = 3; i <= n; i++) {\n");
                reply.append("        int curr = prev1 + prev2;\n");
                reply.append("        prev2 = prev1;\n");
                reply.append("        prev1 = curr;\n");
                reply.append("    }\n");
                reply.append("    return prev1;\n");
                reply.append("}\n");
                reply.append("```\n");

                followups.add("Explain 0/1 Knapsack problem with code");
                followups.add("How to solve Longest Increasing Subsequence (LIS)?");
                followups.add("When should I use DP vs Greedy?");

            // 7. DBMS & SQL
            } else if (queryLower.contains("dbms") || queryLower.contains("sql") || queryLower.contains("acid") || queryLower.contains("normalization") || queryLower.contains("index")) {
                reply.append("🗄️ **Database Management Systems (DBMS) & SQL Key Concepts**\n\n");
                reply.append("### 1. **ACID Properties** (Transaction Guarantees):\n");
                reply.append("- **Atomicity**: All or nothing execution (Rollback on failure).\n");
                reply.append("- **Consistency**: Database transitions from one valid state to another.\n");
                reply.append("- **Isolation**: Concurrent transactions do not interfere with each other.\n");
                reply.append("- **Durability**: Once committed, data changes survive system crashes.\n\n");
                reply.append("### 2. **Database Normalization**:\n");
                reply.append("- **1NF**: Atomic values (no repeating groups/arrays).\n");
                reply.append("- **2NF**: In 1NF + No partial dependency (all non-key attributes depend on full primary key).\n");
                reply.append("- **3NF**: In 2NF + No transitive dependency (non-key attributes depend only on primary key).\n\n");
                reply.append("### 3. **SQL Joins Summary**:\n");
                reply.append("- `INNER JOIN`: Matching records in both tables.\n");
                reply.append("- `LEFT JOIN`: All records from left table + matching from right.\n");
                reply.append("- `RIGHT JOIN`: All records from right table + matching from left.\n\n");
                reply.append("### 4. **Database Indexing**:\n");
                reply.append("Indexes use **B-Trees/B+ Trees** to speed up search queries from `O(N)` table scans to `O(log N)` lookups at the cost of extra storage and slower write operations.");

                followups.add("Explain SQL vs NoSQL differences");
                followups.add("What is the difference between Primary Key and Unique Key?");
                followups.add("Write SQL query to find 2nd highest salary");

            // 8. OPERATING SYSTEMS & NETWORKS
            } else if (queryLower.contains("os") || queryLower.contains("operating system") || queryLower.contains("deadlock") || queryLower.contains("thread") || queryLower.contains("process") || queryLower.contains("tcp") || queryLower.contains("http")) {
                reply.append("⚙️ **Operating Systems & Computer Networks Essentials**\n\n");
                reply.append("### 1. **Process vs Thread**:\n");
                reply.append("- **Process**: An executing program with its own dedicated memory address space (Stack, Heap, Data). Heavy context-switching.\n");
                reply.append("- **Thread**: Lightweight unit of execution within a process that shares memory (Heap) with other threads. Faster context-switching.\n\n");
                reply.append("### 2. **Deadlock & 4 Necessary Conditions (Coffman Conditions)**:\n");
                reply.append("1. Mutual Exclusion\n");
                reply.append("2. Hold and Wait\n");
                reply.append("3. No Preemption\n");
                reply.append("4. Circular Wait\n\n");
                reply.append("### 3. **TCP 3-Way Handshake**:\n");
                reply.append("1. **SYN**: Client sends `SYN` packet to server.\n");
                reply.append("2. **SYN-ACK**: Server acknowledges and responds with `SYN-ACK`.\n");
                reply.append("3. **ACK**: Client confirms with `ACK` packet. Connection established!\n\n");
                reply.append("### 4. **HTTP vs HTTPS**:\n");
                reply.append("HTTPS encrypts HTTP traffic using **TLS/SSL encryption** over port 443, ensuring confidentiality, integrity, and server authentication.");

                followups.add("Explain CPU Scheduling Algorithms (Round Robin vs SJF)");
                followups.add("What is Virtual Memory and Paging?");
                followups.add("Explain Mutex vs Semaphore");

            // 9. SYSTEM DESIGN & SCALABILITY
            } else if (queryLower.contains("system design") || queryLower.contains("architecture") || queryLower.contains("scalability") || queryLower.contains("redis") || queryLower.contains("microservice")) {
                reply.append("🏗️ **System Design Fundamentals for Software Engineers**\n\n");
                reply.append("### 1. **Horizontal vs Vertical Scaling**:\n");
                reply.append("- **Vertical Scaling (Scale Up)**: Adding more CPU/RAM to a single server. (Has physical limit & single point of failure).\n");
                reply.append("- **Horizontal Scaling (Scale Out)**: Adding more server instances behind a Load Balancer. (Highly scalable & fault-tolerant).\n\n");
                reply.append("### 2. **Key Building Blocks**:\n");
                reply.append("- **Load Balancer (Nginx / HAProxy / ALB)**: Distributes incoming user traffic evenly across backend servers.\n");
                reply.append("- **Caching (Redis / Memcached)**: In-memory key-value store to cache frequent database reads (`O(1)` access time).\n");
                reply.append("- **Database Read Replicas**: Distribute heavy read traffic across replica databases while writing to primary.\n");
                reply.append("- **Message Queues (Kafka / RabbitMQ)**: Asynchronous task processing and decoupling services.\n\n");
                reply.append("### 3. **Popular Interview Case Studies**:\n");
                reply.append("1. Design URL Shortener (TinyURL) using Base62 encoding & hash index.\n");
                reply.append("2. Design Rate Limiter using Token Bucket Algorithm.\n");
                reply.append("3. Design Notification System with WebSockets and Pub/Sub.");

                followups.add("How to design TinyURL step by step?");
                followups.add("Explain Redis Caching Strategies (Cache-Aside, Write-Through)");
                followups.add("What is CAP Theorem in distributed systems?");

            // 10. HR & BEHAVIORAL INTERVIEW
            } else if (queryLower.contains("tell me about yourself") || queryLower.contains("hr question") || queryLower.contains("interview tip") || queryLower.contains("behavioral")) {
                reply.append("🎯 **Mastering HR & Behavioral Interviews: The STAR Method**\n\n");
                reply.append("### **How to Answer 'Tell Me About Yourself'**:\n");
                reply.append("Use the **Present-Past-Future Framework** (Keep it within 90 seconds):\n");
                reply.append("1. **Present**: *\"I am currently completing my engineering degree with a focus on Software Engineering, where I've solved ").append(effectiveDsa).append("+ DSA problems and built full-stack applications.\"*\n");
                reply.append("2. **Past**: *\"Recently, I built ").append(projCount > 0 ? "projects including full-stack architectures" : "scalable software projects").append(" where I implemented clean API design and database optimizations.\"*\n");
                reply.append("3. **Future**: *\"I am passionate about building scalable, high-performance systems and am excited about the opportunity to contribute to ").append(targetCompany).append(".\"*\n\n");
                reply.append("### **The STAR Method for Behavioral Questions**:\n");
                reply.append("- **S (Situation)**: Set the context of the challenge.\n");
                reply.append("- **T (Task)**: What was your specific responsibility?\n");
                reply.append("- **A (Action)**: What concrete technical or leadership action did YOU take?\n");
                reply.append("- **R (Result)**: What was the quantifiable outcome (e.g. reduced load time by 30%)?");

                followups.add("How to answer 'What is your greatest weakness?'");
                followups.add("How to answer 'Why should we hire you?'");
                followups.add("What questions should I ask the interviewer at the end?");

            // 11. COMPANY TARGETING & PLACEMENT CRITERIA
            } else if (queryLower.contains("crack") || queryLower.contains("amazon") || queryLower.contains("google") || queryLower.contains("microsoft") || queryLower.contains("tcs") || queryLower.contains("target role") || queryLower.contains("my score") || queryLower.contains("my readiness")) {
                reply.append("🎯 **Target Preparation Strategy for ").append(targetCompany).append(" (").append(targetRole).append(")**\n\n");
                reply.append("Here is your personalized roadmap based on your current SkillTrack profile:\n\n");
                reply.append("1. **DSA Milestone (Current: ").append(effectiveDsa).append(" / ").append(minDsa).append("+)**:\n");
                if (effectiveDsa < minDsa) {
                    reply.append("   - You need **").append(minDsa - effectiveDsa).append(" more solved problems** to hit the competitive hiring cutoff.\n");
                    reply.append("   - Focus heavily on **Arrays, Graphs, Binary Trees, and Dynamic Programming** on LeetCode Medium.\n\n");
                } else {
                    reply.append("   - ✅ Solved count meets target! Focus on speed contests and mock coding interviews.\n\n");
                }
                reply.append("2. **Project Portfolio (Current: ").append(projCount).append(" verified projects)**:\n");
                reply.append("   - Ensure at least 1 project demonstrates end-to-end architecture (e.g. Spring Boot / Node.js + React + Database + Redis).\n\n");
                reply.append("3. **Core CS & Mock Interview Readiness**:\n");
                reply.append("   - Review DBMS Indexing, ACID properties, Multithreading, and OS Paging.\n");
                reply.append("   - Your current CGPA (**").append(String.format(Locale.ROOT, "%.2f", cgpa)).append("**) provides a strong academic foundation.");

                followups.add("Give me top 10 interview questions for " + targetCompany);
                followups.add("How to prepare for System Design in 2 weeks?");
                followups.add("Suggest high-impact project ideas for SDE");

            // 12. GENERAL INTELLIGENT AI RESPONSE FOR ANY FREE-FORM QUESTION
            } else {
                reply.append("💡 **Here is a detailed breakdown on: \"").append(rawQuery).append("\"**\n\n");
                reply.append("To understand this effectively, let's look at the core principles and practical applications:\n\n");
                reply.append("1. **Fundamental Concept**:\n");
                reply.append("   - In software engineering and computer science, mastering this concept helps you write cleaner, more efficient, and scalable applications.\n");
                reply.append("   - Focus on understanding the *underlying mechanism* rather than memorizing syntax.\n\n");
                reply.append("2. **Best Practices & Industry Standards**:\n");
                reply.append("   - Always analyze the time and space complexity before choosing an implementation.\n");
                reply.append("   - Structure your code with clean separation of concerns, proper error handling, and unit test coverage.\n\n");
                reply.append("3. **Interview Application**:\n");
                reply.append("   - When interviewers ask about this, explain your thought process clearly, mention real-world trade-offs, and write modular code.\n\n");
                reply.append("Would you like a code implementation, step-by-step tutorial, or practice problem on this topic?");

                followups.add("Show me a code example for this");
                followups.add("What are the common interview questions on this?");
                followups.add("Explain OOPs Concepts");
                followups.add("How to prepare for " + targetCompany + "?");
            }

            response.setContent(reply.toString());
            response.setQuickFollowups(followups);
            return response;

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error generating AI response for query: " + userQuery, e);
            response.setContent("I encountered an issue processing your query. Please try asking again!");
            response.setQuickFollowups(Arrays.asList("Explain OOPs Concepts", "How to reverse a Linked List?", "What is Dynamic Programming?"));
            return response;
        }
    }

    private boolean isGreeting(String q) {
        return q.equals("hello") || q.equals("hi") || q.equals("hey") || q.equals("namaste") ||
               q.equals("good morning") || q.equals("good evening") || q.equals("good afternoon") ||
               q.equals("how are you") || q.equals("whats up") || q.equals("what's up") ||
               q.startsWith("hello ") || q.startsWith("hi ") || q.startsWith("hey ");
    }

    private boolean isGratitudeOrFarewell(String q) {
        return q.contains("thank") || q.contains("thx") || q.contains("dhanyawad") ||
               q.contains("shukriya") || q.equals("bye") || q.equals("goodbye") ||
               q.equals("see you") || q.startsWith("bye ");
    }
}
