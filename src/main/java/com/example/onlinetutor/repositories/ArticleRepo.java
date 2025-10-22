package com.example.onlinetutor.repositories;

import com.example.onlinetutor.models.Article;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface ArticleRepo extends JpaRepository<Article,Long> {
    List<Article> findByArticleTitle(String topic);
    List<Article> findByUserId(Long userId);
//    List<Article> findByUserId(Long userId, Pageable pageable);
}
