package com.example.onlinetutor.services;


import com.example.onlinetutor.dto.TutorAnalyticsDTO;
import com.example.onlinetutor.models.QuizQuestion;

import java.util.List;
import java.util.Map;

public interface QuizQuestionService {
    List<QuizQuestion> getQuizByArticleId(Long articleId);
    int evaluateQuiz(Long articleId, Map<String, String> answers);

    List<TutorAnalyticsDTO> getTutorAnalytics(Long tutorId);
}
