package com.example.onlinetutor.repositories;

import com.example.onlinetutor.models.QuizQuestion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Service;

import java.util.List;


public interface QuizQuestionRepo extends JpaRepository<QuizQuestion,Long> {
    List<QuizQuestion> findByArticleId(Long articleId);
    void deleteByArticleId(Long articleId);
}
