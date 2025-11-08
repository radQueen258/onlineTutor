package com.example.onlinetutor.services;

import com.example.onlinetutor.dto.TutorAnalyticsDTO;
import com.example.onlinetutor.models.Article;
import com.example.onlinetutor.repositories.ArticleRepo;
import com.example.onlinetutor.repositories.QuizQuestionRepo;
import com.example.onlinetutor.repositories.TestResultRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component
public class StatisticsServiceImpl implements StatisticsService{

    @Autowired
    private QuizQuestionRepo quizQuestionRepo;

    @Autowired
    private ArticleRepo articleRepo;

    @Autowired
    private TestResultRepo testResultRepo;

    @Autowired
    private QuizQuestionService quizQuestionService;

    @Override
    public Map<String, Object> getOverallStatistics() {
        Map<String, Object> stats = new HashMap<>();
        stats.put("mostReadArtcle", "Intro to Java");
        stats.put("averageScore", 85);
        return stats;
    }

    @Override
    public List<TutorAnalyticsDTO> getTutorAnalytics(Long tutorId) {
        List<Article> articles = articleRepo.findByTutorName_Id(tutorId);
        List<TutorAnalyticsDTO> result = new ArrayList<>();

        for (Article article : articles) {
            long passed = testResultRepo.countByArticleAndPassed(article, true);
            long failed = testResultRepo.countByArticleAndPassed(article, false);

//            TODO: Later I must have a method to tell me which are the most failed questions

            Map<String, Long> mistakeMap = quizQuestionService.findQuestionMistakeStats(article.getId());

            TutorAnalyticsDTO dto = new TutorAnalyticsDTO(article.getArticleTitle(), passed, failed, mistakeMap);

//            result.add(new TutorAnalyticsDTO(article.getArticleTitle(), passed, failed));
            result.add(dto);
        }
        return result;
    }
}
