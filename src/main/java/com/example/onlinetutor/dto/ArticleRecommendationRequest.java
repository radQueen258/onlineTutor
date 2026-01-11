package com.example.onlinetutor.dto;

import lombok.Data;

import java.util.List;
import java.util.Map;

@Data
public class ArticleRecommendationRequest {
    private Map<String, Double> topicWeakness;
    private List<WrongAnswerDto> wrongAnswers;
    private List<ArticleDto> articles;
    private int topK = 5;
}
