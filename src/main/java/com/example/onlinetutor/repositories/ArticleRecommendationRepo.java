package com.example.onlinetutor.repositories;

import com.example.onlinetutor.models.ArticleRecommendation;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ArticleRecommendationRepo extends JpaRepository<ArticleRecommendation, Long> {

    List<ArticleRecommendation>
    findTop5ByUserIdOrderByScoreDesc(Long userId);

    void deleteByUserId(Long userId);
}
