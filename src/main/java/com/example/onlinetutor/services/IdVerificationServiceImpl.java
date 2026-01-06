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
    public VerificationResult verifyFrontAndBack(
            byte[] frontBytes, String frontFilename,
            byte[] backBytes, String backFilename
    ) {

        VerificationResult front = verifySingle(frontBytes, frontFilename);
        VerificationResult back  = verifySingle(backBytes, backFilename);

        double avg = (front.getProbability() + back.getProbability()) / 2.0;
        boolean accepted = avg >= 0.10;

        return new VerificationResult(accepted, avg, "clip_front_back");
    }

    private VerificationResult verifySingle(byte[] imageBytes, String filename) {

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.MULTIPART_FORM_DATA);

        MultiValueMap<String, Object> body = new LinkedMultiValueMap<>();

        body.add("file", buildFilePart(imageBytes, filename));

        HttpEntity<MultiValueMap<String, Object>> request =
                new HttpEntity<>(body, headers);

        try {
            ResponseEntity<IdVerificationResponse> response =
                    restTemplate.postForEntity(
                            verifierUrl,
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

    private HttpEntity<byte[]> buildFilePart(byte[] data, String filename) {

        HttpHeaders partHeaders = new HttpHeaders();
        partHeaders.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        partHeaders.setContentDispositionFormData("file", filename);
        partHeaders.setContentLength(data.length);

        return new HttpEntity<>(data, partHeaders);
    }
}
