package com.example.onlinetutor.models;

import com.example.onlinetutor.enums.Subject;
import jakarta.persistence.*;
import lombok.*;

import java.util.ArrayList;
import java.util.List;

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

    @Column(columnDefinition = "TEXT")
    private String articleContent;

    @Column(length = 1024)
    private String imageUrl;

    @Enumerated(EnumType.STRING)
    private Subject subject;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "resource_id")
    private Resource resource;

    @ToString.Exclude
    @OneToOne(mappedBy = "article",
            cascade = CascadeType.ALL, fetch = FetchType.LAZY,
            orphanRemoval = true)
    private Video video;

    private Integer version = 1;

    @ToString.Exclude
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User tutorName;

    @OneToMany(mappedBy = "article", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<QuizQuestion> questions = new ArrayList<>();

    public void addQuestion(QuizQuestion q) {
        q.setArticle(this);
        this.questions.add(q);
    }

}
