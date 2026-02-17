package com.example.onlinetutor.repositories;

import com.example.onlinetutor.models.GeneratedQuestion;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface GeneratedQuestionRepo extends JpaRepository<GeneratedQuestion, Long> {

    List<GeneratedQuestion> findByStudentExam_Id(Long studentExamId);
}
