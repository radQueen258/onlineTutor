package com.example.onlinetutor.services;

import com.example.onlinetutor.models.TestQuestion;
import com.example.onlinetutor.models.User;

import java.util.List;

public interface AptitudeGeneratorService {
    List<TestQuestion> generateQuestionsForStudent(User user);
}
