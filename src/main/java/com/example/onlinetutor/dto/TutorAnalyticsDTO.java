package com.example.onlinetutor.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class TutorAnalyticsDTO {

    private String articleTitle;
    private long studentsPassed;
    private long studentsFailed;

//    TODO: The commonly failed questions field must be here
}
