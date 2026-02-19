package com.example.onlinetutor.models;

import com.example.onlinetutor.enums.Grade;
import com.example.onlinetutor.enums.Subject;
import jakarta.persistence.*;
import lombok.*;

import java.util.List;

@Entity
@Table(name = "exam_questions")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ExamQuestion {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Enumerated(EnumType.STRING)
    private Subject subject;

    @Enumerated(EnumType.STRING)
    private Grade grade;


    @ManyToMany
    @JoinTable(
            name = "question_curriculum_resources",
            joinColumns = @JoinColumn(name = "exam_question_id"),
            inverseJoinColumns = @JoinColumn(name = "curriculum_resource_id")
    )
    private List<CurriculumResource> curriculumResources;

    @Column(columnDefinition = "TEXT")
    private String examQuestionText;

    @ElementCollection
    @CollectionTable(name = "exam_question_options", joinColumns = @JoinColumn(name = "exam_question_id"))
    @Column(name = "exam_option_text")
    private List<String> examOptions;

    private Integer examCorrectAnswer;
}
