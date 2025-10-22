package com.example.onlinetutor.dto;

import java.util.Map;

public class TutorAnalyticsDTO {
    private String articleTitle;
    private long studentsPassed;
    private long studentsFailed;
    private Map<String, Long> commonMistakes;
}
