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
@Table(name = "resources")
public class Resource {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String topicName;

    @OneToOne(mappedBy = "resource", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    private Article article;

    @OneToOne(mappedBy = "resource", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    private Video video;

}
