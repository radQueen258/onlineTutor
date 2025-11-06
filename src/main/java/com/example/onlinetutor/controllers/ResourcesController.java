package com.example.onlinetutor.controllers;

import com.example.onlinetutor.models.Article;
import com.example.onlinetutor.models.Resource;
import com.example.onlinetutor.models.Video;
import com.example.onlinetutor.repositories.ArticleRepo;
import com.example.onlinetutor.repositories.ResourceRepo;
import com.example.onlinetutor.repositories.VideoRepo;
import com.example.onlinetutor.services.ResourceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

@Controller
public class ResourcesController {

    @Autowired
    ResourceRepo resourceRepo;

    @Autowired
    private ResourceService resourceService;
    @Autowired
    private ArticleRepo articleRepo;


    @GetMapping("/resources")
    public String showResources(Model model) {
        model.addAttribute("resources", resourceService.getAllResources());
        return "/user-and-student/resources";
    }


    @GetMapping("/resources/{resourceId}/article/{id}")
    public String openArticle(@PathVariable Long id,
                              @PathVariable Long resourceId,
                              Model model) {
//        Resource resource = resourceRepo.findById(id).orElseThrow(null);

        Article article = articleRepo.findArticlesById(id);

        model.addAttribute("article", article);
        model.addAttribute("resourceId", resourceId);
        return "/user-and-student/article-page";
    }

    @GetMapping("/resources/{resourceId}/video/{id}")
    public String openVideo(@PathVariable Long id,
                            @PathVariable Long resourceId,
                            Model model) {
        Resource resource = resourceRepo.findById(id).orElseThrow(null);
        Video video = resource.getVideo();

        model.addAttribute("video", video);
        model.addAttribute("resourceId", resourceId);
        return "/user-and-student/video-page";
    }

    @GetMapping("/resources/{resourceId}/articles-and-videos")
    public String openArticlesAndVideosPage(@PathVariable Long resourceId,
                                            Model model) {
        List<Article> articleList = articleRepo.findArticlesByResource_Id(resourceId);
//        List<Video> videoList = videoRepo.findVideoByArticle()
        model.addAttribute("articleList", articleList);
        return "user-and-student/articles-and-videos-page";
    }

}
