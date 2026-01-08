package com.example.onlinetutor.services;

import com.example.onlinetutor.enums.Subject;
import com.example.onlinetutor.models.*;
import com.example.onlinetutor.repositories.ArticleRepo;
import com.example.onlinetutor.repositories.ResourceRepo;
import com.example.onlinetutor.repositories.StudyPlanRepo;
import com.example.onlinetutor.repositories.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Component
public class StudyPlanServiceImpl implements StudyPlanService {

    @Autowired
    private ArticleRepo articleRepo;

    @Autowired
    private StudyPlanRepo studyPlanRepo;
    @Autowired
    private UserRepo userRepo;

    @Autowired
    private ResourceRepo resourceRepo;

    @Override
    public void generatePlanForUser(
            User user,
            List<Long> weakCurriculumResourceIds
    ) {

        studyPlanRepo.deleteByUserId(user.getId());

        List<Resource> resources =
                resourceRepo.findAll().stream()
                        .filter(r ->
                                weakCurriculumResourceIds.contains(
                                        r.getCurriculumResource().getId()
                                )
                        )
                        .toList();

        for (Resource resource : resources) {
            for (Article article : resource.getArticles()) {

                StudyPlan plan = StudyPlan.builder()
                        .user(user)
                        .article(article)
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


    @Override
    public void generateStudyPlanFromTest(AptitudeTest test) {

        User user = userRepo.findById(test.getUserId())
                .orElseThrow(() -> new RuntimeException("User not found"));

        // 1. Weak curriculum topics
        Set<CurriculumResource> weakCurriculumResources =
                test.getQuestions().stream()
                        .filter(q -> q.getUserAnswer() != null)
                        .filter(q -> !q.getUserAnswer().equals(q.getCorrectAnswer()))
                        .map(TestQuestion::getCurriculumResource)
                        .collect(Collectors.toSet());

        if (weakCurriculumResources.isEmpty()) return;

        // 2. Find teacher resources mapped to curriculum topics
        List<Resource> resources =
                resourceRepo.findByCurriculumResourceIn(
                        weakCurriculumResources
                );

        if (resources.isEmpty()) return;

        // 3. Fetch articles
        List<Article> articles =
                articleRepo.findByResourceIn(resources);

        // 4. Create study plan
        for (Article article : articles) {

            if (studyPlanRepo.existsByUserAndArticle(user, article)) {
                continue;
            }

            StudyPlan plan = StudyPlan.builder()
                    .user(user)
                    .article(article)
                    .progress(0.0)
                    .completed(false)
                    .build();

            studyPlanRepo.save(plan);
        }
    }

}
