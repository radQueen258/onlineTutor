package com.example.onlinetutor.repositories;

import com.example.onlinetutor.models.Article;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import java.util.List;

@Repository
public interface ArticleRepo extends JpaRepository<Article,Long> {
    List<Article> findByArticleTitle(String topic);
    List<Article> findByTutorName_Id(Long userId);
//    Long count();

    List<Article> findAll();

    void deleteArticleByTutorName_Id(Long tutorNameId);
}
