package com.example.onlinetutor.repositories;

import com.example.onlinetutor.enums.Subject;
import com.example.onlinetutor.models.ChatRoom;
import com.example.onlinetutor.models.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface ChatRoomRepo extends JpaRepository<ChatRoom, Long> {

    Optional<ChatRoom> findByStudentAndSubject(User student, Subject subject);
    List<ChatRoom> findBySubjectIn(List<Subject> subjects);

    List<ChatRoom> findByStudent(User student);
}
