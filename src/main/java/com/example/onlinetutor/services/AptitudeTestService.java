package com.example.onlinetutor.services;

import com.example.onlinetutor.enums.Subject;
import com.example.onlinetutor.models.AptitudeTest;
import com.example.onlinetutor.models.TestQuestion;
import com.example.onlinetutor.models.User;

import java.util.List;
import java.util.Map;
import java.util.Optional;


public interface AptitudeTestService {
    AptitudeTest startTest(Long userId, List<TestQuestion> generatedQuestions);
    AptitudeTest submitTest(Long testId, Map<Long, String> answers);

    Map<String, Object> buildRecommendationPayload(
            AptitudeTest test,
            Map<String, Double> topicWeakness
    );

    List<AptitudeTest> getAllResults();

    Optional<AptitudeTest> getById(Long id);
    Optional<User> getUserById(Long userId);

    AptitudeTest findById(Long testId);

    void save(AptitudeTest completed);

}
