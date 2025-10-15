package com.example.onlinetutor.services;

import com.example.onlinetutor.dto.ResourceDto;
import com.example.onlinetutor.repositories.ResourceRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

import static com.example.onlinetutor.dto.ResourceDto.resourceDtoList;

@Component
public class ResourceServiceImpl implements ResourceService {

    @Autowired
    private ResourceRepo resourceRepo;

    @Override
    public List<ResourceDto> getAllResources() {
        return resourceDtoList(resourceRepo.findAll());
    }
}
