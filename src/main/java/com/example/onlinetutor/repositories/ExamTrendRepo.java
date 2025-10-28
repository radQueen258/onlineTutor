package com.example.onlinetutor.repositories;

import com.example.onlinetutor.models.ExamTrend;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Service;

public interface ExamTrendRepo extends JpaRepository<ExamTrend, Long> {
}
