package com.example.onlinetutor.repositories;

import com.example.onlinetutor.models.StudentExam;
import org.springframework.data.jpa.repository.JpaRepository;

public interface StudentExamRepo extends JpaRepository<StudentExam, Long> {
}
