package com.example.onlinetutor.controllers;


import com.example.onlinetutor.models.User;
import com.example.onlinetutor.repositories.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.security.Principal;

@Controller
public class DashboardController {

    @Autowired
    private UserRepo userRepo;

    public DashboardController(UserRepo userRepo) {
        this.userRepo = userRepo;
    }

    @GetMapping("/dashboard")
    public String dashboard(Model model, Principal principal) {
        String email = principal.getName();

        User user = userRepo.findByEmail(email).orElseThrow(() -> new RuntimeException("User not found"));

        model.addAttribute("userId", user.getId());
        model.addAttribute("firstName", user.getFirstName());
        model. addAttribute("progress", "60%");
        model.addAttribute("upcoming", "Continue Algebraic Expressions");

        return "dashboard";
    }
}
