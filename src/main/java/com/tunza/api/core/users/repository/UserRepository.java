package com.tunza.api.core.users.repository;

import com.tunza.api.core.users.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    List<User> findByTenantId(Long tenantId);
    Optional<User> findByIdentifiantAndTenantId(String identifiant, Long tenantId);
    Optional<User> findByEmailAndTenantId(String email, Long tenantId);
}