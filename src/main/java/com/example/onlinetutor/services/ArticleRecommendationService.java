package com.example.onlinetutor.services;

import com.example.onlinetutor.dto.ArticleRecommendationRequest;

import java.util.Map;

public interface ArticleRecommendationService {
//    Map<String, Object> recommend(ArticleRecommendationRequest request);

//    Map<String, Object> recommend(Map<String, Object> payload);

    Map<String, Object> recommend(ArticleRecommendationRequest request);
}
