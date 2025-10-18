package com.example.onlinetutor.repositories;

import com.example.onlinetutor.models.StudyPlan;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface StudyPlanRepo {

    void save(StudyPlan plan);
    List<StudyPlan> findByUserEmail(String email);

    StudyPlan findFirstByUserEmailAndCompletedFalseOrderByIdAsc(String email);

    StudyPlan findById(Long id);
}
