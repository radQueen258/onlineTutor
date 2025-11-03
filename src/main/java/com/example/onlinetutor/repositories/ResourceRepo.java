package com.example.onlinetutor.repositories;

import com.example.onlinetutor.models.Resource;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Service;

public interface ResourceRepo extends JpaRepository<Resource,Long> {

}
