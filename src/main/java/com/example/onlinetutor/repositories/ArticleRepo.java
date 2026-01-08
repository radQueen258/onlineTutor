package com.example.onlinetutor.repositories;

import com.example.onlinetutor.models.Article;
import com.example.onlinetutor.models.CurriculumResource;
import com.example.onlinetutor.models.Resource;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import java.util.Collection;
import java.util.List;
import java.util.Set;

@Repository
public interface ArticleRepo extends JpaRepository<Article,Long> {
    List<Article> findByArticleTitle(String topic);
    List<Article> findByTutorName_Id(Long userId);
    Long countByResource_Id(Long resourceId);

    List<Article> findArticlesByResource_Id(Long resourceId);
//    Long countArticlesByResource(Resource resource);

    List<Article> findAll();

    void deleteArticleByTutorName_Id(Long tutorNameId);
    void deleteArticleById(Long articleId);

    Article findArticlesById(Long id);

    List<Article> findByResourceIn(Collection<Resource> resources);
}
