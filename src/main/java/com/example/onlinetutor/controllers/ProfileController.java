package com.example.onlinetutor.controllers;

import com.example.onlinetutor.enums.Subject;
import com.example.onlinetutor.models.User;
import com.example.onlinetutor.services.AptitudeTestService;
import com.example.onlinetutor.services.StudyPlanService;
import com.example.onlinetutor.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.parameters.P;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.security.Principal;

@Controller
public class ProfileController {

    @Autowired
    private UserService userService;

    @Autowired
    private StudyPlanService studyPlanService;

    @Autowired
    private AptitudeTestService aptitudeTestService;

    @GetMapping("/profile")
    public String userProfile(@AuthenticationPrincipal UserDetails userDetails,
                              Model model) {
        User user = userService.findByEmail(userDetails.getUsername());
        model.addAttribute("user", user);
        return "/user-and-student/profile";
    }

    @GetMapping("/student/edit")
    public String editProfile(Principal principal, Model model) {

        User user = userService.findByEmail(principal.getName());

        boolean canChangeFocus = studyPlanService.hasCompletedPlans(user.getId());
        model.addAttribute("canChangeFocus", canChangeFocus);
        model.addAttribute("user", user);

        return "/user-and-student/edit-profile";
    }

    @PostMapping("/student/update-password")
    public String updatePassword(Principal principal,
                                 @RequestParam String newPassword) {
        userService.updatePassword(principal.getName(), newPassword);
        return "redirect:/profile";
    }

    @PostMapping("/student/update-focus")
    public String updateFocusAreas(Principal principal, @RequestParam Subject[] focusAreas) {
        User user = userService.findByEmail(principal.getName());

        userService.updateFocusAreas(user.getId(), focusAreas);
//        Arrays.asList(Subject.values()))

        aptitudeTestService.assignNewTest(user.getId(), focusAreas);

        studyPlanService.createPlansForNewStudyFocus(user.getId(), focusAreas);

        return "redirect:/profile";
    }
}
