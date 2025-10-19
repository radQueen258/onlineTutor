package com.example.onlinetutor.repositories;

import com.example.onlinetutor.models.StudyPlan;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public interface StudyPlanRepo extends JpaRepository<StudyPlan,Long> {

//    void save(StudyPlan plan);
    List<StudyPlan> findByUserEmail(String email);

    StudyPlan findFirstByUserEmailAndCompletedFalseOrderByIdAsc(String email);

//    StudyPlan findById(Long id);
}
