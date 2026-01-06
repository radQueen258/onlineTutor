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
            String topicName,                 // ADMIN free-text topic
            Subject subject,                  // ADMIN free-text subject
            Long curriculumResourceId         // optional, ADMIN or TUTOR
    ) {

        Resource resource = new Resource();
        resource.setTutor(user);

        if (user.getRole() == Role.TUTOR) {
            // TUTOR rules: must choose CurriculumResource
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
            // ADMIN rules: can create free-text topic, optional link to CurriculumResource
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

}
