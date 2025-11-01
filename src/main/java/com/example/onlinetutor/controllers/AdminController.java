package com.example.onlinetutor.controllers;

import com.example.onlinetutor.models.User;
import com.example.onlinetutor.repositories.ArticleRepo;
import com.example.onlinetutor.repositories.UserRepo;
import com.example.onlinetutor.repositories.VideoRepo;
import com.example.onlinetutor.services.StatisticsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import java.security.Principal;

@Controller
public class AdminController {

    @Autowired
    private ArticleRepo articleRepo;

    @Autowired
    private VideoRepo videoRepo;

    @Autowired
    private UserRepo userRepo;

    @Autowired
    private StatisticsService statisticsService;



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
    public String deleteUser(@PathVariable("id") Long id, Principal principal) {
        User current = userRepo.findByEmail(principal.getName()).orElseThrow();

        if (!current.getId().equals(id)) {
//            TODO: Solve the constrait issue that I can not delete the user without deleting some things before
            articleRepo.deleteArticleByTutorName_Id(id);
            userRepo.deleteById(id);
        }
        return "redirect:/admin/users";
    }

//    -----------------METHODS FOR ARTICLES----------------------

    @GetMapping("/admin/articles")
    public String viewArticles(Model model) {
        model.addAttribute("articles", articleRepo.findAll());
        return "adminArticles";
    }

//    -----------------METHODS FOR VIDEOS---------------------
    @GetMapping("/admin/videos")
    public String viewVideos(Model model) {
        model.addAttribute("videos", videoRepo.findAll());
        return "adminVideos";
    }

//    ---------------STATISTICS----------------------
    @GetMapping("/statistics")
    public String showStatistics(Model model) {
        model.addAttribute("stats", statisticsService.getOverallStatistics());
        return "adminStatistics";
    }
}
