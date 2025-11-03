package com.example.onlinetutor.services;

import com.example.onlinetutor.enums.AptitudeTestStatus;
import com.example.onlinetutor.models.IdCard;
import com.example.onlinetutor.models.User;
import com.example.onlinetutor.repositories.*;
import jakarta.transaction.Transactional;
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
        }

        userRepo.delete(user);
    }
}
