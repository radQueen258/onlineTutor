package com.example.onlinetutor.services;

import com.example.onlinetutor.dto.AITutorRequest;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import java.util.List;
import java.util.Map;

@Component
public class AITutorServiceImpl implements AITutorService {

    @Value("${llm.api.url}")
    private String apiUrl;

    @Value("${llm.api.key}")
    private String apiKey;

    @Value("${llm.model}")
    private String model;

    @Value("${llm.temperature}")
    private double temperature;

    private final RestTemplate restTemplate = new RestTemplate();


    @Override
    public String askArticleTutor(AITutorRequest req) {

        String systemPrompt = """
                You are an AI tutor inside an online education platform.
                You explain concepts clearly and simply.
                Use ONLY the provided article information.
                If the question is outside the article, say so politely.
                """;

        String userPrompt = """
                Subject: %s
                Article Title: %s
                Article Description: %s
                Source: %s
                
                Student question:
                %s
                """.formatted(
                req.getSubject(),
                req.getTitle(),
                req.getDescription(),
                req.getResource(),
                req.getQuestion()
        );

        // Build DeepSeek request
        Map<String, Object> body = Map.of(
                "model", model,
                "messages", List.of(
                        Map.of("role", "system", "content", systemPrompt),
                        Map.of("role", "user", "content", userPrompt)
                ),
                "temperature", temperature
        );

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.setBearerAuth(apiKey);
        headers.add("HTTP-Referer", "http://localhost");
        headers.add("X-Title", "Online Tutor");

        HttpEntity<Map<String, Object>> entity =
                new HttpEntity<>(body, headers);

        ResponseEntity<Map> response = restTemplate.postForEntity(
                apiUrl,
                entity,
                Map.class
        );

        return extractAnswer(response.getBody());
    }

    private String extractAnswer(Map<String, Object> response) {
        List<Map<String, Object>> choices =
                (List<Map<String, Object>>) response.get("choices");

        Map<String, Object> message =
                (Map<String, Object>) choices.get(0).get("message");

        return message.get("content").toString();
    }


}
