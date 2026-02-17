package com.example.onlinetutor.services;

import com.example.onlinetutor.dto.GeneratedExamResponse;
import com.example.onlinetutor.dto.GradeResponse;
import com.example.onlinetutor.enums.Subject;

import java.util.Map;

public interface AIExamService {

    GeneratedExamResponse generateExam(Long userId, Subject subject) throws Exception;

    GradeResponse gradeExam(Long examId,Long userId, Subject subject, Map<Long, Integer> answers);
}
