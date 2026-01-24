package com.example.onlinetutor.services;

import com.example.onlinetutor.models.Article;
import com.example.onlinetutor.models.Video;
import com.example.onlinetutor.repositories.ArticleRepo;
import com.example.onlinetutor.repositories.QuizQuestionRepo;
import com.example.onlinetutor.repositories.VideoRepo;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class ArticleServiceImpl implements ArticleService {
    @Autowired
    ArticleRepo articleRepo;

    @Autowired
    private QuizQuestionRepo quizQuestionRepo;

    @Autowired
    private VideoRepo videoRepo;



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

    @Override
    public Article findById(Long id) {
        Article article = articleRepo.findArticlesById(id);
        return article;
    }


}
