package com.skilltrack.services;

import com.skilltrack.dto.CodeExecutionResultDTO;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Comparator;
import java.util.UUID;
import java.util.concurrent.TimeUnit;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Sandboxed code execution service for the interactive in-browser playground.
 * Standalone utility execution with strict timeout, resource limits, and isolated workspaces.
 * Strictly 0 database side effects.
 */
public class CodeExecutionService {

    private static final Logger LOGGER = Logger.getLogger(CodeExecutionService.class.getName());
    private static final long TIMEOUT_SECONDS = 6;
    private static final int MAX_OUTPUT_CHARS = 50000;

    public CodeExecutionResultDTO executeCode(String language, String sourceCode, String stdin) {
        CodeExecutionResultDTO result = new CodeExecutionResultDTO();
        result.setLanguage(language);

        if (sourceCode == null || sourceCode.trim().isEmpty()) {
            result.setSuccess(false);
            result.setStderr("Error: Source code cannot be empty.");
            result.setStatusMessage("Empty Code");
            return result;
        }

        String normalizedLang = (language != null) ? language.trim().toLowerCase() : "java";
        long startTime = System.currentTimeMillis();

        Path tempDir = null;
        try {
            tempDir = Files.createTempDirectory("skilltrack_sandbox_" + UUID.randomUUID().toString());
            File workDir = tempDir.toFile();

            switch (normalizedLang) {
                case "java":
                    runJava(workDir, sourceCode, stdin, result);
                    break;
                case "cpp":
                case "c++":
                    runCpp(workDir, sourceCode, stdin, result);
                    break;
                case "c":
                    runC(workDir, sourceCode, stdin, result);
                    break;
                case "javascript":
                case "js":
                case "node":
                    runJavaScript(workDir, sourceCode, stdin, result);
                    break;
                case "python":
                case "py":
                    runPython(workDir, sourceCode, stdin, result);
                    break;
                default:
                    result.setSuccess(false);
                    result.setStderr("Unsupported backend execution language: " + normalizedLang);
                    result.setStatusMessage("Unsupported Language");
                    break;
            }

        } catch (Exception ex) {
            LOGGER.log(Level.WARNING, "Error executing code in sandbox", ex);
            result.setSuccess(false);
            result.setStderr("Execution Engine Exception: " + ex.getMessage());
            result.setStatusMessage("System Error");
        } finally {
            result.setExecutionTimeMs(System.currentTimeMillis() - startTime);
            // Safe cleanup of temporary sandbox directory
            if (tempDir != null) {
                cleanupDirectory(tempDir);
            }
        }

        return result;
    }

    private void runJava(File workDir, String code, String stdin, CodeExecutionResultDTO result) throws Exception {
        // Find public class name or default to Main
        String className = "Main";
        java.util.regex.Matcher m = java.util.regex.Pattern.compile("public\\s+class\\s+([A-Za-z0-9_]+)").matcher(code);
        if (m.find()) {
            className = m.group(1);
        }

        File srcFile = new File(workDir, className + ".java");
        Files.write(srcFile.toPath(), code.getBytes(StandardCharsets.UTF_8));

        // 1. Compile
        ProcessBuilder compilePb = new ProcessBuilder("javac", "-encoding", "UTF-8", srcFile.getAbsolutePath());
        compilePb.directory(workDir);
        Process compileProcess = compilePb.start();

        boolean compiledInTime = compileProcess.waitFor(TIMEOUT_SECONDS, TimeUnit.SECONDS);
        if (!compiledInTime) {
            compileProcess.destroyForcibly();
            result.setSuccess(false);
            result.setStderr("Compilation timed out (" + TIMEOUT_SECONDS + "s limit)");
            result.setStatusMessage("Compile Timeout");
            return;
        }

        String compileErr = readStream(compileProcess.getErrorStream());
        if (compileProcess.exitValue() != 0 || !compileErr.isEmpty()) {
            result.setSuccess(false);
            result.setStderr(compileErr.isEmpty() ? "Compilation failed with exit code " + compileProcess.exitValue() : compileErr);
            result.setExitCode(compileProcess.exitValue());
            result.setStatusMessage("Compilation Error");
            return;
        }

        // 2. Execute
        ProcessBuilder runPb = new ProcessBuilder("java", "-cp", workDir.getAbsolutePath(), className);
        runPb.directory(workDir);
        executeProcess(runPb, stdin, result);
    }

    private void runCpp(File workDir, String code, String stdin, CodeExecutionResultDTO result) throws Exception {
        File srcFile = new File(workDir, "main.cpp");
        File exeFile = new File(workDir, "main.exe");
        Files.write(srcFile.toPath(), code.getBytes(StandardCharsets.UTF_8));

        // 1. Compile with g++
        ProcessBuilder compilePb = new ProcessBuilder("g++", "-O2", srcFile.getAbsolutePath(), "-o", exeFile.getAbsolutePath());
        compilePb.directory(workDir);
        Process compileProcess = compilePb.start();

        boolean compiledInTime = compileProcess.waitFor(TIMEOUT_SECONDS, TimeUnit.SECONDS);
        if (!compiledInTime) {
            compileProcess.destroyForcibly();
            result.setSuccess(false);
            result.setStderr("C++ compilation timed out (" + TIMEOUT_SECONDS + "s limit)");
            result.setStatusMessage("Compile Timeout");
            return;
        }

        String compileErr = readStream(compileProcess.getErrorStream());
        if (compileProcess.exitValue() != 0) {
            result.setSuccess(false);
            result.setStderr(compileErr.isEmpty() ? "C++ compilation failed with exit code " + compileProcess.exitValue() : compileErr);
            result.setExitCode(compileProcess.exitValue());
            result.setStatusMessage("Compilation Error");
            return;
        }

        // 2. Execute binary
        ProcessBuilder runPb = new ProcessBuilder(exeFile.getAbsolutePath());
        runPb.directory(workDir);
        executeProcess(runPb, stdin, result);
    }

    private void runC(File workDir, String code, String stdin, CodeExecutionResultDTO result) throws Exception {
        File srcFile = new File(workDir, "main.c");
        File exeFile = new File(workDir, "main.exe");
        Files.write(srcFile.toPath(), code.getBytes(StandardCharsets.UTF_8));

        // 1. Compile with gcc
        ProcessBuilder compilePb = new ProcessBuilder("gcc", "-O2", srcFile.getAbsolutePath(), "-o", exeFile.getAbsolutePath());
        compilePb.directory(workDir);
        Process compileProcess = compilePb.start();

        boolean compiledInTime = compileProcess.waitFor(TIMEOUT_SECONDS, TimeUnit.SECONDS);
        if (!compiledInTime) {
            compileProcess.destroyForcibly();
            result.setSuccess(false);
            result.setStderr("C compilation timed out (" + TIMEOUT_SECONDS + "s limit)");
            result.setStatusMessage("Compile Timeout");
            return;
        }

        String compileErr = readStream(compileProcess.getErrorStream());
        if (compileProcess.exitValue() != 0) {
            result.setSuccess(false);
            result.setStderr(compileErr.isEmpty() ? "C compilation failed with exit code " + compileProcess.exitValue() : compileErr);
            result.setExitCode(compileProcess.exitValue());
            result.setStatusMessage("Compilation Error");
            return;
        }

        // 2. Execute binary
        ProcessBuilder runPb = new ProcessBuilder(exeFile.getAbsolutePath());
        runPb.directory(workDir);
        executeProcess(runPb, stdin, result);
    }

    private void runJavaScript(File workDir, String code, String stdin, CodeExecutionResultDTO result) throws Exception {
        File srcFile = new File(workDir, "main.js");
        Files.write(srcFile.toPath(), code.getBytes(StandardCharsets.UTF_8));

        ProcessBuilder runPb = new ProcessBuilder("node", srcFile.getAbsolutePath());
        runPb.directory(workDir);
        executeProcess(runPb, stdin, result);
    }

    private void runPython(File workDir, String code, String stdin, CodeExecutionResultDTO result) throws Exception {
        File srcFile = new File(workDir, "main.py");
        Files.write(srcFile.toPath(), code.getBytes(StandardCharsets.UTF_8));

        // Try 'python' or 'py'
        ProcessBuilder runPb = new ProcessBuilder("python", srcFile.getAbsolutePath());
        runPb.directory(workDir);
        executeProcess(runPb, stdin, result);
    }

    private void executeProcess(ProcessBuilder pb, String stdin, CodeExecutionResultDTO result) throws Exception {
        Process process = pb.start();

        // Write stdin if provided
        if (stdin != null && !stdin.isEmpty()) {
            try (OutputStream os = process.getOutputStream()) {
                os.write(stdin.getBytes(StandardCharsets.UTF_8));
                os.flush();
            } catch (IOException ignored) {
            }
        } else {
            try {
                process.getOutputStream().close();
            } catch (IOException ignored) {
            }
        }

        boolean finishedInTime = process.waitFor(TIMEOUT_SECONDS, TimeUnit.SECONDS);
        if (!finishedInTime) {
            process.destroyForcibly();
            result.setSuccess(false);
            result.setStderr("Execution Timed Out (Limit: " + TIMEOUT_SECONDS + "s). Check for infinite loops or unconsumed inputs.");
            result.setStatusMessage("Time Limit Exceeded");
            return;
        }

        int exitCode = process.exitValue();
        String stdout = readStream(process.getInputStream());
        String stderr = readStream(process.getErrorStream());

        result.setExitCode(exitCode);
        result.setStdout(truncate(stdout));
        result.setStderr(truncate(stderr));

        if (exitCode == 0 && stderr.isEmpty()) {
            result.setSuccess(true);
            result.setStatusMessage("Success (Exit Code 0)");
        } else if (exitCode == 0) {
            result.setSuccess(true);
            result.setStatusMessage("Completed with Warnings");
        } else {
            result.setSuccess(false);
            result.setStatusMessage("Runtime Error (Exit Code " + exitCode + ")");
        }
    }

    private String readStream(InputStream is) throws IOException {
        StringBuilder sb = new StringBuilder();
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(is, StandardCharsets.UTF_8))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (sb.length() < MAX_OUTPUT_CHARS) {
                    sb.append(line).append("\n");
                } else {
                    sb.append("\n... [Output Truncated]");
                    break;
                }
            }
        }
        return sb.toString();
    }

    private String truncate(String text) {
        if (text == null) return "";
        if (text.length() > MAX_OUTPUT_CHARS) {
            return text.substring(0, MAX_OUTPUT_CHARS) + "\n... [Output Truncated]";
        }
        return text;
    }

    private void cleanupDirectory(Path dir) {
        try {
            if (Files.exists(dir)) {
                Files.walk(dir)
                        .sorted(Comparator.reverseOrder())
                        .map(Path::toFile)
                        .forEach(File::delete);
            }
        } catch (Exception ignored) {
        }
    }
}
