package com.example.onlinetutor.models;

import jakarta.persistence.*;
import lombok.*;

import java.util.List;

@Entity
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class GeneratedQuestion {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    private StudentExam studentExam;

    @Column(columnDefinition = "TEXT")
    private String questionText;

    @ElementCollection
    @CollectionTable(
            name = "generated_question_options",
            joinColumns = @JoinColumn(name = "generated_question_id")
    )
    @Column(name = "option_text")
    private List<String> options;

    private Integer correctOptionIndex;
}

