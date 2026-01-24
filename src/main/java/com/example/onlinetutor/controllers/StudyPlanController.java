package com.example.onlinetutor.controllers;

import com.example.onlinetutor.dto.AITutorRequest;
import com.example.onlinetutor.enums.AptitudeTestStatus;
import com.example.onlinetutor.models.*;
import com.example.onlinetutor.repositories.AptitudeTestRepo;
import com.example.onlinetutor.repositories.TestResultRepo;
import com.example.onlinetutor.repositories.UserRepo;
import com.example.onlinetutor.services.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
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
    private TestResultRepo testResultRepo;

    @Autowired
    private UserRepo userRepo;

    @Autowired
    private AITutorService aiTutorService;

    @Autowired
    private ArticleService articleService;

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
                             Model model, Principal principal) {
        var plan = studyPlanService.getById(planId);
        User student = userRepo.findByEmail(principal.getName()).orElseThrow();
        int score = quizQuestionService.evaluateAndSaveQuiz(plan.getArticle().getId(), answers, student);


        if (score >= 2) { // todo: POR AGORA VAMOS USAR ASSIM O CRITERIO PARA PASSAR
            plan.setCompleted(true);
            plan.setProgress(1.0);
            studyPlanService.savePlan(plan);
        }

        boolean passed = score >= 2;

        TestResult result = new TestResult();
        result.setArticle(plan.getArticle());
        result.setStudent(plan.getUser());
        result.setPassed(passed);

        testResultRepo.save(result);


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


        return "redirect:/study-plan";
    }

//    --------------- AI TUTOR CONTROLLER -----------------------

    @PostMapping("/api/articles/{id}/ask-ai")
    public ResponseEntity<String> askArticleAi(
            @PathVariable Long id,
            @RequestBody Map<String, String> payload
    ) {
        Article article = articleService.findById(id);

        AITutorRequest req = new AITutorRequest(
                article.getSubject(),
                article.getArticleTitle(),
                article.getArticleContent(),
                article.getResource(),
                payload.get("question")
        );

        return ResponseEntity.ok(
                aiTutorService.askArticleTutor(req)
        );
    }


}
