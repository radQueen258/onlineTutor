//package com.example.onlinetutor.mockData;
//
//import com.example.onlinetutor.enums.Grade;
//import com.example.onlinetutor.enums.Subject;
//import com.example.onlinetutor.models.CurriculumResource;
//import com.example.onlinetutor.repositories.CurriculumResourceRepo;
//import jakarta.annotation.PostConstruct;
//import lombok.RequiredArgsConstructor;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.boot.CommandLineRunner;
//import org.springframework.stereotype.Component;
//
//import java.util.List;
//
//@Component
//@RequiredArgsConstructor
//public class CurriculumResourceDataInitializer {
//
//    private final CurriculumResourceRepo curriculumResourceRepo;
//
//    @PostConstruct
//    public void initCurriculumResources() {
//
//        if (curriculumResourceRepo.count() > 0) return;
//
//        curriculumResourceRepo.saveAll(List.of(
//                new CurriculumResource("Linear Equations", Subject.MATH, Grade.GRADE10),
//                new CurriculumResource("Quadratic Equations", Subject.MATH, Grade.GRADE10),
//
//                new CurriculumResource("Newton Laws", Subject.PHYSICS, Grade.GRADE10),
//                new CurriculumResource("Kinematics", Subject.PHYSICS, Grade.GRADE10)
//        ));
//    }
//}
//
