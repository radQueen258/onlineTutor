package com.example.onlinetutor.controllers;

import com.example.onlinetutor.enums.AptitudeTestStatus;
import com.example.onlinetutor.enums.Subject;
import com.example.onlinetutor.models.User;
import com.example.onlinetutor.repositories.UserRepo;
import com.example.onlinetutor.services.UserService;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;

@Controller
public class OnboardingController {

    @Autowired
    private UserService userService;

    @Autowired
    private UserRepo userRepo;

    @GetMapping("/onboarding")
    public String onboarding(HttpSession session, Model model) {

        Boolean testTaken = (Boolean) session.getAttribute("testTaken");
        if (testTaken == null) {
            session.setAttribute("testTaken", false);
        }
        model.addAttribute("testTaken", testTaken);
        model.addAttribute("subjects", Arrays.asList(Subject.values()));
        return "/user-and-student/onboarding";
    }

    @PostMapping("/setGoals")
    public String setGoals(HttpSession session,
                           @RequestParam String examLevel,
                           @RequestParam List<Subject> subjects) {
        Long userId = (Long) session.getAttribute("userId");
        userService.updateOnboarding(userId,examLevel, subjects);

        userService.updateAptitudeTestStatus(userId, AptitudeTestStatus.NOT_STARTED);

        session.setAttribute("examLevel", examLevel);
        session.setAttribute("subjects", subjects);

        return "redirect:/choose-test";
    }

    @GetMapping("/choose-test")
    public String chooseTest() {
        return "/user-and-student/choose-test";
    }

    @PostMapping("/markTestStatus")
    public String markTestStatus(HttpServletResponse response,
                                            HttpSession session,
                                            @RequestParam(value = "status", required = false) AptitudeTestStatus status) {
        Long userId = (Long) session.getAttribute("userId");

        if (userId == null) {
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            if (auth != null && !auth.getName().equals("anonymousUser")) {
                User user = userRepo.findByEmail(auth.getName()).orElse(null);
                if (user != null) userId = user.getId();
            }
        }

        if (status == null) {
            status = AptitudeTestStatus.NOT_STARTED;
        }

        userService.updateAptitudeTestStatus(userId, status);

        Cookie testStatusCookie = new Cookie("aptitudeTestStatus", "NOT_STARTED");
        testStatusCookie.setPath("/");
        testStatusCookie.setHttpOnly(true);
        testStatusCookie.setMaxAge(60 * 60 * 24); // this is for one day
        response.addCookie(testStatusCookie);

        session.setAttribute("testTaken", status == AptitudeTestStatus.COMPLETED);
        ResponseEntity.ok("Test status updated " + status.name());
        return "redirect:/dashboard";
    }



}
