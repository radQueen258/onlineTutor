package com.example.onlinetutor.services;

import com.example.onlinetutor.dto.IdCardForm;
import com.example.onlinetutor.models.IdCard;
import com.example.onlinetutor.repositories.IdCardRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import org.apache.commons.io.FilenameUtils;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.UUID;

@Component
public class IdCardServiceImpl implements IdCardService {

    @Value("${storage.path}")
    private String storagePath;

//    @Autowired
//    private IdCardRepo  idCardRepo;


    public String saveFile(MultipartFile file) {
        String storageName = UUID.randomUUID().toString() + "."
                + FilenameUtils.getExtension(file.getOriginalFilename());

        try {
            Files.copy(file.getInputStream(), Paths.get(storagePath, storageName));
        } catch (IOException e) {
            throw new RuntimeException("FAILED TO SAVE FILE", e);
        }

        return storagePath + "/" + storageName;
    }


    @Override
    public IdCard saveIdCard(MultipartFile frontImage, MultipartFile backImage) {
        String frontUrl = saveFile(frontImage);
        String backUrl = saveFile(backImage);

        return IdCard.builder()
                .frontImageUrl(frontUrl)
                .backImageUrl(backUrl)
                .build();
    }
}
