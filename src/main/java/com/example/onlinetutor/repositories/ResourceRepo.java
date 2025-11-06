package com.example.onlinetutor.repositories;

import com.example.onlinetutor.models.Resource;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Service;

import java.util.List;

public interface ResourceRepo extends JpaRepository<Resource,Long> {
    List<Resource> findResourceById(Long resourceId);

    void deleteByTutor_Id(Long tutorId);

//    List<Resource> findAll();
}
