package com.example.onlinetutor.controllers;

import com.example.onlinetutor.dto.ArticleRecommendationRequest;
import com.example.onlinetutor.services.ArticleRecommendationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.Map;

@Controller
public class ArticleRecommendationController {

    @Autowired
    private ArticleRecommendationService service;

    @PostMapping("/api/articles/recommend")
    public ResponseEntity<?> recommendArticles(
            @RequestBody ArticleRecommendationRequest request
    ) {
        return ResponseEntity.ok(service.recommend(request));
    }
}
