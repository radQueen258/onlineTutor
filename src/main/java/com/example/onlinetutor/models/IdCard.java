package com.example.onlinetutor.models;

import jakarta.persistence.*;
import lombok.*;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Entity
//@ToString(exclude = {"user"})
@Table(name = "idCard")
public class IdCard {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String frontImageUrl;
    private String backImageUrl;
    private Long size;
    private String type;
}
