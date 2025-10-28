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

//    @Autowired
//    private ArticleRepo articleRepo;
//
//    @Autowired
//    private VideoRepo videoRepo;

    @Autowired
    ResourceRepo resourceRepo;

    @Autowired
    private ResourceService resourceService;


    @GetMapping("/resources")
    public String showResources(Model model) {
        model.addAttribute("resources", resourceService.getAllResources());
        return "resources";
    }


    @GetMapping("/resources/article/{id}")
    public String openArticle(@PathVariable Long id, Model model) {
        Resource resource = resourceRepo.findById(id).orElseThrow(null);
        Article article = resource.getArticle();

        model.addAttribute("article", article);
        return "article-page";
    }

    @GetMapping("/resources/video/{id}")
    public String openVideo(@PathVariable Long id, Model model) {
        Resource resource = resourceRepo.findById(id).orElseThrow(null);
        Video video = resource.getVideo();

        model.addAttribute("video", video);
        return "video-page";
    }

}
