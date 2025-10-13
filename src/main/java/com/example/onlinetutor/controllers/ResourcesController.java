package com.example.onlinetutor.controllers;

import com.example.onlinetutor.models.Article;
import com.example.onlinetutor.repositories.ArticleRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class ResourcesController {

    @Autowired
    private ArticleRepo articleRepo;

    @GetMapping("/article/{id}")
    public String openArticle(@PathVariable Long id, Model model) {
        Article article = articleRepo.findById(id).orElseThrow();
        model.addAttribute("article", article);
        return "article-page";
    }

}
