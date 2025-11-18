package com.example.onlinetutor.controllers;

import com.example.onlinetutor.dto.UserForm;
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

    @GetMapping("/signUp")
    public String signUpPage (Model model) {
        model.addAttribute("subjects", Arrays.asList(Subject.values()));
        return "/user-and-student/sign_up_page";
    }

    @PostMapping("/signUp")
    public String signUp (@ModelAttribute UserForm form,
                          @RequestParam("frontImage") MultipartFile frontImage,
                          @RequestParam("backImage") MultipartFile backImage,
                          HttpServletRequest request,
                          HttpSession session,
                          Model model) {

        if (frontImage == null || frontImage.isEmpty() || backImage == null || backImage.isEmpty()) {
            model.addAttribute("errorMessage", "Please upload both front and back images of your ID.");
            return "/user-and-student/sign_up_page";
        }


        try {
            // 1) Call verifier for front image
            byte[] frontBytes = frontImage.getBytes();
            IdVerificationServiceImpl.VerificationResult frontResult =
                    idVerificationServiceImpl.verifyId(frontBytes, frontImage.getOriginalFilename());

            // 2) Call verifier for back image
            byte[] backBytes = backImage.getBytes();
            IdVerificationServiceImpl.VerificationResult backResult =
                    idVerificationServiceImpl.verifyId(backBytes, backImage.getOriginalFilename());

            // 3) Decide acceptance policy
            // Option A (strict): require both accepted
            boolean accepted = frontResult.accepted && backResult.accepted;

            // Option B (alternative): average probability threshold
            // double avgProb = (frontResult.probability + backResult.probability) / 2.0;
            // boolean accepted = avgProb >= 0.70;

            if (!accepted) {
                String msg = String.format("ID verification failed. Front: %.2f, Back: %.2f",
                        frontResult.probability, backResult.probability);
                model.addAttribute("errorMessage", msg);
                return "/user-and-student/sign_up_page";
            }

        User savedUser = signUpService.addUser(form);

        UsernamePasswordAuthenticationToken token =
                new UsernamePasswordAuthenticationToken(form.getEmail(), form.getPassword());
        Authentication authentication = authenticationManager.authenticate(token);
        SecurityContextHolder.getContext().setAuthentication(authentication);

        session = request.getSession(true);
        session.setAttribute(HttpSessionSecurityContextRepository.SPRING_SECURITY_CONTEXT_KEY,
                SecurityContextHolder.getContext());


        session.setAttribute("userId", savedUser.getId());
        session.setAttribute("testTaken", false);

        if (savedUser.getRole() == Role.TUTOR) {
            return "redirect:/tutor/workplace";
        } else if (savedUser.getRole() == Role.ADMIN) {
            return "redirect:/admin";
        } else {
            return "redirect:/onboarding";
        }

        } catch (IOException ioEx) {
            model.addAttribute("errorMessage", "Could not read uploaded files.");
            return "/user-and-student/sign_up_page";
        } catch (Exception ex) {
            model.addAttribute("errorMessage", "An error occurred while verifying your ID. Please try again.");
            ex.printStackTrace();
            return "/user-and-student/sign_up_page";
        }

    }
}
