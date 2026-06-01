package com.example.onlinetutor.controllers;

import com.example.onlinetutor.dto.UserForm;
import com.example.onlinetutor.dto.VerificationResult;
import com.example.onlinetutor.enums.Role;
import com.example.onlinetutor.enums.Subject;
import com.example.onlinetutor.models.User;
import com.example.onlinetutor.repositories.SchoolRepo;
import com.example.onlinetutor.repositories.UserRepo;
import com.example.onlinetutor.services.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.context.HttpSessionSecurityContextRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

@Controller
public class SignUpController {

    @Autowired
    private SignUpService signUpService;
    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private IdVerificationServiceImpl idVerificationServiceImpl;

//    @Autowired
//    private GPT4_IdVerificationService idVerificationService;

    @Autowired
    private SchoolRepo schoolRepo;

    @Autowired
    private UserRepo userRepo;

    @GetMapping("/signUp")
    public String signUpPage(Model model) {
        model.addAttribute("subjects", Arrays.asList(Subject.values()));
        model.addAttribute("schools", schoolRepo.findAll());
        return "/general/sign_up_page";
    }


//    USED FOR HF AND CLIP
    @PostMapping("/signUp")
    public String signUp(
            @ModelAttribute UserForm form,
            @RequestParam("frontImage") MultipartFile frontImage,
            @RequestParam("backImage") MultipartFile backImage,
            HttpServletRequest request,
            HttpSession session,
            Model model
    ) {

        if (frontImage.isEmpty() || backImage.isEmpty()) {
            model.addAttribute("errorMessage",
                    "Please upload both front and back images of your ID.");
            return "/general/sign_up_page";
        }

        VerificationResult verificationResult;
        try {
             verificationResult =
                    idVerificationServiceImpl.verifyFrontAndBack(
                            frontImage.getBytes(),
                            frontImage.getOriginalFilename(),
                            backImage.getBytes(),
                            backImage.getOriginalFilename()
                    );


            if (!verificationResult.isAccepted()) {
                model.addAttribute(
                        "errorMessage",
                        "ID verification failed (confidence: " +
                                String.format("%.2f", verificationResult.getProbability()) + ")"
                );
                return "/error/notId";
            }

        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute(
                    "errorMessage",
                    "ID verification service error: " + e.getMessage()
            );
            return "/general/sign_up_page";
        }


        User savedUser = signUpService.addUser(form);

        UsernamePasswordAuthenticationToken token =
                new UsernamePasswordAuthenticationToken(
                        form.getEmail(), form.getPassword());

        Authentication authentication =
                authenticationManager.authenticate(token);

        SecurityContextHolder.getContext().setAuthentication(authentication);

        session = request.getSession(true);
        session.setAttribute(
                HttpSessionSecurityContextRepository.SPRING_SECURITY_CONTEXT_KEY,
                SecurityContextHolder.getContext()
        );

        session.setAttribute("userId", savedUser.getId());
        session.setAttribute("testTaken", false);

        return switch (savedUser.getRole()) {
            case TUTOR -> "redirect:/tutor/workplace";
            case ADMIN -> "redirect:/admin";
            default -> "redirect:/waiting-room";
        };

    }


    @GetMapping("/waiting-room")
    public String waitingRoom(HttpSession session, Model model) {
        Long userId = (Long) session.getAttribute("userId");
        if (userId == null) {
            return "redirect:/signUp"; // fallback
        }
        model.addAttribute("userId", userId);
        return "/general/waiting-room";
    }

    @GetMapping("/signup/status/{userId}")
    @ResponseBody
    public Map<String, Object> checkVerification(@PathVariable Long userId) {

        User user = userRepo.findById(userId).orElseThrow();
        Map<String, Object> response = new HashMap<>();
        response.put("verified", user.isVerified());
        return response;
    }
}

