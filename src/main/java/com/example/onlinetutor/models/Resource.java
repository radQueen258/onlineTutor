package com.example.onlinetutor.models;

import jakarta.persistence.*;
import lombok.*;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "resources")
public class Resource {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String topicName;

    @ToString.Exclude
    @OneToOne(mappedBy = "resource", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    private Article article;

    @ToString.Exclude
    @OneToOne(mappedBy = "resource", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    private Video video;

}
