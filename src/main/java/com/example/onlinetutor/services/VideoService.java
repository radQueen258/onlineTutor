package com.example.onlinetutor.services;

import com.example.onlinetutor.models.Video;

public interface VideoService {
    void safeDeleteVideoById(Long video_id);

    Video getVideoById(Long id);
}
