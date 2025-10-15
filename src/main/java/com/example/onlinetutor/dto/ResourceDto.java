package com.example.onlinetutor.dto;

import com.example.onlinetutor.models.Article;
import com.example.onlinetutor.models.Resource;
import com.example.onlinetutor.models.Video;
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
public class ResourceDto {

    private Long id;
    private String topicName;
    private Article article;
    private Video video;

    public static ResourceDto from(Resource resource) {
        return ResourceDto.builder()
                .id(resource.getId())
                .topicName(resource.getTopicName())
                .article(resource.getArticle())
                .video(resource.getVideo())
                .build();
    }

    public static List<ResourceDto> resourceDtoList(List<Resource> resources) {
        return resources.stream()
                .map(ResourceDto::from)
                .collect(Collectors.toList());
    }
}
