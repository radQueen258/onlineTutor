package com.example.onlinetutor.dto;

import com.example.onlinetutor.enums.Gender;
import com.example.onlinetutor.models.User;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
import java.util.stream.Collectors;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class UserDto {

    private Long id;
    private String email;
    private String firstname;
    private String lastname;
    private Gender gender;
    private Long schoolId;
    private boolean isVerified;


    public static UserDto from(User user){
        return UserDto.builder()
                .id (user.getId())
                .email(user.getEmail())
                .firstname(user.getFirstName())
                .lastname(user.getLastName())
                .gender(user.getGender())
                .schoolId(user.getSchool().getId())
                .isVerified(user.isVerified())
                .build();
    }

    public static List<UserDto> userDtoList (List<User> users){
        return users.stream()
                .map(UserDto::from)
                .collect(Collectors.toList());
    }

}
