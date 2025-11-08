package com.example.onlinetutor.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.HashMap;
import java.util.Map;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class TutorAnalyticsDTO {

    private String articleTitle;
    private long studentsPassed;
    private long studentsFailed;

    private Map<String, Long> commonMistakes = new HashMap<>();
}
