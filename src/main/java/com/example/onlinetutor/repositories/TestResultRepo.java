package com.example.onlinetutor.repositories;

import com.example.onlinetutor.models.Article;
import com.example.onlinetutor.models.TestResult;
import com.example.onlinetutor.models.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Service;

import java.util.List;

public interface TestResultRepo extends JpaRepository<TestResult, Long> {

    Long countByArticleAndPassed(Article article, boolean passed);

    @Query("SELECT qr FROM TestResult qr WHERE qr.article.tutorName = :tutor ")
    List<TestResult> findAllByTutor(@Param("tutor") User tutor);

}
