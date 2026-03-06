package com.example.onlinetutor.repositories;

import com.example.onlinetutor.enums.Grade;
import com.example.onlinetutor.enums.Subject;
import com.example.onlinetutor.models.CurriculumResource;
import com.example.onlinetutor.models.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Collection;
import java.util.List;
import java.util.Optional;

@Repository
public interface CurriculumResourceRepo extends JpaRepository<CurriculumResource, Long> {

    List<CurriculumResource> findBySubjectIn(List<Subject> subjects);


//    List<CurriculumResource> findBySubjectAndGrade(Subject subject, Grade grade);
//
//    Optional<CurriculumResource> findByTopicName(String topicName);

    List<CurriculumResource> findBySubjectInAndGrade(Collection<Subject> subjects, Grade grade);

    List<CurriculumResource> findByGrade(Grade grade);

    List<CurriculumResource> findBySubject(Subject subject);

    @Query("""
SELECT cr
FROM CurriculumResource cr
WHERE cr.subject IN :subjects
AND cr.id NOT IN (
    SELECT r.curriculumResource.id
    FROM Resource r
    WHERE r.tutor = :tutor
)
""")
    List<CurriculumResource> findAvailableForTutor(User tutor, List<Subject> subjects);

//    Optional<CurriculumResource> findByTopicName(String topicName);
}
