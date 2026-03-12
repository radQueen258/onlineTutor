package com.example.onlinetutor.controllers;

import com.example.onlinetutor.enums.AptitudeTestStatus;
import com.example.onlinetutor.enums.Subject;
import com.example.onlinetutor.models.AptitudeTest;
import com.example.onlinetutor.models.CurriculumResource;
import com.example.onlinetutor.models.TestQuestion;
import com.example.onlinetutor.models.User;
import com.example.onlinetutor.repositories.AptitudeTestRepo;
import com.example.onlinetutor.repositories.CurriculumResourceRepo;
import com.example.onlinetutor.repositories.StudyPlanRepo;
import com.example.onlinetutor.repositories.UserRepo;
import com.example.onlinetutor.services.AptitudeGeneratorService;
import com.example.onlinetutor.services.AptitudeTestService;
import com.example.onlinetutor.services.StudyPlanService;
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

@Controller
public class AptitudeTestController {

    @Autowired
    private AptitudeTestService testService;

    @Autowired
    private UserRepo userRepo;

    @Autowired
    private CurriculumResourceRepo curriculumResourceRepo;
    @Autowired
    private AptitudeTestService aptitudeTestService;
    @Autowired
    private StudyPlanService studyPlanService;

    @Autowired
    private AptitudeGeneratorService questionGenerator;

    @Autowired
    private AptitudeTestRepo aptitudeTestRepo;

    @PostMapping("/start/{userId}")
    public ResponseEntity<AptitudeTest> startTest(@PathVariable Long userId) {
        User user = userRepo.findById(userId).orElseThrow();
        List<TestQuestion> questions =
                questionGenerator.generateQuestionsForStudent(user);

        AptitudeTest test = testService.startTest(userId, questions);
        return ResponseEntity.ok(test);
    }

    @GetMapping("/aptitude-test/start")
    public String startTest(HttpSession session, Model model, Authentication authentication) {

        Long userId = (Long) session.getAttribute("userId");
        User user = userRepo.findById(userId).orElseThrow();

        AptitudeTest test = aptitudeTestRepo
                .findByUserIdAndStatus(userId, AptitudeTestStatus.IN_PROGRESS)
                .orElse(null);

        if (test == null || test.getQuestions().isEmpty()) {

            List<TestQuestion> questions =
                    questionGenerator.generateQuestionsForStudent(user);

            test = testService.startTest(userId, questions);
        }

        model.addAttribute("test", test);

        return "/user-and-student/aptitude_test";
    }


    @PostMapping("/aptitude-test/submit/{testId}")
    public String submitTestForm(
            @PathVariable Long testId,
            @RequestParam Map<String, String> params,
            Model model,
            HttpSession session
    ) {

        Map<Long, String> answers = params.entrySet().stream()
                .filter(e -> e.getKey().startsWith("answer_"))
                .collect(Collectors.toMap(
                        e -> Long.parseLong(e.getKey().substring("answer_".length())),
                        Map.Entry::getValue
                ));

        AptitudeTest completed = testService.submitTest(testId, answers);
        model.addAttribute("test", completed);

        session.setAttribute("testTaken", true);

        User user = userRepo.findById(completed.getUserId()).orElseThrow();
        user.setAptitudeTestStatus(AptitudeTestStatus.COMPLETED);
        userRepo.save(user);

        completed.setStatus(AptitudeTestStatus.COMPLETED);
        testService.save(completed); // if not already saved

        studyPlanService.generateStudyPlanFromTest(completed);


        return "/user-and-student/aptitude_thankyou";
    }


}
