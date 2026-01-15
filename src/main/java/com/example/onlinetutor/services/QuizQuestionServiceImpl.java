package com.example.onlinetutor.services;

import com.example.onlinetutor.models.QuizAnswer;
import com.example.onlinetutor.models.QuizQuestion;
import com.example.onlinetutor.models.User;
import com.example.onlinetutor.repositories.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Component
public class QuizQuestionServiceImpl implements QuizQuestionService {
    @Autowired
    private QuizQuestionRepo quizQuestionRepo;

    @Autowired
    private QuizAnswerRepo quizAnswerRepo;


    @Override
    public List<QuizQuestion> getQuizByArticleId(Long articleId) {
        return quizQuestionRepo.findByArticleId(articleId);
    }

    @Override
    public int evaluateAndSaveQuiz(Long articleId, Map<String, String> answers, User student) {
        List<QuizQuestion> questions =
                quizQuestionRepo.findByArticleId(articleId);

        int score = 0;

        for (QuizQuestion question : questions) {
            String submittedAnswer =
                    answers.get("q" + question.getId());

            boolean correct = submittedAnswer != null
                    && question.getCorrectAnswer().equals(submittedAnswer);

            if (correct) {
                score++;
            }

//            Here it saves the answers of the student
            QuizAnswer qa = new QuizAnswer();
            qa.setQuestion(question);
            qa.setCorrect(correct);
            System.out.println("Answers map: " + answers);

            quizAnswerRepo.save(qa);
        }

        return score;
    }

    @Override
    public Map<String, Long> findQuestionMistakeStats(Long articleId) {
        List<Object[]> rawStats =
                quizAnswerRepo.findMistakeStatsByArticle(articleId);

        Map<String, Long> result = new LinkedHashMap<>();

        for (Object[] row : rawStats) {
            String question = (String) row[0];
            Long mistakes = (Long) row[1];
            result.put(question, mistakes);
        }

        return result;
    }



}
