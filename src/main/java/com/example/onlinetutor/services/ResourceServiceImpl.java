package com.example.onlinetutor.services;

import com.example.onlinetutor.dto.ResourceDto;
import com.example.onlinetutor.enums.Role;
import com.example.onlinetutor.enums.Subject;
import com.example.onlinetutor.models.Article;
import com.example.onlinetutor.models.CurriculumResource;
import com.example.onlinetutor.models.Resource;
import com.example.onlinetutor.models.User;
import com.example.onlinetutor.repositories.CurriculumResourceRepo;
import com.example.onlinetutor.repositories.ResourceRepo;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Component;

import java.util.List;

import static com.example.onlinetutor.dto.ResourceDto.resourceDtoList;

@Component
public class ResourceServiceImpl implements ResourceService {

    @Autowired
    private ResourceRepo resourceRepo;

    @Autowired
    private ArticleService articleService;

    @Autowired
    private CurriculumResourceRepo curriculumResourceRepo;

    @Override
    public List<ResourceDto> getAllResources() {
        return resourceDtoList(resourceRepo.findAll());
    }

    @Transactional
    @Override
    public void deleteResource(Long resourceId) {
        if (!resourceRepo.existsById(resourceId)) {
            throw new IllegalArgumentException("Resource not found");
        }
        Resource resource = resourceRepo.findById(resourceId).get();

        for (Article article : resource.getArticles()) {
            articleService.safeDeleteArticle(article.getId());
        }

        resourceRepo.deleteById(resourceId);
    }

    @Override
    public Resource createResource(
            User user,
            String topicName,                 // ADMIN
            Subject subject,                  // ADMIN
            Long curriculumResourceId         //  ADMIN or TUTOR
    ) {

        Resource resource = new Resource();
        resource.setTutor(user);

        if (user.getRole() == Role.TUTOR) {
            // TUTOR: must choose CurriculumResource
            if (curriculumResourceId == null) {
                throw new IllegalArgumentException("Curriculum resource must be selected");
            }

            CurriculumResource cr = curriculumResourceRepo.findById(curriculumResourceId)
                    .orElseThrow(() -> new IllegalArgumentException("Curriculum resource not found"));

            if (resourceRepo.existsByTutorAndCurriculumResource(user, cr)) {
                throw new IllegalStateException("You already created this resource");
            }

            resource.setCurriculumResource(cr);
            resource.setTopicName(cr.getTopicName());
            resource.setSubject(cr.getSubject());

        } else if (user.getRole() == Role.ADMIN) {
            // ADMIN : can create free-text topic, optional link to CurriculumResource
            resource.setTopicName(topicName);
            resource.setSubject(subject);

            if (curriculumResourceId != null) {
                CurriculumResource cr = curriculumResourceRepo.findById(curriculumResourceId)
                        .orElseThrow(() -> new IllegalArgumentException("Curriculum resource not found"));
                resource.setCurriculumResource(cr);
            }
        }

        return resourceRepo.save(resource);
    }

    @Transactional
    @Override
    public Resource createResourceFromCurriculum(
            User creator,
            Long curriculumResourceId
    ) {

        CurriculumResource cr = curriculumResourceRepo.findById(curriculumResourceId)
                .orElseThrow(() -> new IllegalArgumentException("Curriculum Resource not found"));

        // Prevent duplicate resources per user
        if (resourceRepo.existsByTutorAndCurriculumResource(creator, cr)) {
            throw new IllegalStateException("You already have this resource");
        }

        Resource resource = Resource.builder()
                .topicName(cr.getTopicName())
                .subject(cr.getSubject())
                .curriculumResource(cr)
                .tutor(creator)
                .build();

        return resourceRepo.save(resource);
    }

    private ResourceDto convertToDto(Resource resource) {
        return ResourceDto.builder()
                .id(resource.getId())
                .topicName(resource.getTopicName())
                .subject(resource.getSubject())
                .build();
    }

    @Override
    public Page<ResourceDto> getResources(String keyword, int page, int size) {
        Pageable pageable = PageRequest.of(page, size, Sort.by("topicName").ascending());

        Page<Resource> resourcePage;

        if (keyword != null && !keyword.trim().isEmpty()) {
            resourcePage = resourceRepo.findByTopicNameContainingIgnoreCase(keyword, pageable);
        } else {
            resourcePage = resourceRepo.findAll(pageable);
        }

        return resourcePage.map(this::convertToDto);
    }


}
