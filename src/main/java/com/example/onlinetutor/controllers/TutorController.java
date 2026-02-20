package com.example.onlinetutor.controllers;

import com.example.onlinetutor.dto.TutorAnalyticsDTO;
import com.example.onlinetutor.enums.Subject;
import com.example.onlinetutor.models.*;
import com.example.onlinetutor.repositories.*;
import com.example.onlinetutor.services.QuizQuestionService;
import com.example.onlinetutor.services.ResourceService;
import com.example.onlinetutor.services.StatisticsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.security.Principal;
import java.util.Arrays;
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

    @Autowired
    private ResourceRepo resourceRepo;

    @Autowired
    private ResourceService resourceService;
    @Autowired
    private StatisticsService statisticsService;

    @Autowired
    private CurriculumResourceRepo curriculumResourceRepo;

    @GetMapping("/tutor/workplace")
    public String workplace(Model model, Principal principal) {
        User tutor = userRepo.findByEmail(principal.getName()).orElseThrow();
        Long tutorId = tutor.getId();
        String tutorName = tutor.getFirstName() + " " + tutor.getLastName();
        List<Article> articles = articleRepo.findByTutorName_Id(tutorId);

        List<Resource> resourcesList = resourceRepo.findAllByTutor_Id(tutorId);


        model.addAttribute("articles", articles);
        model.addAttribute("tutorName", tutorName);
        model.addAttribute("resources", resourcesList);
        return "/tutor/workplace";
    }

    @GetMapping("/tutor/resources/{resourceId}/article/new")
    public String newArticleForm(@PathVariable Long resourceId, Model model) {
        Resource resource = resourceRepo.getById(resourceId);

        Article article = new Article();

        for (int i = 0; i < 3; i++) {
            article.addQuestion(new QuizQuestion());
        }
        article.setResource(resource);
        model.addAttribute("article", article);
        return "/tutor/new-article";
    }


    @PostMapping("/tutor/resources/{resourceId}/article/save")
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

        for (QuizQuestion q : article.getQuestions()) {
            q.setArticle(article);
        }

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
        return "/tutor/view-all-articles";
    }

    @GetMapping("/tutor/resources/{resourceId}/article/{articleId}")
    public String tutorViewArticle(@PathVariable Long resourceId,
                                   @PathVariable Long articleId,
                                   Model model) {
        Article article = articleRepo.findArticlesById(articleId);
        model.addAttribute("article", article);
        model.addAttribute("resourceId", resourceId);

        return "/tutor/view-article";
    }

    @GetMapping("/tutor/resources/{resourceId}/article/{articleId}/upload-video")
    public String showUploadVideoForm(@PathVariable Long articleId,
                                      @PathVariable Long resourceId, Model model) {
        Article article = articleRepo.getById(articleId);
        model.addAttribute("article", article);
        model.addAttribute("video", new Video());
        return "/tutor/upload-video";
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
        List<TutorAnalyticsDTO> stats = statisticsService.getTutorAnalytics(tutor.getId());
        System.out.println("HERE IS THE DATA: " +stats);
        model.addAttribute("stats", stats);
        return "/tutor/analytics";
    }


//    -----------------------FIELD THAT DEALS WITH RESOURCES--------------

//    @GetMapping("/tutor/resources/new")
//    public String showCreateResourceForm(Model model) {
//        model.addAttribute("subjects", Arrays.asList(Subject.values()));
//        model.addAttribute("resource", new Resource());
//        return "/tutor/tutor-create-resource";
//    }

//    @PostMapping("/tutor/resources/save")
//    public String createResource(@ModelAttribute Resource resource,
//                                 Principal principal) {
//        User tutor = userRepo.findUserByEmail(principal.getName());
//        resource.setTutor(tutor);
//        resourceRepo.save(resource);
//        return "redirect:/tutor/workplace";
//    }

    @GetMapping("/tutor/resources/new")
    public String createResourcePage(Model model, Principal principal) {
        User tutor = userRepo.findUserByEmail(principal.getName());

        List<CurriculumResource> availableResources =
                curriculumResourceRepo.findBySubjectIn(tutor.getPreferredSubjects());

        // Remove already-created ones
        List<Resource> existingResources =
                resourceRepo.findByTutor(tutor);

        List<Long> usedIds = existingResources.stream()
                .map(r -> r.getCurriculumResource().getId())
                .toList();

        availableResources.removeIf(cr -> usedIds.contains(cr.getId()));

        model.addAttribute("curriculumResources", availableResources);
        return "/tutor/tutor-create-resource";
    }

    @PostMapping("/tutor/resources/save")
    public String saveResource(@RequestParam Long curriculumResourceId,
                               RedirectAttributes redirectAttributes,
                               Principal principal) {
        User tutor = userRepo.findUserByEmail(principal.getName());

        try {
            // TUTOR call: topicName and subject ignored
            resourceService.createResource(
                    tutor,
                    null,
                    null,
                    curriculumResourceId
            );

            redirectAttributes.addFlashAttribute("success", "Resource created successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }

        return "redirect:/tutor/workplace";
    }



//    -----------------------EDITING ARTICLES AND VIDEOS -----------------------

    @GetMapping("/tutor/article/edit/{articleId}")
    public String editArticleForm(@PathVariable Long articleId, Model model) {
        Article article = articleRepo.findById(articleId)
                .orElseThrow(() -> new IllegalArgumentException("Invalid article ID: " + articleId));

        model.addAttribute("article", article);
        return "/tutor/tutor-edit-article";
    }

    @PostMapping("/tutor/article/edit/{articleId}")
    public String updateArticle(@PathVariable Long articleId,
                                @ModelAttribute Article updatedArticle) {
        Article article = articleRepo.findById(articleId)
                .orElseThrow(() -> new IllegalArgumentException("Invalid article ID: " + articleId));

        if (updatedArticle.getArticleTitle() != null && !updatedArticle.getArticleTitle().trim().isEmpty()) {
            article.setArticleTitle(updatedArticle.getArticleTitle());
        }

        if (updatedArticle.getArticleContent() != null && !updatedArticle.getArticleContent().trim().isEmpty()) {
            article.setArticleContent(updatedArticle.getArticleContent());
        }

        if (updatedArticle.getImageUrl() != null && !updatedArticle.getImageUrl().trim().isEmpty()) {
            article.setImageUrl(updatedArticle.getImageUrl());
        }

        if (updatedArticle.getQuestions() != null) {

            for (int i = 0; i < updatedArticle.getQuestions().size(); i++) {

                if (i < article.getQuestions().size()) {

                    QuizQuestion existing = article.getQuestions().get(i);
                    QuizQuestion incoming = updatedArticle.getQuestions().get(i);

                    existing.setQuestion(incoming.getQuestion());
                    existing.setCorrectAnswer(incoming.getCorrectAnswer());
                    existing.setWrongAnswer1(incoming.getWrongAnswer1());
                    existing.setWrongAnswer2(incoming.getWrongAnswer2());
                    existing.setWrongAnswer3(incoming.getWrongAnswer3());
                }
            }
        }

        articleRepo.save(article);
        return "redirect:/tutor/workplace";
    }

    @GetMapping("/tutor/video/edit/{videoId}")
    public String editVideoForm(@PathVariable Long videoId, Model model) {
        Video video = videoRepo.findById(videoId)
                .orElseThrow(() -> new IllegalArgumentException("Invalid video ID: " + videoId));

        model.addAttribute("video", video);
        return "/tutor/tutor-edit-video";
    }

    @PostMapping("/tutor/video/edit/{videoId}")
    public String updateVideo(@PathVariable Long videoId, @ModelAttribute Video updatedVideo) {
        Video video = videoRepo.findById(videoId)
                .orElseThrow(() -> new IllegalArgumentException("Invalid video ID: " + videoId));

        if (updatedVideo.getVideoTitle() != null && !updatedVideo.getVideoTitle().trim().isEmpty()) {
            video.setVideoTitle(updatedVideo.getVideoTitle());
        }

        if (updatedVideo.getVideoDescription() != null && !updatedVideo.getVideoDescription().trim().isEmpty()) {
            video.setVideoDescription(updatedVideo.getVideoDescription());
        }

        if (updatedVideo.getVideoUrl() != null && !updatedVideo.getVideoUrl().trim().isEmpty()) {
            video.setVideoUrl(updatedVideo.getVideoUrl());
        }

        videoRepo.save(video);
        return "redirect:/tutor/workplace";
    }



}
