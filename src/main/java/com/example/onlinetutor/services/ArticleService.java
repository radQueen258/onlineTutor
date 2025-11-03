package com.example.onlinetutor.services;

import com.example.onlinetutor.models.Article;

public interface ArticleService {

    void safeDeleteArticle(Long articleId);
}
