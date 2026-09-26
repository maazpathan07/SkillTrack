package com.skilltrack.dto;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class CoachChatMessageDTO implements Serializable {

    private static final long serialVersionUID = 1L;

    private String messageId;
    private String sender; // "AI" or "USER"
    private String content;
    private LocalDateTime timestamp;
    private List<String> quickFollowups = new ArrayList<>();

    public CoachChatMessageDTO() {
        this.timestamp = LocalDateTime.now();
    }

    public CoachChatMessageDTO(String sender, String content) {
        this.sender = sender;
        this.content = content;
        this.timestamp = LocalDateTime.now();
    }

    public String getMessageId() {
        return messageId;
    }

    public void setMessageId(String messageId) {
        this.messageId = messageId;
    }

    public String getSender() {
        return sender;
    }

    public void setSender(String sender) {
        this.sender = sender;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public LocalDateTime getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(LocalDateTime timestamp) {
        this.timestamp = timestamp;
    }

    public String getFormattedTime() {
        if (timestamp == null) return "";
        return timestamp.format(DateTimeFormatter.ofPattern("hh:mm a"));
    }

    public List<String> getQuickFollowups() {
        return quickFollowups;
    }

    public void setQuickFollowups(List<String> quickFollowups) {
        this.quickFollowups = quickFollowups;
    }
}
