package com.example.onlinetutor.controllers;


import com.example.onlinetutor.enums.AptitudeTestStatus;
import com.example.onlinetutor.models.User;
import com.example.onlinetutor.repositories.UserRepo;
import com.example.onlinetutor.services.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.Banner;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.security.Principal;

@Controller
public class DashboardController {

    @Autowired
    private UserRepo userRepo;
    @Autowired
    private UserService userService;

    public DashboardController(UserRepo userRepo) {
        this.userRepo = userRepo;
    }

    @GetMapping("/dashboard")
    public String dashboard(Model model, Principal principal,
                            HttpSession session, Authentication authentication,
                            @RequestParam(value = "status", required = false) AptitudeTestStatus status) {
        System.out.println("Logged in user is: " + authentication.getName());
        String email = authentication.getName();
        User user1 = userRepo.findByEmail(email).orElseThrow(() ->
                new RuntimeException("User not found"));

        Long userId = user1.getId();

        if (user1.getAptitudeTestStatus() !=  AptitudeTestStatus.COMPLETED) {
            userService.updateAptitudeTestStatus(userId, status);
        }

        boolean needsTest = user1.getAptitudeTestStatus() == AptitudeTestStatus.NOT_STARTED;
        model.addAttribute("needsTest", needsTest);

        model.addAttribute("userId", user1.getId());
        model.addAttribute("firstName", user1.getFirstName());
        //TODO: These below need to be changed by the real logic
        model. addAttribute("progress", "60%");
        model.addAttribute("upcoming", "Continue Algebraic Expressions");

        return "dashboard";
    }
}
