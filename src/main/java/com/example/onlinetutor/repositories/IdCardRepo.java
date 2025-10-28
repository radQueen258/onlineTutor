package com.example.onlinetutor.repositories;

import com.example.onlinetutor.models.IdCard;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Service;

public interface IdCardRepo extends JpaRepository<IdCard,Long> {
}
