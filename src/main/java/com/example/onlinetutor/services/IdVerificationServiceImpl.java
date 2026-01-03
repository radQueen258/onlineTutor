package com.example.onlinetutor.services;

import com.example.onlinetutor.dto.IdVerificationResponse;
import com.example.onlinetutor.dto.VerificationResult;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

@Service
public class IdVerificationServiceImpl implements IdVerificationService {

    private final RestTemplate restTemplate;
    private final String verifierUrl;

    public IdVerificationServiceImpl(
            RestTemplate restTemplate,
            @Value("${id-verification.url}") String verifierUrl
    ) {
        this.restTemplate = restTemplate;
        this.verifierUrl = verifierUrl;
    }

    @Override
    public VerificationResult verifyId(byte[] imageBytes, String filename) {

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.MULTIPART_FORM_DATA);

        ByteArrayResource fileResource = new ByteArrayResource(imageBytes) {
            @Override
            public String getFilename() {
                return filename;
            }
        };

        MultiValueMap<String, Object> body = new LinkedMultiValueMap<>();
        body.add("file", fileResource);

        HttpEntity<MultiValueMap<String, Object>> request =
                new HttpEntity<>(body, headers);

        try {
            ResponseEntity<IdVerificationResponse> response =
                    restTemplate.exchange(
                            verifierUrl,
                            HttpMethod.POST,
                            request,
                            IdVerificationResponse.class
                    );

            if (!response.getStatusCode().is2xxSuccessful()
                    || response.getBody() == null) {
                return new VerificationResult(false, 0.0, "verifier_error");
            }

            IdVerificationResponse r = response.getBody();
            return new VerificationResult(
                    r.isAccepted(),
                    r.getProbability(),
                    r.getMethod()
            );

        } catch (Exception e) {
            return new VerificationResult(false, 0.0, "service_unavailable");
        }
    }
}
