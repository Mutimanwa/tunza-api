package com.tunza.api.security;

import com.tunza.api.core.users.entity.User;
import com.tunza.api.core.users.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Optional;

/**
 * Service pour charger les détails utilisateur pour Spring Security.
 */
@Service
public class CustomUserDetailsService implements UserDetailsService {

    @Autowired
    private UserRepository userRepository;

    @Override
    public UserDetails loadUserByUsername(String identifiant) throws UsernameNotFoundException {
        // Pour simplifier, assumons tenantId=1 pour l'authentification
        // En production, utiliser une logique plus avancée
        Optional<User> userOpt = userRepository.findByIdentifiantAndTenantId(identifiant, 1L);

        if (userOpt.isEmpty()) {
            throw new UsernameNotFoundException("Utilisateur non trouvé: " + identifiant);
        }

        User user = userOpt.get();
        return org.springframework.security.core.userdetails.User.builder()
                .username(user.getIdentifiant())
                .password(user.getMotDePasseHash())
                .roles(user.getRoleId().toString()) // TODO: Mapper vers noms de rôles
                .build();
    }
}