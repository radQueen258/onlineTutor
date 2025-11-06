package com.example.onlinetutor.controllers;

import com.example.onlinetutor.dto.ResourceDto;
import com.example.onlinetutor.dto.TutorAnalyticsDTO;
import com.example.onlinetutor.models.Article;
import com.example.onlinetutor.models.Resource;
import com.example.onlinetutor.models.User;
import com.example.onlinetutor.models.Video;
import com.example.onlinetutor.repositories.*;
import com.example.onlinetutor.services.QuizQuestionService;
import com.example.onlinetutor.services.ResourceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.parameters.P;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

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

    @Autowired
    private ResourceRepo resourceRepo;

    @Autowired
    private ResourceService resourceService;

    @GetMapping("/tutor/workplace")
    public String workplace(Model model, Principal principal) {
        User tutor = userRepo.findByEmail(principal.getName()).orElseThrow();
        Long tutorId = tutor.getId();
        String tutorName = tutor.getFirstName() + " " + tutor.getLastName();
        List<Article> articles = articleRepo.findByTutorName_Id(tutorId);

        List<Resource> resourcesList = resourceRepo.findAll();


        model.addAttribute("articles", articles);
        model.addAttribute("tutorName", tutorName);
        model.addAttribute("resources", resourcesList);
        return "workplace";
    }

    @GetMapping("/tutor/resources/{resourceId}/article/new")
    public String newArticleForm(@PathVariable Long resourceId, Model model) {
        Resource resource = resourceRepo.getById(resourceId);

        Article article = new Article();
        article.setResource(resource);
        model.addAttribute("article", article);
        return "new-article";
    }


    @PostMapping("/tutor/resources/{resourceId}article/save")
    public String createArticle(@ModelAttribute Article article,
                                Principal principal,
                                @PathVariable Long resourceId,
                                Model model) {
        User tutor = userRepo.findByEmail(principal.getName()).orElseThrow();
        Resource resource = resourceRepo.getById(resourceId);
        article.setTutorName(tutor);
        article.setResource(resource);
        article.setSubject(resource.getSubject());

        model.addAttribute("resourceId", resourceId);

        articleRepo.save(article);
        return "redirect:/tutor/workplace";
    }

    @GetMapping("/tutor/resources/{resourceId}/articles")
    public String viewAllArticles (@PathVariable Long resourceId, Model model
    , Principal principal) {
        User tutor = userRepo.findByEmail(principal.getName()).orElseThrow();
        Long tutorId = tutor.getId();

        List<Resource> resources = resourceRepo.findResourceById(resourceId);
        Long numArticles = articleRepo.countByResource_Id(resourceId);

        boolean exists = false;

        if (numArticles > 0) {
            exists = true;
        }

        List<Article> articles = articleRepo.findByTutorName_Id(tutorId);
        model.addAttribute("articles", articles);
        model.addAttribute("resources", resources);
        model.addAttribute("exists", exists);
        return "view-all-articles";
    }

    @GetMapping("/tutor/resources/{resourceId}/article/{articleId}/upload-video")
    public String showUploadVideoForm(@PathVariable Long articleId,
                                      @PathVariable Long resourceId, Model model) {
        Article article = articleRepo.getById(articleId);
        model.addAttribute("article", article);
        model.addAttribute("video", new Video());
        return "upload-video";
    }


    @PostMapping("/tutor/resources/{resourceId}/article/{id}/upload-video/save")
    public String uploadVideo(@PathVariable Long id,
                              @PathVariable Long resourceId,
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

        return "redirect:/tutor/resources/"+resourceId+"/articles";
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


//    -----------------------FIELD THAT DEALS WITH RESOURCES--------------

    @GetMapping("/tutor/resources/new")
    public String showCreateResourceForm(Model model) {
        model.addAttribute("resource", new Resource());
        return "tutor-create-resource";
    }

    @PostMapping("/tutor/resources")
    public String createResource(@ModelAttribute Resource resource, Principal principal) {
        User tutor = userRepo.findUserByEmail(principal.getName());
        resource.setTutor(tutor);
        resourceRepo.save(resource);
        return "redirect:/tutor/workplace";
    }
}
