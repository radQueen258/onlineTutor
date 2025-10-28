package com.example.onlinetutor.services;

import com.example.onlinetutor.models.Article;
import com.example.onlinetutor.models.StudyPlan;
import com.example.onlinetutor.models.User;
import com.example.onlinetutor.repositories.ArticleRepo;
import com.example.onlinetutor.repositories.StudyPlanRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Component
public class StudyPlanServiceImpl implements StudyPlanService {

    @Autowired
    private ArticleRepo articleRepo;

    @Autowired
    private StudyPlanRepo studyPlanRepo;

    @Override
    public void generatePlanForUser(User user, List<String> weakTopics) {
        for (String topic : weakTopics) {
            List<Article> relatedArticles = articleRepo.findByArticleTitle(topic);

            for (Article article : relatedArticles) {
                StudyPlan plan = StudyPlan.builder()
                        .article(article)
                        .user(user)
                        .progress(0.0)
                        .completed(false)
                        .build();

                studyPlanRepo.save(plan);
            }
        }
    }

    @Override
    public List<StudyPlan> getPlanForUser(String email) {
        return studyPlanRepo.findByUserEmail(email);
    }

    @Override
    public StudyPlan findNextUnfinishedPlan(String email) {
        return studyPlanRepo
                .findFirstByUserEmailAndCompletedFalseOrderByIdAsc(email);
    }

    @Override
    public void savePlan(StudyPlan plan) {
        studyPlanRepo.save(plan);
    }

    @Override
    public StudyPlan getById(Long id) {
        return studyPlanRepo.findById(id).orElse(null);
    }
}
