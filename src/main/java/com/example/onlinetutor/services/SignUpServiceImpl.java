package com.example.onlinetutor.services;

import com.example.onlinetutor.dto.UserForm;
import com.example.onlinetutor.models.IdCard;
import com.example.onlinetutor.models.Role;
import com.example.onlinetutor.models.User;
import com.example.onlinetutor.repositories.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component
public class SignUpServiceImpl implements SignUpService{

    @Autowired
    private UserRepo userRepo;
    private IdCardService idCardService;

    @Autowired
    private PasswordEncoder passwordEncoder;


    @Override
    public void addUser(UserForm form) {

        MultipartFile frontImage = form.getFrontImage();
        MultipartFile backImage = form.getBackImage();

        IdCard  idCard = idCardService.saveIdCard(frontImage, backImage);

        User user = User.builder()
                .email(form.getEmail())
                .password(passwordEncoder.encode(form.getPassword()))
                .firstName(form.getFirstname())
                .lastName(form.getLastname())
                .gender(form.getGender())
                .role(form.getRole())
                .schoolName(form.getSchoolName())
                .idCard(idCard)
                .build();
        userRepo.save(user);
    }
}
