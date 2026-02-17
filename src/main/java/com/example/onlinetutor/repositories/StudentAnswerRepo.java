package com.example.onlinetutor.repositories;

import com.example.onlinetutor.models.StudentAnswer;
import com.example.onlinetutor.models.StudentExam;
import org.springframework.data.jpa.repository.JpaRepository;

public interface StudentAnswerRepo extends JpaRepository<StudentAnswer, Long> {
    void deleteByStudentExam(StudentExam oldExam);
}
