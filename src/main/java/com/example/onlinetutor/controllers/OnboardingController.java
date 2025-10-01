package com.example.onlinetutor.controllers;

import com.example.onlinetutor.enums.AptitudeTestStatus;
import com.example.onlinetutor.services.UserService;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Set;

@Controller
public class OnboardingController {

    @Autowired
    private UserService userService;

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
    public String setGoals(HttpSession session,
                           @RequestParam String examLevel,
                           @RequestParam List<String> subjects) {
        Long userId = (Long) session.getAttribute("userId");
        userService.updateOnboarding(userId, examLevel, subjects);

        session.setAttribute("examLevel", examLevel);
        session.setAttribute("subjects", subjects);

        return "redirect:/choose-test";
    }

    @GetMapping("/choose-test")
    public String chooseTest() {
        return "choose-test";
    }

    @PostMapping("/markTestStatus")
    public ResponseEntity<?> markTestStatus(HttpServletResponse response, HttpSession session, @RequestParam AptitudeTestStatus status) {
        Long userId = (Long) session.getAttribute("userId");

        userService.updateAptitudeTestStatus(userId, status);

        Cookie testStatusCookie = new Cookie("aptitudeTestStatus", "NOT_STARTED");
        testStatusCookie.setPath("/");
        testStatusCookie.setHttpOnly(true);
        testStatusCookie.setMaxAge(60 * 60 * 24); // this is for one day
        response.addCookie(testStatusCookie);

        session.setAttribute("testTaken", status == AptitudeTestStatus.COMPLETED);
        return ResponseEntity.ok("Test status updated");
    }


}
