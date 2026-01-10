package com.example.onlinetutor.services;

import com.example.onlinetutor.enums.AptitudeTestStatus;
import com.example.onlinetutor.models.AptitudeTest;
import com.example.onlinetutor.models.TestQuestion;
import com.example.onlinetutor.models.User;
import com.example.onlinetutor.repositories.AptitudeTestRepo;
import com.example.onlinetutor.repositories.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Optional;


@Component
public class AptitudeTestServiceImpl implements AptitudeTestService {

    @Autowired
    private AptitudeTestRepo testRepository;

//    @Autowired
//    private TestQuestionRepo questionRepository;

    @Autowired
    private UserRepo userRepository;

//    @Autowired
//    private AptitudeTestRepo aptitudeTestRepository;

//    private static final double WEAK_THRESHOLD = 0.5;


    @Override
    public AptitudeTest startTest(Long userId, List<TestQuestion> generatedQuestions) {
        AptitudeTest test = new AptitudeTest();
        test.setUserId(userId);
        test.setStatus(AptitudeTestStatus.IN_PROGRESS);

        for (TestQuestion q : generatedQuestions) {
            q.setAptitudeTest(test);

            if (q.getOptions() == null) {
                q.setOptions(new ArrayList<>());
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

        return test;
    }

    @Override
    public List<AptitudeTest> getAllResults() {
        return testRepository.findAllByOrderByIdDesc();
    }

    @Override
    public Optional<AptitudeTest> getById(Long id) {
        return testRepository.findById(id);
    }

//    @Override
//    public List<AptitudeTest> getAllTests() {
//        return testRepository.findAllByOrderByIdDesc();
//    }

    @Override
    public Optional<User> getUserById(Long userId) {
        return userRepository.findById(userId);
    }

//    @Override
//    public void assignNewTest(Long userId, Subject[] focusAreas) {
//        for (Subject subject : focusAreas) {
//            AptitudeTest test = new AptitudeTest();
//            test.setUserId(userId);
//            test.setStatus(AptitudeTestStatus.NOT_STARTED);
//            test.setScore(null);
//
//            testRepository.save(test);
//
//
//        }
//    }

//    @Override
//    public List<Long> extractWeakCurriculumResources(AptitudeTest test) {
//        Map<Long, List<TestQuestion>> grouped =
//                test.getQuestions().stream()
//                        .collect(Collectors.groupingBy(
//                                q -> q.getCurriculumResource().getId()
//                        ));
//
//        List<Long> weakResources = new ArrayList<>();
//
//        for (var entry : grouped.entrySet()) {
//            long correct = entry.getValue().stream()
//                    .filter(q -> q.getCorrectAnswer().equals(q.getUserAnswer()))
//                    .count();
//
//            double score = (double) correct / entry.getValue().size();
//
//            if (score < WEAK_THRESHOLD) {
//                weakResources.add(entry.getKey());
//            }
//        }
//
//        return weakResources;
//    }

    @Override
    public AptitudeTest findById(Long testId) {
        return null;
    }

    @Override
    public void save(AptitudeTest completed) {
        testRepository.save(completed);
    }

}
