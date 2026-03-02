package com.example.onlinetutor.controllers;

import com.example.onlinetutor.dto.GeneratedExamResponse;
import com.example.onlinetutor.dto.GradeRequest;
import com.example.onlinetutor.dto.GradeResponse;
import com.example.onlinetutor.enums.ExamStatus;
import com.example.onlinetutor.enums.Subject;
import com.example.onlinetutor.models.ExamQuestion;
import com.example.onlinetutor.models.GeneratedQuestion;
import com.example.onlinetutor.models.StudentExam;
import com.example.onlinetutor.repositories.ExamQuestionRepo;
import com.example.onlinetutor.repositories.GeneratedQuestionRepo;
import com.example.onlinetutor.repositories.StudentAnswerRepo;
import com.example.onlinetutor.repositories.StudentExamRepo;
import com.example.onlinetutor.services.AIExamService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.transaction.Transactional;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.*;

@Controller
public class ExamController {

    @Autowired
    private AIExamService aiExamService;

    @Autowired
    private StudentExamRepo studentExamRepo;

    @Autowired
    private GeneratedQuestionRepo generatedQuestionRepo;

    @Autowired
    private ExamQuestionRepo examQuestionRepo;

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
        model.addAttribute("isRetake", false);

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

        boolean isRetake = Boolean.parseBoolean(request.getParameter("retake"));

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

        GradeResponse response;


        if (isRetake) {
            response = aiExamService.gradeRetakeExam(examId, answers);
        } else {
            response = aiExamService.gradeExam(examId, userId, subject, answers);
        }

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
        model.addAttribute("improvement", response.getImprovement());


        return "user-and-student/exam-result";
    }

    @GetMapping("/exam/retake/{examId}")
    @Transactional
    public String retakeGetExam(@PathVariable Long examId, Model model) {

        StudentExam exam = studentExamRepo.findById(examId)
                .orElseThrow(() -> new RuntimeException("Exam not found"));

        // Clear previous answers
        studentAnswerRepo.deleteByStudentExam_Id(examId);

        // Reset exam state
        exam.setPreviousScore(exam.getExamScore());
        exam.setExamScore(null);
        exam.setStatus(ExamStatus.IN_PROGRESS);
        exam.setDateTaken(LocalDateTime.now());

        Integer attempts = exam.getAttemptCount() == null ? 1 : exam.getAttemptCount() + 1;
        exam.setAttemptCount(attempts);

        studentExamRepo.save(exam);

        // Fetch already-generated questions
        List<GeneratedQuestion> questions =
                generatedQuestionRepo.findByStudentExam_Id(examId);

        GeneratedExamResponse response = new GeneratedExamResponse();
        response.setExamId(exam.getId());
        response.setQuestions(questions);

        model.addAttribute("exam", response);
        model.addAttribute("userId", exam.getUser().getId());
        model.addAttribute("subject", exam.getSubject());
        model.addAttribute("isRetake", true);

        return "user-and-student/exam-page";
    }

//    @PostMapping("/exam/retake")
//    @Transactional
//    public String retakeExam(@RequestParam Long examId, Model model) {
//
//        StudentExam exam = studentExamRepo.findById(examId)
//                .orElseThrow(() -> new RuntimeException("Exam not found"));
//
//        // Delete old generated questions
//        studentAnswerRepo.deleteByStudentExam_Id(examId);
//        generatedQuestionRepo.deleteByStudentExamId(examId);
//
//        // Fetch base questions again
//        List<ExamQuestion> baseQuestions =
//                examQuestionRepo.findBySubjectAndGrade(
//                        exam.getSubject(),
//                        exam.getUser().getExamLevel()
//                );
//
//        Collections.shuffle(baseQuestions);
//
//        List<GeneratedQuestion> newQuestions = baseQuestions.stream()
//                .limit(7)
//                .map(q -> GeneratedQuestion.builder()
//                        .studentExam(exam)
//                        .questionText(q.getExamQuestionText())
//                        .options(new ArrayList<>(q.getExamOptions()))
//                        .correctOptionIndex(q.getExamCorrectAnswer())
//                        .build())
//                .toList();
//
//        generatedQuestionRepo.saveAll(newQuestions);
//
//
//        exam.setPreviousScore(exam.getExamScore());
//        exam.setExamScore(null);
//
//        Integer attempts = exam.getAttemptCount() == null ? 1 : exam.getAttemptCount() + 1;
//        exam.setAttemptCount(attempts);
//
//        // Reset exam state
//        exam.setStatus(ExamStatus.IN_PROGRESS);
//        exam.setDateTaken(LocalDateTime.now());
//
//        studentExamRepo.save(exam);
//
//        GeneratedExamResponse response = new GeneratedExamResponse();
//        response.setExamId(exam.getId());
//        response.setQuestions(newQuestions);
//
//        model.addAttribute("exam", response);
//        model.addAttribute("userId", exam.getUser().getId());
//        model.addAttribute("subject", exam.getSubject());
//        model.addAttribute("isRetake", true);
//
//        return "user-and-student/exam-page";
//    }

    @PostMapping("/exam/abandon")
    @Transactional
    public void abandonExam(@RequestBody Long examId) {
        studentExamRepo.deleteById(examId);
    }


}
