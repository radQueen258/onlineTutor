package com.example.onlinetutor.services;

import com.example.onlinetutor.models.ArticleTranslation;

public interface TranslationService {
    String ask(String prompt);
    ArticleTranslation translateArticle(Long articleId, String language);

}
