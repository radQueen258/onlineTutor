package com.example.onlinetutor.services;


import com.example.onlinetutor.models.QuizQuestion;
import com.example.onlinetutor.models.User;

import java.util.List;
import java.util.Map;

public interface QuizQuestionService {
    List<QuizQuestion> getQuizByArticleId(Long articleId);
    int evaluateAndSaveQuiz(Long articleId, Map<String, String> answers, User student);
    Map<String, Long> findQuestionMistakeStats(Long articleId);
//    List<TutorAnalyticsDTO> getTutorAnalytics(Long tutorId);


}
