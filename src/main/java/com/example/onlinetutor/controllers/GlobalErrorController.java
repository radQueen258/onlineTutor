package com.example.onlinetutor.controllers;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class GlobalErrorController implements ErrorController {

    @RequestMapping("/error")
    public String handleError(HttpServletRequest request, Model model) {

        Authentication authentication =
                SecurityContextHolder.getContext().getAuthentication();

        if (authentication != null
                && authentication.isAuthenticated()
                && !"anonymousUser".equals(authentication.getPrincipal())) {

            String redirectUrl = "/";

            if (authentication.getAuthorities().stream()
                    .anyMatch(a -> a.getAuthority().equals("STUDENT"))) {
                redirectUrl = "/dashboard";
            } else if (authentication.getAuthorities().stream()
                    .anyMatch(a -> a.getAuthority().equals("TUTOR"))) {
                redirectUrl = "/tutor/workplace";
            } else if (authentication.getAuthorities().stream()
                    .anyMatch(a -> a.getAuthority().equals("ADMIN"))) {
                redirectUrl = "/admin/workplace";
            }

            model.addAttribute("dashboardUrl", redirectUrl);
        }

        Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
        String message = "An unexpected error occurred";

        if (status != null) {
            message = "Error " + status.toString();
        }

        model.addAttribute("message", message);

        return "/error/error";
    }

    @GetMapping("/error/400")
    public String error400(HttpServletRequest request, Model model) {
        Authentication authentication =
                SecurityContextHolder.getContext().getAuthentication();

        if (authentication != null
                && authentication.isAuthenticated()
                && !"anonymousUser".equals(authentication.getPrincipal())) {

            String redirectUrl = "/";

            if (authentication.getAuthorities().stream()
                    .anyMatch(a -> a.getAuthority().equals("ROLE_STUDENT"))) {
                redirectUrl = "/dashboard";
            } else if (authentication.getAuthorities().stream()
                    .anyMatch(a -> a.getAuthority().equals("ROLE_TUTOR"))) {
                redirectUrl = "/tutor/workplace";
            } else if (authentication.getAuthorities().stream()
                    .anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"))) {
                redirectUrl = "/admin/workplace";
            }

            model.addAttribute("dashboardUrl", redirectUrl);
        }
        return "/error/400";
    }

    @GetMapping("/error/500")
    public String error500(HttpServletRequest request, Model model) {
        Authentication authentication =
                SecurityContextHolder.getContext().getAuthentication();

        if (authentication != null
                && authentication.isAuthenticated()
                && !"anonymousUser".equals(authentication.getPrincipal())) {

            String redirectUrl = "/";

            if (authentication.getAuthorities().stream()
                    .anyMatch(a -> a.getAuthority().equals("ROLE_STUDENT"))) {
                redirectUrl = "/dashboard";
            } else if (authentication.getAuthorities().stream()
                    .anyMatch(a -> a.getAuthority().equals("ROLE_TUTOR"))) {
                redirectUrl = "/tutor/workplace";
            } else if (authentication.getAuthorities().stream()
                    .anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"))) {
                redirectUrl = "/admin/workplace";
            }

            model.addAttribute("dashboardUrl", redirectUrl);
        }
        return "/error/500";
    }
}

