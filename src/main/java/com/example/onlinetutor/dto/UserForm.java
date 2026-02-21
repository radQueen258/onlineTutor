package com.example.onlinetutor.dto;

import com.example.onlinetutor.enums.Gender;
import com.example.onlinetutor.enums.Role;
import com.example.onlinetutor.enums.Subject;
import com.example.onlinetutor.models.School;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class UserForm {

    private String email;
    private String password;
    private String firstName;
    private String lastName;
    private Role role;
    private Gender gender;
//    private IdCard idCard;
    private MultipartFile frontImage;
    private MultipartFile backImage;
    private Long schoolId;
    private List<Subject> preferredSubjects = new ArrayList<>();
}

