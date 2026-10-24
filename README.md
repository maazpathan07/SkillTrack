# SkillTrack — Student Skill, Career Preparation & Placement Readiness Management System

**SkillTrack** is an enterprise-grade placement intelligence and student readiness management system. Built using a robust Java EE (Servlet 3.1) architecture and pure MVC design patterns, it bridges the gap between campus academic curricula and industry hiring standards by empowering students to benchmark technical skills, showcase verified project portfolios, track algorithmic DSA progress, scan resumes with ATS intelligence, and leverage Generative AI career coaching.

---

## 🌟 Key Platform Capabilities

1. **Deterministic Readiness Scoring Engine**: Multi-factor algorithm balancing skill competencies, DSA problem counts, verified software projects, certifications, and preparation milestones.
2. **24/7 AI Placement Coach**: Powered by Google Gemini Generative AI (`GeminiAiClient.java`) with resilient multi-model failover, contextual student profile awareness, and interview preparation diagnostics.
3. **In-Browser Code Playground**: Interactive, zero-install algorithmic coding environment powered by Ace Editor supporting Java, Python, C++, and JavaScript with pre-populated starter code structures and instant client-side execution.
4. **Live Code Platform Synchronization**: Direct integration with **LeetCode GraphQL API** for automatic topic allocation across 18 DSA categories and **GitHub REST API** for verifiable repository project synchronization.
5. **Ivy-League ATS Resume Builder & Diagnostic Scanner**: Single-column ATS-compliant resume generator and diagnostic scanner evaluating keyword density, action verbs, and company cutoff alignment.
6. **Multi-Provider OAuth 2.0 Authentication**: Seamless single sign-on (SSO) via Google, GitHub, and LinkedIn alongside secure PBKDF2 password authentication.
7. **TPO Enterprise Drive Shortlisting Simulator**: Campus Training & Placement Officer (TPO) dashboard with dynamic criteria filtering (CGPA, Backlogs, DSA benchmarks, core skills) and CSV/XLS cohort exports.
8. **Tamper-Evident Placement Passport (`/passport/{hash}`)**: Publicly shareable, cryptographically hashed student credentials for one-click verification by enterprise recruiters.

---

## 🏗️ System Architecture & Tech Stack

- **Architecture:** Layered MVC + Service Layer + DAO Layer (`com.skilltrack.*`)
- **IDE:** NetBeans IDE 8.2 (Standard Ant-based Web Project, zero external build tool required)
- **Runtime Environment:** Java JDK 8 (1.8 compliance)
- **Application Server:** Apache Tomcat 8.0.27 (Servlet 3.1 / Java EE 7, `javax.servlet.*` namespace)
- **Database:** MySQL 8.x (`com.mysql.cj.jdbc.Driver`)
- **View Layer:** JSP 2.3 + JSTL 1.2 + Unified Expression Language (`${...}`) with **zero Java scriptlets** (`<% ... %>`)
- **Styling & UI:** Apple iOS Glassmorphism, Bootstrap 4.6.2, jQuery 3.6.0, Chart.js 2.9.4, JetBrains Mono font, `@media print` A4 layouts
- **AI Engine:** Google Gemini Generative AI (HTTP REST client with fallback pipeline)
- **Security:** `PBKDF2WithHmacSHA256` password hashing (65,536 iterations, 16-byte random salt, 256-bit key), Session-bound anti-CSRF token verification, and session-derived student data ownership (IDOR defense).

---

## 📁 Repository Directory Structure

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
│   ├── schema.sql                      # 15+ tables, constraints, indexes & full seed data
│   ├── database.properties.example
│   └── README.md
├── src/
│   └── java/
│       ├── database.properties         # Active database connection credentials
│       └── com/skilltrack/
│           ├── config/                 # DBConnection, AppConfig & OAuthConfig
│           ├── constants/              # Enums (UserRole, SkillLevel, OAuthProvider, Department, etc.)
│           ├── models/                 # Domain POJOs (Student, TargetRole, Project, Certification, etc.)
│           ├── dto/                    # View and Data Transfer Objects (StudentProfileDTO, ReadinessDTO)
│           ├── dao/                    # Parameterized JDBC DAOs with connection pooling
│           ├── services/               # Authoritative Business & Scoring Engines
│           │   ├── ReadinessScoreService.java      # Deterministic 0-100 placement scoring
│           │   ├── SkillGapService.java            # Target role benchmark gap analysis
│           │   ├── AiPlacementCoachService.java    # Gemini AI integration engine
│           │   ├── AtsScannerService.java          # Keyword & layout ATS scoring
│           │   ├── CodePlatformSyncService.java    # LeetCode GraphQL & GitHub REST sync
│           │   ├── PlacementCriteriaService.java   # TPO eligibility verification
│           │   └── OAuthService.java               # Google, GitHub & LinkedIn OAuth 2.0
│           ├── controllers/            # Thin HTTP Servlets (Post/Redirect/Get pattern)
│           ├── filters/                # CharacterEncoding, Authentication, Role, CSRF defense
│           └── utils/                  # PasswordUtil (PBKDF2), GeminiAiClient, OAuthHttpClient, CsrfUtil
└── web/
    ├── index.jsp                       # Public landing page with showcase engines
    ├── assets/
    │   ├── css/                        # Apple glassmorphic UI, custom-style.css, playground styles
    │   └── js/                         # jQuery 3.6.0, Bootstrap bundle, Chart.js, Ace editor, app-validation.js
    └── WEB-INF/
        ├── web.xml                     # Servlet 3.1 web deployment descriptor
        ├── lib/                        # Genuine binary JAR dependencies (JSTL, MySQL Driver, Servlet API)
        └── views/                      # Protected JSP presentation templates
            ├── common/                 # Header, Navbar, Footer, Draggable AI Coach widget, Alerts
            ├── auth/                   # login.jsp, register.jsp with OAuth SSO buttons
            ├── student/                # Dashboard, Profile, Skills, Projects, Certifications, DSA Tracker,
            │                           # Code Playground, Dream Job Matcher, ATS Scanner, Readiness Card
            └── admin/                  # Dashboard, Student Directory, Criteria, Roles, Drive Shortlisting
```

---

## 🚀 Quick Start & Setup Instructions

### Step 1: Database Initialization
1. Ensure **MySQL Server 8.0+** is installed and running on port `3306`.
2. Open MySQL Workbench or terminal and execute:
   ```sql
   SOURCE C:/path/to/SkillTrack/database/schema.sql;
   ```
   *(Initializes `skilltrack_db` with all tables, foreign keys, indexes, target roles, 25+ skills, 18 DSA topics, placement criteria, and admin account).*

### Step 2: Database & API Credentials Configuration
Verify and update `src/java/database.properties`:
```properties
db.driver=com.mysql.cj.jdbc.Driver
db.url=jdbc:mysql://localhost:3306/skilltrack_db?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true&characterEncoding=UTF-8
db.username=root
db.password=YOUR_MYSQL_PASSWORD
```

*(Optional)* Configure Google Gemini API key or OAuth Client IDs in application environment or properties:
```properties
gemini.api.key=YOUR_GEMINI_API_KEY
```

### Step 3: Run in NetBeans IDE 8.2 / Apache Tomcat
1. Launch **NetBeans IDE 8.2**.
2. Navigate to **File $\to$ Open Project...** and select the `SkillTrack` folder.
3. Verify that **Apache Tomcat 8.0.27** is configured under **Tools $\to$ Servers**.
4. Right-click the project node and select **Clean and Build**.
5. Press **Run** (or `F6`).
6. The application will deploy and open at:
   ```text
   http://localhost:8080/SkillTrack/
   ```

---

## 🔐 Default Credentials

| Role | Email | Password | Access / Capabilities |
|---|---|---|---|
| **Administrator (TPO)** | `admin@skilltrack.com` | `Admin@123` | Full access to Student Directory, Taxonomy, Criteria, Drive Shortlisting & Exports |
| **Student** | Self-register via `/register` or OAuth SSO | Chosen by user | Academic Profile, Portfolio, DSA Tracker, Code Playground, ATS Scanner & Passport |

---

## 📊 Authoritative Scoring Engines

### A. Overall Placement Readiness Index Formula
Implemented strictly in [`ReadinessScoreService.java`](src/java/com/skilltrack/services/ReadinessScoreService.java):
$$\text{Readiness Index} = (w_S \times S) + (w_D \times D) + (w_P \times P) + (w_C \times C) + (w_T \times T)$$

- **Dynamic Configurable Weights & Benchmarks**:
  - $w_S = 0.35$ (Skills Match: $S = \min(100, \text{matched} / \text{totalRequired} \times 100)$)
  - $w_D = 0.25$ (DSA Solved: $D = \min(100, \text{solved} / 150 \times 100)$)
  - $w_P = 0.20$ (Projects: $P = \min(100, \text{completed} / 3 \times 100)$)
  - $w_C = 0.10$ (Certifications: $C = \min(100, \text{verified} / 2 \times 100)$)
  - $w_T = 0.10$ (Preparation Tasks: $T = \text{completed} / \text{total} \times 100$)

### B. Skill Gap Benchmark Classification
Implemented strictly in [`SkillGapService.java`](src/java/com/skilltrack/services/SkillGapService.java):
- **`MATCHED`**: $\text{Student Skill Level} \ge \text{Target Role Required Level}$
- **`NEEDS_IMPROVEMENT`**: Student has added the skill, but level is below target benchmark.
- **`MISSING`**: Student has not acquired or declared this required skill.

### C. Non-Predictive Placement Criteria Evaluation
Implemented strictly in [`PlacementCriteriaService.java`](src/java/com/skilltrack/services/PlacementCriteriaService.java):
- Computes deterministic eligibility against CGPA cutoffs, backlogs, department filters, minimum DSA problems, and mandatory frameworks.
- Generates transparent self-assessment statuses: `MEETS_REQUIREMENT`, `NEEDS_IMPROVEMENT`, or `DOES_NOT_MEET_REQUIREMENT`.

---

## 🛡️ Enterprise Security & Quality Assurance

- [x] **Zero Java Scriptlets**: 100% pure JSTL 1.2 and Expression Language (`${...}`) across all protected view templates.
- [x] **Cryptographic Password Security**: PBKDF2 with HMAC-SHA256 (65,536 iterations and cryptographically random salt).
- [x] **Anti-CSRF Verification**: Session-bound cryptographically generated tokens verified on state-changing requests.
- [x] **Anti-IDOR Protection**: All student data modifications are strictly derived from the validated HTTP session user ID.
- [x] **Input Sanitization & Output Encoding**: Protection against XSS and SQL Injection via parameterized JDBC queries.
- [x] **Print-Ready Documents**: `@media print` A4 layouts for Student Placement Passports and Cohort Analytics Reports.
