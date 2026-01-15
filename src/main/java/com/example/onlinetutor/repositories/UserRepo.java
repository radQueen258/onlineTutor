package com.example.onlinetutor.repositories;

import com.example.onlinetutor.enums.Role;
import com.example.onlinetutor.models.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface UserRepo extends JpaRepository<User,Long> {

    Optional <User> findByEmail(String email);
    User findUserByEmail(String email);

    void deleteIdCardById(Long id);

    long countByRole(Role role);

    List<User> findAllByRole(Role role);
}
