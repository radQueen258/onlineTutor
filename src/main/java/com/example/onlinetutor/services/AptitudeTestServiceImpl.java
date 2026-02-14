package com.example.onlinetutor.services;

import com.example.onlinetutor.dto.ArticleDto;
import com.example.onlinetutor.dto.ArticleRecommendationRequest;
import com.example.onlinetutor.dto.WrongAnswerDto;
import com.example.onlinetutor.enums.AptitudeTestStatus;
import com.example.onlinetutor.enums.Subject;
import com.example.onlinetutor.models.AptitudeTest;
import com.example.onlinetutor.models.ArticleRecommendation;
import com.example.onlinetutor.models.TestQuestion;
import com.example.onlinetutor.models.User;
import com.example.onlinetutor.repositories.AptitudeTestRepo;
import com.example.onlinetutor.repositories.ArticleRecommendationRepo;
import com.example.onlinetutor.repositories.ArticleRepo;
import com.example.onlinetutor.repositories.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.util.*;


@Component
public class AptitudeTestServiceImpl implements AptitudeTestService {

    @Autowired
    private AptitudeTestRepo testRepository;

    @Autowired
    private UserRepo userRepository;

    @Autowired
    private ArticleRepo articleRepo;

    @Autowired
    private ArticleRecommendationService articleRecommendationService;

    @Autowired
    private ArticleRecommendationRepo articleRecommendationRepo;


    @Override
    public AptitudeTest startTest(Long userId, List<TestQuestion> generatedQuestions) {
//        checking if the aptitude test for that user already exists

        Optional<AptitudeTest> existingOpt =
                testRepository.findAptitudeTestByUserIdAndStatus(userId, AptitudeTestStatus.IN_PROGRESS);

        if (existingOpt.isPresent()) {
            return existingOpt.get(); // Return existing test
        }

//        IF not create a new test
        AptitudeTest test = new AptitudeTest();
        test.setUserId(userId);
        test.setStatus(AptitudeTestStatus.IN_PROGRESS);

        for (TestQuestion q : generatedQuestions) {
            q.setAptitudeTest(test);

            if (q.getOptionEntities() == null) {
                q.setOptionEntities(new ArrayList<>());
            }
        }

        test.setQuestions(generatedQuestions);

        return testRepository.save(test);
    }

    @Override
    public AptitudeTest submitTest(Long testId, Map<Long, String> answers) {
        AptitudeTest test = testRepository.findById(testId)
                .orElseThrow(()->new RuntimeException("test not found"));

        int score = 0;
        for (TestQuestion q: test.getQuestions()) {
            String userAnswer = answers.get(q.getId());
            q.setUserAnswer(userAnswer);

            if (q.getCorrectAnswer().equals(userAnswer)) {
                score++;
            }
        }

        test.setScore(score);
        test.setStatus(AptitudeTestStatus.COMPLETED);
        testRepository.save(test);

// AFTER test.setStatus(COMPLETED)
        Map<Subject, Integer> wrongCounts = new HashMap<>();

        for (TestQuestion q : test.getQuestions()) {
            if (q.getUserAnswer() != null &&
                    !q.getUserAnswer().equals(q.getCorrectAnswer())) {

                wrongCounts.merge(q.getSubject(), 1, Integer::sum);
            }
        }

        int max = wrongCounts.values().stream()
                .max(Integer::compareTo)
                .orElse(1);

// Build topic weakness normalized between 0 and 1
        Map<String, Double> topicWeakness = new HashMap<>();
        wrongCounts.forEach((subject, count) ->
                topicWeakness.put(subject.name(), count / (double) max)
        );

// Build wrong answers DTO
        List<WrongAnswerDto> wrongAnswerDtos = test.getQuestions().stream()
                .filter(q -> q.getUserAnswer() != null &&
                        !q.getUserAnswer().equals(q.getCorrectAnswer()))
                .map(q -> {
                    WrongAnswerDto dto = new WrongAnswerDto();
                    dto.setTopic(q.getSubject().name());
                    dto.setKeywords(Collections.emptyList()); // no keywords yet
                    dto.setDifficulty(3); // default if you don’t track difficulty yet
                    return dto;
                })
                .toList();

// Build articles DTO
        List<ArticleDto> articleDtos = articleRepo.findAll().stream()
                .map(a -> new ArticleDto(
                        a.getId(),
                        a.getSubject().name(),
                        Collections.emptyList(), // no keywords yet
                        3, // difficulty placeholder
                        3  // internalQuestionLevel placeholder
                ))
                .toList();

// Build request DTO
        ArticleRecommendationRequest request = new ArticleRecommendationRequest();
        request.setTopicWeakness(topicWeakness);
        request.setWrongAnswers(wrongAnswerDtos);
        request.setArticles(articleDtos);
        request.setTopK(5);


        Map<String, Object> response = articleRecommendationService.recommend(request);

// Save results
        List<Map<String, Object>> results = (List<Map<String, Object>>) response.get("recommendations");
        for (Map<String, Object> r : results) {
            ArticleRecommendation rec = new ArticleRecommendation();
            rec.setUserId(test.getUserId());
            rec.setArticleId(Long.valueOf(r.get("article_id").toString()));
            rec.setScore(Double.parseDouble(r.get("score").toString()));
            rec.setCreatedAt(LocalDateTime.now());
            articleRecommendationRepo.save(rec);
        }

        return test;

    }

    @Override
    public Map<String, Object> buildRecommendationPayload(
            AptitudeTest test,
            Map<String, Double> topicWeakness
    ) {
        List<Map<String, Object>> articles =
                articleRepo.findAll().stream()
                        .map(article -> {
                            Map<String, Object> map = new HashMap<>();
                            map.put("id", article.getId());
                            map.put("subject", article.getSubject().name());
                            map.put(
                                    "text",
                                    article.getArticleTitle() + " " + article.getArticleContent()
                            );
                            map.put("question_count", article.getQuestions().size());
                            return map;
                        })
                        .toList();

        Map<String, Object> payload = new HashMap<>();
        payload.put("user_id", test.getUserId());
        payload.put("wrong_subjects", topicWeakness);
        payload.put("articles", articles);

        return payload;
    }


    @Override
    public List<AptitudeTest> getAllResults() {
        return testRepository.findAllByOrderByIdDesc();
    }

    @Override
    public Optional<AptitudeTest> getById(Long id) {
        return testRepository.findById(id);
    }

    @Override
    public Optional<User> getUserById(Long userId) {
        return userRepository.findById(userId);
    }

    @Override
    public AptitudeTest findById(Long testId) {
        return null;
    }

    @Override
    public void save(AptitudeTest completed) {
        testRepository.save(completed);
    }

}
