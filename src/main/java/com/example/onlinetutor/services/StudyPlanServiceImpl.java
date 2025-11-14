package com.example.onlinetutor.services;

import com.example.onlinetutor.enums.Subject;
import com.example.onlinetutor.models.Article;
import com.example.onlinetutor.models.StudyPlan;
import com.example.onlinetutor.models.User;
import com.example.onlinetutor.repositories.ArticleRepo;
import com.example.onlinetutor.repositories.StudyPlanRepo;
import com.example.onlinetutor.repositories.UserRepo;
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
    @Autowired
    private UserRepo userRepo;

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

    @Override
    public boolean hasCompletedPlans(Long userId) {
        List<StudyPlan> plans = studyPlanRepo.findByUser_Id(userId);

        if (plans.isEmpty()) {
            return false;
        }

        for (StudyPlan plan : plans) {
            if (!plan.isCompleted()) {
                return false;
            }
        }
        return true;
    }

    @Override
    public void createPlansForNewStudyFocus(Long userID, Subject[] newFocusAreas) {
        studyPlanRepo.deleteByUserId(userID);

        User user = userRepo.findById(userID).orElse(null);

        for (Subject focusArea : newFocusAreas) {
            StudyPlan plan = new StudyPlan();
            plan.setUser(user);
            plan.setProgress(0);
            plan.setCompleted(false);
//            plan.setArticle(focusArea);
            studyPlanRepo.save(plan);
        }

//        TODO: I Must later on check well the creation of plans
    }

}
