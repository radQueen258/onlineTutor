package com.example.onlinetutor.services;

import com.example.onlinetutor.dto.VerificationResult;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import java.util.Map;

@Service
public class GPT4_IdVerificationServiceImpl implements GPT4_IdVerificationService {

    private final RestTemplate restTemplate;
    private final String deepSeekUrl;
    private final String apiKey;

    public GPT4_IdVerificationServiceImpl(
            RestTemplate restTemplate,
            @Value("${id-verification.url}") String deepSeekUrl,
            @Value("${openrouter.api.key}") String apiKey // optional if needed
    ) {
        this.restTemplate = restTemplate;
        this.deepSeekUrl = deepSeekUrl;
        this.apiKey = apiKey;
    }




    @Override
    public VerificationResult verifyFrontAndBack(byte[] frontBytes, String frontFilename, byte[] backBytes, String backFilename) {
        {
            MultiValueMap<String, Object> body = new LinkedMultiValueMap<>();
            body.add("front", new ByteArrayResource(frontBytes) {
                @Override public String getFilename() { return frontFilename; }
            });
            body.add("back", new ByteArrayResource(backBytes) {
                @Override public String getFilename() { return backFilename; }
            });

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.MULTIPART_FORM_DATA);

            if (apiKey != null && !apiKey.isEmpty()) {
                headers.set("Authorization", "Bearer " + apiKey);
            }

            HttpEntity<MultiValueMap<String, Object>> request = new HttpEntity<>(body, headers);

            ResponseEntity<Map> response =
                    restTemplate.postForEntity(deepSeekUrl, request, Map.class);

            Map<String, Object> data = response.getBody();
            boolean accepted = false;
            double probability = 0.0;

            if (data != null) {
                accepted = (Boolean) data.getOrDefault("accepted", false);
                probability = ((Number) data.getOrDefault("probability", 0.0)).doubleValue();
            }

            return new VerificationResult(accepted, probability, "deepseek");
        }
    }
}
