package com.example.onlinetutor.dto;

import lombok.Data;

import java.util.List;

@Data
public class ArticleDto {
    private Long id;
    private String topic;
    private List<String> keywords;
    private int difficulty;
    private int internalQuestionLevel;
}
