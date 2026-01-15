package com.example.onlinetutor.controllers;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class GlobalErrorController implements ErrorController {

    @RequestMapping("/error")
    public String handleError(HttpServletRequest request, Model model) {
        Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
        Object exception = request.getAttribute(RequestDispatcher.ERROR_EXCEPTION);

        String message = "An unexpected error occurred";

        if (status != null) {
            int statusCode = Integer.parseInt(status.toString());
            message = "Error " + statusCode;
        }

        if (exception != null) {
            message += ": " + exception.toString();
        }

        model.addAttribute("message", message);

        return "/error/error"; // fallback template
    }
}

