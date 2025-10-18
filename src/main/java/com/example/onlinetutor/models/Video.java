package com.example.onlinetutor.models;

import jakarta.persistence.*;
import lombok.*;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Entity
//@ToString(exclude = {"user", "article", "resource"})
@Table(name = "videos")
public class Video {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String videoTitle;
    private String videoDescription;
    private String videoUrl;
    private String subject;

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
