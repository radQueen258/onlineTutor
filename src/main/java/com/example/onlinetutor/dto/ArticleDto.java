package com.example.onlinetutor.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

import java.util.List;

@Data
public class ArticleDto {
    private Long id;
    private String topic;
    private List<String> keywords;
    private int difficulty;

    @JsonProperty("internal_question_level")
    private int internalQuestionLevel;
}
