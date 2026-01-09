package com.example.onlinetutor.models;

import jakarta.persistence.*;
import lombok.*;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

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

    @Transient
    public List<String> getShuffledAnswers() {
        List<String> answers = new ArrayList<>();
        answers.add(correctAnswer);
        answers.add(wrongAnswer1);
        answers.add(wrongAnswer2);
        answers.add(wrongAnswer3);
        Collections.shuffle(answers);
        return answers;
    }
}
