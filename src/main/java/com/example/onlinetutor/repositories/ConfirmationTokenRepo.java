package com.example.onlinetutor.repositories;

import com.example.onlinetutor.models.ConfirmationToken;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Service;
import java.util.Optional;

@Service
public interface ConfirmationTokenRepo extends JpaRepository<ConfirmationToken,Long> {

    Optional<ConfirmationToken> findByConfirmationToken(String confirmationToken);
}
