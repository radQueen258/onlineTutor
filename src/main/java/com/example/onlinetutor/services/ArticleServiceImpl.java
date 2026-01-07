package com.example.onlinetutor.services;

import com.example.onlinetutor.models.Article;
import com.example.onlinetutor.repositories.ArticleRepo;
import com.example.onlinetutor.repositories.QuizQuestionRepo;
import com.example.onlinetutor.repositories.UserRepo;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class ArticleServiceImpl implements ArticleService {
    @Autowired
    ArticleRepo articleRepo;
    @Autowired
    UserRepo userRepo;
    @Autowired
    private QuizQuestionRepo quizQuestionRepo;

    @PersistenceContext
    private EntityManager em;

    @Transactional
    @Override
    public void safeDeleteArticle(Long articleId) {
        Article article = articleRepo.findById(articleId)
                .orElseThrow(() -> new IllegalArgumentException("Article not found"));

        articleRepo.delete(article);
    }
}
