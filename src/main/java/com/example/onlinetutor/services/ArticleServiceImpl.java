package com.example.onlinetutor.services;

import com.example.onlinetutor.models.Article;
import com.example.onlinetutor.models.Video;
import com.example.onlinetutor.repositories.ArticleRepo;
import com.example.onlinetutor.repositories.QuizQuestionRepo;
import com.example.onlinetutor.repositories.UserRepo;
import com.example.onlinetutor.repositories.VideoRepo;
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

    @Autowired
    private VideoRepo videoRepo;

    @Autowired
    private VideoService videoService;


    @Transactional
    @Override
    public void safeDeleteArticle(Long articleId) {

        Article article = articleRepo.findById(articleId)
                .orElseThrow(() -> new IllegalArgumentException("Article not found"));

        if (article.getVideo() != null) {
            Video video = article.getVideo();
            video.setArticle(null);      // VERY IMPORTANT
            article.setVideo(null);
            videoRepo.delete(video);
        }

        quizQuestionRepo.deleteByArticleId(articleId);

        if (article.getResource() != null) {
            article.getResource().getArticles().remove(article);
            article.setResource(null);
        }

        articleRepo.delete(article);
    }



}
