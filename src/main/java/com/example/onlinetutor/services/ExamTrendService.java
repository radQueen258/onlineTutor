package com.example.onlinetutor.services;

import com.example.onlinetutor.models.ExamTrend;
import org.springframework.stereotype.Component;

import java.util.List;


public interface ExamTrendService {

    List<ExamTrend> getAllTrends();
}
