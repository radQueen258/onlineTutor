package com.example.onlinetutor.controllers;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class OnboardingController {

    @GetMapping("/onboarding")
    public String onboarding(HttpSession session, Model model) {

        Boolean testTaken = (Boolean) session.getAttribute("testTaken");
        if (testTaken == null) {
            session.setAttribute("testTaken", false);
        }
        model.addAttribute("testTaken", testTaken);
        return "onboarding";
    }

    @PostMapping("/setGoals")
    public String setGoals(HttpSession session, @RequestParam String examLevel, @RequestParam List<String> subjects) {
        session.setAttribute("examLevel", examLevel);
        session.setAttribute("subjects", subjects);
        return "redirect:/dashboard";
    }

    @PostMapping("/markTestStatus")
    public ResponseEntity<?> markTestStatus(HttpServletResponse response) {
        Cookie testStatusCookie = new Cookie("aptitudeTestStatus", "NOT_STARTED");
        testStatusCookie.setPath("/");
        testStatusCookie.setHttpOnly(true);
        testStatusCookie.setMaxAge(60 * 60 * 24); // this is for one day
        response.addCookie(testStatusCookie);
        return ResponseEntity.ok("Cookie Set");
    }


}
