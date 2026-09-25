package com.skilltrack.utils;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

public final class OAuthHttpClient {

    private static final Logger LOGGER = Logger.getLogger(OAuthHttpClient.class.getName());

    private OAuthHttpClient() {
    }

    public static String sendPost(String endpoint, Map<String, String> params, Map<String, String> headers) throws Exception {
        URL url = new URL(endpoint);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setConnectTimeout(10000);
        conn.setReadTimeout(15000);
        conn.setDoOutput(true);
        conn.setDoInput(true);

        // Default content type is form urlencoded
        conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
        conn.setRequestProperty("Accept", "application/json");
        conn.setRequestProperty("User-Agent", "SkillTrack-OAuth-Client/1.0");

        if (headers != null) {
            for (Map.Entry<String, String> entry : headers.entrySet()) {
                conn.setRequestProperty(entry.getKey(), entry.getValue());
            }
        }

        StringBuilder postData = new StringBuilder();
        if (params != null) {
            for (Map.Entry<String, String> entry : params.entrySet()) {
                if (postData.length() > 0) postData.append('&');
                postData.append(ValidationUtil.urlEncode(entry.getKey()))
                        .append('=')
                        .append(ValidationUtil.urlEncode(entry.getValue()));
            }
        }

        byte[] postBytes = postData.toString().getBytes(StandardCharsets.UTF_8);
        conn.setRequestProperty("Content-Length", String.valueOf(postBytes.length));

        try (OutputStream os = conn.getOutputStream()) {
            os.write(postBytes);
            os.flush();
        }

        int responseCode = conn.getResponseCode();
        InputStream stream = (responseCode >= 200 && responseCode < 400) ? conn.getInputStream() : conn.getErrorStream();

        return readStream(stream);
    }

    public static String sendGet(String endpoint, String bearerToken, Map<String, String> headers) throws Exception {
        URL url = new URL(endpoint);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setConnectTimeout(10000);
        conn.setReadTimeout(15000);

        conn.setRequestProperty("Accept", "application/json");
        conn.setRequestProperty("User-Agent", "SkillTrack-OAuth-Client/1.0");

        if (bearerToken != null && !bearerToken.trim().isEmpty()) {
            conn.setRequestProperty("Authorization", "Bearer " + bearerToken.trim());
        }

        if (headers != null) {
            for (Map.Entry<String, String> entry : headers.entrySet()) {
                conn.setRequestProperty(entry.getKey(), entry.getValue());
            }
        }

        int responseCode = conn.getResponseCode();
        InputStream stream = (responseCode >= 200 && responseCode < 400) ? conn.getInputStream() : conn.getErrorStream();

        return readStream(stream);
    }

    private static String readStream(InputStream stream) throws Exception {
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
