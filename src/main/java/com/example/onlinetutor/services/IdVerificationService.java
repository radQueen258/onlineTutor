package com.example.onlinetutor.services;

import com.example.onlinetutor.dto.VerificationResult;

public interface IdVerificationService {

    VerificationResult verifyId(byte[] imageBytes, String filename);
}
