package com.example.onlinetutor.services;

import com.example.onlinetutor.dto.IdCardForm;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component
public interface IdCardService {
    String saveIdCard(MultipartFile file, IdCardForm idCardForm);
}
