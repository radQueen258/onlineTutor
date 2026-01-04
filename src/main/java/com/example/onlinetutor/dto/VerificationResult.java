package com.example.onlinetutor.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class VerificationResult {
    private  boolean accepted;
    private  double probability;
    private  String method;

//    public VerificationResult(boolean accepted, double probability, String method) {
//        this.accepted = accepted;
//        this.probability = probability;
//        this.method = method;
//    }

//    public boolean isAccepted() {
//        return accepted;
//    }
//
//    public double getProbability() {
//        return probability;
//    }
//
//    public String getMethod() {
//        return method;
//    }
}
