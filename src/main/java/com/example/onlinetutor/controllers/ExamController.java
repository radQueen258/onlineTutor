package com.example.onlinetutor.controllers;

import com.example.onlinetutor.dto.GeneratedExamResponse;
import com.example.onlinetutor.dto.GradeRequest;
import com.example.onlinetutor.dto.GradeResponse;
import com.example.onlinetutor.enums.Subject;
import com.example.onlinetutor.services.AIExamService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.HashMap;
import java.util.Map;

@Controller
public class ExamController {

    @Autowired
    private AIExamService aiExamService;

    @GetMapping("/exam/start")
    public String startExam(
            @RequestParam Long userId,
            @RequestParam Subject subject,
            Model model) throws Exception {

        GeneratedExamResponse exam = aiExamService.generateExam(userId, subject);

        model.addAttribute("exam", exam);
        model.addAttribute("userId", userId);
        model.addAttribute("subject", subject);

        return "user-and-student/exam-page";

    }


    @GetMapping("/exam/generate")
    public GeneratedExamResponse generateExam(@RequestParam Subject subject, @RequestParam Long userId) throws Exception {
        return aiExamService.generateExam(userId, subject);
    }

    @PostMapping("/exam/grade")
    public GradeResponse gradeExam(@RequestBody GradeRequest request) throws Exception {

        return aiExamService.gradeExam(
                request.getExamId(),
                request.getUserId(),
                request.getSubject(),
                request.getAnswers()
        );
    }

    @PostMapping("/exam/submit")
    public String submitExam(HttpServletRequest request, Model model) {

        Long examId = Long.parseLong(request.getParameter("examId"));
        Long userId = Long.parseLong(request.getParameter("userId"));
        Subject subject = Subject.valueOf(request.getParameter("subject"));

        Map<Long, Integer> answers = new HashMap<>();

        request.getParameterMap().forEach((key, value) -> {
            if (key.startsWith("answer_")) {
                Long questionId = Long.parseLong(key.replace("answer_", ""));
                Integer selectedOption = Integer.parseInt(value[0]);
                answers.put(questionId, selectedOption);
            }
        });

        GradeResponse response = aiExamService.gradeExam(
                examId,
                userId,
                subject,
                answers
        );

        model.addAttribute("score", response.getScore());
        model.addAttribute("examId", response.getExamId());

        return "user-and-student/exam-result";
    }

}
