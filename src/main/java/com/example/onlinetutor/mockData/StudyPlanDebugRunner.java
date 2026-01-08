//package com.example.onlinetutor.mockData;
//
//import com.example.onlinetutor.enums.AptitudeTestStatus;
//import com.example.onlinetutor.repositories.AptitudeTestRepo;
//import com.example.onlinetutor.services.StudyPlanService;
//import lombok.RequiredArgsConstructor;
//import org.springframework.boot.CommandLineRunner;
//import org.springframework.stereotype.Component;
//
//@Component
//@RequiredArgsConstructor
//public class StudyPlanDebugRunner implements CommandLineRunner {
//
//    private final AptitudeTestRepo aptitudeTestRepo;
//    private final StudyPlanService studyPlanService;
//
//    @Override
//    public void run(String... args) {
//
//        aptitudeTestRepo.findAll().stream()
//                .filter(t -> t.getStatus() == AptitudeTestStatus.COMPLETED)
//                .findFirst()
//                .ifPresent(studyPlanService::generateStudyPlanFromTest);
//    }
//}
//
