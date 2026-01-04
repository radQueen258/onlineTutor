package com.example.onlinetutor.services;

import com.example.onlinetutor.dto.VerificationResult;

public interface IdVerificationService {

    VerificationResult verifyFrontAndBack(
            byte[] frontBytes, String frontFilename,
            byte[] backBytes, String backFilename
    );
}
