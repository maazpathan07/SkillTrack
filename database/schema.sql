-- =====================================================================
-- SkillTrack Database Schema Specification
-- Target Database: MySQL 8.x
-- Database Name: skilltrack_db
-- Character Set: utf8mb4 / utf8mb4_unicode_ci
-- =====================================================================

CREATE DATABASE IF NOT EXISTS skilltrack_db
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_unicode_ci;

USE skilltrack_db;

-- ---------------------------------------------------------------------
-- Table 1: USERS (Authentication & Role Base)
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(120) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NULL,
    salt VARCHAR(64) NULL,
    role ENUM('STUDENT', 'ADMIN') NOT NULL,
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    oauth_provider VARCHAR(20) NOT NULL DEFAULT 'LOCAL',
    oauth_id VARCHAR(100) NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_users_email (email),
    INDEX idx_users_role (role),
    INDEX idx_users_oauth (oauth_provider, oauth_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- Table 2: TARGET_ROLES (Career Target Roles)
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS target_roles (
    role_id INT AUTO_INCREMENT PRIMARY KEY,
    role_title VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_roles_title (role_title)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- Table 3: STUDENTS (Student Profiles)
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL UNIQUE,
    full_name VARCHAR(100) NOT NULL,
    roll_number VARCHAR(50) NOT NULL UNIQUE,
    department VARCHAR(50) NOT NULL,
    graduation_year INT NOT NULL,
    cgpa DECIMAL(3,2) NOT NULL DEFAULT 0.00,
    target_role_id INT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_students_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_students_target_role FOREIGN KEY (target_role_id) REFERENCES target_roles(role_id) ON DELETE SET NULL,
    INDEX idx_students_dept (department),
    INDEX idx_students_grad_year (graduation_year),
    INDEX idx_students_cgpa (cgpa),
    INDEX idx_students_target_role (target_role_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- Table 4: ADMINS (Administrator Profiles)
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS admins (
    admin_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL UNIQUE,
    full_name VARCHAR(100) NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_admins_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- Table 5: SKILLS (Master Skill Taxonomy)
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS skills (
    skill_id INT AUTO_INCREMENT PRIMARY KEY,
    skill_name VARCHAR(100) NOT NULL UNIQUE,
    category ENUM('PROGRAMMING_LANGUAGES', 'FRAMEWORKS', 'DATABASES', 'DEV_TOOLS', 'CORE_CS') NOT NULL,
    description TEXT,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_skills_name (skill_name),
    INDEX idx_skills_category (category)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- Table 6: ROLE_SKILL_REQUIREMENTS (Benchmark Skills per Role)
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS role_skill_requirements (
    requirement_id INT AUTO_INCREMENT PRIMARY KEY,
    role_id INT NOT NULL,
    skill_id INT NOT NULL,
    min_proficiency ENUM('BEGINNER', 'INTERMEDIATE', 'ADVANCED') NOT NULL,
    is_mandatory TINYINT(1) NOT NULL DEFAULT 1,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_role_req_role FOREIGN KEY (role_id) REFERENCES target_roles(role_id) ON DELETE CASCADE,
    CONSTRAINT fk_role_req_skill FOREIGN KEY (skill_id) REFERENCES skills(skill_id) ON DELETE CASCADE,
    UNIQUE KEY uq_role_skill (role_id, skill_id),
    INDEX idx_role_req_role (role_id),
    INDEX idx_role_req_skill (skill_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- Table 7: STUDENT_SKILLS (Student Acquired Skills)
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS student_skills (
    student_skill_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    skill_id INT NOT NULL,
    proficiency_level ENUM('BEGINNER', 'INTERMEDIATE', 'ADVANCED') NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_student_skill_student FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    CONSTRAINT fk_student_skill_skill FOREIGN KEY (skill_id) REFERENCES skills(skill_id) ON DELETE CASCADE,
    UNIQUE KEY uq_student_skill (student_id, skill_id),
    INDEX idx_student_skill_student (student_id),
    INDEX idx_student_skill_skill (skill_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- Table 8: PROJECTS (Student Portfolio Projects)
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS projects (
    project_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    title VARCHAR(150) NOT NULL,
    description TEXT NOT NULL,
    tech_stack VARCHAR(255) NOT NULL,
    github_url VARCHAR(255),
    live_demo_url VARCHAR(255),
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_projects_student FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    INDEX idx_projects_student (student_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- Table 9: CERTIFICATIONS (Student Verified Certifications)
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS certifications (
    cert_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    title VARCHAR(150) NOT NULL,
    issuing_org VARCHAR(150) NOT NULL,
    issue_date DATE NOT NULL,
    credential_url VARCHAR(255),
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_certs_student FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    INDEX idx_certs_student (student_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- Table 10: DSA_TOPICS (Master DSA Topic Taxonomy)
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS dsa_topics (
    topic_id INT AUTO_INCREMENT PRIMARY KEY,
    topic_name VARCHAR(100) NOT NULL UNIQUE,
    category ENUM('CORE_DSA', 'ADVANCED_DSA') NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_dsa_topic_name (topic_name),
    INDEX idx_dsa_topic_category (category)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- Table 11: STUDENT_DSA_PROGRESS (Student Topic Progress)
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS student_dsa_progress (
    progress_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    topic_id INT NOT NULL,
    status ENUM('NOT_STARTED', 'IN_PROGRESS', 'COMPLETED') NOT NULL DEFAULT 'NOT_STARTED',
    problems_solved INT NOT NULL DEFAULT 0,
    notes TEXT,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_dsa_prog_student FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    CONSTRAINT fk_dsa_prog_topic FOREIGN KEY (topic_id) REFERENCES dsa_topics(topic_id) ON DELETE CASCADE,
    UNIQUE KEY uq_student_dsa_topic (student_id, topic_id),
    INDEX idx_dsa_prog_student (student_id),
    INDEX idx_dsa_prog_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- Table 11B: STUDENT_CODING_PROFILES (Live LeetCode & GitHub Sync)
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS student_coding_profiles (
    student_id INT PRIMARY KEY,
    leetcode_username VARCHAR(100) NULL,
    leetcode_total_solved INT NOT NULL DEFAULT 0,
    leetcode_easy_solved INT NOT NULL DEFAULT 0,
    leetcode_medium_solved INT NOT NULL DEFAULT 0,
    leetcode_hard_solved INT NOT NULL DEFAULT 0,
    leetcode_ranking INT NOT NULL DEFAULT 0,
    leetcode_contest_rating VARCHAR(50) NULL,
    leetcode_synced_at DATETIME NULL,
    github_username VARCHAR(100) NULL,
    github_repos_count INT NOT NULL DEFAULT 0,
    github_followers INT NOT NULL DEFAULT 0,
    github_bio TEXT NULL,
    github_avatar_url VARCHAR(255) NULL,
    github_profile_url VARCHAR(255) NULL,
    github_synced_at DATETIME NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_coding_prof_student FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    INDEX idx_coding_leetcode (leetcode_username),
    INDEX idx_coding_github (github_username)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- Table 12: PREPARATION_TASKS (Actionable Checklist)
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS preparation_tasks (
    task_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    status ENUM('PENDING', 'COMPLETED') NOT NULL DEFAULT 'PENDING',
    target_date DATE NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_tasks_student FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    INDEX idx_tasks_student (student_id),
    INDEX idx_tasks_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- Table 13: PLACEMENT_CRITERIA (Configurable Placement Benchmarks)
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS placement_criteria (
    criteria_id INT AUTO_INCREMENT PRIMARY KEY,
    company_name VARCHAR(100) NOT NULL,
    role_title VARCHAR(100) NOT NULL,
    min_cgpa DECIMAL(3,2) NOT NULL DEFAULT 0.00,
    min_dsa_problems INT NOT NULL DEFAULT 0,
    min_projects INT NOT NULL DEFAULT 0,
    min_certifications INT NOT NULL DEFAULT 0,
    allowed_departments VARCHAR(255) NOT NULL DEFAULT 'ALL',
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_criteria_company (company_name),
    INDEX idx_criteria_active (is_active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- Table 14: CRITERIA_SKILL_REQUIREMENTS (Skills for Placement Criteria)
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS criteria_skill_requirements (
    requirement_id INT AUTO_INCREMENT PRIMARY KEY,
    criteria_id INT NOT NULL,
    skill_id INT NOT NULL,
    min_proficiency ENUM('BEGINNER', 'INTERMEDIATE', 'ADVANCED') NOT NULL,
    is_mandatory TINYINT(1) NOT NULL DEFAULT 1,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_crit_req_criteria FOREIGN KEY (criteria_id) REFERENCES placement_criteria(criteria_id) ON DELETE CASCADE,
    CONSTRAINT fk_crit_req_skill FOREIGN KEY (skill_id) REFERENCES skills(skill_id) ON DELETE CASCADE,
    UNIQUE KEY uq_criteria_skill (criteria_id, skill_id),
    INDEX idx_crit_req_criteria (criteria_id),
    INDEX idx_crit_req_skill (skill_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- Table 15: APP_SETTINGS (Dynamic Configuration & Readiness Weights)
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS app_settings (
    setting_id INT AUTO_INCREMENT PRIMARY KEY,
    setting_key VARCHAR(100) NOT NULL UNIQUE,
    setting_value VARCHAR(255) NOT NULL,
    description VARCHAR(255),
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_settings_key (setting_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================================
-- SEED DATA
-- =====================================================================

-- 1. Default Admin User (Password: Admin@123)
-- PBKDF2WithHmacSHA256, 65536 iterations, 256 bits derived key
INSERT INTO users (user_id, email, password_hash, salt, role, is_active) VALUES 
(1, 'admin@skilltrack.com', '9YmZI2yiGK4RuN1L7PNfFItK4F4XLUqcrQtM/ZrTg2M=', 'JLfPwbbI6eSzvjickdRGdw==', 'ADMIN', 1)
ON DUPLICATE KEY UPDATE email=email;

INSERT INTO admins (admin_id, user_id, full_name) VALUES 
(1, 1, 'System Administrator')
ON DUPLICATE KEY UPDATE full_name=full_name;

-- 2. App Settings (Readiness weights and default benchmarks)
INSERT INTO app_settings (setting_key, setting_value, description) VALUES
('readiness.weight.skills', '0.35', 'Weight for Skill Gap Match (0.35 = 35%)'),
('readiness.weight.dsa', '0.25', 'Weight for DSA Progress (0.25 = 25%)'),
('readiness.weight.projects', '0.20', 'Weight for Completed Projects (0.20 = 20%)'),
('readiness.weight.certifications', '0.10', 'Weight for Certifications (0.10 = 10%)'),
('readiness.weight.tasks', '0.10', 'Weight for Preparation Tasks (0.10 = 10%)'),
('readiness.benchmark.dsa_problems', '150', 'Benchmark problem count for 100% DSA readiness'),
('readiness.benchmark.projects', '3', 'Benchmark project count for 100% Project readiness'),
('readiness.benchmark.certifications', '2', 'Benchmark certification count for 100% Certification readiness')
ON DUPLICATE KEY UPDATE setting_value=VALUES(setting_value);

-- 3. Target Roles (14 Comprehensive IT, Software & Data Engineering Career Roles)
INSERT INTO target_roles (role_id, role_title, description, is_active) VALUES
(1, 'Full Stack Java Developer', 'End-to-end web developer mastering Java backend, Spring Boot, relational databases, REST APIs, and React/HTML5 frontends.', 1),
(2, 'Full Stack MERN Developer', 'Modern JavaScript full stack engineer specializing in MongoDB, Express.js, React.js, Node.js, and TypeScript.', 1),
(3, 'Java Backend Developer', 'Specialized in building robust, scalable server-side systems, microservices, and high-concurrency APIs using Java and Spring Boot.', 1),
(4, 'Python Backend Developer', 'Develops high-performance web applications, data processing pipelines, and microservices using Python, FastAPI/Django, and SQL.', 1),
(5, 'Frontend Developer (React / UI)', 'Crafts modern, responsive, component-driven user interfaces using modern JavaScript, React.js, HTML5, and CSS3.', 1),
(6, 'Data Analyst & BI Specialist', 'Extracts actionable business insights using SQL, Python (Pandas/NumPy), statistical modeling, and relational DBMS.', 1),
(7, 'Data Engineer (Big Data & ETL)', 'Designs scalable data pipelines, ETL workflows, data warehousing, and distributed streaming using Python, SQL, and cloud storage.', 1),
(8, 'Machine Learning & AI Engineer', 'Builds and deploys predictive models, deep learning networks, and NLP systems using Python, PyTorch, and TensorFlow.', 1),
(9, 'Cloud & DevOps Engineer', 'Automates cloud infrastructure, CI/CD pipelines, containerization, and deployment workflows using Docker, AWS, and Linux.', 1),
(10, 'Cyber Security & SOC Analyst', 'Protects software systems and cloud assets with network security, vulnerability auditing, OWASP standards, and penetration testing.', 1),
(11, 'Mobile App Developer (Android / Flutter)', 'Creates high-performance native and cross-platform mobile apps using Kotlin, Flutter, and RESTful mobile APIs.', 1),
(12, 'Software Test Engineer (SDET / QA)', 'Automates end-to-end software quality assurance, regression suites, API tests, and performance benchmarks using Selenium and Java/Python.', 1),
(13, 'Systems & Low-Level Software Engineer', 'Builds high-performance systems, network protocols, and hardware interfaces using C/C++, Linux internals, and multithreading.', 1),
(14, 'IT Business & Product Analyst', 'Bridges engineering and product requirements with technical documentation, data analytics, SQL queries, and agile workflow management.', 1)
ON DUPLICATE KEY UPDATE role_title=VALUES(role_title), description=VALUES(description);

-- 4. Master Skills (25 Core Skills across 5 Categories)
INSERT INTO skills (skill_id, skill_name, category, description) VALUES
(1, 'Java', 'PROGRAMMING_LANGUAGES', 'Core Java, OOP principles, Collections, Multithreading, Streams, and JVM fundamentals.'),
(2, 'Python', 'PROGRAMMING_LANGUAGES', 'Core Python programming, data structures, scripting, and OOP.'),
(3, 'JavaScript', 'PROGRAMMING_LANGUAGES', 'Modern ES6+ JavaScript, DOM manipulation, asynchronous programming, and events.'),
(4, 'C++', 'PROGRAMMING_LANGUAGES', 'C++ syntax, pointers, memory management, and Standard Template Library (STL).'),
(5, 'SQL', 'PROGRAMMING_LANGUAGES', 'Structured Query Language, complex joins, subqueries, grouping, and indexing.'),
(6, 'Servlets & JSP', 'FRAMEWORKS', 'Java EE / Jakarta EE web application fundamentals, MVC architecture, filters, and sessions.'),
(7, 'Spring Boot', 'FRAMEWORKS', 'Enterprise microservices, dependency injection, Spring MVC, Spring Data, and Spring Security.'),
(8, 'React.js', 'FRAMEWORKS', 'Modern component-driven UI library, React hooks, state management, and SPA architecture.'),
(9, 'HTML5 & CSS3', 'FRAMEWORKS', 'Semantic HTML5 markup, responsive CSS3 styling, Flexbox, CSS Grid, and Bootstrap.'),
(10, 'Node.js', 'FRAMEWORKS', 'Asynchronous JavaScript runtime, Express framework, and REST API development.'),
(11, 'RESTful APIs', 'FRAMEWORKS', 'REST architecture principles, JSON payloads, HTTP methods, status codes, and API security.'),
(12, 'MySQL', 'DATABASES', 'Relational database design, normalization, transactions, ACID properties, and MySQL optimization.'),
(13, 'PostgreSQL', 'DATABASES', 'Advanced open-source relational database, complex queries, JSONB, and indexing.'),
(14, 'MongoDB', 'DATABASES', 'NoSQL document database, aggregation pipelines, schema modeling, and indexing.'),
(15, 'Docker', 'DEV_TOOLS', 'Containerization, Dockerfile creation, image management, and multi-container Docker Compose.'),
(16, 'Git & GitHub', 'DEV_TOOLS', 'Version control workflows, branching, merging, pull requests, and collaborative Git practices.'),
(17, 'Linux/Bash', 'DEV_TOOLS', 'Linux command line, file system permissions, shell scripting, and server administration.'),
(18, 'AWS Core', 'DEV_TOOLS', 'Cloud infrastructure essentials including EC2, S3, RDS, IAM, and VPC fundamentals.'),
(19, 'CI/CD Pipelines', 'DEV_TOOLS', 'Continuous Integration & Continuous Deployment workflows (GitHub Actions, Jenkins).'),
(20, 'Data Structures & Algorithms', 'CORE_CS', 'Arrays, Linked Lists, Trees, Graphs, Sorting, Searching, and Dynamic Programming.'),
(21, 'OOP', 'CORE_CS', 'Object-Oriented Programming principles: Encapsulation, Inheritance, Polymorphism, Abstraction.'),
(22, 'DBMS', 'CORE_CS', 'Database Management System concepts, ER modeling, Normalization, Transactions, and Concurrency.'),
(23, 'Operating Systems', 'CORE_CS', 'Process management, threads, synchronization, deadlocks, memory management, and virtual memory.'),
(24, 'Computer Networks', 'CORE_CS', 'OSI model, TCP/IP protocols, routing, DNS, HTTP/HTTPS, sockets, and network security.'),
(25, 'Pandas & NumPy', 'CORE_CS', 'Data manipulation, vectorized operations, series, dataframes, and numerical computation in Python.')
ON DUPLICATE KEY UPDATE skill_name=VALUES(skill_name);

-- 5. Role Skill Requirements (Benchmark per Target Role)
-- Role 1: Java Backend Developer
INSERT INTO role_skill_requirements (role_id, skill_id, min_proficiency, is_mandatory) VALUES
(1, 1, 'ADVANCED', 1),       -- Java (ADVANCED)
(1, 6, 'INTERMEDIATE', 1),   -- Servlets & JSP (INTERMEDIATE)
(1, 7, 'INTERMEDIATE', 1),   -- Spring Boot (INTERMEDIATE)
(1, 5, 'INTERMEDIATE', 1),   -- SQL (INTERMEDIATE)
(1, 12, 'INTERMEDIATE', 1),  -- MySQL (INTERMEDIATE)
(1, 11, 'INTERMEDIATE', 1),  -- RESTful APIs (INTERMEDIATE)
(1, 20, 'INTERMEDIATE', 1),  -- DSA (INTERMEDIATE)
(1, 21, 'ADVANCED', 1),      -- OOP (ADVANCED)
(1, 22, 'INTERMEDIATE', 1),  -- DBMS (INTERMEDIATE)
(1, 16, 'BEGINNER', 1)       -- Git & GitHub (BEGINNER)
ON DUPLICATE KEY UPDATE min_proficiency=VALUES(min_proficiency);

-- Role 2: Full Stack Java Developer
INSERT INTO role_skill_requirements (role_id, skill_id, min_proficiency, is_mandatory) VALUES
(2, 1, 'INTERMEDIATE', 1),   -- Java
(2, 6, 'INTERMEDIATE', 1),   -- Servlets & JSP
(2, 8, 'INTERMEDIATE', 1),   -- React.js
(2, 9, 'INTERMEDIATE', 1),   -- HTML5 & CSS3
(2, 3, 'INTERMEDIATE', 1),   -- JavaScript
(2, 5, 'INTERMEDIATE', 1),   -- SQL
(2, 12, 'INTERMEDIATE', 1),  -- MySQL
(2, 11, 'INTERMEDIATE', 1),  -- RESTful APIs
(2, 20, 'INTERMEDIATE', 1),  -- DSA
(2, 16, 'INTERMEDIATE', 1)   -- Git & GitHub
ON DUPLICATE KEY UPDATE min_proficiency=VALUES(min_proficiency);

-- Role 3: Frontend Developer
INSERT INTO role_skill_requirements (role_id, skill_id, min_proficiency, is_mandatory) VALUES
(3, 3, 'ADVANCED', 1),       -- JavaScript
(3, 8, 'ADVANCED', 1),       -- React.js
(3, 9, 'ADVANCED', 1),       -- HTML5 & CSS3
(3, 11, 'INTERMEDIATE', 1),  -- RESTful APIs
(3, 16, 'INTERMEDIATE', 1),  -- Git & GitHub
(3, 20, 'BEGINNER', 1)       -- DSA
ON DUPLICATE KEY UPDATE min_proficiency=VALUES(min_proficiency);

-- Role 4: Python Backend Developer
INSERT INTO role_skill_requirements (role_id, skill_id, min_proficiency, is_mandatory) VALUES
(4, 2, 'ADVANCED', 1),       -- Python
(4, 11, 'INTERMEDIATE', 1),  -- RESTful APIs
(4, 5, 'INTERMEDIATE', 1),   -- SQL
(4, 13, 'INTERMEDIATE', 1),  -- PostgreSQL
(4, 20, 'INTERMEDIATE', 1),  -- DSA
(4, 21, 'ADVANCED', 1),      -- OOP
(4, 22, 'INTERMEDIATE', 1),  -- DBMS
(4, 16, 'BEGINNER', 1)       -- Git & GitHub
ON DUPLICATE KEY UPDATE min_proficiency=VALUES(min_proficiency);

-- Role 5: Data Analyst
INSERT INTO role_skill_requirements (role_id, skill_id, min_proficiency, is_mandatory) VALUES
(5, 2, 'INTERMEDIATE', 1),   -- Python
(5, 5, 'ADVANCED', 1),       -- SQL
(5, 25, 'ADVANCED', 1),      -- Pandas & NumPy
(5, 12, 'INTERMEDIATE', 1),  -- MySQL
(5, 22, 'INTERMEDIATE', 1),  -- DBMS
(5, 16, 'BEGINNER', 1)       -- Git & GitHub
ON DUPLICATE KEY UPDATE min_proficiency=VALUES(min_proficiency);

-- Role 6: Cloud/DevOps Engineer
INSERT INTO role_skill_requirements (role_id, skill_id, min_proficiency, is_mandatory) VALUES
(6, 15, 'ADVANCED', 1),      -- Docker
(6, 17, 'ADVANCED', 1),      -- Linux/Bash
(6, 18, 'INTERMEDIATE', 1),  -- AWS Core
(6, 19, 'INTERMEDIATE', 1),  -- CI/CD Pipelines
(6, 16, 'ADVANCED', 1),      -- Git & GitHub
(6, 24, 'INTERMEDIATE', 1)   -- Computer Networks
ON DUPLICATE KEY UPDATE min_proficiency=VALUES(min_proficiency);

-- 6. DSA Topics (18 Standard Core & Advanced Topics)
INSERT INTO dsa_topics (topic_id, topic_name, category) VALUES
(1, 'Array & Strings', 'CORE_DSA'),
(2, 'Two Pointers & Sliding Window', 'CORE_DSA'),
(3, 'Linked List', 'CORE_DSA'),
(4, 'Stack & Queue', 'CORE_DSA'),
(5, 'Recursion & Backtracking', 'CORE_DSA'),
(6, 'Binary Search', 'CORE_DSA'),
(7, 'Trees & Binary Search Trees', 'CORE_DSA'),
(8, 'Heaps & Priority Queues', 'CORE_DSA'),
(9, 'Graphs & Traversals (BFS/DFS)', 'CORE_DSA'),
(10, 'Dynamic Programming', 'ADVANCED_DSA'),
(11, 'Greedy Algorithms', 'CORE_DSA'),
(12, 'Bit Manipulation', 'CORE_DSA'),
(13, 'Trie (Prefix Tree)', 'ADVANCED_DSA'),
(14, 'Disjoint Set Union (DSU)', 'ADVANCED_DSA'),
(15, 'Shortest Paths (Dijkstra/Bellman-Ford)', 'ADVANCED_DSA'),
(16, 'Minimum Spanning Tree (Prim/Kruskal)', 'ADVANCED_DSA'),
(17, 'Top 150 Interview Questions', 'CORE_DSA'),
(18, 'System Design Basics (DSA-focused)', 'ADVANCED_DSA')
ON DUPLICATE KEY UPDATE topic_name=VALUES(topic_name);

-- 7. Placement Criteria Profiles (3 Pre-seeded Mock Criteria)
INSERT INTO placement_criteria (criteria_id, company_name, role_title, min_cgpa, min_dsa_problems, min_projects, min_certifications, allowed_departments, is_active) VALUES
(1, 'Tier-1 Product Company', 'Software Development Engineer (SDE-1)', 7.50, 150, 3, 1, 'CSE,IT,ECE', 1),
(2, 'High-Growth Startup', 'Full Stack Developer', 6.50, 80, 3, 1, 'CSE,IT,ECE,EEE', 1),
(3, 'Enterprise IT Services', 'Systems Engineer', 6.00, 40, 1, 1, 'ALL', 1)
ON DUPLICATE KEY UPDATE company_name=VALUES(company_name);

-- 8. Criteria Skill Requirements
-- Criteria 1: Tier-1 SDE-1
INSERT INTO criteria_skill_requirements (criteria_id, skill_id, min_proficiency, is_mandatory) VALUES
(1, 20, 'ADVANCED', 1),     -- DSA (ADVANCED)
(1, 1, 'INTERMEDIATE', 1),   -- Java (INTERMEDIATE)
(1, 21, 'ADVANCED', 1),      -- OOP (ADVANCED)
(1, 22, 'INTERMEDIATE', 1),  -- DBMS (INTERMEDIATE)
(1, 23, 'INTERMEDIATE', 1)   -- OS (INTERMEDIATE)
ON DUPLICATE KEY UPDATE min_proficiency=VALUES(min_proficiency);

-- Criteria 2: High-Growth Startup (Full Stack)
INSERT INTO criteria_skill_requirements (criteria_id, skill_id, min_proficiency, is_mandatory) VALUES
(2, 3, 'INTERMEDIATE', 1),   -- JavaScript
(2, 8, 'INTERMEDIATE', 1),   -- React.js
(2, 11, 'INTERMEDIATE', 1),  -- RESTful APIs
(2, 12, 'INTERMEDIATE', 1),  -- MySQL
(2, 16, 'INTERMEDIATE', 1)   -- Git & GitHub
ON DUPLICATE KEY UPDATE min_proficiency=VALUES(min_proficiency);

-- Criteria 3: Enterprise IT Services (Systems Engineer)
INSERT INTO criteria_skill_requirements (criteria_id, skill_id, min_proficiency, is_mandatory) VALUES
(3, 1, 'BEGINNER', 1),       -- Java
(3, 5, 'BEGINNER', 1),       -- SQL
(3, 21, 'BEGINNER', 1)       -- OOP
ON DUPLICATE KEY UPDATE min_proficiency=VALUES(min_proficiency);
