package com.example.onlinetutor.repositories;

import com.example.onlinetutor.models.QuizQuestion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Service;

import java.util.List;


public interface QuizQuestionRepo extends JpaRepository<QuizQuestion,Long> {
    List<QuizQuestion> findByArticleId(Long articleId);
    void deleteByArticleId(Long articleId);

    @Query("""
            SELECT q.question AS question, COUNT(a) AS wrongCount
            FROM QuizAnswer a
            JOIN a.question q
            WHERE a.correct = false AND q.article.id = :articleId
            GROUP BY q.question
            ORDER BY wrongCount DESC 
""")
    List<Object[]> findCommonMistakesByArticleId(@Param("articleId") Long articleId);
}
