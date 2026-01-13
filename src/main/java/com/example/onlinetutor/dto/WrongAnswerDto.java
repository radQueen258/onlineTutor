package com.example.onlinetutor.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class WrongAnswerDto {
    private String topic;
    private List<String> keywords;
    private int difficulty;
}
