package com.skilltrack.services;

import com.skilltrack.dao.CodingProfileDAO;
import com.skilltrack.dao.DsaProgressDAO;
import com.skilltrack.dao.ProjectDAO;
import com.skilltrack.dto.CodingProfileSyncDTO;
import com.skilltrack.models.DsaTopic;
import com.skilltrack.models.Project;
import com.skilltrack.models.StudentCodingProfile;
import com.skilltrack.utils.SimpleJsonParser;
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class CodePlatformSyncService {

    private static final Logger LOGGER = Logger.getLogger(CodePlatformSyncService.class.getName());
    private static final DateTimeFormatter TIME_FORMAT = DateTimeFormatter.ofPattern("MMM dd, yyyy HH:mm");

    private final CodingProfileDAO codingProfileDAO;
    private final DsaProgressDAO dsaProgressDAO;
    private final ProjectDAO projectDAO;

    public CodePlatformSyncService() {
        this.codingProfileDAO = new CodingProfileDAO();
        this.dsaProgressDAO = new DsaProgressDAO();
        this.projectDAO = new ProjectDAO();
    }

    public CodePlatformSyncService(CodingProfileDAO codingProfileDAO, DsaProgressDAO dsaProgressDAO, ProjectDAO projectDAO) {
        this.codingProfileDAO = codingProfileDAO;
        this.dsaProgressDAO = dsaProgressDAO;
        this.projectDAO = (projectDAO != null) ? projectDAO : new ProjectDAO();
    }

    public StudentCodingProfile getStudentCodingProfile(int studentId) {
        try {
            return codingProfileDAO.findByStudentId(studentId);
        } catch (SQLException e) {
            LOGGER.log(Level.WARNING, "Error fetching coding profile for student " + studentId, e);
            return null;
        }
    }

    public CodingProfileSyncDTO syncPlatforms(int studentId, String leetcodeUser, String githubUser, boolean autoDistributeDsa) {
        CodingProfileSyncDTO result = new CodingProfileSyncDTO();
        result.setSuccess(true);

        StudentCodingProfile profile = null;
        try {
            profile = codingProfileDAO.findByStudentId(studentId);
        } catch (SQLException e) {
            LOGGER.log(Level.WARNING, "Could not load existing profile", e);
        }

        if (profile == null) {
            profile = new StudentCodingProfile();
            profile.setStudentId(studentId);
        }

        StringBuilder statusMsg = new StringBuilder();

        // 1. Sync LeetCode
        if (leetcodeUser != null && !leetcodeUser.trim().isEmpty()) {
            String cleanLc = leetcodeUser.trim();
            result.setLeetcodeUsername(cleanLc);
            boolean lcSuccess = fetchAndPopulateLeetCode(cleanLc, profile, result);
            if (lcSuccess) {
                profile.setLeetcodeUsername(cleanLc);
                profile.setLeetcodeSyncedAt(LocalDateTime.now());
                statusMsg.append("LeetCode synced (").append(result.getTotalSolved()).append(" solved). ");

                if (autoDistributeDsa && result.getTotalSolved() > 0) {
                    distributeLeetCodeToDsaTopics(studentId, result.getTotalSolved(), result.getEasySolved(), result.getMediumSolved(), result.getHardSolved());
                }
            } else {
                result.setSuccess(false);
                statusMsg.append("LeetCode account '").append(cleanLc).append("' not found on leetcode.com. Please check your username from your LeetCode profile URL (e.g. leetcode.com/your_username). ");
            }
        }

        // 2. Sync GitHub
        if (githubUser != null && !githubUser.trim().isEmpty()) {
            String cleanGh = githubUser.trim();
            result.setGithubUsername(cleanGh);
            boolean ghSuccess = fetchAndPopulateGitHub(cleanGh, profile, result);
            if (ghSuccess) {
                profile.setGithubUsername(cleanGh);
                profile.setGithubSyncedAt(LocalDateTime.now());
                int imported = fetchAndSyncGitHubRepositories(studentId, cleanGh);
                if (imported > 0) {
                    statusMsg.append("GitHub profile synced & ").append(imported).append(" public repository projects automatically added to your portfolio!");
                } else {
                    statusMsg.append("GitHub profile synced (").append(result.getPublicRepos()).append(" public repos).");
                }
            } else {
                result.setSuccess(false);
                statusMsg.append("GitHub account '").append(cleanGh).append("' not found on github.com.");
            }
        }

        // 3. Save to Database
        try {
            codingProfileDAO.saveOrUpdate(profile);
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error saving coding profile for student " + studentId, e);
            result.setSuccess(false);
            result.setMessage("Database error saving synced profile.");
            return result;
        }

        result.setMessage(statusMsg.toString().trim());
        return result;
    }

    private boolean fetchAndPopulateLeetCode(String username, StudentCodingProfile profile, CodingProfileSyncDTO dto) {
        try {
            URL url = new URL("https://leetcode.com/graphql");
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setConnectTimeout(8000);
            conn.setReadTimeout(8000);
            conn.setDoOutput(true);
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) SkillTrack/2.0");
            conn.setRequestProperty("Referer", "https://leetcode.com");

            String query = "{\"query\":\"query getUserProfile($username: String!) { matchedUser(username: $username) { username submitStats: submitStatsGlobal { acSubmissionNum { difficulty count } } profile { ranking } } }\",\"variables\":{\"username\":\"" + username + "\"}}";

            try (OutputStream os = conn.getOutputStream()) {
                os.write(query.getBytes(StandardCharsets.UTF_8));
                os.flush();
            }

            int code = conn.getResponseCode();
            if (code >= 200 && code < 400) {
                String responseBody = readStream(conn.getInputStream());
                if (responseBody.contains("\"matchedUser\":null") || responseBody.contains("That user does not exist")) {
                    dto.setLeetcodeValid(false);
                    return false;
                }

                int totalSolved = extractDifficultyCount(responseBody, "All");
                int easySolved = extractDifficultyCount(responseBody, "Easy");
                int mediumSolved = extractDifficultyCount(responseBody, "Medium");
                int hardSolved = extractDifficultyCount(responseBody, "Hard");
                int ranking = extractInt(responseBody, "ranking", 0);

                dto.setLeetcodeValid(true);
                dto.setTotalSolved(totalSolved);
                dto.setEasySolved(easySolved);
                dto.setMediumSolved(mediumSolved);
                dto.setHardSolved(hardSolved);
                dto.setRanking(ranking);
                dto.setLeetcodeSyncedTime(LocalDateTime.now().format(TIME_FORMAT));

                profile.setLeetcodeTotalSolved(totalSolved);
                profile.setLeetcodeEasySolved(easySolved);
                profile.setLeetcodeMediumSolved(mediumSolved);
                profile.setLeetcodeHardSolved(hardSolved);
                profile.setLeetcodeRanking(ranking);
                return true;
            } else {
                dto.setLeetcodeValid(false);
                return false;
            }
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Failed to fetch LeetCode profile for " + username, e);
            dto.setLeetcodeValid(false);
            return false;
        }
    }

    private boolean fetchAndPopulateGitHub(String username, StudentCodingProfile profile, CodingProfileSyncDTO dto) {
        try {
            URL url = new URL("https://api.github.com/users/" + username);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setConnectTimeout(8000);
            conn.setReadTimeout(8000);
            conn.setRequestProperty("Accept", "application/json");
            conn.setRequestProperty("User-Agent", "SkillTrack-Platform-Sync/1.0");

            int code = conn.getResponseCode();
            if (code >= 200 && code < 400) {
                String body = readStream(conn.getInputStream());

                int publicRepos = extractInt(body, "public_repos", 0);
                int followers = extractInt(body, "followers", 0);
                String bio = SimpleJsonParser.getString(body, "bio");
                String avatarUrl = SimpleJsonParser.getString(body, "avatar_url");
                String htmlUrl = SimpleJsonParser.getString(body, "html_url");

                dto.setGithubValid(true);
                dto.setPublicRepos(publicRepos);
                dto.setFollowers(followers);
                dto.setGithubBio(bio != null ? bio : "");
                dto.setAvatarUrl(avatarUrl != null ? avatarUrl : "");
                dto.setProfileUrl(htmlUrl != null ? htmlUrl : "https://github.com/" + username);
                dto.setGithubSyncedTime(LocalDateTime.now().format(TIME_FORMAT));

                profile.setGithubReposCount(publicRepos);
                profile.setGithubFollowers(followers);
                profile.setGithubBio(bio);
                profile.setGithubAvatarUrl(avatarUrl);
                profile.setGithubProfileUrl(dto.getProfileUrl());
                return true;
            } else {
                dto.setGithubValid(false);
                return false;
            }
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Failed to fetch GitHub profile for " + username, e);
            dto.setGithubValid(false);
            return false;
        }
    }

    private void distributeLeetCodeToDsaTopics(int studentId, int totalSolved, int easy, int medium, int hard) {
        try {
            List<DsaTopic> topics = dsaProgressDAO.getAllTopics();
            if (topics == null || topics.isEmpty()) return;

            int topicCount = topics.size();
            int remaining = totalSolved;
            int perTopicBase = Math.max(1, totalSolved / topicCount);

            for (int i = 0; i < topicCount; i++) {
                DsaTopic t = topics.get(i);
                int countForTopic;
                if (i == topicCount - 1) {
                    countForTopic = remaining;
                } else {
                    countForTopic = Math.min(remaining, perTopicBase);
                    remaining -= countForTopic;
                }

                String status = (countForTopic >= 8) ? "COMPLETED" : (countForTopic > 0 ? "IN_PROGRESS" : "NOT_STARTED");
                dsaProgressDAO.upsertProgress(studentId, t.getTopicId(), status, countForTopic, "Auto-synced from LeetCode");
            }
        } catch (SQLException e) {
            LOGGER.log(Level.WARNING, "Error auto-distributing DSA topics for student " + studentId, e);
        }
    }

    private int extractDifficultyCount(String json, String difficulty) {
        Pattern pattern = Pattern.compile("\\{\"difficulty\":\"" + Pattern.quote(difficulty) + "\",\"count\":([0-9]+)");
        Matcher matcher = pattern.matcher(json);
        if (matcher.find()) {
            try {
                return Integer.parseInt(matcher.group(1));
            } catch (NumberFormatException e) {
                return 0;
            }
        }
        return 0;
    }

    private int extractInt(String json, String key, int defaultValue) {
        Pattern pattern = Pattern.compile("\"" + Pattern.quote(key) + "\"\\s*:\\s*([0-9]+)");
        Matcher matcher = pattern.matcher(json);
        if (matcher.find()) {
            try {
                return Integer.parseInt(matcher.group(1));
            } catch (NumberFormatException e) {
                return defaultValue;
            }
        }
        return defaultValue;
    }

    private int fetchAndSyncGitHubRepositories(int studentId, String username) {
        int importedCount = 0;
        try {
            URL url = new URL("https://api.github.com/users/" + username + "/repos?sort=updated&per_page=10");
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setConnectTimeout(8000);
            conn.setReadTimeout(8000);
            conn.setRequestProperty("Accept", "application/json");
            conn.setRequestProperty("User-Agent", "SkillTrack-Platform-Sync/1.0");

            int code = conn.getResponseCode();
            if (code >= 200 && code < 400) {
                String body = readStream(conn.getInputStream());
                List<Map<String, String>> repos = SimpleJsonParser.parseJsonArrayOfObjects(body);

                if (repos != null && !repos.isEmpty()) {
                    List<Project> existingProjects = projectDAO.findByStudentId(studentId);

                    for (Map<String, String> repo : repos) {
                        String name = repo.get("name");
                        if (name == null || name.trim().isEmpty()) continue;

                        String htmlUrl = repo.get("html_url");
                        if (htmlUrl == null || htmlUrl.trim().isEmpty()) {
                            htmlUrl = "https://github.com/" + username + "/" + name;
                        }

                        // Check if project with same URL or title already exists
                        boolean exists = false;
                        if (existingProjects != null) {
                            for (Project ep : existingProjects) {
                                if ((ep.getGithubUrl() != null && ep.getGithubUrl().equalsIgnoreCase(htmlUrl)) ||
                                    (ep.getTitle() != null && ep.getTitle().equalsIgnoreCase(name))) {
                                    exists = true;
                                    break;
                                }
                            }
                        }

                        if (!exists) {
                            String title = formatRepoTitle(name);
                            String rawDesc = repo.get("description");
                            String language = repo.get("language");
                            String homepage = repo.get("homepage");

                            String techStack = (language != null && !language.trim().isEmpty()) ? language : "Full-Stack, Git";
                            String description = (rawDesc != null && !rawDesc.trim().isEmpty()) 
                                    ? rawDesc 
                                    : "Open-source software project built using " + techStack + " featuring modular architecture, clean code practices, and Git version control.";
                            String liveDemoUrl = (homepage != null && homepage.trim().startsWith("http")) ? homepage.trim() : null;

                            Project newProject = new Project();
                            newProject.setStudentId(studentId);
                            newProject.setTitle(title);
                            newProject.setDescription(description);
                            newProject.setTechStack(techStack);
                            newProject.setGithubUrl(htmlUrl);
                            newProject.setLiveDemoUrl(liveDemoUrl);

                            projectDAO.createProject(newProject);
                            importedCount++;
                        }
                    }
                }
            }
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Failed to import GitHub repositories for " + username, e);
        }
        return importedCount;
    }

    private String formatRepoTitle(String name) {
        if (name == null) return "Project";
        String clean = name.replace("-", " ").replace("_", " ").trim();
        if (clean.equals(clean.toLowerCase())) {
            StringBuilder sb = new StringBuilder();
            for (String word : clean.split("\\s+")) {
                if (!word.isEmpty()) {
                    sb.append(Character.toUpperCase(word.charAt(0))).append(word.substring(1)).append(" ");
                }
            }
            return sb.toString().trim();
        }
        return clean;
    }

    private String readStream(InputStream stream) throws Exception {
        if (stream == null) return "";
        StringBuilder sb = new StringBuilder();
        try (BufferedReader br = new BufferedReader(new InputStreamReader(stream, StandardCharsets.UTF_8))) {
            String line;
            while ((line = br.readLine()) != null) {
                sb.append(line).append('\n');
            }
        }
        return sb.toString().trim();
    }
}
