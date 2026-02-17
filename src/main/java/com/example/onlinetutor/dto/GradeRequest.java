package com.example.onlinetutor.dto;

import com.example.onlinetutor.enums.Subject;
import com.example.onlinetutor.models.User;
import lombok.Getter;
import lombok.Setter;

import java.util.Map;

@Getter
@Setter
public class GradeRequest {
    private Long examId;
    private Long userId;
    private Subject subject;
    private Map<Long, Integer> answers;
}
