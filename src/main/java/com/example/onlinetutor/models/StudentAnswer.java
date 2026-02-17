package com.example.onlinetutor.models;

import jakarta.persistence.*;
import lombok.*;


@Entity
@Table(name = "student_exam_answers")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class StudentAnswer {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "student_exam_id")
    private StudentExam studentExam;

//    @ManyToOne
//    @JoinColumn(name = "question_id")
//    private ExamQuestion examQuestion;

    @ManyToOne
    private GeneratedQuestion generatedQuestion;

    private Integer studentExamAnswer;

    private Boolean correct;
}

