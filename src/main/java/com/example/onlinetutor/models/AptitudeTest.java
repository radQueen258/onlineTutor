package com.example.onlinetutor.models;

import com.example.onlinetutor.enums.AptitudeTestStatus;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "aptitude_tests")
public class AptitudeTest {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Long userId;

    @Enumerated(EnumType.STRING)
    private AptitudeTestStatus status = AptitudeTestStatus.NOT_STARTED;

    private Integer score;

    @OneToMany(mappedBy = "aptitudeTest", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<TestQuestion> questios = new ArrayList<>();
}
