package com.example.onlinetutor.services;

import com.example.onlinetutor.dto.VerificationResult;

import java.io.IOException;

public interface IdVerificationService {

    VerificationResult verifyFrontAndBack(
            byte[] frontBytes, String frontFilename,
            byte[] backBytes, String backFilename
    ) throws IOException;
}
