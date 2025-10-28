package com.example.onlinetutor.services;

import com.example.onlinetutor.models.ConfirmationToken;
import org.springframework.stereotype.Component;


public interface ConfirmationTokenService {
    void saveConfirmationToken(ConfirmationToken confirmationToken);
}
