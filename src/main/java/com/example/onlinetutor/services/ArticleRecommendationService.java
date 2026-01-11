package com.example.onlinetutor.services;

import com.example.onlinetutor.dto.ArticleRecommendationRequest;

import java.util.Map;

public interface ArticleRecommendationService {
    Map<String, Object> recommend(ArticleRecommendationRequest request);
}
