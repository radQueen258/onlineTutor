package com.example.onlinetutor.services;

import com.example.onlinetutor.dto.ResourceDto;
import com.example.onlinetutor.enums.Subject;
import com.example.onlinetutor.models.Resource;
import com.example.onlinetutor.models.User;
import org.springframework.data.domain.Page;

import java.util.List;

public interface ResourceService {
    List<ResourceDto> getAllResources();
    void deleteResource(Long resourceId);

    Resource createResource(User tutor, String topicName,
                            Subject subject, Long curriculumResourceId);

    Resource createResourceFromCurriculum(
            User creator,
            Long curriculumResourceId
    );

    Page<ResourceDto> getResources(String keyword, int page, int size);

}
