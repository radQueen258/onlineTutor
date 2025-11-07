package com.example.onlinetutor.controllers;

import com.example.onlinetutor.enums.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.Arrays;

@Controller
public class SignInController {
    @GetMapping("/signIn")
    public String getSignInPage() {
        System.out.println("Subjects in model: " + Arrays.toString(Subject.values()));

        return "/user-and-student/sign_in_page";
    }
}