package com.example.onlinetutor.dto;

import java.util.Map;

public class TutorAnalyticsDTO {
    private String articleTitle;
    private long studentsPassed;
    private long studentsFailed;

    public TutorAnalyticsDTO(String articleTitle, long passed, long failed) {
    }
//    private Map<String, Long> commonMistakes;
}
