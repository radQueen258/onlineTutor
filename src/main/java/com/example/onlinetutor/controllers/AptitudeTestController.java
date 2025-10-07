package com.example.onlinetutor.controllers;

import com.example.onlinetutor.models.AptitudeTest;
import com.example.onlinetutor.models.TestQuestion;
import com.example.onlinetutor.models.User;
import com.example.onlinetutor.repositories.UserRepo;
import com.example.onlinetutor.services.AptitudeTestService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.stream.Collectors;

import java.util.List;

//@RestController
//@RequestMapping("/api/aptitude-test")
//@RequiredArgsConstructor
@Controller
public class AptitudeTestController {

    @Autowired
    private AptitudeTestService testService;

    @Autowired
    private UserRepo userRepo;

    @PostMapping("/start/{userId}")
    public ResponseEntity<AptitudeTest> startTest(@PathVariable Long userId) {
        // TODO: generate questions dynamically based on profile (examLevel and subjects)
        List<TestQuestion> questions = generateSampleQuestions();
        AptitudeTest test = testService.startTest(userId, questions);

        return ResponseEntity.ok(test);
    }

    @GetMapping("/aptitude-test/start")
    public String startTest(HttpSession session, Model model, Authentication authentication) {
        String email = authentication.getName();

        User user = userRepo.findByEmail(email).orElseThrow(() ->
                new RuntimeException("User not found"));

        Long userId = user.getId();

//        Long userId = (Long) session.getAttribute("userId");
        AptitudeTest test = testService.startTest(userId, generateSampleQuestions());

//        System.out.println("Generated Test: " + test);
//        System.out.println("Questions: " + (test != null ? test.getQuestions() : "test is null"));
        model.addAttribute("test", test);

        return "aptitude_test";
    }


    @PostMapping("/aptitude-test/submit/{testId}")
    public String submitTestForm(
            @PathVariable Long testId,
            @RequestParam Map<String, String> params,
            Model model) {

        Map<Long, String> answers = params.entrySet().stream()
                .filter(entry -> entry.getKey().startsWith("answer_"))
                .collect(Collectors.toMap(
                        entry -> Long.parseLong(entry.getKey().substring("answer_".length())),
                        Map.Entry::getValue
                ));
        AptitudeTest completed = testService.submitTest(testId, answers);
        model.addAttribute("test", completed);
        return "aptitude_thankyou";
    }

//    TODO: This is a temporary method later will brainstorm how to do the real questions generator

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
