package com.example.onlinetutor.controllers;

import com.example.onlinetutor.dto.TutorAnalyticsDTO;
import com.example.onlinetutor.models.Article;
import com.example.onlinetutor.models.User;
import com.example.onlinetutor.models.Video;
import com.example.onlinetutor.repositories.ArticleRepo;
import com.example.onlinetutor.repositories.QuizQuestionRepo;
import com.example.onlinetutor.repositories.UserRepo;
import com.example.onlinetutor.repositories.VideoRepo;
import com.example.onlinetutor.services.QuizQuestionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.List;

@Controller
public class TutorController {

    @Autowired
    private ArticleRepo articleRepo;

    @Autowired
    private VideoRepo videoRepo;

    @Autowired
    private QuizQuestionService quizQuestionService;

    @Autowired
    private UserRepo userRepo;

    @GetMapping("/tutor/workplace")
    public String workplace(Model model, Principal principal) {
        User tutor = userRepo.findByEmail(principal.getName()).orElseThrow();
        Long tutorId = tutor.getId();
        String tutorName = tutor.getFirstName() + " " + tutor.getLastName();
        List<Article> articles = articleRepo.findByTutorName_Id(tutorId);
        model.addAttribute("articles", articles);
        model.addAttribute("tutorName", tutorName);
        return "workplace";
    }

    @GetMapping("/tutor/article/new")
    public String newArticleForm(Model model) {
        model.addAttribute("article", new Article());
        return "new-article";
    }


    @PostMapping("/tutor/article/save")
    public String createArticle(@ModelAttribute Article article, Principal principal) {
        User tutor = userRepo.findByEmail(principal.getName()).orElseThrow();
        article.setTutorName(tutor);
        articleRepo.save(article);
        return "redirect:/tutor/workplace";
    }

    @GetMapping("/tutor/article/{articleId}/upload-video")
    public String showUploadVideoForm(@PathVariable Long articleId, Model model) {
        Article article = articleRepo.getById(articleId);
        model.addAttribute("article", article);
        model.addAttribute("video", new Video());
        return "upload-video";
    }


    @PostMapping("/tutor/article/{id}/upload-video")
    public String uploadVideo(@PathVariable Long id,
                              @RequestParam("videoTitle") String videoTitle,
                              @RequestParam("videoDescription") String videoDescription,
                              @RequestParam("videoUrl") String videoUrl,
                              Principal principal,
                              Model model) {
        User tutor = userRepo.findByEmail(principal.getName()).orElseThrow();
        Article article = articleRepo.getById(id);

        model.addAttribute("article", article);

        Video video = new Video();
        video.setVideoTitle(videoTitle);
        video.setVideoDescription(videoDescription);
        video.setVideoUrl(videoUrl);
        video.setSubject(article.getSubject());
        video.setTutorName(tutor);
        video.setArticle(article);
        video.setResource(article.getResource());

        videoRepo.save(video);

        return "redirect:/tutor/workplace";
    }

//    ANALYSIS OF STUDENT PERFORMANCE
    @GetMapping("/tutor/analytics")
    public String analytics(Model model, Principal principal) {
        User tutor = userRepo.findByEmail(principal.getName()).orElseThrow();
        List<TutorAnalyticsDTO> stats = quizQuestionService.getTutorAnalytics(tutor.getId());
        System.out.println("HERE IS THE DATA: " +stats);
        model.addAttribute("stats", stats);
        return "analytics";
    }
}
