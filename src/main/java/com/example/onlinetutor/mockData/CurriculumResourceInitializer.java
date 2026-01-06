package com.example.onlinetutor.mockData;

import com.example.onlinetutor.enums.Grade;
import com.example.onlinetutor.enums.Subject;
import com.example.onlinetutor.models.CurriculumResource;
import com.example.onlinetutor.repositories.CurriculumResourceRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

@Component
public class CurriculumResourceInitializer implements CommandLineRunner {

    @Autowired
    private CurriculumResourceRepo curriculumResourceRepo;

    @Override
    public void run(String... args) {
        if (curriculumResourceRepo.count() > 0) return;

        curriculumResourceRepo.save(
                CurriculumResource.builder()
                        .topicName("Linear Equations")
                        .subject(Subject.MATH)
                        .grade(Grade.GRADE10)
                        .build()
        );

        curriculumResourceRepo.save(
                CurriculumResource.builder()
                        .topicName("Newton Laws")
                        .subject(Subject.PHYSICS)
                        .grade(Grade.GRADE10)
                        .build()
        );
    }
}
