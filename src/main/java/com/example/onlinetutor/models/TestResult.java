package com.example.onlinetutor.models;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class TestResult {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private int score;
    private boolean passed;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private  User student;

    @ManyToOne
    @JoinColumn(name = "article_id")
    private Article article;

}
