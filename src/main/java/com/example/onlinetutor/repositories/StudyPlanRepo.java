package com.example.onlinetutor.repositories;

import com.example.onlinetutor.models.Article;
import com.example.onlinetutor.models.StudyPlan;
import com.example.onlinetutor.models.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

public interface StudyPlanRepo extends JpaRepository<StudyPlan,Long> {

//    void save(StudyPlan plan);
    List<StudyPlan> findByUserEmail(String email);

    StudyPlan findFirstByUserEmailAndCompletedFalseOrderByIdAsc(String email);
    void deleteByUserId(Long id);

//    List<StudyPlan> findAllByUser_IdAndCompletedIsTrue(Long userId, boolean completed);

    List<StudyPlan> findByUser_Id(Long userId);

    boolean existsByUserAndArticle(User user, Article article);

//    StudyPlan findById(Long id);

    List<StudyPlan> findByUser(User user);

    List<StudyPlan> findByUserAndCompletedFalseOrderByIdAsc(User user);
}
