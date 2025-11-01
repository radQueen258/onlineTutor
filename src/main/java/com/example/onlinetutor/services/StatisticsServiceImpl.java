package com.example.onlinetutor.services;

import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;

@Component
public class StatisticsServiceImpl implements StatisticsService{

    @Override
    public Map<String, Object> getOverallStatistics() {
        Map<String, Object> stats = new HashMap<>();
        stats.put("mostReadArtcle", "Intro to Java");
        stats.put("averageScore", 85);
        return stats;
    }
}
