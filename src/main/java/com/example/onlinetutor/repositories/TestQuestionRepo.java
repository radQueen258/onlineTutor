package com.example.onlinetutor.repositories;

import com.example.onlinetutor.models.TestQuestion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TestQuestionRepo extends JpaRepository<TestQuestion,Long> {
}
