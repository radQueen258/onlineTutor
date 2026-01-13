package com.example.onlinetutor.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ArticleDto {
    private Long id;
    private String topic;
    private List<String> keywords;
    private int difficulty;

    @JsonProperty("internal_question_level")
    private int internalQuestionLevel;

//    public static ArticleDto fromEntity(Article article) {
//        return ArticleDto.fromEntity(article);
//    }
}
