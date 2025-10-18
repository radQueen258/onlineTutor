package com.example.onlinetutor.models;

import com.example.onlinetutor.enums.AptitudeTestStatus;
import com.example.onlinetutor.enums.Gender;
import com.example.onlinetutor.enums.Role;
import jakarta.persistence.*;
import lombok.*;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;


@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Entity
//@ToString(exclude = {"idCard", "videos", "articles", "resources"})
@Table(name = "account")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true, nullable = false)
    private String email;

    private String password;
    private String firstName;
    private String lastName;
    private String schoolName;


    @Enumerated(EnumType.STRING)
    private Gender gender;

    @Enumerated(EnumType.STRING)
    private Role role;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "id_card_id", referencedColumnName = "id")
    private IdCard idCard;

    //    Fields to be filled after the Aptitude Test
    private String examLevel;

    @ElementCollection(fetch = FetchType.EAGER)
    @CollectionTable(name = "user_subjects", joinColumns = @JoinColumn(name = "user_id"))
    @Column(name = "subjects")
    private List<String> preferredSubjects = new ArrayList<>();

    @Enumerated(EnumType.STRING)
    private AptitudeTestStatus aptitudeTestStatus = AptitudeTestStatus.NOT_STARTED;

    @OneToMany(mappedBy = "tutorName", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Video> video;

    @OneToMany(mappedBy = "tutorName", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Article> article;

}
