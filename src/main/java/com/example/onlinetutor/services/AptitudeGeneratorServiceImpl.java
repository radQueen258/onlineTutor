package com.example.onlinetutor.services;

import com.example.onlinetutor.models.CurriculumResource;
import com.example.onlinetutor.models.TestQuestion;
import com.example.onlinetutor.models.User;
import com.example.onlinetutor.repositories.CurriculumResourceRepo;
import com.example.onlinetutor.repositories.TestQuestionRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Component
public class AptitudeGeneratorServiceImpl implements AptitudeGeneratorService {

    @Autowired
    private CurriculumResourceRepo curriculumResourceRepo;

    @Autowired
    private TestQuestionRepo testQuestionRepo;

    @Override
    public List<TestQuestion> generateQuestionsForStudent(User user) {


        List<CurriculumResource> curriculumResources =
                curriculumResourceRepo.findBySubjectInAndGrade(
                        user.getPreferredSubjects(),
                        user.getExamLevel()
                );


        List<TestQuestion> allQuestions =
                testQuestionRepo.findByCurriculumResources(curriculumResources);


        Map<CurriculumResource, List<TestQuestion>> byResource =
                allQuestions.stream()
                        .collect(Collectors.groupingBy(TestQuestion::getCurriculumResource));


        List<TestQuestion> selected = new ArrayList<>();

        for (var entry : byResource.entrySet()) {
            List<TestQuestion> questions = entry.getValue();
            Collections.shuffle(questions);

            selected.add(questions.get(0));
            if (questions.size() > 1) {
                selected.add(questions.get(1));
            }
        }

        return selected;
    }
}
