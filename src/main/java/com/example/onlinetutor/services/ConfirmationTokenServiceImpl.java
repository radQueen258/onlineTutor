package com.example.onlinetutor.services;

import com.example.onlinetutor.models.ConfirmationToken;
import com.example.onlinetutor.repositories.ConfirmationTokenRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

@Component
public class ConfirmationTokenServiceImpl implements ConfirmationTokenService {

    @Autowired
    private ConfirmationTokenRepo confirmationTokenRepo;

    @Override
    public void saveConfirmationToken(ConfirmationToken confirmationToken) {
        confirmationTokenRepo.save(confirmationToken);
    }
}
