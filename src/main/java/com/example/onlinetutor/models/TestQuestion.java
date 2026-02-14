package com.example.onlinetutor.models;

import com.example.onlinetutor.enums.Subject;
import jakarta.persistence.*;
import lombok.*;

import java.util.ArrayList;
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

    @Enumerated(EnumType.STRING)
    private Subject subject;

//    @ElementCollection(fetch = FetchType.EAGER)
//    @CollectionTable(
//            name = "test_question_options",
//            joinColumns = @JoinColumn(name = "test_question_id")
//    )
//    @Column(name = "option_value")
//    private List<String> options = new ArrayList<>();


    private String correctAnswer;
    private String userAnswer;

    @ToString.Exclude
    @ManyToOne
    @JoinColumn(name = "aptitude_test_id")
    private AptitudeTest aptitudeTest;

    @ManyToOne
    @JoinColumn(name = "curriculum_resource_id")
    private CurriculumResource curriculumResource;

    @ToString.Exclude
    @OneToMany(mappedBy = "testQuestion", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    private List<TestQuestionOption> optionEntities = new ArrayList<>();


}
