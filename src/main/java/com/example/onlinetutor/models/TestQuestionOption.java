package com.example.onlinetutor.models;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Entity
@Table(name = "test_question_options")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class TestQuestionOption {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "option_value")
    private String optionValue; // A, B, C, D

    @Column(name = "options")
    private String options;     // actual text

    @ToString.Exclude
    @ManyToOne
    @JoinColumn(name = "test_question_id")
    private TestQuestion testQuestion;
}

