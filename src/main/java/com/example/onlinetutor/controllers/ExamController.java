package com.example.onlinetutor.controllers;

import com.example.onlinetutor.dto.GeneratedExamResponse;
import com.example.onlinetutor.dto.GradeRequest;
import com.example.onlinetutor.dto.GradeResponse;
import com.example.onlinetutor.enums.ExamStatus;
import com.example.onlinetutor.enums.Subject;
import com.example.onlinetutor.models.StudentExam;
import com.example.onlinetutor.repositories.GeneratedQuestionRepo;
import com.example.onlinetutor.repositories.StudentAnswerRepo;
import com.example.onlinetutor.repositories.StudentExamRepo;
import com.example.onlinetutor.services.AIExamService;
import jakarta.servlet.http.HttpServletRequest;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ExamController {

    @Autowired
    private AIExamService aiExamService;

    @Autowired
    private StudentExamRepo studentExamRepo;

    @Autowired
    private GeneratedQuestionRepo generatedQuestionRepo;

    @Autowired
    private StudentAnswerRepo studentAnswerRepo;


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

        StudentExam exam = studentExamRepo.findById(examId).orElseThrow();
        List<Map<String, String>> weakTopics = new ArrayList<>();
        if (exam.getSuggestionsJson() != null) {
            JSONArray jsonArray = new JSONArray(exam.getSuggestionsJson());
            for (int i = 0; i < jsonArray.length(); i++) {
                JSONObject obj = jsonArray.getJSONObject(i);
                Map<String, String> topic = new HashMap<>();
                topic.put("topic", obj.getString("topic"));
                topic.put("explanation", obj.getString("explanation"));
                weakTopics.add(topic);
            }
        }

        model.addAttribute("score", response.getScore());
        model.addAttribute("examId", response.getExamId());
        model.addAttribute("weakTopics", weakTopics);


        return "user-and-student/exam-result";
    }

    @PostMapping("/exam/{examId}/retake")
    public String retakeExam(@PathVariable Long examId) {
        StudentExam oldExam = studentExamRepo.findById(examId).orElseThrow();

        // Delete generated questions & student answers
        generatedQuestionRepo.deleteByStudentExam(oldExam);
        studentAnswerRepo.deleteByStudentExam(oldExam);

        // Keep StudentExam row (score history)
        oldExam.setStatus(ExamStatus.IN_PROGRESS);
        oldExam.setExamScore(null);
        oldExam.setSuggestionsJson(null);
        studentExamRepo.save(oldExam);

        return "redirect:/exam/start?subject=" + oldExam.getSubject();
    }


}
