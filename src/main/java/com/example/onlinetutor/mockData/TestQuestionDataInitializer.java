package com.example.onlinetutor.mockData;

import com.example.onlinetutor.enums.Grade;
import com.example.onlinetutor.models.CurriculumResource;
import com.example.onlinetutor.models.TestQuestion;
import com.example.onlinetutor.repositories.CurriculumResourceRepo;
import com.example.onlinetutor.repositories.TestQuestionRepo;
import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
@RequiredArgsConstructor
public class TestQuestionDataInitializer {

    private final TestQuestionRepo testQuestionRepo;
    private final CurriculumResourceRepo curriculumResourceRepo;

    @PostConstruct
    public void initTestQuestions() {

        if (testQuestionRepo.count() > 0) return;

        List<CurriculumResource> resources =
                curriculumResourceRepo.findByGrade(Grade.GRADE10);

        for (CurriculumResource cr : resources) {

            for (int i = 1; i <= 2; i++) {

                TestQuestion q = new TestQuestion();

                q.setQuestionText(
                        "Question " + i + " for " + cr.getTopicName()
                );

                // ✅ IMPORTANT: subject alignment
                q.setSubject(cr.getSubject());

                // ✅ IMPORTANT: mutable list for ElementCollection
                q.setOptions(new ArrayList<>(List.of(
                        "A",
                        "B",
                        "C",
                        "D"
                )));

                q.setCorrectAnswer("A");
                q.setCurriculumResource(cr);

                testQuestionRepo.save(q);
            }
        }
    }
}


