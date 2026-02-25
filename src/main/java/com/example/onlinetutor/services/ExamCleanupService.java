package com.example.onlinetutor.services;

import com.example.onlinetutor.enums.ExamStatus;
import com.example.onlinetutor.models.StudentExam;
import com.example.onlinetutor.repositories.StudentExamRepo;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class ExamCleanupService {

    @Autowired
    private StudentExamRepo studentExamRepo;

    @Scheduled(fixedRate = 1200000) // every 20 minutes
    @Transactional
    public void deleteAbandonedExams() {

        LocalDateTime threshold = LocalDateTime.now().minusMinutes(30);

        List<StudentExam> abandoned =
                studentExamRepo.findByStatusAndDateTakenBefore(
                        ExamStatus.IN_PROGRESS, threshold);

        studentExamRepo.deleteAll(abandoned);
    }
}
