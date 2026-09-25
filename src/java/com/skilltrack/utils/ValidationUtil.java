package com.skilltrack.utils;

import java.util.regex.Pattern;

public final class ValidationUtil {

    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$");
    private static final Pattern ROLL_NUMBER_PATTERN = Pattern.compile("^[A-Za-z0-9_-]{3,30}$");

    private ValidationUtil() {
    }

    public static boolean isValidEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }
        return EMAIL_PATTERN.matcher(email.trim()).matches();
    }

    public static boolean isValidPassword(String password) {
        if (password == null) {
            return false;
        }
        // At least 6 characters
        return password.length() >= 6;
    }

    public static boolean isValidRollNumber(String rollNumber) {
        if (rollNumber == null || rollNumber.trim().isEmpty()) {
            return false;
        }
        return ROLL_NUMBER_PATTERN.matcher(rollNumber.trim()).matches();
    }

    public static boolean isValidCgpa(double cgpa) {
        return cgpa >= 0.0 && cgpa <= 10.0;
    }

    public static boolean isValidGraduationYear(int year) {
        return year >= 2000 && year <= 2040;
    }

    public static boolean isNotEmpty(String str) {
        return str != null && !str.trim().isEmpty();
    }

    public static String sanitizeString(String input) {
        if (input == null) return "";
        return input.trim();
    }

    public static int parsePositiveInt(String input, int defaultValue) {
        if (input == null || input.trim().isEmpty()) return defaultValue;
        try {
            int val = Integer.parseInt(input.trim());
            return val >= 0 ? val : defaultValue;
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }

    public static double parseDouble(String input, double defaultValue) {
        if (input == null || input.trim().isEmpty()) return defaultValue;
        try {
            return Double.parseDouble(input.trim());
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }

    public static String urlEncode(String input) {
        if (input == null) return "";
        try {
            return java.net.URLEncoder.encode(input, "UTF-8");
        } catch (java.io.UnsupportedEncodingException e) {
            return input;
        }
    }
}
