package com.example.onlinetutor.controllers;

import com.example.onlinetutor.dto.TutorAnalyticsDTO;
import com.example.onlinetutor.enums.Grade;
import com.example.onlinetutor.enums.Role;
import com.example.onlinetutor.enums.Subject;
import com.example.onlinetutor.models.*;
import com.example.onlinetutor.repositories.*;
import com.example.onlinetutor.services.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.security.Principal;
import java.util.Arrays;
import java.util.List;

@Controller
public class AdminController {

    @Autowired
    private ArticleRepo articleRepo;

    @Autowired
    private VideoRepo videoRepo;

    @Autowired
    private VideoService videoService;

    @Autowired
    private UserRepo userRepo;

    @Autowired
    private StatisticsService statisticsService;

    @Autowired
    private UserService userService;
    @Autowired
    private ArticleService articleService;

    @Autowired
    private AptitudeTestService aptitudeTestService;

    @Autowired
    private ResourceRepo resourceRepo;

    @Autowired
    private CurriculumResourceRepo curriculumResourceRepo;

    @Autowired
    private QuizQuestionService quizQuestionService;

    @Autowired
    private ResourceService resourceService;


    @GetMapping("/admin/dashboard")
    public String adminDashboard(Model model, Principal principal) {
        User admin = userRepo.findByEmail(principal.getName()).orElseThrow();
        long totalStudents = userRepo.countByRole(Role.STUDENT);
        long totalTutors = userRepo.countByRole(Role.TUTOR);
        model.addAttribute("adminName", admin.getFirstName());
        model.addAttribute("totalStudents", totalStudents);
        model.addAttribute("totalTutors", totalTutors);
        model.addAttribute("totalArticles",  articleRepo.count());
        model.addAttribute("totalVideos",  videoRepo.count());
        model.addAttribute("statistics", statisticsService.getOverallStatistics());
        return "/admin/adminDashboard";
    }

    @GetMapping("/admin/workplace")
    public String adminWorkplace(Model model, Principal principal) {
        User admin = userRepo.findByEmail(principal.getName()).orElseThrow();
        Long adminId = admin.getId();
//        String tutorName = tutor.getFirstName() + " " + tutor.getLastName();
        List<Article> articles = articleRepo.findByTutorName_Id(adminId);

        List<Resource> resourcesList = resourceRepo.findAllByTutor_Id(adminId);


        model.addAttribute("articles", articles);
//        model.addAttribute("tutorName", tutorName);
        model.addAttribute("resources", resourcesList);
        return "/admin/admin-workplace";
    }

//    ---------------VIEW ALL USERSS -----------------

    @GetMapping("/admin/users/tutors")
    public String viewUsers(Model model) {
        model.addAttribute("users", userRepo.findAll());
        model.addAttribute("userStudent", userRepo.findAllByRole(Role.STUDENT));
        model.addAttribute("userTutor", userRepo.findAllByRole(Role.TUTOR));
        return "/admin/adminUsers";
    }

    @GetMapping("/admin/users/students")
    public String viewStudents(Model model) {
        model.addAttribute("users", userRepo.findAll());
        model.addAttribute("userStudent", userRepo.findAllByRole(Role.STUDENT));
//        model.addAttribute("userTutor", userRepo.findAllByRole(Role.TUTOR));
        return "/admin/adminStudents";
    }

    @PostMapping("/admin/users/delete/{id}")
    public String deleteUser(@PathVariable("id") Long id,
                             Principal principal,
                             RedirectAttributes redirectAttributes) {
        User current = userRepo.findByEmail(principal.getName()).orElse(null);

        if (current == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Your session is invalid. Please log in again.");
            return "redirect:/login";
        }
        if (!current.getId().equals(id)) {
            userService.deleteUserAndDependencies(id);
            redirectAttributes.addFlashAttribute("successMessage", "User deleted successfully.");
        }
        return "redirect:/admin/dashboard";
    }

//    -----------------METHODS FOR ARTICLES----------------------

    @GetMapping("/admin/articles")
    public String viewArticles(Model model) {
        model.addAttribute("articles", articleRepo.findAll());
        return "/admin/adminArticles";
    }

    @PostMapping("/admin/articles/delete/{id}")
    public String deleteArticle(@PathVariable("id") Long id) {
        articleService.safeDeleteArticle(id);
        return "redirect:/admin/articles";
    }

    @GetMapping("/admin/resources/{resourceId}/article/new")
    public String newArticleForm(@PathVariable Long resourceId,Model model) {
        Resource resource = resourceRepo.getById(resourceId);

        Article article = new Article();
        for (int i = 0; i < 3; i++) {
            article.addQuestion(new QuizQuestion());
        }
        article.setResource(resource);
        model.addAttribute("article", article);
        return "/admin/admin-new-article";
    }

    @PostMapping("/admin/resources/{resourceId}/article/save")
    public String createArticle(@ModelAttribute Article article,
                                Principal principal,
                                @PathVariable Long resourceId,
                                Model model) {
        User admin = userRepo.findByEmail(principal.getName()).orElseThrow();
        Resource resource = resourceRepo.getById(resourceId);
        article.setTutorName(admin);
        article.setResource(resource);
        article.setSubject(resource.getSubject());

        model.addAttribute("resourceId", resourceId);

        for (QuizQuestion q : article.getQuestions()) {
            q.setArticle(article);
        }

        articleRepo.save(article);
        return "redirect:/admin/workplace";
    }

    @GetMapping("/admin/resources/{resourceId}/article/{articleId}")
    public String tutorViewArticle(@PathVariable Long resourceId,
                                   @PathVariable Long articleId,
                                   Model model) {
        Article article = articleRepo.findArticlesById(articleId);
        model.addAttribute("article", article);
        model.addAttribute("resourceId", resourceId);

        return "/admin/view-article";
    }

//    -----------------METHODS FOR VIDEOS---------------------
    @GetMapping("/admin/videos")
    public String viewVideos(Model model) {
        model.addAttribute("videos", videoRepo.findAll());
        return "/admin/adminVideos";
    }


    @PostMapping("/admin/videos/delete/{id}")
    public String deleteVideo(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
//        System.out.println("🧹 Deleting video ID = " + id);
        videoService.safeDeleteVideoById(id);
//        videoRepo.deleteVideoById(id);
        redirectAttributes.addFlashAttribute("successMessage", "Video deleted successfully!");
        return "redirect:/admin/videos";
    }

    @GetMapping("/admin/resources/{resourceId}/article/{articleId}/upload-video")
    public String showUploadVideoForm(@PathVariable Long articleId,
                                      @PathVariable Long resourceId,
                                      Model model) {
        Article article = articleRepo.getById(articleId);
        model.addAttribute("article", article);
        model.addAttribute("video", new Video());
        return "/admin/admin-upload-video";
    }

    @PostMapping("/admin/resources/{resourceId}/article/{articleId}/upload-video/save")
    public String uploadVideo(@PathVariable Long articleId,
                              @PathVariable Long resourceId,
                              @RequestParam("videoTitle") String videoTitle,
                              @RequestParam("videoDescription") String videoDescription,
                              @RequestParam("videoUrl") String videoUrl,
                              Principal principal,
                              Model model) {
        User admin = userRepo.findByEmail(principal.getName()).orElseThrow();
        Article article = articleRepo.getById(articleId);

        model.addAttribute("article", article);

        Video video = new Video();
        video.setVideoTitle(videoTitle);
        video.setVideoDescription(videoDescription);
        video.setVideoUrl(videoUrl);
        video.setSubject(article.getSubject());
        video.setTutorName(admin);
        video.setArticle(article);
        video.setResource(article.getResource());

        videoRepo.save(video);

        return "redirect:/admin/workplace";
    }

//    ---------------STATISTICS----------------------
    @GetMapping("/admin/statistics")
    public String showStatistics(Model model) {
        model.addAttribute("stats", statisticsService.getOverallStatistics());
        return "/admin/adminStatistics";
    }

    @GetMapping("/admin/aptitude-results")
    public String viewAptitudeResults(Model model) {
        List<AptitudeTest> tests = aptitudeTestService.getAllResults();
//        var results = aptitudeTestService.getAllResults();
        model.addAttribute("tests", tests);
        return "/admin/admin-aptitude-results";
    }

    @GetMapping("/admin/aptitude-results/{id}")
    public String viewAptitudeResultDetails(@PathVariable Long id, Model model) {
        var test = aptitudeTestService.getById(id)
                .orElseThrow(() -> new IllegalArgumentException("Test not found"));

        var user = aptitudeTestService.getUserById(test.getUserId()).orElse(null);

        model.addAttribute("test", test);
        model.addAttribute("user", user);
        return "/admin/admin-aptitude-result-details";
    }

    //    ANALYSIS OF STUDENT PERFORMANCE
    @GetMapping("/admin/analytics")
    public String analytics(Model model, Principal principal) {
        User tutor = userRepo.findByEmail(principal.getName()).orElseThrow();
        List<TutorAnalyticsDTO> stats = statisticsService.getTutorAnalytics(tutor.getId());
        model.addAttribute("stats", stats);
        return "/admin/admin-analytics";
    }

    //    -----------------------FIELD THAT DEALS WITH RESOURCES--------------

    @GetMapping("/admin/create-choice")
    public String showAdminCreateChoice() {
        return "/admin/admin-create-choice";
    }

    @GetMapping("/admin/curriculum-resources/new")
    public String showCurriculumResourcePage(Model model) {
        model.addAttribute("subjects", Arrays.asList(Subject.values()));
        model.addAttribute("grades", Arrays.asList(Grade.values()));
        return "/admin/admin-create-curriculum-resource";
    }


    @GetMapping("/admin/resources/new")
    public String showCreateResourceForm(Model model) {
        model.addAttribute("subjects", Arrays.asList(Subject.values()));
        model.addAttribute("curriculumResources", curriculumResourceRepo.findAll());
        return "/admin/admin-create-resource";
    }

    @PostMapping("/admin/resources/save")
    public String createResource(
            @RequestParam Long curriculumResourceId,
            Principal principal,
            RedirectAttributes redirectAttributes
    ) {

        User admin = userRepo.findUserByEmail(principal.getName());

        try {
            resourceService.createResourceFromCurriculum(
                    admin,
                    curriculumResourceId
            );
            redirectAttributes.addFlashAttribute(
                    "success", "Resource created successfully"
            );
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }

        return "redirect:/admin/workplace";
    }

    @PostMapping("/admin/curriculum-resources/save")
    public String createCurriculumResource(
            @RequestParam String topicName,
            @RequestParam Subject subject,
            @RequestParam Grade grade,
            RedirectAttributes redirectAttributes
    ) {

        CurriculumResource cr = new CurriculumResource();
        cr.setTopicName(topicName);
        cr.setSubject(subject);
        cr.setGrade(grade);

        curriculumResourceRepo.save(cr);

        redirectAttributes.addFlashAttribute("success", "Curriculum resource created");
        return "redirect:/admin/workplace";
    }


    @GetMapping("/admin/resources/{resourceId}/articles")
    public String viewAllArticles (@PathVariable Long resourceId, Model model
            , Principal principal) {
        User admin = userRepo.findByEmail(principal.getName()).orElseThrow();
        Long adminId = admin.getId();

        List<Resource> resources = resourceRepo.findResourceById(resourceId);
        Long numArticles = articleRepo.countByResource_Id(resourceId);

        boolean exists = false;

        if (numArticles > 0) {
            exists = true;
        }

        List<Article> articles = articleRepo.findByTutorName_Id(adminId);
        model.addAttribute("articles", articles);
        model.addAttribute("resources", resources);
        model.addAttribute("exists", exists);
        return "/admin/admin-view-all-articles";
    }

    @GetMapping("/admin/videos/{videoId}")
    public String adminViewVideos(@PathVariable Long videoId,
                                  Model model, Principal principal) {
        Video video = videoRepo.getVideoById(videoId);
        Long resourceId = video.getResource().getId();
        model.addAttribute("video", video);
        model.addAttribute("resourceId", resourceId);
        return  "/admin/admin-view-video";
    }

    //    -----------------------EDITING ARTICLES AND VIDEOS -----------------------

    @GetMapping("/admin/article/edit/{articleId}")
    public String adminEditArticleForm(@PathVariable Long articleId, Model model) {
        Article article = articleRepo.findById(articleId)
                .orElseThrow(() -> new IllegalArgumentException("Invalid article ID: " + articleId));

        model.addAttribute("article", article);
        return "/admin/admin-edit-article";
    }

    @PostMapping("/admin/article/edit/{articleId}")
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

        articleRepo.save(article);
        return "redirect:/admin/workplace";
    }

    @GetMapping("/admin/video/edit/{videoId}")
    public String editVideoForm(@PathVariable Long videoId, Model model) {
        Video video = videoRepo.findById(videoId)
                .orElseThrow(() -> new IllegalArgumentException("Invalid video ID: " + videoId));

        model.addAttribute("video", video);
        return "/admin/admin-edit-video";
    }

    @PostMapping("/admin/video/edit/{videoId}")
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
        return "redirect:/admin/workplace";
    }
}
