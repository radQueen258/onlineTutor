package com.example.onlinetutor.controllers;

import com.example.onlinetutor.dto.UserForm;
import com.example.onlinetutor.services.SignUpService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class SignUpController {

    @Autowired
    private SignUpService signUpService;

    @GetMapping("/signUp")
    public String signUpPage () {
        return "sign_up_page";
    }

    @PostMapping("/signUp")
    public String signUp (@ModelAttribute UserForm form) {
        signUpService.addUser(form);
        return "redirect:/signIn";
    }
}
