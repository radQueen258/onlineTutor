package com.example.onlinetutor.controllers;


import com.example.onlinetutor.dto.DashboardStudyPlanInfo;
import com.example.onlinetutor.enums.AptitudeTestStatus;
import com.example.onlinetutor.models.StudyPlan;
import com.example.onlinetutor.models.User;
import com.example.onlinetutor.repositories.StudyPlanRepo;
import com.example.onlinetutor.repositories.UserRepo;
import com.example.onlinetutor.services.StudyPlanService;
import com.example.onlinetutor.services.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.security.Principal;
import java.util.List;

@Controller
public class DashboardController {

    @Autowired
    private UserRepo userRepo;
    @Autowired
    private UserService userService;

    @Autowired
    private StudyPlanService studyPlanService;

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

        if (!needsTest) {
            DashboardStudyPlanInfo info =
                    studyPlanService.getDashboardInfo(user1);

            model.addAttribute("progress", info.getProgressPercent() + "%");
            model.addAttribute("upcoming", info.getUpcoming());
        }


        return "/user-and-student/dashboard";
    }
}
