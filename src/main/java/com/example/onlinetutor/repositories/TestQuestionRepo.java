package com.example.onlinetutor.repositories;

import com.example.onlinetutor.models.CurriculumResource;
import com.example.onlinetutor.models.TestQuestion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import java.util.List;

public interface TestQuestionRepo extends JpaRepository<TestQuestion,Long> {
    @Query("""
        SELECT q FROM TestQuestion q
        WHERE q.curriculumResource IN :resources
    """)
    List<TestQuestion> findByCurriculumResources(
            @Param("resources") List<CurriculumResource> resources
    );

}
