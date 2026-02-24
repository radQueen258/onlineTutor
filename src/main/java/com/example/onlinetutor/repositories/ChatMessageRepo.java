package com.example.onlinetutor.repositories;

import com.example.onlinetutor.models.ChatMessage;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface ChatMessageRepo extends JpaRepository<ChatMessage, Long> {

    @Modifying
    @Query("UPDATE ChatMessage m SET m.read = true WHERE m.chatRoom.id = :roomId AND m.receiver.id = :userId")
    void markMessagesAsRead(@Param("roomId") Long roomId, @Param("userId") Long userId);
}
