package com.tunza.api.core.auth;

import com.tunza.api.core.users.entity.User;
import com.tunza.api.core.users.repository.UserRepository;
import com.tunza.api.security.JwtUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

/**
 * Contrôleur pour l'authentification.
 * Gère le login et génère les tokens JWT.
 */
@RestController
@RequestMapping("/api/v1/auth")
public class AuthController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private JwtUtil jwtUtil;

    /**
     * Endpoint de connexion.
     * Valide les credentials et retourne un token JWT.
     * @param request Données de connexion
     * @return Token JWT ou erreur
     */
    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody LoginRequest request) {
        Optional<User> userOpt = userRepository.findByIdentifiantAndTenantId(request.getIdentifiant(), request.getTenantId());

        if (userOpt.isPresent()) {
            User user = userOpt.get();
            if (passwordEncoder.matches(request.getPassword(), user.getMotDePasseHash())) {
                // Générer token
                String token = jwtUtil.generateToken(user.getIdentifiant(), user.getTenantId(), user.getRoleId().toString());

                Map<String, Object> response = new HashMap<>();
                response.put("token", token);
                response.put("user", Map.of(
                    "id", user.getId(),
                    "identifiant", user.getIdentifiant(),
                    "nom", "Utilisateur", // TODO: Ajouter nom/prénom dans User
                    "role", user.getRoleId()
                ));

                return ResponseEntity.ok(response);
            }
        }

        return ResponseEntity.badRequest().body(Map.of("message", "Identifiants invalides"));
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