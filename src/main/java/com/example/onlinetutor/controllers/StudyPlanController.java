package com.example.onlinetutor.controllers;

import com.example.onlinetutor.models.QuizQuestion;
import com.example.onlinetutor.models.StudyPlan;
import com.example.onlinetutor.repositories.StudyPlanRepo;
import com.example.onlinetutor.services.QuizQuestionService;
import com.example.onlinetutor.services.StudyPlanService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.security.Principal;
import java.util.List;
import java.util.Map;

@Controller
public class StudyPlanController {

    @Autowired
    private StudyPlanService studyPlanService;

    @Autowired
    private QuizQuestionService quizQuestionService;

    @GetMapping("/study-plan")
    public String studyPlan(Model model, Principal principal) {
        List<StudyPlan> plans = studyPlanService.getPlanForUser(principal.getName());
        model.addAttribute("plans", plans);
        return "study-plan";
    }

    @GetMapping("/study/continue")
    public String continueStudyPlan(Model model, Principal principal) {
        StudyPlan nextPlan = studyPlanService.findNextUnfinishedPlan(principal.getName());

        if (nextPlan == null) {
            model.addAttribute("message", "All lessons completed!");
            return "study-plan";
        }

        model.addAttribute("plan",  nextPlan);
        model.addAttribute("article", nextPlan.getArticle());
        model.addAttribute("quiz", quizQuestionService.getQuizByArticleId(nextPlan.getArticle().getId()));

        return "study-session";
    }

    @PostMapping("/submit/{planId}")
    public String submitQuiz(@PathVariable Long planId,
                             @RequestParam Map<String, String> answers,
                             Model model) {
        var plan = studyPlanService.getById(planId);
        int score = quizQuestionService.evaluateQuiz(plan.getArticle().getId(), answers);

        if (score >= 2) { // POR AGORA VAMOS USAR ASSIM O CRITERIO PARA PASSAR
            plan.setCompleted(true);
            plan.setProgress(1.0);
            studyPlanService.savePlan(plan);
        }

        model.addAttribute("score", score);
        model.addAttribute("article", plan.getArticle());

        return "study-result";
    }
}
