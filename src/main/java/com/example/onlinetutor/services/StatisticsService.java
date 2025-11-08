package com.example.onlinetutor.services;

import com.example.onlinetutor.dto.TutorAnalyticsDTO;

import java.util.List;
import java.util.Map;

public interface StatisticsService {

    Map<String, Object> getOverallStatistics();
    List<TutorAnalyticsDTO> getTutorAnalytics(Long tutorId);
}
