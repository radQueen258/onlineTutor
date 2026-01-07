package com.example.onlinetutor.services;

import com.example.onlinetutor.models.Video;
import com.example.onlinetutor.repositories.VideoRepo;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

@Transactional
@Service
public class VideoServiceImpl implements VideoService {

    @Autowired
    private VideoRepo  videoRepo;


    @Transactional
    @Override
    public void safeDeleteVideoById(Long video_id) {
//        Video video = videoRepo.getVideoById(video_id);
//        if (video.getArticle() != null) {
//            video.getArticle().setVideo(null);
//        }
//        videoRepo.delete(video);

        Video video = videoRepo.findById(video_id)
                .orElseThrow(() -> new IllegalArgumentException("Video not found"));
        videoRepo.delete(video);
    }

    @Override
    public Video getVideoById(Long id) {
        return videoRepo.getVideoById(id);
    }
}
