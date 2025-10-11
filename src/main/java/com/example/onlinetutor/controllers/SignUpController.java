package com.example.onlinetutor.controllers;

import com.example.onlinetutor.dto.UserForm;
import com.example.onlinetutor.models.User;
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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class SignUpController {

    @Autowired
    private SignUpService signUpService;
    @Autowired
    private AuthenticationManager authenticationManager;

    @GetMapping("/signUp")
    public String signUpPage () {
        return "sign_up_page";
    }

    @PostMapping("/signUp")
    public String signUp (@ModelAttribute UserForm form, HttpServletRequest request, HttpSession session) {
        User savedUser = signUpService.addUser(form);

//        Authentication authentication = authenticationManager.authenticate(
//                new UsernamePasswordAuthenticationToken(savedUser.getEmail(), savedUser.getPassword())
//        );
//
//        SecurityContextHolder.getContext().setAuthentication(authentication);

        UsernamePasswordAuthenticationToken token =
                new UsernamePasswordAuthenticationToken(form.getEmail(), form.getPassword());
        Authentication authentication = authenticationManager.authenticate(token);
        SecurityContextHolder.getContext().setAuthentication(authentication);

        session = request.getSession(true);
        session.setAttribute(HttpSessionSecurityContextRepository.SPRING_SECURITY_CONTEXT_KEY,
                SecurityContextHolder.getContext());


        session.setAttribute("userId", savedUser.getId());
        session.setAttribute("testTaken", false);

        return "redirect:/onboarding";
    }
}
