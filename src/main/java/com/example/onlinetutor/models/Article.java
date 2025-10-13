package com.example.onlinetutor.models;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

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

    @OneToOne
    @JoinColumn(name = "resource_id")
    private Resource resource;

    @OneToOne(mappedBy = "article", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private Video video;
}
