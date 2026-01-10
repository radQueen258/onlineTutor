package com.example.onlinetutor.controllers;

import com.example.onlinetutor.dto.UserForm;
import com.example.onlinetutor.dto.VerificationResult;
import com.example.onlinetutor.enums.Role;
import com.example.onlinetutor.enums.Subject;
import com.example.onlinetutor.models.User;
import com.example.onlinetutor.services.IdVerificationServiceImpl;
import com.example.onlinetutor.services.SignUpService;
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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Arrays;

@Controller
public class SignUpController {

    @Autowired
    private SignUpService signUpService;
    @Autowired
    private AuthenticationManager authenticationManager;
    @Autowired
    private IdVerificationServiceImpl idVerificationServiceImpl;

    private VerificationResult verificationResult;

    @GetMapping("/signUp")
    public String signUpPage(Model model) {
        model.addAttribute("subjects", Arrays.asList(Subject.values()));
        return "/user-and-student/sign_up_page";
    }

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
            return "/user-and-student/sign_up_page";
        }

        System.out.println("Front filename: " + frontImage.getOriginalFilename());
        System.out.println("Front size: " + frontImage.getSize());

        System.out.println("Back filename: " + backImage.getOriginalFilename());
        System.out.println("Back size: " + backImage.getSize());


        try {
            VerificationResult result =
                    idVerificationServiceImpl.verifyFrontAndBack(
                            frontImage.getBytes(),
                            frontImage.getOriginalFilename(),
                            backImage.getBytes(),
                            backImage.getOriginalFilename()
                    );

            System.out.println("THE RESULT IS: " + result.getProbability());
            System.out.println("Accepted: " + result.isAccepted());
            System.out.println("Method: " + result.getMethod());


            if (!result.isAccepted()) {
                model.addAttribute(
                        "errorMessage",
                        "ID verification failed (confidence: " +
                                String.format("%.2f", result.getProbability()) + ")"
                );
                return "/error/notId";
            }

        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute(
                    "errorMessage",
                    "ID verification service error: " + e.getMessage()
            );
            return "/user-and-student/sign_up_page";
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
            default -> "redirect:/onboarding";
        };

    }
}

