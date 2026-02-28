//package com.example.onlinetutor.services;
//
//import com.example.onlinetutor.dto.VerificationResult;
//import org.imgscalr.Scalr;
//import org.springframework.beans.factory.annotation.Value;
//import org.springframework.http.HttpEntity;
//import org.springframework.http.HttpHeaders;
//import org.springframework.http.MediaType;
//import org.springframework.http.ResponseEntity;
//import org.springframework.stereotype.Service;
//import org.springframework.web.client.RestTemplate;
//
//import javax.imageio.ImageIO;
//import java.awt.image.BufferedImage;
//import java.io.ByteArrayInputStream;
//import java.io.ByteArrayOutputStream;
//import java.io.IOException;
//import java.util.Base64;
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//
//@Service
//public class DeepSeekIdVerificationServiceImpl implements IdVerificationService {
//
//    private final RestTemplate restTemplate;
//    private final String openRouterUrl;
//    private final String openRouterApiKey;
//
//    public DeepSeekIdVerificationServiceImpl(
//            RestTemplate restTemplate,
//            @Value("${openrouter.url}") String openRouterUrl,
//            @Value("${openrouter.api.key}") String openRouterApiKey
//    ) {
//        this.restTemplate = restTemplate;
//        this.openRouterUrl = openRouterUrl;
//        this.openRouterApiKey = openRouterApiKey;
//    }
//
//    @Override
//    public VerificationResult verifyFrontAndBack(byte[] frontBytes,
//                                                 String frontFilename,
//                                                 byte[] backBytes,
//                                                 String backFilename) throws IOException {
//
//
//        // 🔥 Resize FRONT image
//        BufferedImage frontOriginal =
//                ImageIO.read(new ByteArrayInputStream(frontBytes));
//
//        BufferedImage frontResized =
//                Scalr.resize(frontOriginal, 600); // max width 600px
//
//        ByteArrayOutputStream frontOut = new ByteArrayOutputStream();
//        ImageIO.write(frontResized, "jpg", frontOut);
//        byte[] frontCompressed = frontOut.toByteArray();
//
//
//        // 🔥 Resize BACK image
//        BufferedImage backOriginal =
//                ImageIO.read(new ByteArrayInputStream(backBytes));
//
//        BufferedImage backResized =
//                Scalr.resize(backOriginal, 600);
//
//        ByteArrayOutputStream backOut = new ByteArrayOutputStream();
//        ImageIO.write(backResized, "jpg", backOut);
//        byte[] backCompressed = backOut.toByteArray();
//
//
//        // 🔥 IMPORTANT: Resize images before Base64 (reduce tokens!)
//        String frontBase64 = Base64.getEncoder().encodeToString(frontBytes);
//        String backBase64 = Base64.getEncoder().encodeToString(backBytes);
//
//        String prompt = """
//        You are an ID verification system.
//
//        Determine if these two images are the front and back of a real government ID card.
//
//        Return ONLY valid JSON:
//        {
//          "accepted": true/false,
//          "probability": number_between_0_and_1
//        }
//        """;
//
//        Map<String, Object> message = Map.of(
//                "role", "user",
//                "content", List.of(
//                        Map.of("type", "text", "text", prompt),
//                        Map.of("type", "image_url",
//                                "image_url", Map.of("url", "data:image/jpeg;base64," + frontBase64)),
//                        Map.of("type", "image_url",
//                                "image_url", Map.of("url", "data:image/jpeg;base64," + backBase64))
//                )
//        );
//
//        Map<String, Object> requestBody = new HashMap<>();
//        requestBody.put("model", "deepseek/deepseek-chat"); // cheap DeepSeek model
//        requestBody.put("messages", List.of(message));
//        requestBody.put("max_tokens", 150); // VERY IMPORTANT for free tier
//
//        HttpHeaders headers = new HttpHeaders();
//        headers.setContentType(MediaType.APPLICATION_JSON);
//        headers.set("Authorization", "Bearer " + openRouterApiKey);
//
//        HttpEntity<Map<String, Object>> request =
//                new HttpEntity<>(requestBody, headers);
//
//        ResponseEntity<Map> response =
//                restTemplate.postForEntity(openRouterUrl, request, Map.class);
//
//        Map body = response.getBody();
//
//        // Extract model response
//        List choices = (List) body.get("choices");
//        Map firstChoice = (Map) choices.get(0);
//        Map messageResponse = (Map) firstChoice.get("message");
//
//        String content = (String) messageResponse.get("content");
//
//        // Parse returned JSON manually (you can use ObjectMapper instead)
//        boolean accepted = content.contains("\"accepted\": true");
//        double probability = accepted ? 0.9 : 0.1;
//
//        return new VerificationResult(accepted, probability, "deepseek");
//    }
//
//
////    @Override
////    public VerificationResult verifyFrontAndBack(byte[] frontBytes, String frontFilename, byte[] backBytes, String backFilename) {
////        {
////            MultiValueMap<String, Object> body = new LinkedMultiValueMap<>();
////            body.add("front", new ByteArrayResource(frontBytes) {
////                @Override public String getFilename() { return frontFilename; }
////            });
////            body.add("back", new ByteArrayResource(backBytes) {
////                @Override public String getFilename() { return backFilename; }
////            });
////
////            HttpHeaders headers = new HttpHeaders();
////            headers.setContentType(MediaType.MULTIPART_FORM_DATA);
////
////            if (apiKey != null && !apiKey.isEmpty()) {
////                headers.set("Authorization", "Bearer " + apiKey);
////            }
////
////            HttpEntity<MultiValueMap<String, Object>> request = new HttpEntity<>(body, headers);
////
////            ResponseEntity<Map> response =
////                    restTemplate.postForEntity(deepSeekUrl, request, Map.class);
////
////            Map<String, Object> data = response.getBody();
////            boolean accepted = false;
////            double probability = 0.0;
////
////            if (data != null) {
////                accepted = (Boolean) data.getOrDefault("accepted", false);
////                probability = ((Number) data.getOrDefault("probability", 0.0)).doubleValue();
////            }
////
////            return new VerificationResult(accepted, probability, "deepseek");
////        }
////    }
//}
