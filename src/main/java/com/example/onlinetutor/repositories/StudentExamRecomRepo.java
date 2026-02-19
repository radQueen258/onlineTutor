package com.example.onlinetutor.repositories;

import com.example.onlinetutor.models.StudentExamRecom;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface StudentExamRecomRepo extends JpaRepository<StudentExamRecom, Long> {
    List<StudentExamRecom> findByStudentExam_Id(Long examId);

    void deleteByStudentExam_Id(Long id);
}
