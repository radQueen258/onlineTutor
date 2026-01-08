package com.example.onlinetutor.repositories;

import com.example.onlinetutor.enums.Grade;
import com.example.onlinetutor.enums.Subject;
import com.example.onlinetutor.models.CurriculumResource;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Collection;
import java.util.List;
import java.util.Optional;

@Repository
public interface CurriculumResourceRepo extends JpaRepository<CurriculumResource, Long> {

    List<CurriculumResource> findBySubjectIn(List<Subject> subjects);


    List<CurriculumResource> findBySubjectAndGrade(Subject subject, Grade grade);

    Optional<CurriculumResource> findByTopicName(String linearEquations);

    List<CurriculumResource> findBySubjectInAndGrade(Collection<Subject> subjects, Grade grade);

    List<CurriculumResource> findByGrade(Grade grade);
}
