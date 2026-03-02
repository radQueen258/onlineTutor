package com.example.onlinetutor.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class GradeResponse {
    private Long examId;
    private double score;
    private double improvement;

    public GradeResponse(double score) {
        this.score = score;
    }

    public GradeResponse(Long id, double score) {
        this.examId = id;
        this.score = score;
    }
}
