package com.example.onlinetutor.services;

import com.example.onlinetutor.dto.TutorAnalyticsDTO;
import com.example.onlinetutor.models.Article;
import com.example.onlinetutor.models.QuizQuestion;
import com.example.onlinetutor.repositories.ArticleRepo;
import com.example.onlinetutor.repositories.QuizQuestionRepo;
import com.example.onlinetutor.repositories.TestQuestionRepo;
import com.example.onlinetutor.repositories.TestResultRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Component
public class QuizQuestionServiceImpl implements QuizQuestionService {
    @Autowired
    private QuizQuestionRepo quizQuestionRepo;


    @Override
    public List<QuizQuestion> getQuizByArticleId(Long articleId) {
        return quizQuestionRepo.findByArticleId(articleId);
    }

    @Override
    public int evaluateQuiz(Long articleId, Map<String, String> answers) {
        List<QuizQuestion> questions = getQuizByArticleId(articleId);
        int score = 0;

        for (QuizQuestion q : questions) {
            String userAnswer = answers.get("q" + q.getId());
            if (userAnswer != null && userAnswer.equalsIgnoreCase(q.getCorrectAnswer())) {
                score++;
            }
        }
        return score;
    }

    @Override
    public Map<String, Long> findQuestionMistakeStats(Long articleId) {
        List<Object[]> rows = quizQuestionRepo.findCommonMistakesByArticleId(articleId);
        Map<String, Long> map = new LinkedHashMap<>();
        for (Object[] row : rows) {
            map.put((String) row[0], (Long) row[1]);
        }
        return map;
    }

}
