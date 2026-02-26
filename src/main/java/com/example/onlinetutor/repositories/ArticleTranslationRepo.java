package com.example.onlinetutor.repositories;

import com.example.onlinetutor.models.ArticleTranslation;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface ArticleTranslationRepo extends JpaRepository<ArticleTranslation, Long> {

    Optional<ArticleTranslation> findByArticleIdAndLanguage(Long articleId, String language);

    List<ArticleTranslation> findByLanguage(String language);
}
