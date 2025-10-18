package com.example.onlinetutor.models;

import jakarta.persistence.*;
import lombok.*;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "articles")
public class Article {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String articleTitle;
    private String articleContent;
    private String imageUrl;
    private String subject; // TODO: This must later be substituted wuth an actual ENUM of subjects

    @OneToOne
    @JoinColumn(name = "resource_id")
    private Resource resource;

    @ToString.Exclude
    @OneToOne(mappedBy = "article", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private Video video;

    @ToString.Exclude
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User tutorName;

}
