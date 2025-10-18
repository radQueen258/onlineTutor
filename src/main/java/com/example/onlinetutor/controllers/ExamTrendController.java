package com.example.onlinetutor.controllers;

import com.example.onlinetutor.models.ExamTrend;
import com.example.onlinetutor.services.ExamTrendService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class ExamTrendController {

    @Autowired
    private ExamTrendService examTrendService;

    @GetMapping("/exam-trends")
    public String examTrends(Model model) {
        List<ExamTrend> trends = examTrendService.getAllTrends();
        model.addAttribute("trends", trends);
        return "exam-trends";
    }
}
