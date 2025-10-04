package com.example.onlinetutor.services;

import com.example.onlinetutor.enums.AptitudeTestStatus;
import com.example.onlinetutor.models.User;

import java.util.List;
import java.util.Set;

public interface UserService {

    User updateOnboarding (String examLevel, List<String> subjects);

    User updateAptitudeTestStatus(Long userId, AptitudeTestStatus status);

    User findById(Long userId);

}
