package com.example.onlinetutor.services;

import com.example.onlinetutor.dto.VerificationResult;

public interface GPT4_IdVerificationService {

    VerificationResult verifyFrontAndBack(
            byte[] frontBytes, String frontFilename,
            byte[] backBytes, String backFilename
    );

    class VerificationResult {
        private final boolean accepted;
        private final double probability;
        private final String method;

        public VerificationResult(boolean accepted, double probability, String method) {
            this.accepted = accepted;
            this.probability = probability;
            this.method = method;
        }

        public boolean isAccepted() { return accepted; }
        public double getProbability() { return probability; }
        public String getMethod() { return method; }
    }

}
