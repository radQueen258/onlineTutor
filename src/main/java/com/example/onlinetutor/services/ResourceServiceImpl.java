package com.example.onlinetutor.services;

import com.example.onlinetutor.dto.ResourceDto;
import com.example.onlinetutor.models.Article;
import com.example.onlinetutor.models.Resource;
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
}
