package com.example.onlinetutor.services;

import com.example.onlinetutor.dto.TutorAnalyticsDTO;
import com.example.onlinetutor.models.Article;
import com.example.onlinetutor.models.QuizQuestion;
import com.example.onlinetutor.repositories.ArticleRepo;
import com.example.onlinetutor.repositories.QuizQuestionRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Component
public class QuizQuestionServiceImpl implements QuizQuestionService {
    @Autowired
    private QuizQuestionRepo quizQuestionRepo;

    @Autowired
    private ArticleRepo articleRepo;


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
    public List<TutorAnalyticsDTO> getTutorAnalytics(Long tutorId) {
        List<Article> articles = articleRepo.findByUserId(tutorId);
        List<TutorAnalyticsDTO> result = new ArrayList<>();

        for (Article article : articles) {

        }
        return List.of();
    }

}
