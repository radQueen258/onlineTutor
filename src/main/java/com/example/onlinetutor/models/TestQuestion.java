package com.example.onlinetutor.models;

import jakarta.persistence.*;
import lombok.*;

import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "test_questions")
public class TestQuestion {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String questionText;
    private String subject;

    @ElementCollection
    private List<String> options;

    private String correctAnswer;
    private String userAnswer;

    @ToString.Exclude
    @ManyToOne
    @JoinColumn(name = "aptitude_test_id")
    private AptitudeTest aptitudeTest;

}
