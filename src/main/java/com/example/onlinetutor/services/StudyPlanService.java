package com.example.onlinetutor.services;

import com.example.onlinetutor.enums.Subject;
import com.example.onlinetutor.models.StudyPlan;
import com.example.onlinetutor.models.User;
import com.example.onlinetutor.repositories.StudyPlanRepo;
import org.springframework.stereotype.Component;

import java.util.List;


public interface StudyPlanService {

    void generatePlanForUser(User user, List<Long> weakCurriculumResourceIds);

    List<StudyPlan> getPlanForUser(String email);

    StudyPlan findNextUnfinishedPlan(String email);

    void savePlan(StudyPlan plan);

    StudyPlan getById(Long id);

    boolean hasCompletedPlans(Long userId);

    void createPlansForNewStudyFocus(Long userID, Subject[] newFocusAreas);

}
