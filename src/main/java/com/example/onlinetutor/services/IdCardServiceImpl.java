package com.example.onlinetutor.services;

import com.example.onlinetutor.dto.IdCardForm;
import com.example.onlinetutor.models.IdCard;
import com.example.onlinetutor.repositories.IdCardRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import org.apache.commons.io.FilenameUtils;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.UUID;

@Service
public class IdCardServiceImpl implements IdCardService {

    @Value("${storage.path}")
    private String storagePath;

    @Autowired
    private IdCardRepo  idCardRepo;


    @Override
    public String saveIdCard(MultipartFile file, IdCardForm idCardForm) {
        String storageName = UUID.randomUUID().toString() + "." +
                FilenameUtils.getExtension(file.getOriginalFilename());

        IdCard idCard = IdCard.builder()
                .frontImageUrl(idCardForm.getFrontImageUrl())
                .backImageUrl(idCardForm.getBackImageUrl())
                .type(file.getContentType())
                .size(file.getSize())
                .storageFileName(storageName)
                .url(storagePath + "/" + storageName)
                .build();

        try {
            Files.copy(file.getInputStream(), Paths.get(storagePath, storageName));
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

        filesRepository.save(fileInfo);
        return fileInfo.getStorageFileName();
    }
}
