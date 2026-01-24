package com.example.onlinetutor.dto;

import com.example.onlinetutor.enums.Subject;
import com.example.onlinetutor.models.Resource;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class AITutorRequest {
    private Subject subject;
    private String title;
    private String description;
    private Resource resource;
    private String question;
}
