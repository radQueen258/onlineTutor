package com.example.onlinetutor.controllers;

import com.example.onlinetutor.enums.Role;
import com.example.onlinetutor.enums.Subject;
import com.example.onlinetutor.models.ChatRoom;
import com.example.onlinetutor.models.User;
import com.example.onlinetutor.repositories.ChatRoomRepo;
import com.example.onlinetutor.repositories.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.security.Principal;
import java.util.List;

@Controller
public class ChatController {

    @Autowired
    private UserRepo userRepo;

    @Autowired
    private ChatRoomRepo chatRoomRepo;

    /*
     ============================================
     STUDENT: Open Chat By Subject
     ============================================
     URL example:
     /chat/student/BIOLOGY
     */
    @GetMapping("/chat/student/{subject}")
    public String openStudentChat(@PathVariable Subject subject,
                                  Model model,
                                  Principal principal) {

        User student = userRepo.findByEmail(principal.getName())
                .orElseThrow(() -> new RuntimeException("User not found"));

        if (student.getRole() != Role.STUDENT) {
            throw new RuntimeException("Access denied");
        }

        // Create room if not exists
        ChatRoom chatRoom = chatRoomRepo
                .findByStudentAndSubject(student, subject)
                .orElseGet(() -> {
                    ChatRoom newRoom = ChatRoom.builder()
                            .student(student)
                            .subject(subject)
                            .build();
                    return chatRoomRepo.save(newRoom);
                });

        model.addAttribute("chatRoom", chatRoom);
        model.addAttribute("currentUser", student);

        return "user-and-student/contact_teacher";
    }

    @GetMapping("/chat/student")
    public String studentChatHub(Model model, Principal principal) {

        User student = userRepo.findByEmail(principal.getName()).orElseThrow();

        List<ChatRoom> rooms = chatRoomRepo.findByStudent(student);

        model.addAttribute("chatRooms", rooms);
        model.addAttribute("subjects", student.getPreferredSubjects());

        return "user-and-student/student_chat_hub";
    }


    /*
     ============================================
     TEACHER: View All Chats For His Subjects
     ============================================
     URL:
     /chat/teacher
     */
    @GetMapping("/chat/teacher")
    public String teacherChats(Model model, Principal principal) {

        User tutor = userRepo.findByEmail(principal.getName())
                .orElseThrow(() -> new RuntimeException("User not found"));

        if (tutor.getRole() != Role.TUTOR) {
            throw new RuntimeException("Access denied");
        }

        List<ChatRoom> chatRooms =
                chatRoomRepo.findBySubjectIn(tutor.getPreferredSubjects());

        model.addAttribute("chatRooms", chatRooms);
        model.addAttribute("currentUser", tutor);

        return "tutor/teacher_chat_list";
    }


    /*
     ============================================
     TEACHER: Open Specific Student Chat
     ============================================
     URL:
     /chat/teacher/room/5
     */
    @GetMapping("/chat/teacher/room/{roomId}")
    public String openTeacherChat(@PathVariable Long roomId,
                                  Model model,
                                  Principal principal) {

        User tutor = userRepo.findByEmail(principal.getName())
                .orElseThrow(() -> new RuntimeException("User not found"));

        if (tutor.getRole() != Role.TUTOR) {
            throw new RuntimeException("Access denied");
        }

        ChatRoom chatRoom = chatRoomRepo.findById(roomId)
                .orElseThrow(() -> new RuntimeException("Chat not found"));

        // SECURITY CHECK
        if (!tutor.getPreferredSubjects().contains(chatRoom.getSubject())) {
            throw new RuntimeException("Access denied");
        }

        model.addAttribute("chatRoom", chatRoom);
        model.addAttribute("currentUser", tutor);

        return "tutor/contact_student";
    }
}
