package com.example.onlinetutor.services;

import com.example.onlinetutor.dto.ResourceDto;
import com.example.onlinetutor.models.Article;
import com.example.onlinetutor.models.CurriculumResource;
import com.example.onlinetutor.models.Resource;
import com.example.onlinetutor.models.User;
import com.example.onlinetutor.repositories.CurriculumResourceRepo;
import com.example.onlinetutor.repositories.ResourceRepo;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
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
    public Resource createResource(User tutor, Long curriculumResourceId) {
        CurriculumResource cr =
                curriculumResourceRepo.findById(curriculumResourceId)
                        .orElseThrow();

        if (resourceRepo.existsByTutorAndCurriculumResource(tutor, cr)) {
            throw new IllegalStateException("Resource already exists");
        }

        Resource resource = Resource.builder()
                .curriculumResource(cr)
                .subject(cr.getSubject())
                .tutor(tutor)
                .topicName(cr.getTopicName())
                .build();

        return resourceRepo.save(resource);
    }
}
