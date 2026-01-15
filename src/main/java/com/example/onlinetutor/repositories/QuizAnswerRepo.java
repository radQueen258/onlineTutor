package com.example.onlinetutor.repositories;

import com.example.onlinetutor.models.QuizAnswer;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface QuizAnswerRepo extends JpaRepository<QuizAnswer, Long> {

    @Query("""
        SELECT qa.question.question, COUNT(qa)
        FROM QuizAnswer qa
        WHERE qa.question.article.id = :articleId
          AND qa.correct = false
        GROUP BY qa.question.question
        ORDER BY COUNT(qa) DESC
    """)
    List<Object[]> findMistakeStatsByArticle(@Param("articleId") Long articleId);
}
