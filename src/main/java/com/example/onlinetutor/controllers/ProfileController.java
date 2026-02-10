package com.example.onlinetutor.controllers;

import com.example.onlinetutor.enums.AptitudeTestStatus;
import com.example.onlinetutor.enums.Grade;
import com.example.onlinetutor.enums.Subject;
import com.example.onlinetutor.models.User;
import com.example.onlinetutor.repositories.AptitudeTestRepo;
import com.example.onlinetutor.repositories.StudyPlanRepo;
import com.example.onlinetutor.repositories.UserRepo;
import com.example.onlinetutor.services.AptitudeTestService;
import com.example.onlinetutor.services.StudyPlanService;
import com.example.onlinetutor.services.UserService;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
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
import java.util.ArrayList;
import java.util.Arrays;

@Controller
public class ProfileController {

    @Autowired
    private UserService userService;

    @Autowired
    private StudyPlanService studyPlanService;

    @Autowired
    private AptitudeTestService aptitudeTestService;

    @Autowired
    private UserRepo userRepo;

    @Autowired
    private StudyPlanRepo studyPlanRepo;

    @Autowired
    private AptitudeTestRepo aptitudeTestRepo;

    @GetMapping("/profile")
    public String userProfile(@AuthenticationPrincipal UserDetails userDetails,
                              Model model) {
        User user = userService.findByEmail(userDetails.getUsername());
        boolean canChangeFocus =
                studyPlanService.hasCompletedPlans(user.getId());

        model.addAttribute("canChangeFocus", canChangeFocus);
        model.addAttribute("user", user);

        return "/user-and-student/profile";
    }

    @GetMapping("/tutor/profile")
    public String tutorProfile(@AuthenticationPrincipal UserDetails userDetails,
                              Model model) {
        User user = userService.findByEmail(userDetails.getUsername());

        model.addAttribute("user", user);

//        TODO: I must have a function to help the tutor chnage the subject he/she teaches

        return "/tutor/tutor-profile";
    }

    @GetMapping("/student/edit")
    public String editProfile(Principal principal, Model model) {

        User user = userService.findByEmail(principal.getName());

        boolean canChangeFocus = studyPlanService.hasCompletedPlans(user.getId());
        model.addAttribute("canChangeFocus", canChangeFocus);
        model.addAttribute("user", user);
        model.addAttribute("subjects", Arrays.asList(Subject.values()));
        model.addAttribute("grades", Arrays.asList(Grade.values()));

        return "/user-and-student/edit-profile";
    }

    @GetMapping("/tutor/edit")
    public String tutorEditProfile(Principal principal, Model model) {

        User user = userService.findByEmail(principal.getName());

//        boolean canChangeFocus = studyPlanService.hasCompletedPlans(user.getId());
//        model.addAttribute("canChangeFocus", canChangeFocus);
        model.addAttribute("user", user);
        model.addAttribute("subjects", Arrays.asList(Subject.values()));
//        model.addAttribute("grades", Arrays.asList(Grade.values()));

        return "/tutor/tutor-edit-profile";
    }

    @PostMapping("/student/update-password")
    public String updatePassword(Principal principal,
                                 @RequestParam String newPassword) {
        userService.updatePassword(principal.getName(), newPassword);
        return "redirect:/profile";
    }

    @PostMapping("/tutor/update-password")
    public String tutorUpdatePassword(Principal principal,
                                 @RequestParam String newPassword) {
        userService.updatePassword(principal.getName(), newPassword);
        return "redirect:/tutor/profile";
    }

    @Transactional
    @PostMapping("/student/update-focus")
    public String updateFocus(
            @RequestParam("focusAreas") Subject[] focusAreas,
            @RequestParam("grade") Grade grade,
            Authentication authentication
    ) {
        User user = userService.findByEmail(authentication.getName());


        if (!studyPlanService.hasCompletedPlans(user.getId())) {
            throw new RuntimeException("Cannot change focus before completing study plan");
        }

//        studyPlanRepo.deleteByUserId(user.getId());
        studyPlanService.archiveStudyPlans(user.getId());
        user.setAptitudeTestStatus(AptitudeTestStatus.NOT_STARTED);
        user.setPreferredSubjects(new ArrayList<>(Arrays.asList(focusAreas)));

        user.setExamLevel(grade);
        user.setAptitudeTestStatus(AptitudeTestStatus.NOT_STARTED);
        userRepo.save(user);

        return "redirect:/aptitude-test/start";
    }


    @Transactional
    @PostMapping("/tutor/update-focus")
    public String updateSubjectTutor(
            @RequestParam("focusAreas") Subject[] focusAreas,
            Authentication authentication
    ) {
        User user = userService.findByEmail(authentication.getName());
        user.setPreferredSubjects(new ArrayList<>(Arrays.asList(focusAreas)));


        userRepo.save(user);

        return "redirect:/tutor/profile";
    }

}
