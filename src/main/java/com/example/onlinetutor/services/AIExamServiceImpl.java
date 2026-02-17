package com.example.onlinetutor.services;

import com.example.onlinetutor.dto.GeneratedExamResponse;
import com.example.onlinetutor.dto.GradeResponse;
import com.example.onlinetutor.enums.ExamStatus;
import com.example.onlinetutor.enums.Subject;
import com.example.onlinetutor.models.*;
import com.example.onlinetutor.repositories.*;
import jakarta.transaction.Transactional;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Component
public class AIExamServiceImpl implements AIExamService{

    @Autowired
    private ExamQuestionRepo examQuestionRepo;

    @Autowired
    private OpenRouterClient openRouterClient;

    @Autowired
    private StudentExamRepo studentExamRepo;

    @Autowired
    private StudentAnswerRepo studentAnswerRepo;
    @Autowired
    private UserRepo userRepo;

    @Autowired
    private GeneratedQuestionRepo generatedQuestionRepo;

    @Autowired
    private CurriculumResourceRepo curriculumResourceRepo;

    private String buildPrompt(String baseText) {
        return """
You are an expert national exam creator.

Your task:
Generate a NEW exam in Portuguese based on the base questions below.

STRICT RULES:
- Generate exactly 7 multiple choice questions.
- Each question must have exactly 4 options.
- Options must be inside an array.
- The correct answer must be the LETTER only: A, B, C, or D.
- Keep everything in Portuguese.
- Return ONLY valid JSON.
- Do NOT include explanations.
- Do NOT include markdown.
- Do NOT include ```json.
- Do NOT include any text before or after the JSON.

Return EXACTLY in this format:

{
  "questions": [
    {
      "question": "Pergunta aqui",
      "options": ["Opção A", "Opção B", "Opção C", "Opção D"],
      "correct": "A"
    }
  ]
}

Base questions:
""" + baseText;
    }




    @Transactional
    @Override
    public GeneratedExamResponse generateExam(Long userId, Subject subject) throws Exception {

        User user = userRepo.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));

        List<ExamQuestion> baseQuestions = examQuestionRepo.findBySubject(subject);
        Collections.shuffle(baseQuestions);

        String baseText = baseQuestions.stream()
                .limit(7)
                .map(ExamQuestion::getExamQuestionText)
                .collect(Collectors.joining("\n"));

        String prompt = buildPrompt(baseText);

        String aiResponse = openRouterClient.sendPrompt(prompt);

        System.out.println("RAW AI RESPONSE:");
        System.out.println(aiResponse);

        aiResponse = aiResponse.trim();

        if (aiResponse.startsWith("```")) {
            aiResponse = aiResponse
                    .replace("```json", "")
                    .replace("```", "")
                    .trim();
        }

        int firstBrace = aiResponse.indexOf("{");
        int lastBrace = aiResponse.lastIndexOf("}");

        if (firstBrace == -1 || lastBrace == -1) {
            throw new RuntimeException("AI did not return valid JSON.");
        }

        String cleanJson = aiResponse.substring(firstBrace, lastBrace + 1);

        JSONObject json = new JSONObject(cleanJson);
        JSONArray questionsArray = json.getJSONArray("questions");

        StudentExam exam = StudentExam.builder()
                .user(user)
                .subject(subject)
                .status(ExamStatus.IN_PROGRESS)
                .dateTaken(LocalDateTime.now())
                .build();

        studentExamRepo.save(exam);

        List<GeneratedQuestion> savedQuestions = new ArrayList<>();

        for (int i = 0; i < questionsArray.length(); i++) {

            JSONObject q = questionsArray.getJSONObject(i);
            JSONArray optionsArray = q.getJSONArray("options");

            List<String> options = new ArrayList<>();
            for (int j = 0; j < optionsArray.length(); j++) {
                options.add(optionsArray.getString(j));
            }

            String correctLetter = q.getString("correct");

            Integer correctIndex = switch (correctLetter.toUpperCase()) {
                case "A" -> 0;
                case "B" -> 1;
                case "C" -> 2;
                case "D" -> 3;
                default -> throw new RuntimeException("Invalid correct answer letter from AI");
            };

            GeneratedQuestion generatedQuestion = GeneratedQuestion.builder()
                    .studentExam(exam)
                    .questionText(q.getString("question"))
                    .options(options)
                    .correctOptionIndex(correctIndex)
                    .build();

            savedQuestions.add(generatedQuestion);
        }

        generatedQuestionRepo.saveAll(savedQuestions);

        return new GeneratedExamResponse(exam.getId(), savedQuestions);
    }


    private String generateWeakTopicsJson(Subject subject, List<GeneratedQuestion> wrongQuestions) throws Exception {

        List<CurriculumResource> resources = curriculumResourceRepo.findBySubject(subject);


        String questionsText = wrongQuestions.stream()
                .map(q -> "- " + q.getQuestionText())
                .collect(Collectors.joining("\n"));

        String resourceList = resources.stream()
                .map(r -> r.getTopicName())
                .collect(Collectors.joining(", "));

        String prompt = """
            You are an academic tutor AI.

            Subject: %s

            The student answered these questions incorrectly:
            %s

            From the following list of topics:
            %s

            Identify which topics the student is weak in. Return JSON ONLY in this format:

            {
              "weakTopics": [
                {
                  "topic": "topic name from the list",
                  "explanation": "short explanation of difficulty"
                }
              ]
            }
            """.formatted(subject, questionsText, resourceList);

        //  Call AI
        String aiResponse = openRouterClient.sendPrompt(prompt);

        // Clean AI response
        aiResponse = aiResponse.trim();
        if (aiResponse.startsWith("```")) {
            aiResponse = aiResponse
                    .replace("```json", "")
                    .replace("```", "")
                    .trim();
        }

        int firstBrace = aiResponse.indexOf("{");
        int lastBrace = aiResponse.lastIndexOf("}");
        if (firstBrace == -1 || lastBrace == -1) {
            throw new RuntimeException("AI did not return valid JSON for weak topics.");
        }

        String cleanJson = aiResponse.substring(firstBrace, lastBrace + 1);


        JSONObject json = new JSONObject(cleanJson);

        if (!json.has("weakTopics")) {
            throw new RuntimeException("AI JSON missing 'weakTopics' field.");
        }

        JSONArray weakTopicsArray = json.getJSONArray("weakTopics");

        return weakTopicsArray.toString();
    }





    @Transactional
    @Override
    public GradeResponse gradeExam(Long examId, Long userId, Subject subject, Map<Long, Integer> answers) {
        // 1️⃣ Fetch the exam
        StudentExam exam = studentExamRepo.findById(examId)
                .orElseThrow(() -> new RuntimeException("Exam not found"));

        List<GeneratedQuestion> questions = generatedQuestionRepo.findByStudentExam_Id(exam.getId());

        int correctCount = 0;
        List<GeneratedQuestion> wrongQuestions = new ArrayList<>();

        // 2️⃣ Grade each question
        for (GeneratedQuestion q : questions) {
            Integer selected = answers.get(q.getId());
            boolean isCorrect = selected != null && selected.equals(q.getCorrectOptionIndex());

            if (isCorrect) correctCount++;
            else wrongQuestions.add(q);

            StudentAnswer answer = StudentAnswer.builder()
                    .studentExam(exam)
                    .generatedQuestion(q)
                    .studentExamAnswer(selected)
                    .correct(isCorrect)
                    .build();

            studentAnswerRepo.save(answer);
        }

        // 3️⃣ Calculate score
        double score = (correctCount * 100.0) / questions.size();
        exam.setExamScore(score);
        exam.setStatus(ExamStatus.COMPLETED);

        // 4️⃣ Generate weak topics JSON only if there are wrong questions
        if (!wrongQuestions.isEmpty()) {
            String weakTopicsJson = null;
            try {
                weakTopicsJson = generateWeakTopicsJson(subject, wrongQuestions);
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
            exam.setSuggestionsJson(weakTopicsJson);
        }

        studentExamRepo.save(exam);

        return new GradeResponse(exam.getId(), score);
    }



}
