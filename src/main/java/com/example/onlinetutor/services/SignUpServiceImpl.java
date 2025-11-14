package com.example.onlinetutor.services;

import com.example.onlinetutor.dto.UserForm;
import com.example.onlinetutor.models.ConfirmationToken;
import com.example.onlinetutor.models.IdCard;
import com.example.onlinetutor.models.User;
import com.example.onlinetutor.repositories.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDateTime;
import java.util.UUID;

@Component
public class SignUpServiceImpl implements SignUpService{

    @Autowired
    private UserRepo userRepo;
    @Autowired
    private IdCardService idCardService;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private ConfirmationTokenService confirmationTokenService;


    @Override
    public User addUser(UserForm form) {

        MultipartFile frontImage = form.getFrontImage();
        MultipartFile backImage = form.getBackImage();

        IdCard  idCard = idCardService.saveIdCard(frontImage, backImage);

        System.out.println("THIS IS THE IDCARD" + idCard);

        User user = User.builder()
                .email(form.getEmail())
                .password(passwordEncoder.encode(form.getPassword()))
                .firstName(form.getFirstName())
                .lastName(form.getLastName())
                .gender(form.getGender())
                .role(form.getRole())
                .schoolName(form.getSchoolName())
                .idCard(idCard)
                .build();

        userRepo.save(user);

        String token = UUID.randomUUID().toString();
        ConfirmationToken confirmationToken = new ConfirmationToken(
                token,
                LocalDateTime.now(),
                LocalDateTime.now().plusMinutes(15),
                user
        );

        confirmationTokenService.saveConfirmationToken(confirmationToken);

//        TODO: SEND EMAIL
//        TODO: ADD CONFIRMATION AFTER ALL THE BACKEND IS DONE

        System.out.println("User saved successfully: " + confirmationToken);
        return user;
    }
}
