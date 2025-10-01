package com.example.onlinetutor.services;

import com.example.onlinetutor.enums.AptitudeTestStatus;
import com.example.onlinetutor.models.User;
import com.example.onlinetutor.repositories.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Set;

@Component
public class UserServiceImpl implements UserService{

    @Autowired
    private UserRepo userRepo;

    @Override
    public User updateOnboarding(Long userId, String examLevel, Set<String> subjects) {
        User user = userRepo.findById(userId)
                .orElseThrow(()-> new RuntimeException("User not found!!")) ;

        user.setExamLevel(examLevel);
        user.setPreferredSubjects(subjects);
        userRepo.save(user);
        return user;
    }

    @Override
    public User updateAptitudeTestStatus(Long userId, AptitudeTestStatus status) {
        User user = userRepo.findById(userId)
                .orElseThrow(()-> new RuntimeException("User not found!!")) ;
        user.setAptitudeTestStatus(status);
        userRepo.save(user);
        return user;
    }
}
