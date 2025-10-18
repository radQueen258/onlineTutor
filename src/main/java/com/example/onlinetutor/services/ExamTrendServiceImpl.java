package com.example.onlinetutor.services;

import com.example.onlinetutor.models.ExamTrend;
import com.example.onlinetutor.repositories.ExamTrendRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ExamTrendServiceImpl implements ExamTrendService {

    @Autowired
    private ExamTrendRepo examTrendRepo;

    @Override
    public List<ExamTrend> getAllTrends() {
        return examTrendRepo.findAll();
    }
}
