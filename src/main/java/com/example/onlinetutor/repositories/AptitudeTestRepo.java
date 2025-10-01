package com.example.onlinetutor.repositories;

import com.example.onlinetutor.models.AptitudeTest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestParam;

@Repository
public interface AptitudeTestRepo extends JpaRepository<AptitudeTest,Long> {
    Optional<AptitudeTest> findByUserId(Long userId);
}
