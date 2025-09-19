package com.example.onlinetutor.dto;

import com.example.onlinetutor.models.Gender;
import com.example.onlinetutor.models.IdCard;
import com.example.onlinetutor.models.Role;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class UserForm {

    private String email;
    private String password;
    private String firstname;
    private String lastname;
    private Role role;
    private Gender gender;
    private IdCard idCard;
}
