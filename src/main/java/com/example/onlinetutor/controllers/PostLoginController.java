//package com.example.onlinetutor.controllers;
//
//import com.example.onlinetutor.enums.AptitudeTestStatus;
//import com.example.onlinetutor.models.AptitudeTest;
//import com.example.onlinetutor.models.User;
//import com.example.onlinetutor.services.AptitudeTestService;
//import com.example.onlinetutor.services.UserService;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.security.core.Authentication;
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.GetMapping;
//
//import java.util.Optional;
//
//@Controller
//public class PostLoginController {
//
//    @Autowired
//    private UserService userService;
//
//    @Autowired
//    private AptitudeTestService aptitudeTestService;
//
//    @GetMapping("/post-login")
//    public String postLogin(Authentication auth) {
//
//        User user = userService.getByEmail(auth.getName());
//
//        if (!user.isOnboardingCompleted()) {
//            return "redirect:/onboarding";
//        }
//
//        Optional<AptitudeTest> test =
//                aptitudeTestService.findLatestByUserId(user.getId());
//
//        if (test.isEmpty() || test.get().getStatus() != AptitudeTestStatus.COMPLETED) {
//            return "redirect:/aptitude-test/start";
//        }
//
//        return "redirect:/dashboard";
//    }
//}
