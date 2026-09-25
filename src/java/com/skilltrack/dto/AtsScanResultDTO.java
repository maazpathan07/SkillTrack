package com.skilltrack.dto;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class AtsScanResultDTO implements Serializable {
    private static final long serialVersionUID = 1L;

    private int overallScore; // 0 to 100
    private String targetRoleTitle;
    private String companyName;
    private int keywordScore;
    private int actionVerbScore;
    private int metricScore;
    private int formatScore;
    
    private List<String> matchedKeywords = new ArrayList<>();
    private List<String> missingKeywords = new ArrayList<>();
    private List<String> detectedActionVerbs = new ArrayList<>();
    private List<String> detectedMetrics = new ArrayList<>();
    private List<String> presentSections = new ArrayList<>();
    private List<String> missingSections = new ArrayList<>();
    private List<String> improvementTips = new ArrayList<>();
    private int wordCount;
    private int characterCount;

    public AtsScanResultDTO() {
    }

    public int getOverallScore() {
        return overallScore;
    }

    public void setOverallScore(int overallScore) {
        this.overallScore = overallScore;
    }

    public String getTargetRoleTitle() {
        return targetRoleTitle;
    }

    public void setTargetRoleTitle(String targetRoleTitle) {
        this.targetRoleTitle = targetRoleTitle;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public int getKeywordScore() {
        return keywordScore;
    }

    public void setKeywordScore(int keywordScore) {
        this.keywordScore = keywordScore;
    }

    public int getActionVerbScore() {
        return actionVerbScore;
    }

    public void setActionVerbScore(int actionVerbScore) {
        this.actionVerbScore = actionVerbScore;
    }

    public int getMetricScore() {
        return metricScore;
    }

    public void setMetricScore(int metricScore) {
        this.metricScore = metricScore;
    }

    public int getFormatScore() {
        return formatScore;
    }

    public void setFormatScore(int formatScore) {
        this.formatScore = formatScore;
    }

    public List<String> getMatchedKeywords() {
        return matchedKeywords;
    }

    public void setMatchedKeywords(List<String> matchedKeywords) {
        this.matchedKeywords = matchedKeywords;
    }

    public List<String> getMissingKeywords() {
        return missingKeywords;
    }

    public void setMissingKeywords(List<String> missingKeywords) {
        this.missingKeywords = missingKeywords;
    }

    public List<String> getDetectedActionVerbs() {
        return detectedActionVerbs;
    }

    public void setDetectedActionVerbs(List<String> detectedActionVerbs) {
        this.detectedActionVerbs = detectedActionVerbs;
    }

    public List<String> getDetectedMetrics() {
        return detectedMetrics;
    }

    public void setDetectedMetrics(List<String> detectedMetrics) {
        this.detectedMetrics = detectedMetrics;
    }

    public List<String> getPresentSections() {
        return presentSections;
    }

    public void setPresentSections(List<String> presentSections) {
        this.presentSections = presentSections;
    }

    public List<String> getMissingSections() {
        return missingSections;
    }

    public void setMissingSections(List<String> missingSections) {
        this.missingSections = missingSections;
    }

    public List<String> getImprovementTips() {
        return improvementTips;
    }

    public void setImprovementTips(List<String> improvementTips) {
        this.improvementTips = improvementTips;
    }

    public int getWordCount() {
        return wordCount;
    }

    public void setWordCount(int wordCount) {
        this.wordCount = wordCount;
    }

    public int getCharacterCount() {
        return characterCount;
    }

    public void setCharacterCount(int characterCount) {
        this.characterCount = characterCount;
    }
}
