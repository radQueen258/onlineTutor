package com.example.onlinetutor.controllers;

import com.example.onlinetutor.enums.Subject;
import com.example.onlinetutor.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.Arrays;

@Controller
public class UserController {

    @GetMapping("/")
    public String homePage() {
        return "/general/home";
    }

    @GetMapping("/features")
    public String featuresPage() {
        return "/general/features";
    }

    @GetMapping("/about")
    public String aboutPage() {
        return "/general/about";
    }

    @GetMapping("/contact")
    public String contactPage() {
        return "/general/contact";
    }
}
