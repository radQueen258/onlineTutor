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
@Table(name = "videos")
public class Video {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String videoTitle;
    private String videoDescription;
    private String videoUrl;

    @OneToOne
    @JoinColumn(name = "resource_id")
    private Resource resource;

    @OneToOne
    @JoinColumn(name = "article_id")
    private Article article;
}
