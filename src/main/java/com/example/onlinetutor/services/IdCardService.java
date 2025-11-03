package com.example.onlinetutor.services;

import com.example.onlinetutor.dto.IdCardForm;
import com.example.onlinetutor.models.IdCard;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;


public interface IdCardService {
    IdCard saveIdCard(MultipartFile frontImage, MultipartFile backImage);
//    void deleteIdCard(Long id);
}
