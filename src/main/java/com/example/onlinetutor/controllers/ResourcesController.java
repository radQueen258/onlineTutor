package com.example.onlinetutor.controllers;

import com.example.onlinetutor.dto.ResourceDto;
import com.example.onlinetutor.models.Article;
import com.example.onlinetutor.models.Resource;
import com.example.onlinetutor.models.Video;
import com.example.onlinetutor.repositories.ArticleRepo;
import com.example.onlinetutor.repositories.ResourceRepo;
import com.example.onlinetutor.repositories.VideoRepo;
import com.example.onlinetutor.services.ResourceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
    public String showResources(
            @RequestParam(defaultValue = "") String keyword,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam (defaultValue = "10") int size,
            Model model) {

        Page<ResourceDto> resourcePage = resourceService.getResources(keyword, page, size);

        model.addAttribute("resources", resourcePage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", resourcePage.getTotalPages());
        model.addAttribute("keyword", keyword);
//        model.addAttribute("resources", resourceService.getAllResources());
        return "/user-and-student/resources";
    }


    @GetMapping("/resources/{resourceId}/article/{id}")
    public String openArticle(@PathVariable Long id,
                              @PathVariable Long resourceId,
                              Model model) {

        Article article = articleRepo.findArticlesById(id);

        model.addAttribute("article", article);
        model.addAttribute("resourceId", resourceId);
        return "/user-and-student/article-page";
    }

    @GetMapping("/resources/{resourceId}/video/{id}")
    public String openVideo(@PathVariable Long id,
                            @PathVariable Long resourceId,
                            Model model) {
        Resource resource = resourceRepo.findById(resourceId).orElseThrow(null);
        Video video = resource.getVideo();

        model.addAttribute("video", video);
        model.addAttribute("resourceId", resourceId);
        return "/user-and-student/video-page";
    }

    @GetMapping("/resources/{resourceId}/articles-and-videos")
    public String openArticlesAndVideosPage(@PathVariable Long resourceId,
                                            Model model) {
        List<Article> articleList = articleRepo.findArticlesByResource_Id(resourceId);
//        String resourceName = resourceRepo.findResourceTopicNameById(resourceId);

        List<Resource> resources = resourceRepo.findResourceById(resourceId);
//        List<String> name = resources.
        model.addAttribute("articleList", articleList);
        model.addAttribute("resourceName", resources);
        return "user-and-student/articles-and-videos-page";
    }

    @PostMapping("/tutor/resources/{resourceId}/delete")
    public String deleteResource(@PathVariable Long resourceId,
                                 RedirectAttributes  redirectAttributes) {
        try {
            resourceService.deleteResource(resourceId);
            redirectAttributes.addFlashAttribute("success", "Resource Deleted Successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to delete resource");
        }
        return "redirect:/tutor/workplace";
    }

}
