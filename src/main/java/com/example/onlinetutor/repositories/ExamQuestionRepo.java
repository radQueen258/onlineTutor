package com.example.onlinetutor.repositories;

import com.example.onlinetutor.enums.Subject;
import com.example.onlinetutor.models.ExamQuestion;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ExamQuestionRepo extends JpaRepository<ExamQuestion, Long> {

    List<ExamQuestion> findBySubject(Subject subject);
}
