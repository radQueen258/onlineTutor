package com.example.onlinetutor.services;

import com.example.onlinetutor.repositories.ArticleRepo;
import com.example.onlinetutor.repositories.QuizQuestionRepo;
import com.example.onlinetutor.repositories.UserRepo;
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

    @Transactional
    @Override
    public void safeDeleteArticle(Long articleId) {
        if (articleRepo.findById(articleId).isPresent()) {
            quizQuestionRepo.deleteByArticleId(articleId);
            articleRepo.deleteArticleById(articleId);
        }
    }
}
