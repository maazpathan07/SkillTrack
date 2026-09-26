package com.skilltrack.controllers;

import com.skilltrack.dto.CodeExecutionResultDTO;
import com.skilltrack.services.CodeExecutionService;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Controller for the In-Browser Interactive Code Playground.
 * Pure sandbox scratchpad for student practice with 0 database writes.
 */
@WebServlet(name = "StudentCodePlaygroundServlet", urlPatterns = {"/app/student/code-playground", "/app/student/playground"})
public class StudentCodePlaygroundServlet extends HttpServlet {

    private final CodeExecutionService codeExecutionService;

    public StudentCodePlaygroundServlet() {
        this.codeExecutionService = new CodeExecutionService();
    }

    public StudentCodePlaygroundServlet(CodeExecutionService codeExecutionService) {
        this.codeExecutionService = codeExecutionService;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("activeNav", "playground");
        request.getRequestDispatcher("/WEB-INF/views/student/code-playground.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");

        String language = request.getParameter("language");
        String sourceCode = request.getParameter("sourceCode");
        String stdin = request.getParameter("stdin");

        // Handle raw JSON request if payload was sent as application/json
        String contentType = request.getContentType();
        if (contentType != null && contentType.toLowerCase().contains("application/json")) {
            StringBuilder jsonBuffer = new StringBuilder();
            String line;
            try (BufferedReader reader = request.getReader()) {
                while ((line = reader.readLine()) != null) {
                    jsonBuffer.append(line);
                }
            }
            String jsonStr = jsonBuffer.toString();
            language = extractJsonField(jsonStr, "language");
            sourceCode = extractJsonField(jsonStr, "sourceCode");
            stdin = extractJsonField(jsonStr, "stdin");
        }

        if (language == null || language.trim().isEmpty()) {
            language = "java";
        }

        CodeExecutionResultDTO result = codeExecutionService.executeCode(language, sourceCode, stdin);

        try (PrintWriter out = response.getWriter()) {
            StringBuilder jsonResponse = new StringBuilder();
            jsonResponse.append("{");
            jsonResponse.append("\"success\":").append(result.isSuccess()).append(",");
            jsonResponse.append("\"language\":\"").append(escapeJson(result.getLanguage())).append("\",");
            jsonResponse.append("\"stdout\":\"").append(escapeJson(result.getStdout())).append("\",");
            jsonResponse.append("\"stderr\":\"").append(escapeJson(result.getStderr())).append("\",");
            jsonResponse.append("\"exitCode\":").append(result.getExitCode()).append(",");
            jsonResponse.append("\"executionTimeMs\":").append(result.getExecutionTimeMs()).append(",");
            jsonResponse.append("\"statusMessage\":\"").append(escapeJson(result.getStatusMessage())).append("\"");
            jsonResponse.append("}");
            out.print(jsonResponse.toString());
            out.flush();
        }
    }

    private String extractJsonField(String json, String key) {
        if (json == null || key == null) return null;
        java.util.regex.Pattern p = java.util.regex.Pattern.compile("\"" + java.util.regex.Pattern.quote(key) + "\"\\s*:\\s*\"([^\"\\\\]*(?:\\\\.[^\"\\\\]*)*)\"");
        java.util.regex.Matcher m = p.matcher(json);
        if (m.find()) {
            return unescapeJson(m.group(1));
        }
        return null;
    }

    private String escapeJson(String str) {
        if (str == null) return "";
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < str.length(); i++) {
            char ch = str.charAt(i);
            switch (ch) {
                case '"': sb.append("\\\""); break;
                case '\\': sb.append("\\\\"); break;
                case '\b': sb.append("\\b"); break;
                case '\f': sb.append("\\f"); break;
                case '\n': sb.append("\\n"); break;
                case '\r': sb.append("\\r"); break;
                case '\t': sb.append("\\t"); break;
                default:
                    if (ch < ' ') {
                        String t = "000" + Integer.toHexString(ch);
                        sb.append("\\u").append(t.substring(t.length() - 4));
                    } else {
                        sb.append(ch);
                    }
                    break;
            }
        }
        return sb.toString();
    }

    private String unescapeJson(String str) {
        if (str == null) return null;
        return str.replace("\\n", "\n")
                  .replace("\\r", "\r")
                  .replace("\\t", "\t")
                  .replace("\\\"", "\"")
                  .replace("\\\\", "\\");
    }
}
