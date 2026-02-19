package com.example.onlinetutor.models;

import com.example.onlinetutor.enums.Subject;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Entity
public class StudentExamRecom {


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    private StudentExam studentExam;

    @ManyToOne
    private User user;

    @Enumerated(EnumType.STRING)
    private Subject subject;

    @ManyToMany
    @JoinTable(
            name = "student_exam_recommendations",
            joinColumns = @JoinColumn(name = "recommendation_id"),
            inverseJoinColumns = @JoinColumn(name = "curriculum_resource_id")
    )
    private List<CurriculumResource> recommendedResources;

}
