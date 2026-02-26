package com.example.onlinetutor.controllers;

import com.example.onlinetutor.models.ArticleTranslation;
import com.example.onlinetutor.models.ExamTrend;
import com.example.onlinetutor.repositories.ArticleTranslationRepo;
import com.example.onlinetutor.services.ExamTrendService;
import com.example.onlinetutor.services.TranslationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class TranslationController {

    @Autowired
    private ExamTrendService examTrendService;

    @Autowired
    private TranslationService translationService;

    @Autowired
    private ArticleTranslationRepo translationRepo;

    @GetMapping("/exam-trends")
    public String examTrends(Model model) {
        List<ExamTrend> trends = examTrendService.getAllTrends();
        model.addAttribute("trends", trends);
        return "translations";
    }

    /*
      ============================================================
       AJAX TRANSLATION REQUEST (FROM GLOBE ICON)
      ============================================================
      This is called by:
      fetch("/articles/{id}/translate?language=xx", { method: "POST" })
      It MUST return a plain URL string.
      */
    @PostMapping("/articles/{id}/translate")
    @ResponseBody
    public String translateArticle(@PathVariable Long id,
                                   @RequestParam String language) {

        // Call service (this handles cache check internally)
        ArticleTranslation translation =
                translationService.translateArticle(id, language);

        // Return the URL that the modal will open
        return "/articles/" + id + "/translations/" + language;
    }


    /*
     ============================================================
      VIEW A SPECIFIC TRANSLATION
     ============================================================
     This loads the actual translated article page
     */
    @GetMapping("/articles/{id}/translations/{language}")
    public String viewTranslation(@PathVariable Long id,
                                  @PathVariable String language,
                                  Model model) {

        ArticleTranslation translation =
                translationRepo
                        .findByArticleIdAndLanguage(id, language)
                        .orElseThrow(() ->
                                new RuntimeException("Translation not found"));

        model.addAttribute("translation", translation);

        return "/user-and-student/translation-view"; // your translation-view.ftlh
    }


    /*
     ============================================================
     TRANSLATIONS LIBRARY PAGE
     ============================================================
     /translations
     Shows table of all translations
     */
    @GetMapping("/articles/translations")
    public String listTranslations(Model model) {

        List<ArticleTranslation> translations =
                translationRepo.findAll();

        model.addAttribute("translations", translations);

        return "/user-and-student/translations"; // translations.ftlh
    }


}
