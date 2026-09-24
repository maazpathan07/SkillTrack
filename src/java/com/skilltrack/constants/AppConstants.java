package com.skilltrack.constants;

public final class AppConstants {

    private AppConstants() {
        // Prevent instantiation
    }

    // Application Metadata
    public static final String APP_NAME = "SkillTrack";
    public static final String APP_VERSION = "1.0";

    // Session Attribute Keys
    public static final String SESSION_USER_ID = "SESSION_USER_ID";
    public static final String SESSION_USER_ROLE = "SESSION_USER_ROLE";
    public static final String SESSION_USER_EMAIL = "SESSION_USER_EMAIL";
    public static final String SESSION_USER_NAME = "SESSION_USER_NAME";
    public static final String SESSION_STUDENT_ID = "SESSION_STUDENT_ID";
    public static final String SESSION_ADMIN_ID = "SESSION_ADMIN_ID";
    public static final String SESSION_CSRF_TOKEN = "CSRF_TOKEN";

    // Request & Flash Message Keys
    public static final String FLASH_SUCCESS = "flashSuccess";
    public static final String FLASH_ERROR = "flashError";
    public static final String FLASH_INFO = "flashInfo";
    public static final String FORM_ERRORS = "formErrors";
    public static final String CSRF_PARAM_NAME = "csrfToken";
    public static final String CSRF_HEADER_NAME = "X-CSRF-Token";

    // Setting Keys in APP_SETTINGS
    public static final String SETTING_WEIGHT_SKILLS = "readiness.weight.skills";
    public static final String SETTING_WEIGHT_DSA = "readiness.weight.dsa";
    public static final String SETTING_WEIGHT_PROJECTS = "readiness.weight.projects";
    public static final String SETTING_WEIGHT_CERTS = "readiness.weight.certifications";
    public static final String SETTING_WEIGHT_TASKS = "readiness.weight.tasks";

    public static final String SETTING_BENCHMARK_DSA = "readiness.benchmark.dsa_problems";
    public static final String SETTING_BENCHMARK_PROJECTS = "readiness.benchmark.projects";
    public static final String SETTING_BENCHMARK_CERTS = "readiness.benchmark.certifications";

    // Default Fallback Values
    public static final double DEFAULT_WEIGHT_SKILLS = 0.35;
    public static final double DEFAULT_WEIGHT_DSA = 0.25;
    public static final double DEFAULT_WEIGHT_PROJECTS = 0.20;
    public static final double DEFAULT_WEIGHT_CERTS = 0.10;
    public static final double DEFAULT_WEIGHT_TASKS = 0.10;

    public static final int DEFAULT_BENCHMARK_DSA = 150;
    public static final int DEFAULT_BENCHMARK_PROJECTS = 3;
    public static final int DEFAULT_BENCHMARK_CERTS = 2;

    // Pagination
    public static final int DEFAULT_PAGE_SIZE = 10;

    // Disclaimer
    public static final String READINESS_DISCLAIMER = "This readiness index is a self-assessment and preparation tracking metric calculated against target role benchmarks. It is not an automated hiring prediction or guarantee of selection.";
}
