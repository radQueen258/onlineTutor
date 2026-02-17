package com.example.onlinetutor.models;

import com.example.onlinetutor.enums.ExamStatus;
import com.example.onlinetutor.enums.Subject;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "student_exams")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class StudentExam {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;


    @Enumerated(EnumType.STRING)
    private Subject subject;

    private Double examScore;

    @Column(columnDefinition = "TEXT")
    private String suggestionsJson; // weak topics JSON

    private LocalDateTime dateTaken;

    @OneToMany(mappedBy = "studentExam", cascade = CascadeType.ALL)
    private List<StudentAnswer> answers;

    @OneToMany(mappedBy = "studentExam", cascade = CascadeType.ALL)
    private List<GeneratedQuestion> generatedQuestions;

    @Enumerated(EnumType.STRING)
    private ExamStatus status;
}

