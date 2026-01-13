package com.example.onlinetutor.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

import java.util.List;
import java.util.Map;

@Data
public class ArticleRecommendationRequest {
    @JsonProperty("topic_weakness")
    private Map<String, Double> topicWeakness;

    @JsonProperty("wrong_answers")
    private List<WrongAnswerDto> wrongAnswers;

    @JsonProperty("articles")
    private List<ArticleDto> articles;

    @JsonProperty("top_k")
    private int topK = 5;
}
