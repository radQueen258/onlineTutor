package com.example.onlinetutor.services;

import com.example.onlinetutor.enums.AptitudeTestStatus;
import com.example.onlinetutor.enums.Subject;
import com.example.onlinetutor.models.User;

import java.util.List;
import java.util.Set;

public interface UserService {

    User updateOnboarding (Long userId, String examLevel, List<Subject> subjects);

    User updateAptitudeTestStatus(Long userId, AptitudeTestStatus status);

    User findById(Long userId);
    User findByEmail(String email);

    void deleteIdCardById(Long userId);
    void deleteUserAndDependencies(Long userId);

    void updatePassword(String email, String newPassword);
    void updateFocusAreas(Long userId, Subject[] focusAreas);

}
