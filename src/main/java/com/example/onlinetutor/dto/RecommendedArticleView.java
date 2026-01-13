package com.example.onlinetutor.dto;

import com.example.onlinetutor.enums.Subject;
import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class RecommendedArticleView {
    private Long articleId;
    private Long resourceId;
    private String title;
    private Subject subject;
    private double score;
}

