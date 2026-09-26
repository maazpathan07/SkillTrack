package com.skilltrack.utils;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * High-performance HTTP client for Google Gemini Generative AI API.
 * Enables real-time LLM chat intelligence for SkillTrack platform.
 */
public class GeminiAiClient {

    private static final Logger LOGGER = Logger.getLogger(GeminiAiClient.class.getName());

    private static String apiKey;
    private static String modelName = "gemini-3.8-flash";
    private static String baseUrl = "https://generativelanguage.googleapis.com/v1beta/models/";
    private static double temperature = 0.7;
    private static int maxTokens = 2048;
    private static boolean isConfigured = false;

    static {
        loadConfiguration();
    }

    private static synchronized void loadConfiguration() {
        try (InputStream input = GeminiAiClient.class.getClassLoader().getResourceAsStream("gemini.properties")) {
            if (input != null) {
                Properties prop = new Properties();
                prop.load(input);
                apiKey = prop.getProperty("gemini.api.key", "").trim();
                modelName = prop.getProperty("gemini.model", "gemini-3.8-flash").trim();
                baseUrl = prop.getProperty("gemini.api.url", "https://generativelanguage.googleapis.com/v1beta/models/").trim();
                try {
                    temperature = Double.parseDouble(prop.getProperty("gemini.temperature", "0.7"));
                } catch (Exception ignored) {}
                try {
                    maxTokens = Integer.parseInt(prop.getProperty("gemini.max.output.tokens", "2048"));
                } catch (Exception ignored) {}

                if (!apiKey.isEmpty() && !apiKey.equals("YOUR_GEMINI_API_KEY")) {
                    isConfigured = true;
                    LOGGER.info("Google Gemini AI client configured successfully with model: " + modelName);
                } else {
                    LOGGER.warning("gemini.api.key is empty or placeholder in gemini.properties");
                }
            } else {
                LOGGER.warning("gemini.properties not found on classpath.");
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error loading gemini.properties: " + e.getMessage(), e);
        }
    }

    public static boolean isAvailable() {
        if (!isConfigured) {
            loadConfiguration();
        }
        return isConfigured && apiKey != null && !apiKey.isEmpty();
    }

    /**
     * Generates real-time AI response for a user prompt with system context instructions.
     */
    public static String generateResponse(String systemInstruction, String userPrompt) {
        if (!isAvailable()) {
            LOGGER.warning("Gemini AI API Key not configured. Returning fallback.");
            return null;
        }

        try {
            String endpointUrl = baseUrl + modelName + ":generateContent?key=" + apiKey;
            URL url = new URL(endpointUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            conn.setRequestProperty("Accept", "application/json");
            conn.setConnectTimeout(15000);
            conn.setReadTimeout(30000);
            conn.setDoOutput(true);

            // Construct Gemini Request JSON
            StringBuilder requestJson = new StringBuilder();
            requestJson.append("{");

            // Optional System Instruction
            if (systemInstruction != null && !systemInstruction.trim().isEmpty()) {
                requestJson.append("\"system_instruction\":{");
                requestJson.append("\"parts\":[{\"text\":").append(escapeJson(systemInstruction.trim())).append("}]");
                requestJson.append("},");
            }

            // User Prompt Contents
            requestJson.append("\"contents\":[{");
            requestJson.append("\"parts\":[{\"text\":").append(escapeJson(userPrompt.trim())).append("}]");
            requestJson.append("}],");

            // Generation Config
            requestJson.append("\"generationConfig\":{");
            requestJson.append("\"temperature\":").append(temperature).append(",");
            requestJson.append("\"maxOutputTokens\":").append(maxTokens);
            requestJson.append("}");

            requestJson.append("}");

            byte[] postData = requestJson.toString().getBytes(StandardCharsets.UTF_8);
            try (OutputStream os = conn.getOutputStream()) {
                os.write(postData);
                os.flush();
            }

            int responseCode = conn.getResponseCode();
            if (responseCode >= 200 && responseCode < 300) {
                try (BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8))) {
                    StringBuilder responseBuilder = new StringBuilder();
                    String line;
                    while ((line = br.readLine()) != null) {
                        responseBuilder.append(line);
                    }
                    return extractTextFromGeminiResponse(responseBuilder.toString());
                }
            } else {
                try (BufferedReader br = new BufferedReader(new InputStreamReader(conn.getErrorStream(), StandardCharsets.UTF_8))) {
                    StringBuilder errBuilder = new StringBuilder();
                    String line;
                    while ((line = br.readLine()) != null) {
                        errBuilder.append(line);
                    }
                    LOGGER.log(Level.WARNING, "Gemini API Error (" + responseCode + "): " + errBuilder.toString());
                }
                return null;
            }

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Exception calling Google Gemini API: " + e.getMessage(), e);
            return null;
        }
    }

    /**
     * Extracts text content from Google Gemini JSON response structure:
     * candidates[0].content.parts[0].text
     */
    private static String extractTextFromGeminiResponse(String json) {
        if (json == null || json.isEmpty()) return null;

        try {
            int partsIndex = json.indexOf("\"parts\"");
            if (partsIndex == -1) return null;

            int textIndex = json.indexOf("\"text\":", partsIndex);
            if (textIndex == -1) return null;

            int quoteStart = json.indexOf("\"", textIndex + 7);
            if (quoteStart == -1) return null;

            StringBuilder sb = new StringBuilder();
            boolean escape = false;
            for (int i = quoteStart + 1; i < json.length(); i++) {
                char c = json.charAt(i);
                if (escape) {
                    switch (c) {
                        case 'n': sb.append('\n'); break;
                        case 'r': sb.append('\r'); break;
                        case 't': sb.append('\t'); break;
                        case 'b': sb.append('\b'); break;
                        case 'f': sb.append('\f'); break;
                        case '"': sb.append('\"'); break;
                        case '\\': sb.append('\\'); break;
                        case 'u':
                            if (i + 4 < json.length()) {
                                try {
                                    String hex = json.substring(i + 1, i + 5);
                                    sb.append((char) Integer.parseInt(hex, 16));
                                    i += 4;
                                } catch (Exception ignored) {
                                    sb.append(c);
                                }
                            }
                            break;
                        default: sb.append(c); break;
                    }
                    escape = false;
                } else if (c == '\\') {
                    escape = true;
                } else if (c == '"') {
                    // Check if closing quote of the text field
                    break;
                } else {
                    sb.append(c);
                }
            }

            return sb.toString();

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error parsing Gemini response JSON: " + e.getMessage(), e);
            return null;
        }
    }

    private static String escapeJson(String input) {
        if (input == null) return "\"\"";
        StringBuilder sb = new StringBuilder("\"");
        for (int i = 0; i < input.length(); i++) {
            char c = input.charAt(i);
            switch (c) {
                case '\\': sb.append("\\\\"); break;
                case '"': sb.append("\\\""); break;
                case '\b': sb.append("\\b"); break;
                case '\f': sb.append("\\f"); break;
                case '\n': sb.append("\\n"); break;
                case '\r': sb.append("\\r"); break;
                case '\t': sb.append("\\t"); break;
                default:
                    if (c < ' ') {
                        String t = "000" + Integer.toHexString(c);
                        sb.append("\\u").append(t.substring(t.length() - 4));
                    } else {
                        sb.append(c);
                    }
                    break;
            }
        }
        sb.append("\"");
        return sb.toString();
    }
}
