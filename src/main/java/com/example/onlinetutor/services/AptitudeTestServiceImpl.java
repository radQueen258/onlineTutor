package com.example.onlinetutor.services;

import com.example.onlinetutor.enums.AptitudeTestStatus;
import com.example.onlinetutor.models.AptitudeTest;
import com.example.onlinetutor.models.TestQuestion;
import com.example.onlinetutor.models.User;
import com.example.onlinetutor.repositories.AptitudeTestRepo;
import com.example.onlinetutor.repositories.TestQuestionRepo;
import com.example.onlinetutor.repositories.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;
import java.util.Optional;

@Component
public class AptitudeTestServiceImpl implements AptitudeTestService {

    @Autowired
    private AptitudeTestRepo testRepository;

    @Autowired
    private TestQuestionRepo questionRepository;

    @Autowired
    private UserRepo userRepository;


    @Override
    public AptitudeTest startTest(Long userId, List<TestQuestion> generatedQuestions) {
        AptitudeTest test = new AptitudeTest();
        test.setUserId(userId);
        test.setStatus(AptitudeTestStatus.IN_PROGRESS);

        for (TestQuestion q: generatedQuestions) {
            q.setAptitudeTest(test);
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

    @Override
    public List<AptitudeTest> getAllTests() {
        return testRepository.findAllByOrderByIdDesc();
    }

    @Override
    public Optional<User> getUserById(Long userId) {
        return userRepository.findById(userId);
    }
}
