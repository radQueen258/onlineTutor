package com.example.onlinetutor.repositories;

import com.example.onlinetutor.models.TestQuestion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

public interface TestQuestionRepo extends JpaRepository<TestQuestion,Long> {

}
