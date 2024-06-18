package com.sweater.repos;

import com.sweater.domain.Role;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface RoleRepo extends JpaRepository<Role, Long> {
    Optional<Role> findById(Long id);
    Optional<Role> findByRole(String role);
}
