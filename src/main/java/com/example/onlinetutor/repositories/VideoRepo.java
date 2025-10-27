package com.example.onlinetutor.repositories;

import com.example.onlinetutor.models.Article;
import com.example.onlinetutor.models.User;
import com.example.onlinetutor.models.Video;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface VideoRepo extends JpaRepository<Video,Long> {
    List<Video> findVideoByArticle(Article article);
    List<Video> findVideoByAuthor(User author);
}
