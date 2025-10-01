package com.example.onlinetutor.controllers;

import com.example.onlinetutor.models.AptitudeTest;
import com.example.onlinetutor.models.TestQuestion;
import com.example.onlinetutor.services.AptitudeTestService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/aptitude-test")
@RequiredArgsConstructor
public class AptitudeTestController {

    @Autowired
    private AptitudeTestService testService;

    @PostMapping("/start/{userId}")
    public ResponseEntity<AptitudeTest> startTest(@PathVariable Long userId) {
        // TODO: generate questions dynamically based on profile (examLevel and subjects)
        List<TestQuestion> questions = generateSampleQuestions();
        AptitudeTest test = testService.startTest(userId, questions);

        return ResponseEntity.ok(test);
    }


    @PostMapping("/submit/{testId}")
    public ResponseEntity<AptitudeTest> submitTest(
            @PathVariable Long testId,
            @RequestBody Map<Long, String> answers) {

        AptitudeTest completed = testService.submitTest(testId, answers);
        return ResponseEntity.ok(completed);
    }

//    This is a temporary method later will brainstorm how to do the real questions generator

    private List<TestQuestion> generateSampleQuestions() {
        TestQuestion q1 = new TestQuestion();
        q1.setQuestionText("What is 2 + 2?");
        q1.setOptions(List.of("3", "4", "5"));
        q1.setCorrectAnswer("4");
        q1.setSubject("Math");

        TestQuestion q2 = new TestQuestion();
        q2.setQuestionText("Who discovered gravity?");
        q2.setOptions(List.of("Newton", "Einstein", "Tesla"));
        q2.setCorrectAnswer("Newton");
        q2.setSubject("Physics");

        return List.of(q1, q2);
    }
}
