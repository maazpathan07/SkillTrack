package com.skilltrack.services;

import com.skilltrack.config.DBConnection;
import com.skilltrack.config.OAuthConfig;
import com.skilltrack.constants.OAuthProvider;
import com.skilltrack.constants.UserRole;
import com.skilltrack.dao.AdminDAO;
import com.skilltrack.dao.StudentDAO;
import com.skilltrack.dao.UserDAO;
import com.skilltrack.dto.OAuthUserInfo;
import com.skilltrack.models.Admin;
import com.skilltrack.models.Student;
import com.skilltrack.models.User;
import com.skilltrack.utils.OAuthHttpClient;
import com.skilltrack.utils.SimpleJsonParser;
import com.skilltrack.utils.ValidationUtil;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.Year;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class OAuthService {

    private static final Logger LOGGER = Logger.getLogger(OAuthService.class.getName());

    private final UserDAO userDAO;
    private final StudentDAO studentDAO;
    private final AdminDAO adminDAO;

    public OAuthService() {
        this.userDAO = new UserDAO();
        this.studentDAO = new StudentDAO();
        this.adminDAO = new AdminDAO();
    }

    public OAuthService(UserDAO userDAO, StudentDAO studentDAO, AdminDAO adminDAO) {
        this.userDAO = userDAO;
        this.studentDAO = studentDAO;
        this.adminDAO = adminDAO;
    }

    public String getAuthorizationUrl(OAuthProvider provider, String state, String redirectUri) {
        String clientId = OAuthConfig.getClientId(provider);
        String finalRedirect = OAuthConfig.getRedirectUri(provider, redirectUri);

        switch (provider) {
            case GOOGLE:
                return "https://accounts.google.com/o/oauth2/v2/auth"
                        + "?client_id=" + ValidationUtil.urlEncode(clientId)
                        + "&redirect_uri=" + ValidationUtil.urlEncode(finalRedirect)
                        + "&response_type=code"
                        + "&scope=" + ValidationUtil.urlEncode("openid profile email")
                        + "&state=" + ValidationUtil.urlEncode(state)
                        + "&access_type=offline&prompt=select_account";

            case GITHUB:
                return "https://github.com/login/oauth/authorize"
                        + "?client_id=" + ValidationUtil.urlEncode(clientId)
                        + "&redirect_uri=" + ValidationUtil.urlEncode(finalRedirect)
                        + "&scope=" + ValidationUtil.urlEncode("read:user user:email")
                        + "&state=" + ValidationUtil.urlEncode(state);

            case LINKEDIN:
                return "https://www.linkedin.com/oauth/v2/authorization"
                        + "?response_type=code"
                        + "&client_id=" + ValidationUtil.urlEncode(clientId)
                        + "&redirect_uri=" + ValidationUtil.urlEncode(finalRedirect)
                        + "&state=" + ValidationUtil.urlEncode(state)
                        + "&scope=" + ValidationUtil.urlEncode("openid profile email");

            default:
                return null;
        }
    }

    public OAuthUserInfo exchangeCodeForUserInfo(OAuthProvider provider, String code, String redirectUri) throws Exception {
        String clientId = OAuthConfig.getClientId(provider);
        String clientSecret = OAuthConfig.getClientSecret(provider);
        String finalRedirect = OAuthConfig.getRedirectUri(provider, redirectUri);

        switch (provider) {
            case GOOGLE: {
                Map<String, String> tokenParams = new HashMap<>();
                tokenParams.put("code", code);
                tokenParams.put("client_id", clientId);
                tokenParams.put("client_secret", clientSecret);
                tokenParams.put("redirect_uri", finalRedirect);
                tokenParams.put("grant_type", "authorization_code");

                String tokenJson = OAuthHttpClient.sendPost("https://oauth2.googleapis.com/token", tokenParams, null);
                String accessToken = SimpleJsonParser.getString(tokenJson, "access_token");
                if (accessToken == null) {
                    throw new IllegalArgumentException("Failed to obtain Google access token: " + tokenJson);
                }

                String userJson = OAuthHttpClient.sendGet("https://www.googleapis.com/oauth2/v3/userinfo", accessToken, null);
                String sub = SimpleJsonParser.getString(userJson, "sub");
                String email = SimpleJsonParser.getString(userJson, "email");
                String name = SimpleJsonParser.getString(userJson, "name");
                String picture = SimpleJsonParser.getString(userJson, "picture");

                return new OAuthUserInfo(OAuthProvider.GOOGLE, sub, email, name, picture, null);
            }

            case GITHUB: {
                Map<String, String> tokenParams = new HashMap<>();
                tokenParams.put("code", code);
                tokenParams.put("client_id", clientId);
                tokenParams.put("client_secret", clientSecret);
                tokenParams.put("redirect_uri", finalRedirect);

                Map<String, String> headers = new HashMap<>();
                headers.put("Accept", "application/json");

                String tokenJson = OAuthHttpClient.sendPost("https://github.com/login/oauth/access_token", tokenParams, headers);
                String accessToken = SimpleJsonParser.getString(tokenJson, "access_token");
                if (accessToken == null) {
                    throw new IllegalArgumentException("Failed to obtain GitHub access token: " + tokenJson);
                }

                String userJson = OAuthHttpClient.sendGet("https://api.github.com/user", accessToken, null);
                String id = SimpleJsonParser.getString(userJson, "id");
                String login = SimpleJsonParser.getString(userJson, "login");
                String name = SimpleJsonParser.getString(userJson, "name");
                String email = SimpleJsonParser.getString(userJson, "email");
                String avatarUrl = SimpleJsonParser.getString(userJson, "avatar_url");
                String htmlUrl = SimpleJsonParser.getString(userJson, "html_url");

                if (name == null || name.trim().isEmpty()) {
                    name = login;
                }

                // If primary email is hidden, fetch user emails list
                if (email == null || email.trim().isEmpty()) {
                    try {
                        String emailsJson = OAuthHttpClient.sendGet("https://api.github.com/user/emails", accessToken, null);
                        email = extractPrimaryGitHubEmail(emailsJson);
                    } catch (Exception e) {
                        LOGGER.log(Level.WARNING, "Could not fetch GitHub emails: " + e.getMessage());
                    }
                }

                if (email == null || email.trim().isEmpty()) {
                    email = login + "@users.noreply.github.com";
                }

                return new OAuthUserInfo(OAuthProvider.GITHUB, id, email, name, avatarUrl, htmlUrl != null ? htmlUrl : "https://github.com/" + login);
            }

            case LINKEDIN: {
                Map<String, String> tokenParams = new HashMap<>();
                tokenParams.put("grant_type", "authorization_code");
                tokenParams.put("code", code);
                tokenParams.put("client_id", clientId);
                tokenParams.put("client_secret", clientSecret);
                tokenParams.put("redirect_uri", finalRedirect);

                String tokenJson = OAuthHttpClient.sendPost("https://www.linkedin.com/oauth/v2/accessToken", tokenParams, null);
                String accessToken = SimpleJsonParser.getString(tokenJson, "access_token");
                if (accessToken == null) {
                    throw new IllegalArgumentException("Failed to obtain LinkedIn access token: " + tokenJson);
                }

                String userJson = OAuthHttpClient.sendGet("https://api.linkedin.com/v2/userinfo", accessToken, null);
                String sub = SimpleJsonParser.getString(userJson, "sub");
                String email = SimpleJsonParser.getString(userJson, "email");
                String name = SimpleJsonParser.getString(userJson, "name");
                String picture = SimpleJsonParser.getString(userJson, "picture");

                return new OAuthUserInfo(OAuthProvider.LINKEDIN, sub, email, name, picture, null);
            }

            default:
                throw new UnsupportedOperationException("Unsupported provider: " + provider);
        }
    }

    public AuthService.AuthResult processOAuthLogin(OAuthUserInfo userInfo) {
        if (userInfo == null || userInfo.getEmail() == null || userInfo.getEmail().trim().isEmpty()) {
            return AuthService.AuthResult.failure("Unable to retrieve verified email from " + (userInfo != null ? userInfo.getProvider().getDisplayName() : "OAuth Provider"));
        }

        String email = userInfo.getEmail().trim().toLowerCase();
        String fullName = (userInfo.getName() != null && !userInfo.getName().trim().isEmpty())
                ? userInfo.getName().trim()
                : email.substring(0, email.indexOf('@'));

        try {
            // 1. Check if user already exists by OAuth Provider + ID or by verified Email
            User existingUser = userDAO.findByOAuth(userInfo.getProvider(), userInfo.getProviderId());
            if (existingUser == null) {
                existingUser = userDAO.findByEmail(email);
            }

            if (existingUser != null) {
                if (!existingUser.isActive()) {
                    return AuthService.AuthResult.failure("Your account is currently disabled. Please contact the administrator.");
                }

                // Link OAuth info if not already linked
                if (existingUser.getOAuthId() == null || existingUser.getOAuthId().isEmpty()) {
                    userDAO.updateOAuthInfo(existingUser.getUserId(), userInfo.getProvider(), userInfo.getProviderId());
                    existingUser.setOAuthProvider(userInfo.getProvider());
                    existingUser.setOAuthId(userInfo.getProviderId());
                }

                Student student = null;
                Admin admin = null;

                if (existingUser.getRole() == UserRole.STUDENT) {
                    student = studentDAO.findByUserId(existingUser.getUserId());
                } else if (existingUser.getRole() == UserRole.ADMIN) {
                    admin = adminDAO.findByUserId(existingUser.getUserId());
                }

                return AuthService.AuthResult.success(existingUser, student, admin);
            }

            // 2. Register new student via OAuth in a single transaction
            Connection conn = null;
            try {
                conn = DBConnection.getConnection();
                conn.setAutoCommit(false);

                User newUser = new User();
                newUser.setEmail(email);
                newUser.setPasswordHash(null);
                newUser.setSalt(null);
                newUser.setRole(UserRole.STUDENT);
                newUser.setActive(true);
                newUser.setOAuthProvider(userInfo.getProvider());
                newUser.setOAuthId(userInfo.getProviderId());

                int userId = userDAO.createUser(newUser, conn);

                // Auto-generate a clean student roll number
                String rollNumber = generateUniqueRollNumber(userInfo.getProvider());

                Student newStudent = new Student();
                newStudent.setUserId(userId);
                newStudent.setFullName(fullName);
                newStudent.setRollNumber(rollNumber);
                newStudent.setDepartment("Computer Science");
                newStudent.setGraduationYear(Year.now().getValue() + 1);
                newStudent.setCgpa(0.00);
                newStudent.setTargetRoleId(null);

                studentDAO.createStudent(newStudent, conn);

                conn.commit();
                LOGGER.info("Successfully registered new student via " + userInfo.getProvider() + " OAuth: " + email);
                return AuthService.AuthResult.success(newUser, newStudent, null);
            } catch (SQLException e) {
                if (conn != null) {
                    try {
                        conn.rollback();
                    } catch (SQLException ex) {
                        LOGGER.log(Level.SEVERE, "Rollback error during OAuth registration", ex);
                    }
                }
                LOGGER.log(Level.SEVERE, "OAuth registration transaction failed for email: " + email, e);
                return AuthService.AuthResult.failure("Registration via " + userInfo.getProvider().getDisplayName() + " failed due to database error.");
            } finally {
                if (conn != null) {
                    try {
                        conn.setAutoCommit(true);
                        conn.close();
                    } catch (SQLException ex) {
                        LOGGER.log(Level.WARNING, "Error closing connection", ex);
                    }
                }
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Database error during OAuth login for email: " + email, e);
            return AuthService.AuthResult.failure("A database error occurred during social sign in. Please try again.");
        }
    }

    private String generateUniqueRollNumber(OAuthProvider provider) {
        String prefix = provider.name().substring(0, 2);
        String uuidSuffix = UUID.randomUUID().toString().replace("-", "").substring(0, 6).toUpperCase();
        return prefix + "-" + Year.now().getValue() + "-" + uuidSuffix;
    }

    private String extractPrimaryGitHubEmail(String emailsJson) {
        if (emailsJson == null) return null;
        // Matches primary email: "email"\s*:\s*"([^"]+)",\s*"primary"\s*:\s*true
        Pattern p = Pattern.compile("\"email\"\\s*:\\s*\"([^\"]+)\"\\s*,\\s*\"primary\"\\s*:\\s*true");
        Matcher m = p.matcher(emailsJson);
        if (m.find()) {
            return m.group(1);
        }
        // Fallback: any verified email
        Pattern p2 = Pattern.compile("\"email\"\\s*:\\s*\"([^\"]+)\"\\s*,[^\\]]*?\"verified\"\\s*:\\s*true");
        Matcher m2 = p2.matcher(emailsJson);
        if (m2.find()) {
            return m2.group(1);
        }
        return null;
    }
}
