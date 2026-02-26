package com.example.onlinetutor.services;

import com.example.onlinetutor.models.Article;
import com.example.onlinetutor.models.ArticleTranslation;
import com.example.onlinetutor.repositories.ArticleRepo;
import com.example.onlinetutor.repositories.ArticleTranslationRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Component
public class TranslationServiceImpl implements TranslationService {

    @Autowired
    private ArticleTranslationRepo translationRepo;

    @Autowired
    private ArticleRepo articleRepo;

    private final RestTemplate restTemplate = new RestTemplate();

    @Value("${translation.api.key}")
    private String apiKey;


    @Override
    public String ask(String prompt) {

        String url = "https://openrouter.ai/api/v1/chat/completions";

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.set("Authorization", "Bearer " + apiKey);
        headers.set("HTTP-Referer", "http://localhost:3000"); // required by OpenRouter
        headers.set("X-Title", "Online Tutor MZ");

        Map<String, Object> body = new HashMap<>();
        body.put("model", "openai/gpt-4o-mini"); // or your current model

        List<Map<String, String>> messages = List.of(
                Map.of("role", "user", "content", prompt)
        );

        body.put("messages", messages);

        HttpEntity<Map<String, Object>> request =
                new HttpEntity<>(body, headers);

        ResponseEntity<Map> response =
                restTemplate.postForEntity(url, request, Map.class);

        List<Map<String, Object>> choices =
                (List<Map<String, Object>>) response.getBody().get("choices");

        Map<String, Object> message =
                (Map<String, Object>) choices.get(0).get("message");

        return (String) message.get("content");

    }

    @Override
    public ArticleTranslation translateArticle(Long articleId, String language) {
        // 1️⃣ Get article
        Article article = articleRepo.findById(articleId)
                .orElseThrow(() -> new RuntimeException("Article not found"));

        // 2️⃣ Check if translation already exists
        Optional<ArticleTranslation> existing =
                translationRepo.findByArticleIdAndLanguage(articleId, language);

        if (existing.isPresent()) {
            return existing.get();
        }

        // 3️⃣ Build prompt
        String prompt = """
                Translate the following educational article into %s.

                Rules:
                - Translate only.
                - Do not summarize.
                - Do not add explanations.
                - Preserve structure.
                - Do NOT translate formulas, variable names or code.
                
                Return the result in this exact format:
                
                TITLE:
                <translated title>
                
                CONTENT:
                <translated content>
                
                Article:
                Title: %s
                Content: %s
              
                """.formatted(language,
                article.getArticleTitle(),
                article.getArticleContent());

        // 4️⃣ Call AI
        String aiResponse = ask(prompt);

        String[] parts = aiResponse.split("CONTENT:");

        String translatedTitle = parts[0].replace("TITLE:", "").trim();
        String translatedContent = parts.length > 1 ? parts[1].trim() : "";

        // ⚠️ Ideally parse title/content separately
        // For now assume whole text returned

        // 5️⃣ Save translation
        ArticleTranslation translation = new ArticleTranslation();
        translation.setArticle(article);
        translation.setLanguage(language);
        translation.setTranslatedTitle(translatedTitle);
        translation.setTranslatedContent(translatedContent);
        translation.setSourceVersion(article.getVersion());

        return translationRepo.save(translation);
    }
}
