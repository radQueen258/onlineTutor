package com.example.onlinetutor.services;

import com.example.onlinetutor.enums.AptitudeTestStatus;
import com.example.onlinetutor.models.AptitudeTest;
import com.example.onlinetutor.models.TestQuestion;
import com.example.onlinetutor.repositories.AptitudeTestRepo;
import com.example.onlinetutor.repositories.TestQuestionRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Component
public class AptitudeTestServiceImpl implements AptitudeTestService {

    @Autowired
    private AptitudeTestRepo testRepository;

    @Autowired
    private TestQuestionRepo questionRepository;


    @Override
    public AptitudeTest startTest(Long userId, List<TestQuestion> generatedQuestions) {
        AptitudeTest test = new AptitudeTest();
        test.setUserId(userId);
        test.setStatus(AptitudeTestStatus.IN_PROGRESS);

        for (TestQuestion q: generatedQuestions) {
            q.setAptitudeTest(test);
        }
        test.setQuestios(generatedQuestions);

        return testRepository.save(test);
    }

    @Override
    public AptitudeTest submitTest(Long testId, Map<Long, String> answers) {
        AptitudeTest test = testRepository.findById(testId)
                .orElseThrow(()->new RuntimeException("test not found"));

        int score = 0;
        for (TestQuestion q: test.getQuestios()) {
            String userAnswer = answers.get(q.getId());
            q.setUserAnswer(userAnswer);

            if (q.getCorrectAnswer().equals(userAnswer)) {
                score++;
            }
        }

        test.setScore(score);
        test.setStatus(AptitudeTestStatus.COMPLETED);
        return testRepository.save(test);
    }
}
