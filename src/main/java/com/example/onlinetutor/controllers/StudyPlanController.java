package com.example.onlinetutor.controllers;

import com.example.onlinetutor.enums.AptitudeTestStatus;
import com.example.onlinetutor.models.AptitudeTest;
import com.example.onlinetutor.models.StudyPlan;
import com.example.onlinetutor.models.User;
import com.example.onlinetutor.repositories.AptitudeTestRepo;
import com.example.onlinetutor.services.AptitudeTestService;
import com.example.onlinetutor.services.QuizQuestionService;
import com.example.onlinetutor.services.StudyPlanService;
import com.example.onlinetutor.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.List;
import java.util.Map;

@Controller
public class StudyPlanController {

    @Autowired
    private StudyPlanService studyPlanService;

    @Autowired
    private QuizQuestionService quizQuestionService;

    @Autowired
    private AptitudeTestRepo aptitudeTestRepo;

    @Autowired
    private AptitudeTestService aptitudeTestService;

    @Autowired
    private UserService userService;

    @GetMapping("/study-plan")
    public String studyPlan(Model model, Principal principal) {
        List<StudyPlan> plans = studyPlanService.getPlanForUser(principal.getName());
        model.addAttribute("plans", plans);
        return "/user-and-student/study-plan";
    }

    @GetMapping("/study/continue")
    public String continueStudyPlan(Model model, Principal principal) {
        StudyPlan nextPlan = studyPlanService.findNextUnfinishedPlan(principal.getName());

        if (nextPlan == null) {
            model.addAttribute("message", "All lessons completed!");
            return "/user-and-student/study-plan";
        }

        model.addAttribute("plan",  nextPlan);
        model.addAttribute("article", nextPlan.getArticle());
        model.addAttribute("quiz", quizQuestionService.getQuizByArticleId(nextPlan.getArticle().getId()));

        return "/user-and-student/study-session";
    }

    @PostMapping("/submit/{planId}")
    public String submitQuiz(@PathVariable Long planId,
                             @RequestParam Map<String, String> answers,
                             Model model) {
        var plan = studyPlanService.getById(planId);
        int score = quizQuestionService.evaluateQuiz(plan.getArticle().getId(), answers);

        if (score >= 2) { // todo: POR AGORA VAMOS USAR ASSIM O CRITERIO PARA PASSAR
            plan.setCompleted(true);
            plan.setProgress(1.0);
            studyPlanService.savePlan(plan);
        }

        model.addAttribute("score", score);
        model.addAttribute("article", plan.getArticle());

        return "/user-and-student/study-result";
    }


    @GetMapping("/debug/generate-plan/{testId}")
    @ResponseBody
    public String generatePlanFromExistingTest(@PathVariable Long testId) {

        AptitudeTest test = aptitudeTestRepo.findById(testId)
                .orElseThrow(() -> new RuntimeException("Test not found"));

        if (test.getStatus() != AptitudeTestStatus.COMPLETED) {
            return "Test is not completed yet";
        }

        studyPlanService.generateStudyPlanFromTest(test);

        return "Study Plan generated from test " + testId;
    }

    @PostMapping("/study-plan/generate/{testId}")
    public String generateStudyPlan(@PathVariable Long testId,
                                    @AuthenticationPrincipal UserDetails userDetails) {

//        User student = userService.findByEmail(userDetails.getUsername());
//        AptitudeTest test = aptitudeTestService.findById(testId);

//        studyPlanService.generateStudyPlan(student, test);

        return "redirect:/study-plan";
    }

}
