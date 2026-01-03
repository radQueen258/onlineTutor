package com.example.onlinetutor.dto;

public class VerificationResult {
    private final boolean accepted;
    private final double probability;
    private final String method;

    public VerificationResult(boolean accepted, double probability, String method) {
        this.accepted = accepted;
        this.probability = probability;
        this.method = method;
    }

    public boolean isAccepted() {
        return accepted;
    }

    public double getProbability() {
        return probability;
    }

    public String getMethod() {
        return method;
    }
}
