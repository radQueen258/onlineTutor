package com.example.onlinetutor.dto;

import com.example.onlinetutor.models.GeneratedQuestion;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class GeneratedExamResponse {
    private Long examId;
    private List<GeneratedQuestion> questions;
}
