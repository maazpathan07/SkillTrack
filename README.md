# SkillTrack — Student Skill, Career Preparation & Placement Readiness Management System

**SkillTrack** is an enterprise-grade, student skill assessment and placement readiness management system. It enables students to track technical skills, portfolio projects, verified certifications, Data Structures & Algorithms (DSA) problem solving, and actionable preparation tasks against configurable industry target role benchmarks.

---

## 1. System Architecture & Tech Stack

- **Architecture:** Layered MVC + Service Layer + DAO Layer (`com.skilltrack.*`)
- **IDE:** NetBeans IDE 8.2 (Standard Ant-based Web Project, no Maven required)
- **Runtime Environment:** Java JDK 8 (1.8 compliance)
- **Application Server:** Apache Tomcat 8.0.27 (Servlet 3.1 / Java EE 7, `javax.servlet.*` namespace)
- **Database:** MySQL 8.x (`com.mysql.cj.jdbc.Driver`)
- **View Layer:** JSP + JSTL 1.2 + Expression Language (`${...}`) with **zero Java scriptlets** (`<% ... %>`)
- **Frontend / Styling:** Bootstrap 4.6.2, jQuery 3.6.0, Chart.js 2.9.4, Custom CSS, `@media print` A4 layouts
- **Security:** `PBKDF2WithHmacSHA256` password hashing (65,536 iterations, 16-byte random salt, 256-bit key), Session-bound anti-CSRF token verification, and session-derived student data ownership (IDOR defense).

---

## 2. Directory Structure

```text
SkillTrack/
├── build.xml                           # Root NetBeans Ant build script
├── README.md                           # Master setup and execution guide
├── nbproject/                          # NetBeans 8.2 project metadata & properties
│   ├── project.xml
│   ├── project.properties
│   ├── build-impl.xml
│   └── genfiles.properties
├── database/                           # MySQL 8 database schema & configuration templates
│   ├── schema.sql                      # 15 tables, constraints, indexes & full seed data
│   ├── database.properties.example
│   └── README.md
├── src/
│   └── java/
│       ├── database.properties         # Active database connection credentials
│       └── com/skilltrack/
│           ├── config/                 # DBConnection & AppConfig
│           ├── constants/              # Enums (UserRole, SkillLevel, TaskStatus, etc.)
│           ├── models/                 # 15 Domain POJOs
│           ├── dto/                    # 10 View and Data Transfer Objects
│           ├── dao/                    # 12 Parameterized JDBC DAOs
│           ├── services/               # Authoritative Business & Scoring Engines
│           ├── controllers/            # Thin HTTP Servlets (Post/Redirect/Get)
│           ├── filters/                # CharacterEncoding, Authentication, Role, CSRF
│           └── utils/                  # PasswordUtil (PBKDF2), Validation, Date, Url, Session
└── web/
    ├── index.jsp                       # Entry router
    ├── assets/
    │   ├── css/                        # Bootstrap 4.6.2, custom-style.css, readiness-card.css
    │   └── js/                         # jQuery 3.6.0, Bootstrap bundle, Chart.js, app-validation.js
    └── WEB-INF/
        ├── web.xml                     # Servlet 3.1 web deployment descriptor
        ├── lib/                        # Genuine binary JAR dependencies
        │   ├── jstl-1.2.jar
        │   ├── mysql-connector-java-8.0.28.jar
        │   ├── javax.servlet-api-3.1.0.jar
        │   └── javax.servlet.jsp-api-2.3.1.jar
        └── views/                      # Protected JSP presentation templates
            ├── common/                 # Header, Navbar, Sidebar, Footer, Alerts, Pagination, Errors
            ├── auth/                   # login.jsp, register.jsp
            ├── student/                # dashboard, profile, skills, projects, certs, dsa, tasks, skill-gap, criteria, readiness-card
            └── admin/                  # dashboard, students directory, student detail, roles, skills, criteria, cohort export
```

---

## 3. Quick Start & Setup Instructions

### Step 1: Database Initialization
1. Ensure **MySQL Server 8.0+** is running.
2. Open your MySQL client / MySQL Workbench and execute the script:
   ```sql
   SOURCE /path/to/SkillTrack/database/schema.sql;
   ```
   *(Creates `skilltrack_db` with all 15 tables, foreign keys, indexes, target roles, 25 skills, 18 DSA topics, placement criteria, and the initial admin).*

### Step 2: Database Connection Configuration
Check `src/java/database.properties` and update your local MySQL password if set:
```properties
db.driver=com.mysql.cj.jdbc.Driver
db.url=jdbc:mysql://localhost:3306/skilltrack_db?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true&characterEncoding=UTF-8
db.username=root
db.password=YOUR_MYSQL_PASSWORD
```

### Step 3: Open and Run in NetBeans IDE 8.2
1. Launch **NetBeans IDE 8.2**.
2. Go to **File $\to$ Open Project...** and select the `SkillTrack` directory.
3. Ensure **Apache Tomcat 8.0.27** is configured in **Tools $\to$ Servers**.
4. Right-click the `SkillTrack` project node and select **Clean and Build**.
5. Right-click the project and select **Run** (or press `F6`).
6. The application will deploy and open in your default browser at `http://localhost:8080/SkillTrack/`.

---

## 4. Default Login Credentials

| Role | Email | Password | Pre-configured Data |
|---|---|---|---|
| **Administrator** | `admin@skilltrack.com` | `Admin@123` | Master Taxonomy, Roles, Placement Criteria, Cohort Analytics |
| **New Student** | Self-register via `/register` | User chosen | Full access to Academic Profile, Portfolio, DSA Tracker, Skill Gap & Readiness Card |

---

## 5. Authoritative Business Logic & Engines

### A. Overall Placement Readiness Index Formula
Implemented strictly in [`ReadinessScoreService.java`](file:///c:/Users/91816/OneDrive/Desktop/SkillTrack/src/java/com/skilltrack/services/ReadinessScoreService.java):
$$\text{Readiness Index} = (w_S \times S) + (w_D \times D) + (w_P \times P) + (w_C \times C) + (w_T \times T)$$
- **Weights & Benchmarks** (dynamically loaded from `APP_SETTINGS` table):
  - $w_S = 0.35$ (Skills Match: $S = \min(100, \text{matched} / \text{totalRequired} \times 100)$)
  - $w_D = 0.25$ (DSA Solved: $D = \min(100, \text{solved} / 150 \times 100)$)
  - $w_P = 0.20$ (Projects: $P = \min(100, \text{completed} / 3 \times 100)$)
  - $w_C = 0.10$ (Certifications: $C = \min(100, \text{verified} / 2 \times 100)$)
  - $w_T = 0.10$ (Preparation Tasks: $T = \text{completed} / \text{total} \times 100$)

### B. Role Skill Gap Classification
Implemented strictly in [`SkillGapService.java`](file:///c:/Users/91816/OneDrive/Desktop/SkillTrack/src/java/com/skilltrack/services/SkillGapService.java):
- **`MATCHED`**: $\text{Student Level} \ge \text{Role Required Level}$ ($\text{ADVANCED (3)} > \text{INTERMEDIATE (2)} > \text{BEGINNER (1)}$)
- **`NEEDS_IMPROVEMENT`**: Student possesses the skill, but level is below benchmark.
- **`MISSING`**: Student has not added the skill to their profile.

### C. Non-Predictive Placement Criteria Evaluation
Implemented strictly in [`PlacementCriteriaService.java`](file:///c:/Users/91816/OneDrive/Desktop/SkillTrack/src/java/com/skilltrack/services/PlacementCriteriaService.java):
- Evaluates eligibility against CGPA, Department branch, DSA count, Projects, Certifications, and specific Skill requirements.
- Returns deterministic self-assessment statuses (`MEETS_REQUIREMENT`, `NEEDS_IMPROVEMENT`, `DOES_NOT_MEET_REQUIREMENT`).

---

## 6. Verification & Testing Checklist

- [x] Java 8 (1.8) compilation verified with zero errors.
- [x] Apache Tomcat 8.0.27 / Servlet 3.1 (`javax.servlet.*`) runtime compatibility.
- [x] MySQL 8.x schema with foreign keys, indexes, and full seed data.
- [x] Genuine binary dependencies in `web/WEB-INF/lib/`.
- [x] Thin controllers, Post/Redirect/Get pattern on all forms.
- [x] Zero Java scriptlets in JSPs (pure JSTL 1.2 and Expression Language).
- [x] Anti-CSRF token verification and `AuthenticationFilter` / `RoleFilter` access control.
- [x] Printable `@media print` A4 layouts for Readiness Profile Card and Cohort Report.
