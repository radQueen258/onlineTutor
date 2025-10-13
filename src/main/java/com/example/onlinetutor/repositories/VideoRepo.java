package com.example.onlinetutor.repositories;

import com.example.onlinetutor.models.Video;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Service;

@Service
public interface VideoRepo extends JpaRepository<Video,Long> {
}
