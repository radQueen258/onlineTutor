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

    /**
     * Verifies FRONT and BACK images by calling the ML service twice
     * and combining the probabilities.
     */
    @Override
    public VerificationResult verifyFrontAndBack(
            byte[] frontBytes, String frontFilename,
            byte[] backBytes, String backFilename
    ) {

        VerificationResult frontResult =
                verifySingleImage(frontBytes, frontFilename);

        VerificationResult backResult =
                verifySingleImage(backBytes, backFilename);

        // If either request failed hard
        if (!frontResult.isAccepted() && !backResult.isAccepted()) {
            return new VerificationResult(false, 0.0, "both_failed");
        }

        double avgProbability =
                (frontResult.getProbability() + backResult.getProbability()) / 2.0;

        boolean accepted = avgProbability >= 0.10;

        return new VerificationResult(
                accepted,
                avgProbability,
                "clip_front_back_avg"
        );
    }

    private VerificationResult verifySingleImage(byte[] imageBytes, String filename) {

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.MULTIPART_FORM_DATA);

        MultiValueMap<String, Object> body = new LinkedMultiValueMap<>();
        body.add("file", toResource(imageBytes, filename)); // 🔴 IMPORTANT

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
            e.printStackTrace();
            return new VerificationResult(false, 0.0, "service_unavailable");
        }
    }

    /**
     * Converts byte[] to multipart resource with filename
     */
    private ByteArrayResource toResource(byte[] bytes, String filename) {
        return new ByteArrayResource(bytes) {
            @Override
            public String getFilename() {
                return filename;
            }

            @Override
            public long contentLength() {
                return bytes.length;
            }
        };
    }
}