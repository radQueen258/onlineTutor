package com.example.onlinetutor.services;

import com.example.onlinetutor.enums.Subject;
import com.example.onlinetutor.models.ExamQuestion;
import com.example.onlinetutor.repositories.ExamQuestionRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.File;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.List;

@Service
public class ExamQuestionServiceImpl {

    @Autowired
    private ExamQuestionRepo examQuestionRepo;


    public void importQuestionsFromFolder(String subjectFolder, Subject subject) throws Exception {
        File folder = new File(subjectFolder);
        File[] examFolders = folder.listFiles(File::isDirectory);

        if (examFolders == null) return;

        for (File exam : examFolders) {
            File[] questionFiles = exam.listFiles((dir, name) -> name.endsWith("_questions.txt"));

            if (questionFiles != null) {
                for (File file : questionFiles) {
                    List<String> lines = Files.readAllLines(file.toPath());
                    for (String line : lines) {
                        // Simple parsing: Q1: question text
                        if (line.startsWith("Q")) {
                            String questionText = line.substring(line.indexOf(":") + 1).trim();


                            ExamQuestion question = ExamQuestion.builder()
                                    .subject(subject)
                                    .examQuestionText(questionText)
                                    .examOptions(new ArrayList<>()) // empty for now
                                    .examCorrectAnswer(null) // empty for now
                                    .build();

                            examQuestionRepo.save(question);
                        }
                    }
                }
            }
        }
    }
}
