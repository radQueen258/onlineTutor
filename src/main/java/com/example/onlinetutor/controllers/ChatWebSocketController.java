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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.Principal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.UUID;

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

        boolean isMine = sender.getId().equals(message.getSender().getId());
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm");


        ChatMessageResponseDTO response = ChatMessageResponseDTO.builder()
                .id(message.getId())
                .senderId(sender.getId())
                .senderName(sender.getFirstName())
                .content(message.getContent())
                .time(message.getTimestamp().format(formatter))
                .fileUrl(message.getFileUrl())
                .fileType(message.getFileType())
                .mine(isMine)
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

    @PostMapping("/chat/upload")
    @ResponseBody
    public ChatMessageResponseDTO uploadFile(
            @RequestParam("file") MultipartFile file,
            @RequestParam("chatRoomId") Long chatRoomId,
            Principal principal) throws IOException {

        User sender = userRepo.findByEmail(principal.getName()).orElseThrow();
        ChatRoom room = chatRoomRepo.findById(chatRoomId).orElseThrow();

        validateAccess(sender, room);

        // SAVE FILE
        String fileName = UUID.randomUUID() + "_" + file.getOriginalFilename();
        Path path = Paths.get("uploads/" + fileName);
        Files.createDirectories(path.getParent());
        Files.write(path, file.getBytes());

        String fileUrl = "/uploads/" + fileName;

        String fileType = file.getContentType().startsWith("image") ? "image" : "file";

        ChatMessage message = ChatMessage.builder()
                .chatRoom(room)
                .sender(sender)
                .content("") // no text
                .fileUrl(fileUrl)
                .fileType(fileType)
                .timestamp(LocalDateTime.now())
                .build();

        chatMessageRepo.save(message);

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm");

        ChatMessageResponseDTO response = ChatMessageResponseDTO.builder()
                .id(message.getId())
                .senderId(sender.getId())
                .senderName(sender.getFirstName())
                .content("")
                .fileUrl(fileUrl)
                .fileType(fileType)
                .time(message.getTimestamp().format(formatter))
                .mine(true)
                .build();

        messagingTemplate.convertAndSend("/topic/chat/" + room.getId(), response);

        return response;
    }
}
