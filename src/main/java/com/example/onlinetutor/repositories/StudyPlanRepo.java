package com.example.onlinetutor.repositories;

import com.example.onlinetutor.models.Article;
import com.example.onlinetutor.models.StudyPlan;
import com.example.onlinetutor.models.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface StudyPlanRepo extends JpaRepository<StudyPlan,Long> {

//    List<StudyPlan> findByUserEmail(String email);

    StudyPlan findFirstByUserEmailAndCompletedFalseOrderByIdAsc(String email);
    void deleteByUserId(Long id);

    List<StudyPlan> findByUser_Id(Long userId);

    boolean existsByUserAndArticle(User user, Article article);

    List<StudyPlan> findByUser(User user);

//    List<StudyPlan> findByUserAndCompletedFalseOrderByIdAsc(User user);

    List<StudyPlan> findByUserEmailAndArchivedFalse(String email);
}
