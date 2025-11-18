package com.example.onlinetutor.services;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

@Component
public class IdVerificationServiceImpl implements IdVerificationService {

    private final RestTemplate restTemplate = new RestTemplate();
    private final ObjectMapper objectMapper = new ObjectMapper();
    private final String verifierUrl = "https://undefaced-marielle-subobliquely.ngrok-free.dev/verify";

    public VerificationResult verifyId(byte[] imageBytes, String filename) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.MULTIPART_FORM_DATA);

        ByteArrayResource bar = new ByteArrayResource(imageBytes) {
            @Override
            public String getFilename() {return filename;}
            @Override
            public long contentLength() {return imageBytes.length;}
        };

        MultiValueMap<String, Object> body = new LinkedMultiValueMap<>();
        body.add("file", bar);
        HttpEntity<MultiValueMap<String, Object>> requestEntity = new HttpEntity<>(body, headers);

        ResponseEntity<String> response = restTemplate.postForEntity(verifierUrl, requestEntity, String.class);
        if (response.getStatusCode().is2xxSuccessful()) {
            return new VerificationResult(false, 0.0, "verifier_error");
        }

        try {
            JsonNode node = objectMapper.readTree(response.getBody());
            boolean accepted = node.path("accepted").asBoolean(false);
            double probability = node.path("probability").asDouble(0.0);
            return new VerificationResult(accepted, probability, node.path("method").asText());
        } catch (Exception e) {
            return new VerificationResult(false, 0.0, "parse_error");
        }
    }



    public static class VerificationResult {
        public final boolean accepted;
        public final double probability;
        public final String method;


//        public VerificationResult(boolean accepted, double probability) {}
        public VerificationResult(boolean accepted, double probability, String method) {
            this.accepted = accepted;
            this.probability = probability;
            this.method = method;
        }
    }

}
