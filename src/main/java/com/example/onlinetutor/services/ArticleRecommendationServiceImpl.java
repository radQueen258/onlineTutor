package com.example.onlinetutor.services;

import com.example.onlinetutor.dto.ArticleRecommendationRequest;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
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
        Map<String,Object> payload = new HashMap<>();
        payload.put("topic_weakness", request.getTopicWeakness());
        payload.put("wrong_answers", request.getWrongAnswers());
        payload.put("articles", request.getArticles());
        payload.put("topK", request.getTopK());

        ResponseEntity<Map<String,Object>> response =
                restTemplate.exchange(
                        recommenderUrl,
                        HttpMethod.POST,
                        new HttpEntity<>(payload),
                        new ParameterizedTypeReference<Map<String,Object>>() {}
                );

        return response.getBody();
    }
}
