package com.example.onlinetutor.models;

import com.example.onlinetutor.enums.Grade;
import com.example.onlinetutor.enums.Subject;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "curriculum_resources")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CurriculumResource {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String topicName;

    @Enumerated(EnumType.STRING)
    private Subject subject;

    @Enumerated(EnumType.STRING)
    private Grade grade;

    public CurriculumResource(String topicName, Subject subject, Grade grade) {
    }
}
