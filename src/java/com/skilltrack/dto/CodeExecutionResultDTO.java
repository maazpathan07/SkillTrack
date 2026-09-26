package com.skilltrack.dto;

import java.io.Serializable;

/**
 * Data Transfer Object for Code Playground execution results.
 * Strictly in-memory and standalone - zero database impact.
 */
public class CodeExecutionResultDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    private boolean success;
    private String language;
    private String stdout;
    private String stderr;
    private int exitCode;
    private long executionTimeMs;
    private String statusMessage;

    public CodeExecutionResultDTO() {
        this.success = false;
        this.exitCode = -1;
        this.stdout = "";
        this.stderr = "";
        this.statusMessage = "Ready";
    }

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public String getLanguage() {
        return language;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    public String getStdout() {
        return stdout != null ? stdout : "";
    }

    public void setStdout(String stdout) {
        this.stdout = stdout;
    }

    public String getStderr() {
        return stderr != null ? stderr : "";
    }

    public void setStderr(String stderr) {
        this.stderr = stderr;
    }

    public int getExitCode() {
        return exitCode;
    }

    public void setExitCode(int exitCode) {
        this.exitCode = exitCode;
    }

    public long getExecutionTimeMs() {
        return executionTimeMs;
    }

    public void setExecutionTimeMs(long executionTimeMs) {
        this.executionTimeMs = executionTimeMs;
    }

    public String getStatusMessage() {
        return statusMessage;
    }

    public void setStatusMessage(String statusMessage) {
        this.statusMessage = statusMessage;
    }
}
