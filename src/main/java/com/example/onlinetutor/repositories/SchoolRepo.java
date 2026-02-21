package com.example.onlinetutor.repositories;

import com.example.onlinetutor.models.School;
import org.springframework.data.jpa.repository.JpaRepository;

public interface SchoolRepo extends JpaRepository<School, Long> {
}
