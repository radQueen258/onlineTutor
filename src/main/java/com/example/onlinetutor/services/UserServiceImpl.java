package com.example.onlinetutor.services;

import com.example.onlinetutor.enums.AptitudeTestStatus;
import com.example.onlinetutor.models.User;
import com.example.onlinetutor.repositories.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Set;

@Component
public class UserServiceImpl implements UserService{

    @Autowired
    private UserRepo userRepo;

    @Override
    public User updateOnboarding(Long userId, String examLevel, List<String> subjects) {
//        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
//        String email = auth.getName();


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

    @Override
    public User findById(Long userId) {
        User user = userRepo.findById(userId)
                .orElseThrow(()-> new RuntimeException("User not found!!")) ;

        return user;
    }

    @Override
    public User findByEmail(String email) {
        User user = userRepo.findByEmail(email)
                .orElseThrow(()-> new RuntimeException("User not found!!")) ;
        return user;
    }
}
