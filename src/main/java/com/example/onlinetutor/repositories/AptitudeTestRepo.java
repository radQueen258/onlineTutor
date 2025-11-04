package com.example.onlinetutor.repositories;

import com.example.onlinetutor.models.AptitudeTest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Optional;


public interface AptitudeTestRepo extends JpaRepository<AptitudeTest,Long> {
    Optional<AptitudeTest> findByUserId(Long userId);
    void deleteByUserId(Long userId);
//    List<AptitudeTest> findAllScore();
    List<AptitudeTest> findAllByOrderByIdDesc();
}
