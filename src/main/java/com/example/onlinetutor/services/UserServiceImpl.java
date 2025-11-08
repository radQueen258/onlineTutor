package com.example.onlinetutor.services;

import com.example.onlinetutor.enums.AptitudeTestStatus;
import com.example.onlinetutor.models.IdCard;
import com.example.onlinetutor.models.User;
import com.example.onlinetutor.repositories.*;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import java.util.Arrays;
import java.util.List;

@Component
public class UserServiceImpl implements UserService{

    @Autowired
    private UserRepo userRepo;
    @Autowired
    private ConfirmationTokenRepo confirmationTokenRepo;

    @Autowired
    private VideoRepo videoRepo;

    @Autowired
    private ArticleRepo articleRepo;

    @Autowired
    private IdCardRepo idCardRepo;

    @Autowired
    private TestResultRepo testResultRepo;

    @Autowired
    private AptitudeTestRepo aptitudeTestRepo;
    @Autowired
    private QuizQuestionRepo quizQuestionRepo;

    @Autowired
    private StudyPlanRepo studyPlanRepo;
    @Autowired
    private ResourceRepo resourceRepo;
    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    public User updateOnboarding(Long userId, String examLevel, List<String> subjects) {
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

    @Override
    public void deleteIdCardById(Long userId) {
        User user = userRepo.findById(userId).orElseThrow();
        IdCard idCard = user.getIdCard();
        idCardRepo.delete(idCard);
    }

    @Transactional
    @Override
    public void deleteUserAndDependencies(Long userId) {
        User user = userRepo.findById(userId).orElse(null);
        if (user == null) return;

        studyPlanRepo.deleteByUserId(userId);
        confirmationTokenRepo.deleteByUserId(userId);
        aptitudeTestRepo.deleteByUserId(userId);
        userRepo.deleteIdCardById(userId);
        testResultRepo.deleteByStudent_Id(userId);

        if (user.getRole().equals("TUTOR")) {
            var articles = articleRepo.findByTutorName_Id(userId);
            for (var article : articles) {
                quizQuestionRepo.deleteByArticleId(article.getId());
            }
            articleRepo.deleteArticleByTutorName_Id(userId);
            videoRepo.deleteVideoByTutorName_Id(userId);
            resourceRepo.deleteByTutor_Id(userId);
        }

        userRepo.delete(user);
    }

    @Override
    public void updatePassword(String email, String newPassword) {
        User user = findByEmail(email);
        user.setPassword(passwordEncoder.encode(newPassword));
        userRepo.save(user);
    }

    @Override
    public void updateFocusAreas(Long userId, String[] focusAreas) {
        User user = userRepo.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));
        user.setPreferredSubjects(Arrays.asList(focusAreas));
        userRepo.save(user);
    }
}
