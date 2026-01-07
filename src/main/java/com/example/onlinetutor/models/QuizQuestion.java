package com.example.onlinetutor.models;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class QuizQuestion {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "article_id", nullable = false)
    private Article article;


    @NonNull
    @Column(columnDefinition = "TEXT")
    private String question;

    @NonNull
    private String wrongAnswer1;
    @NonNull
    private String wrongAnswer2;
    @NonNull
    private String wrongAnswer3;

    @NonNull
    private String correctAnswer;
}
