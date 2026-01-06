package com.example.onlinetutor.repositories;

import com.example.onlinetutor.enums.Grade;
import com.example.onlinetutor.enums.Subject;
import com.example.onlinetutor.models.CurriculumResource;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CurriculumResourceRepo extends JpaRepository<CurriculumResource, Long> {

    List<CurriculumResource> findBySubject(List<Subject> subject);

    List<CurriculumResource> findBySubjectAndGrade(Subject subject, Grade grade);
}
