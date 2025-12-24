package com.tunza.api.core.auth;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/auth")
public class AuthController {

    // Placeholder for login
    @PostMapping("/login")
    public ResponseEntity<String> login(@RequestBody LoginRequest request) {
        // TODO: Implement JWT generation
        return ResponseEntity.ok("JWT Token Placeholder");
    }

    public static class LoginRequest {
        private String identifiant;
        private String password;
        private Long tenantId;

        // Getters and Setters
        public String getIdentifiant() { return identifiant; }
        public void setIdentifiant(String identifiant) { this.identifiant = identifiant; }

        public String getPassword() { return password; }
        public void setPassword(String password) { this.password = password; }

        public Long getTenantId() { return tenantId; }
        public void setTenantId(Long tenantId) { this.tenantId = tenantId; }
    }
}