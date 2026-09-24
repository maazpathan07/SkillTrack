package com.skilltrack.models;

import com.skilltrack.constants.TopicCategory;
import java.io.Serializable;
import java.time.LocalDateTime;

public class DsaTopic implements Serializable {
    private static final long serialVersionUID = 1L;

    private int topicId;
    private String topicName;
    private TopicCategory category;
    private LocalDateTime createdAt;

    public DsaTopic() {
    }

    public DsaTopic(int topicId, String topicName, TopicCategory category) {
        this.topicId = topicId;
        this.topicName = topicName;
        this.category = category;
    }

    public int getTopicId() {
        return topicId;
    }

    public void setTopicId(int topicId) {
        this.topicId = topicId;
    }

    public String getTopicName() {
        return topicName;
    }

    public void setTopicName(String topicName) {
        this.topicName = topicName;
    }

    public TopicCategory getCategory() {
        return category;
    }

    public void setCategory(TopicCategory category) {
        this.category = category;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
}
