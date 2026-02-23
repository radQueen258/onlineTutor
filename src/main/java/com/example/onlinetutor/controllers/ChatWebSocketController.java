package com.example.onlinetutor.controllers;

import com.example.onlinetutor.dto.ChatMessageDTO;
import com.example.onlinetutor.dto.ChatMessageResponseDTO;
import com.example.onlinetutor.enums.Role;
import com.example.onlinetutor.models.ChatMessage;
import com.example.onlinetutor.models.ChatRoom;
import com.example.onlinetutor.models.User;
import com.example.onlinetutor.repositories.ChatMessageRepo;
import com.example.onlinetutor.repositories.ChatRoomRepo;
import com.example.onlinetutor.repositories.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

import java.security.Principal;
import java.time.LocalDateTime;

@Controller
public class ChatWebSocketController {

    @Autowired
    private ChatRoomRepo chatRoomRepo;

    @Autowired
    private ChatMessageRepo chatMessageRepo;

    @Autowired
    private SimpMessagingTemplate messagingTemplate;

    @Autowired
    private UserRepo userRepo;


    @MessageMapping("/chat.send")
    public void sendMessage(ChatMessageDTO dto, Principal principal) {

        User sender = userRepo.findByEmail(principal.getName())
                .orElseThrow();

        ChatRoom room = chatRoomRepo.findById(dto.getChatRoomId())
                .orElseThrow();

        // SECURITY CHECK
        validateAccess(sender, room);

        ChatMessage message = ChatMessage.builder()
                .chatRoom(room)
                .sender(sender)
                .content(dto.getContent())
                .timestamp(LocalDateTime.now())
                .build();

        chatMessageRepo.save(message);

        ChatMessageResponseDTO response = ChatMessageResponseDTO.builder()
                .id(message.getId())
                .senderId(sender.getId())
                .senderName(sender.getFirstName())
                .content(message.getContent())
                .timestamp(message.getTimestamp())
                .build();

        messagingTemplate.convertAndSend(
                "/topic/chat/" + room.getId(),
                response
        );
    }

    private void validateAccess(User user, ChatRoom room) {

        if (user.getRole() == Role.STUDENT) {
            if (!room.getStudent().getId().equals(user.getId())) {
                throw new RuntimeException("Access denied");
            }
        }

        if (user.getRole() == Role.TUTOR) {
            if (!user.getPreferredSubjects().contains(room.getSubject())) {
                throw new RuntimeException("Access denied");
            }
        }
    }
}
