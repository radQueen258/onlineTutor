package com.example.onlinetutor.models;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(
        uniqueConstraints = @UniqueConstraint(columnNames = {"article_id", "language"})
)
public class ArticleTranslation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "article_id", nullable = false)
    private Article article;

    private String language;

    @Column(length = 500)
    private String translatedTitle;

    @Column(columnDefinition = "TEXT")
    private String translatedContent;

    private Integer sourceVersion;

    private LocalDateTime createdAt = LocalDateTime.now();

}
