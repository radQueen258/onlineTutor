package com.example.onlinetutor.services;

import com.example.onlinetutor.models.AptitudeTest;
import com.example.onlinetutor.models.TestQuestion;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;


public interface AptitudeTestService {
    AptitudeTest startTest(Long userId, List<TestQuestion> generatedQuestions);
    AptitudeTest submitTest(Long testId, Map<Long, String> answers);
}
