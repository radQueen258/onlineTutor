package com.example.onlinetutor.repositories;

import com.example.onlinetutor.models.Article;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Service;

@Service
public interface ArticleRepo extends JpaRepository<Article,Long> {
}
