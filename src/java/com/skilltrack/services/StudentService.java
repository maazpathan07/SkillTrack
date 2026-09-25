package com.skilltrack.services;

import com.skilltrack.constants.SkillLevel;
import com.skilltrack.constants.TaskStatus;
import com.skilltrack.dao.CertificationDAO;
import com.skilltrack.dao.DsaProgressDAO;
import com.skilltrack.dao.ProjectDAO;
import com.skilltrack.dao.SkillDAO;
import com.skilltrack.dao.StudentDAO;
import com.skilltrack.dao.TaskDAO;
import com.skilltrack.dto.StudentProfileDTO;
import com.skilltrack.models.Certification;
import com.skilltrack.models.PreparationTask;
import com.skilltrack.models.Project;
import com.skilltrack.models.Student;
import com.skilltrack.models.StudentDsaProgress;
import com.skilltrack.models.StudentSkill;
import com.skilltrack.utils.UrlUtil;
import com.skilltrack.utils.ValidationUtil;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class StudentService {

    private static final Logger LOGGER = Logger.getLogger(StudentService.class.getName());

    private final StudentDAO studentDAO;
    private final SkillDAO skillDAO;
    private final ProjectDAO projectDAO;
    private final CertificationDAO certificationDAO;
    private final DsaProgressDAO dsaProgressDAO;
    private final TaskDAO taskDAO;
    private final com.skilltrack.dao.CodingProfileDAO codingProfileDAO;

    public StudentService() {
        this.studentDAO = new StudentDAO();
        this.skillDAO = new SkillDAO();
        this.projectDAO = new ProjectDAO();
        this.certificationDAO = new CertificationDAO();
        this.dsaProgressDAO = new DsaProgressDAO();
        this.taskDAO = new TaskDAO();
        this.codingProfileDAO = new com.skilltrack.dao.CodingProfileDAO();
    }

    public Student getStudentById(int studentId) {
        try {
            return studentDAO.findById(studentId);
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching student by ID: " + studentId, e);
            return null;
        }
    }

    public StudentProfileDTO getStudentProfile(int studentId) {
        try {
            Student student = studentDAO.findById(studentId);
            if (student == null) return null;

            StudentProfileDTO profile = new StudentProfileDTO();
            profile.setStudent(student);
            profile.setSkills(skillDAO.findByStudentId(studentId));
            profile.setProjects(projectDAO.findByStudentId(studentId));
            profile.setCertifications(certificationDAO.findByStudentId(studentId));
            profile.setDsaProgressList(dsaProgressDAO.getStudentDsaProgress(studentId));
            profile.setTotalDsaProblemsSolved(dsaProgressDAO.getTotalProblemsSolved(studentId));
            profile.setCodingProfile(codingProfileDAO.findByStudentId(studentId));

            return profile;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error constructing student profile for ID: " + studentId, e);
            return null;
        }
    }

    public boolean updateProfile(int studentId, String fullName, String rollNumber, String department, int gradYear, double cgpa, Integer targetRoleId) throws IllegalArgumentException, SQLException {
        if (!ValidationUtil.isNotEmpty(fullName)) {
            throw new IllegalArgumentException("Full Name cannot be empty.");
        }
        if (!ValidationUtil.isValidRollNumber(rollNumber)) {
            throw new IllegalArgumentException("Valid Roll Number is required.");
        }
        if (!ValidationUtil.isNotEmpty(department)) {
            throw new IllegalArgumentException("Department is required.");
        }
        if (!ValidationUtil.isValidGraduationYear(gradYear)) {
            throw new IllegalArgumentException("Graduation year must be between 2000 and 2040.");
        }
        if (!ValidationUtil.isValidCgpa(cgpa)) {
            throw new IllegalArgumentException("CGPA must be between 0.00 and 10.00.");
        }

        if (studentDAO.rollNumberExists(rollNumber, studentId)) {
            throw new IllegalArgumentException("Roll number already in use by another student.");
        }

        Student student = studentDAO.findById(studentId);
        if (student == null) {
            throw new IllegalArgumentException("Student not found.");
        }

        student.setFullName(fullName.trim());
        student.setRollNumber(rollNumber.trim().toUpperCase());
        student.setDepartment(department.trim());
        student.setGraduationYear(gradYear);
        student.setCgpa(cgpa);
        student.setTargetRoleId(targetRoleId != null && targetRoleId > 0 ? targetRoleId : null);

        return studentDAO.updateProfile(student);
    }

    public boolean updateTargetRole(int studentId, Integer targetRoleId) throws SQLException {
        return studentDAO.updateTargetRole(studentId, targetRoleId);
    }

    // --- Skills Management ---
    public List<StudentSkill> getStudentSkills(int studentId) throws SQLException {
        return skillDAO.findByStudentId(studentId);
    }

    public boolean addOrUpdateSkill(int studentId, int skillId, SkillLevel level) throws SQLException {
        if (skillId <= 0 || level == null) {
            throw new IllegalArgumentException("Valid skill and proficiency level are required.");
        }
        return skillDAO.upsertStudentSkill(studentId, skillId, level);
    }

    public boolean deleteSkill(int studentId, int skillId) throws SQLException {
        return skillDAO.deleteStudentSkill(studentId, skillId);
    }

    // --- Projects Management ---
    public List<Project> getStudentProjects(int studentId) throws SQLException {
        return projectDAO.findByStudentId(studentId);
    }

    public Project getProject(int studentId, int projectId) throws SQLException {
        return projectDAO.findById(projectId, studentId);
    }

    public int addProject(int studentId, String title, String description, String techStack, String githubUrl, String liveDemoUrl) throws IllegalArgumentException, SQLException {
        if (!ValidationUtil.isNotEmpty(title)) {
            throw new IllegalArgumentException("Project title is required.");
        }
        if (!ValidationUtil.isNotEmpty(description)) {
            throw new IllegalArgumentException("Project description is required.");
        }
        if (!ValidationUtil.isNotEmpty(techStack)) {
            throw new IllegalArgumentException("Tech stack is required.");
        }

        Project p = new Project();
        p.setStudentId(studentId);
        p.setTitle(title.trim());
        p.setDescription(description.trim());
        p.setTechStack(techStack.trim());
        p.setGithubUrl(UrlUtil.sanitizeUrl(githubUrl));
        p.setLiveDemoUrl(UrlUtil.sanitizeUrl(liveDemoUrl));

        return projectDAO.createProject(p);
    }

    public boolean updateProject(int studentId, int projectId, String title, String description, String techStack, String githubUrl, String liveDemoUrl) throws IllegalArgumentException, SQLException {
        if (!ValidationUtil.isNotEmpty(title)) {
            throw new IllegalArgumentException("Project title is required.");
        }
        if (!ValidationUtil.isNotEmpty(description)) {
            throw new IllegalArgumentException("Project description is required.");
        }
        if (!ValidationUtil.isNotEmpty(techStack)) {
            throw new IllegalArgumentException("Tech stack is required.");
        }

        Project p = new Project();
        p.setProjectId(projectId);
        p.setStudentId(studentId);
        p.setTitle(title.trim());
        p.setDescription(description.trim());
        p.setTechStack(techStack.trim());
        p.setGithubUrl(UrlUtil.sanitizeUrl(githubUrl));
        p.setLiveDemoUrl(UrlUtil.sanitizeUrl(liveDemoUrl));

        return projectDAO.updateProject(p);
    }

    public boolean deleteProject(int studentId, int projectId) throws SQLException {
        return projectDAO.deleteProject(projectId, studentId);
    }

    // --- Certifications Management ---
    public List<Certification> getStudentCertifications(int studentId) throws SQLException {
        return certificationDAO.findByStudentId(studentId);
    }

    public Certification getCertification(int studentId, int certId) throws SQLException {
        return certificationDAO.findById(certId, studentId);
    }

    public int addCertification(int studentId, String title, String issuingOrg, LocalDate issueDate, String credentialUrl) throws IllegalArgumentException, SQLException {
        if (!ValidationUtil.isNotEmpty(title)) {
            throw new IllegalArgumentException("Certification title is required.");
        }
        if (!ValidationUtil.isNotEmpty(issuingOrg)) {
            throw new IllegalArgumentException("Issuing organization is required.");
        }
        if (issueDate == null) {
            throw new IllegalArgumentException("Issue date is required.");
        }

        Certification c = new Certification();
        c.setStudentId(studentId);
        c.setTitle(title.trim());
        c.setIssuingOrg(issuingOrg.trim());
        c.setIssueDate(issueDate);
        c.setCredentialUrl(UrlUtil.sanitizeUrl(credentialUrl));

        return certificationDAO.createCertification(c);
    }

    public boolean updateCertification(int studentId, int certId, String title, String issuingOrg, LocalDate issueDate, String credentialUrl) throws IllegalArgumentException, SQLException {
        if (!ValidationUtil.isNotEmpty(title)) {
            throw new IllegalArgumentException("Certification title is required.");
        }
        if (!ValidationUtil.isNotEmpty(issuingOrg)) {
            throw new IllegalArgumentException("Issuing organization is required.");
        }
        if (issueDate == null) {
            throw new IllegalArgumentException("Issue date is required.");
        }

        Certification c = new Certification();
        c.setCertId(certId);
        c.setStudentId(studentId);
        c.setTitle(title.trim());
        c.setIssuingOrg(issuingOrg.trim());
        c.setIssueDate(issueDate);
        c.setCredentialUrl(UrlUtil.sanitizeUrl(credentialUrl));

        return certificationDAO.updateCertification(c);
    }

    public boolean deleteCertification(int studentId, int certId) throws SQLException {
        return certificationDAO.deleteCertification(certId, studentId);
    }

    // --- DSA Progress Management ---
    public List<StudentDsaProgress> getStudentDsaProgress(int studentId) throws SQLException {
        return dsaProgressDAO.getStudentDsaProgress(studentId);
    }

    public List<StudentDsaProgress> getDsaProgress(int studentId) throws SQLException {
        return getStudentDsaProgress(studentId);
    }

    public boolean updateDsaProgress(int studentId, int topicId, String status, int problemsSolved, String notes) throws SQLException {
        return dsaProgressDAO.upsertProgress(studentId, topicId, status, problemsSolved, notes);
    }

    // --- Tasks Management ---
    public List<PreparationTask> getStudentTasks(int studentId) throws SQLException {
        return taskDAO.findByStudentId(studentId);
    }

    public PreparationTask getTask(int studentId, int taskId) throws SQLException {
        return taskDAO.findById(taskId, studentId);
    }

    public int addTask(int studentId, String title, String description, LocalDate targetDate) throws IllegalArgumentException, SQLException {
        if (!ValidationUtil.isNotEmpty(title)) {
            throw new IllegalArgumentException("Task title is required.");
        }

        PreparationTask task = new PreparationTask();
        task.setStudentId(studentId);
        task.setTitle(title.trim());
        task.setDescription(description != null ? description.trim() : null);
        task.setStatus(TaskStatus.PENDING);
        task.setTargetDate(targetDate);

        return taskDAO.createTask(task);
    }

    public boolean updateTask(int studentId, int taskId, String title, String description, TaskStatus status, LocalDate targetDate) throws IllegalArgumentException, SQLException {
        if (!ValidationUtil.isNotEmpty(title)) {
            throw new IllegalArgumentException("Task title is required.");
        }

        PreparationTask task = new PreparationTask();
        task.setTaskId(taskId);
        task.setStudentId(studentId);
        task.setTitle(title.trim());
        task.setDescription(description != null ? description.trim() : null);
        task.setStatus(status != null ? status : TaskStatus.PENDING);
        task.setTargetDate(targetDate);

        return taskDAO.updateTask(task);
    }

    public boolean updateTaskStatus(int studentId, int taskId, TaskStatus status) throws SQLException {
        return taskDAO.updateStatus(taskId, studentId, status);
    }

    public boolean deleteTask(int studentId, int taskId) throws SQLException {
        return taskDAO.deleteTask(taskId, studentId);
    }

    public boolean updateProfileImage(int studentId, String profileImage) throws SQLException {
        return studentDAO.updateProfileImage(studentId, profileImage);
    }
}
