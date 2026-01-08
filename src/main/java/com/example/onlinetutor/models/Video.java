package com.example.onlinetutor.models;

import com.example.onlinetutor.enums.Subject;
import jakarta.persistence.*;
import lombok.*;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "videos")
public class Video {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String videoTitle;

    @Column(columnDefinition = "TEXT")
    private String videoDescription;

    private String videoUrl;

    @Enumerated(EnumType.STRING)
    private Subject subject;

    @ToString.Exclude
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User tutorName;

    @OneToOne
    @JoinColumn(name = "resource_id")
    private Resource resource;

    @OneToOne
    @JoinColumn(name = "article_id")
    private Article article;

}
