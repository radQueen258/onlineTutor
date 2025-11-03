package com.example.onlinetutor.controllers;

import com.example.onlinetutor.models.AptitudeTest;
import com.example.onlinetutor.models.Article;
import com.example.onlinetutor.models.User;
import com.example.onlinetutor.models.Video;
import com.example.onlinetutor.repositories.ArticleRepo;
import com.example.onlinetutor.repositories.UserRepo;
import com.example.onlinetutor.repositories.VideoRepo;
import com.example.onlinetutor.services.*;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.security.Principal;
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


    @GetMapping("/admin/dashboard")
    public String adminDashboard(Model model, Principal principal) {
        model.addAttribute("adminName", principal.getName());
        model.addAttribute("totalUsers", userRepo.count());
        model.addAttribute("totalArticles",  articleRepo.count());
        model.addAttribute("totalVideos",  videoRepo.count());
        model.addAttribute("statistics", statisticsService.getOverallStatistics());
        return "adminDashboard";
    }

//    ---------------VIEW ALL USERSS -----------------

    @GetMapping("/admin/users")
    public String viewUsers(Model model) {
        model.addAttribute("users", userRepo.findAll());
        return "adminUsers";
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
        return "redirect:/admin/users";
    }

//    -----------------METHODS FOR ARTICLES----------------------

    @GetMapping("/admin/articles")
    public String viewArticles(Model model) {
        model.addAttribute("articles", articleRepo.findAll());
        return "adminArticles";
    }

    @PostMapping("/admin/articles/delete/{id}")
    public String deleteArticle(@PathVariable("id") Long id) {
        articleService.safeDeleteArticle(id);
        return "redirect:/admin/articles";
    }

    @GetMapping("/admin/article/new")
    public String newArticleForm(Model model) {
        model.addAttribute("article", new Article());
        return "admin-new-article";
    }

    @PostMapping("/admin/article/save")
    public String createArticle(@ModelAttribute Article article, Principal principal) {
        User admin = userRepo.findByEmail(principal.getName()).orElseThrow();
        article.setTutorName(admin);
        articleRepo.save(article);
        return "redirect:/admin/articles";
    }

//    -----------------METHODS FOR VIDEOS---------------------
    @GetMapping("/admin/videos")
    public String viewVideos(Model model) {
        model.addAttribute("videos", videoRepo.findAll());
        return "adminVideos";
    }


    @PostMapping("/admin/videos/delete/{id}")
    public String deleteVideo(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
//        System.out.println("🧹 Deleting video ID = " + id);
        videoService.safeDeleteVideoById(id);
//        videoRepo.deleteVideoById(id);
        redirectAttributes.addFlashAttribute("successMessage", "Video deleted successfully!");
        return "redirect:/admin/videos";
    }

    @GetMapping("/admin/article/{articleId}/upload-video")
    public String showUploadVideoForm(@PathVariable Long articleId, Model model) {
        Article article = articleRepo.getById(articleId);
        model.addAttribute("article", article);
        model.addAttribute("video", new Video());
        return "admin-upload-video";
    }

    @PostMapping("/admin/article/{id}/upload-video")
    public String uploadVideo(@PathVariable Long id,
                              @RequestParam("videoTitle") String videoTitle,
                              @RequestParam("videoDescription") String videoDescription,
                              @RequestParam("videoUrl") String videoUrl,
                              Principal principal,
                              Model model) {
        User admin = userRepo.findByEmail(principal.getName()).orElseThrow();
        Article article = articleRepo.getById(id);

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

        return "redirect:/admin/videos";
    }

//    ---------------STATISTICS----------------------
    @GetMapping("/admin/statistics")
    public String showStatistics(Model model) {
        model.addAttribute("stats", statisticsService.getOverallStatistics());
        return "adminStatistics";
    }

    @GetMapping("/admin/aptitude-results")
    public String viewAptitudeResults(Model model) {
        List<AptitudeTest> tests = aptitudeTestService.getAllResults();
//        var results = aptitudeTestService.getAllResults();
        model.addAttribute("tests", tests);
        return "admin-aptitude-results";
    }

    @GetMapping("/admin/aptitude-results/{id}")
    public String viewAptitudeResultDetails(@PathVariable Long id, Model model) {
        var test = aptitudeTestService.getById(id)
                .orElseThrow(() -> new IllegalArgumentException("Test not found"));

        var user = aptitudeTestService.getUserById(test.getUserId()).orElse(null);

        model.addAttribute("test", test);
        model.addAttribute("user", user);
        return "admin-aptitude-result-details";
    }
}
