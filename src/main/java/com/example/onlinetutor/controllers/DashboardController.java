package com.example.onlinetutor.controllers;


import com.example.onlinetutor.dto.DashboardStudyPlanInfo;
import com.example.onlinetutor.dto.RecommendedArticleView;
import com.example.onlinetutor.enums.AptitudeTestStatus;
import com.example.onlinetutor.models.*;
import com.example.onlinetutor.repositories.*;
import com.example.onlinetutor.services.AptitudeTestService;
import com.example.onlinetutor.services.ArticleRecommendationService;
import com.example.onlinetutor.services.StudyPlanService;
import com.example.onlinetutor.services.UserService;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpSession;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.security.Principal;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;

@Controller
public class DashboardController {

    @Autowired
    private UserRepo userRepo;
    @Autowired
    private UserService userService;

    @Autowired
    private StudyPlanService studyPlanService;

    @Autowired
    private ArticleRepo articleRepo;

    @Autowired
    private StudentExamRepo studentExamRepo;

    @Autowired
    private StudentExamRecomRepo studentExamRecomRepo;

    @Autowired
    private ObjectMapper objectMapper;
    @Autowired
    private AptitudeTestService aptitudeTestService;
//    @Autowired
//    private ArticleRecommendationService articleRecommendationService;
//    @Autowired
//    private AptitudeTestService aptitudeTestService;
//    @Autowired
//    private AptitudeTestRepo aptitudeTestRepo;

    @Autowired
    private ArticleRecommendationRepo  articleRecommendationRepo;

    public DashboardController(UserRepo userRepo) {
        this.userRepo = userRepo;
    }

    @GetMapping("/dashboard")
    public String dashboard(Model model, Principal principal,
                            HttpSession session, Authentication authentication,
                            @RequestParam(value = "status", required = false) AptitudeTestStatus status) {

        String email = authentication.getName();
        User user1 = userRepo.findByEmail(email).orElseThrow(() ->
                new RuntimeException("User not found"));

        Long userId = user1.getId();

        List<StudentExam> exams = studentExamRepo.findByUserIdOrderByDateTakenDesc(userId);

        if (user1.getAptitudeTestStatus() !=  AptitudeTestStatus.COMPLETED) {
            userService.updateAptitudeTestStatus(userId, status);
        }

        boolean needsTest = false;
        if (user1.getAptitudeTestStatus() != AptitudeTestStatus.COMPLETED) {
            needsTest = true;
        }

        model.addAttribute("needsTest", needsTest);

        model.addAttribute("userId", user1.getId());
        model.addAttribute("firstName", user1.getFirstName());

//        --------ARTICLE RECOMMENDATION USING ML IN HF--------------
        List<ArticleRecommendation> recs =
                articleRecommendationRepo
                        .findTop5ByUserIdOrderByScoreDesc(userId);

        List<RecommendedArticleView> recommendations = recs.stream()
                .map(rec -> {
                    Article article = articleRepo.findById(rec.getArticleId())
                            .orElse(null);

                    if (article == null || article.getResource() == null) {
                        return null;
                    }

                    return new RecommendedArticleView(
                            article.getId(),
                            article.getResource().getId(),
                            article.getArticleTitle(),
                            article.getSubject(),
                            rec.getScore()
                    );
                })
                .filter(Objects::nonNull)
                .toList();


        if (!needsTest) {
            DashboardStudyPlanInfo info =
                    studyPlanService.getDashboardInfo(user1);

            model.addAttribute("progress", info.getProgressPercent() + "%");
            model.addAttribute("upcoming", info.getUpcoming());
            model.addAttribute("recommendations", recommendations);

        }


//        ===================EXAM SCORES AND WEAK TOPICS=======================
        Map<String, List<CurriculumResource>> examWeakTopics = new HashMap<>();

        for (StudentExam exam : exams) {
            List<StudentExamRecom> recoms =
                    studentExamRecomRepo.findByStudentExam_Id(exam.getId());

            List<CurriculumResource> resources = recoms.stream()
                    .flatMap(r -> r.getRecommendedResources().stream())
                    .distinct()
                    .toList();

            examWeakTopics.put(String.valueOf(exam.getId()), resources);
        }


        model.addAttribute("user", user1);
        model.addAttribute("examWeakTopics", examWeakTopics);
        model.addAttribute("exams", exams.stream()
                .map(e -> Map.of(
                        "id", e.getId(),
                        "subject", e.getSubject(),
                        "dateTaken", e.getDateTaken().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm")),
                        "score", e.getExamScore()
                ))
                .collect(Collectors.toList()));

        model.addAttribute("selectedSubjects", user1.getPreferredSubjects());
        model.addAttribute("studentGrade", user1.getExamLevel());




        return "/user-and-student/dashboard";
    }
}
