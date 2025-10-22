package com.example.onlinetutor.controllers;

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
        List<Article> articles = articleRepo.findByUserId(tutorId);
        model.addAttribute("articles", articles);
        return "tutor/workplace";
    }

    @GetMapping("/tutor/article/new")
    public String newArticleForm(Model model) {
        model.addAttribute("article", new Article());
        return "tutor/new-article";
    }


    @PostMapping("/tutor/article")
    public String createArticle(@ModelAttribute Article article, Principal principal) {
        User tutor = userRepo.findByEmail(principal.getName()).orElseThrow();
        article.setTutorName(tutor);
        articleRepo.save(article);
        return "redirect:/tutor/workplace";
    }

    @PostMapping("/tutor/article/{id}/upload-video")
    public String uploadVideo(@PathVariable Long id,
                              @RequestParam("videoTitle") String videoTitle,
                              @RequestParam("videoDescription") String videoDescription,
                              @RequestParam("videoUrl") String videoUrl,
                              @RequestParam("subject") String subject,
                              Principal principal) {
        User tutor = userRepo.findByEmail(principal.getName()).orElseThrow();
        Article article = articleRepo.getById(id);

        Video video = new Video();
        video.setVideoTitle(videoTitle);
        video.setVideoDescription(videoDescription);
        video.setVideoUrl(videoUrl);
        video.setSubject(subject);
        video.setTutorName(tutor);
        video.setArticle(article);

        videoRepo.save(video);

        return "redirect:/tutor/workplace";
    }

    @GetMapping("/tutor/analytics")
    public String analytics(Model model, Principal principal) {
        User tutor = userRepo.findByEmail(principal.getName()).orElseThrow();
        var stats = quizQuestionService.getTutorAnalytics(tutor.getId());

        model.addAttribute("stats", stats);
        return "tutor/analytics";
    }
}
