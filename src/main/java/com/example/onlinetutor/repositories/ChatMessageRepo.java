package com.example.onlinetutor.repositories;

import com.example.onlinetutor.models.ChatMessage;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ChatMessageRepo extends JpaRepository<ChatMessage, Long> {
}
