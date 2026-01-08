//package com.example.onlinetutor.mockData;
//
//import com.example.onlinetutor.models.Article;
//import com.example.onlinetutor.models.CurriculumResource;
//import com.example.onlinetutor.models.Resource;
//import com.example.onlinetutor.models.User;
//import com.example.onlinetutor.repositories.ArticleRepo;
//import com.example.onlinetutor.repositories.CurriculumResourceRepo;
//import com.example.onlinetutor.repositories.ResourceRepo;
//import com.example.onlinetutor.repositories.UserRepo;
//import jakarta.annotation.PostConstruct;
//import lombok.RequiredArgsConstructor;
//import org.springframework.stereotype.Component;
//
//import java.util.List;
//
//@Component
//@RequiredArgsConstructor
//public class TutorResourceDataInitializer {
//
//    private final UserRepo userRepo;
//    private final ResourceRepo resourceRepo;
//    private final ArticleRepo articleRepo;
//    private final CurriculumResourceRepo curriculumResourceRepo;
//
//    @PostConstruct
//    public void initTutorResources() {
//
//        User tutor = userRepo.findByEmail("tutor@example.com")
//                .orElseThrow(() ->
//                        new IllegalStateException("Tutor with email tutor@example.com not found")
//                );
//
//        List<CurriculumResource> curriculumResources =
//                curriculumResourceRepo.findAll();
//
//        for (CurriculumResource cr : curriculumResources) {
//
//            boolean exists = resourceRepo
//                    .existsByTutorAndCurriculumResource(tutor, cr);
//
//            if (exists) continue;
//
//            Resource resource = new Resource();
//            resource.setTutor(tutor);
//            resource.setCurriculumResource(cr);
//            resource.setTopicName(cr.getTopicName());
//            resourceRepo.save(resource);
//
//            // Create dummy articles
//            for (int i = 1; i <= 2; i++) {
//                Article article = new Article();
//                article.setArticleTitle(cr.getTopicName() + " – Article " + i);
//                article.setArticleContent(
//                        "Dummy educational content for " + cr.getTopicName()
//                );
//                article.setResource(resource);
//                articleRepo.save(article);
//            }
//        }
//    }
//}
//
