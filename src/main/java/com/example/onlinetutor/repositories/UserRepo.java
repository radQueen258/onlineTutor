package com.example.onlinetutor.repositories;

import com.example.onlinetutor.models.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepo extends JpaRepository<User,Long> {

}
