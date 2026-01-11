package com.example.onlinetutor.services;

import com.example.onlinetutor.dto.ArticleRecommendationRequest;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.Map;

@Service
public class ArticleRecommendationServiceImpl implements ArticleRecommendationService {

    private final RestTemplate restTemplate;
    private final String recommenderUrl;


    public ArticleRecommendationServiceImpl(RestTemplate restTemplate,
                        @Value("${hf.article.recommender.url}") String recommenderUrl
    ) {
        this.restTemplate = restTemplate;
        this.recommenderUrl = recommenderUrl;

    }

    @Override
    public Map<String, Object> recommend(ArticleRecommendationRequest request) {

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        HttpEntity<ArticleRecommendationRequest> entity =
                new HttpEntity<>(request, headers);

        return restTemplate.postForObject(
                recommenderUrl + "/recommend",
                entity,
                Map.class
        );
    }
}
