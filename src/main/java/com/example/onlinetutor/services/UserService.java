package com.example.onlinetutor.services;

import com.example.onlinetutor.enums.AptitudeTestStatus;
import com.example.onlinetutor.models.User;

import java.util.Set;

public interface UserService {

    User updateOnboarding (Long userId, String examLevel, Set<String> subjects);

    User updateAptitudeTestStatus(Long userId, AptitudeTestStatus status);
}
