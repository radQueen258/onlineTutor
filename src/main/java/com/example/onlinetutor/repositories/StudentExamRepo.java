package com.example.onlinetutor.repositories;

import com.example.onlinetutor.enums.ExamStatus;
import com.example.onlinetutor.enums.Subject;
import com.example.onlinetutor.models.StudentExam;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public interface StudentExamRepo extends JpaRepository<StudentExam, Long> {
    Optional<Object> findByUser_IdAndSubjectAndStatus(Long userId, Subject subject, ExamStatus examStatus);

    List<StudentExam> findByUserId(Long userId);

    List<StudentExam> findByUserIdOrderByDateTakenDesc(Long userId);

    List<StudentExam> findByStatusAndDateTakenBefore(ExamStatus status, LocalDateTime time);
}
