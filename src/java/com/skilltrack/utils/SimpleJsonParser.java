package com.skilltrack.utils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Lightweight, zero-dependency JSON Parser for extracting OAuth token & profile fields.
 */
public final class SimpleJsonParser {

    private SimpleJsonParser() {
    }

    /**
     * Extracts a top-level string property value from a JSON string.
     */
    public static String getString(String json, String key) {
        if (json == null || key == null) return null;

        // Matches "key"\s*:\s*"value" (handles escaped quotes inside value)
        Pattern pString = Pattern.compile("\"" + Pattern.quote(key) + "\"\\s*:\\s*\"([^\"\\\\]*(?:\\\\.[^\"\\\\]*)*)\"");
        Matcher mString = pString.matcher(json);
        if (mString.find()) {
            return unescapeJson(mString.group(1));
        }

        // Fallback for number or boolean values converted to string: "key"\s*:\s*([0-9]+|true|false)
        Pattern pOther = Pattern.compile("\"" + Pattern.quote(key) + "\"\\s*:\\s*([0-9]+|true|false)");
        Matcher mOther = pOther.matcher(json);
        if (mOther.find()) {
            return mOther.group(1);
        }

        return null;
    }

    /**
     * Parses simple flat JSON string into Key-Value Map.
     */
    public static Map<String, String> parseFlatJson(String json) {
        Map<String, String> map = new HashMap<>();
        if (json == null || json.trim().isEmpty()) return map;

        Pattern pattern = Pattern.compile("\"([^\"]+)\"\\s*:\\s*(\"[^\"]*\"|[0-9]+|true|false|null)");
        Matcher matcher = pattern.matcher(json);
        while (matcher.find()) {
            String key = matcher.group(1);
            String val = matcher.group(2);
            if (val.startsWith("\"") && val.endsWith("\"") && val.length() >= 2) {
                val = val.substring(1, val.length() - 1);
            }
            map.put(key, unescapeJson(val));
        }
        return map;
    }

    /**
     * Parses a JSON array of objects into a list of key-value maps.
     */
    public static List<Map<String, String>> parseJsonArrayOfObjects(String jsonArray) {
        List<Map<String, String>> list = new ArrayList<>();
        if (jsonArray == null || jsonArray.trim().isEmpty()) return list;

        int depth = 0;
        int objStart = -1;
        boolean inString = false;
        boolean escape = false;

        for (int i = 0; i < jsonArray.length(); i++) {
            char c = jsonArray.charAt(i);

            if (escape) {
                escape = false;
                continue;
            }

            if (c == '\\') {
                escape = true;
                continue;
            }

            if (c == '"') {
                inString = !inString;
                continue;
            }

            if (!inString) {
                if (c == '{') {
                    if (depth == 0) {
                        objStart = i;
                    }
                    depth++;
                } else if (c == '}') {
                    depth--;
                    if (depth == 0 && objStart != -1) {
                        String objJson = jsonArray.substring(objStart, i + 1);
                        list.add(parseFlatJson(objJson));
                        objStart = -1;
                    }
                }
            }
        }
        return list;
    }

    private static String unescapeJson(String input) {
        if (input == null) return null;
        return input.replace("\\\"", "\"")
                    .replace("\\\\", "\\")
                    .replace("\\/", "/")
                    .replace("\\b", "\b")
                    .replace("\\f", "\f")
                    .replace("\\n", "\n")
                    .replace("\\r", "\r")
                    .replace("\\t", "\t");
    }
}
