package com.tunza.api.security;

import io.jsonwebtoken.*;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.security.Key;
import java.util.Date;

/**
 * Utilitaire pour la gestion des JWT.
 * Génère, valide et extrait les informations des tokens.
 */
@Component
public class JwtUtil {

    @Value("${jwt.secret}")
    private String secret;

    @Value("${jwt.expiration}")
    private long expirationTime;

    private Key getSigningKey() {
        return Keys.hmacShaKeyFor(secret.getBytes());
    }

    /**
     * Génère un token JWT pour un utilisateur.
     * @param identifiant Identifiant de l'utilisateur
     * @param tenantId ID du tenant
     * @param role Rôle de l'utilisateur
     * @return Token JWT
     */
    public String generateToken(String identifiant, Long tenantId, String role) {
        return Jwts.builder()
                .setSubject(identifiant)
                .claim("tenantId", tenantId)
                .claim("role", role)
                .setIssuedAt(new Date())
                .setExpiration(new Date(System.currentTimeMillis() + expirationTime))
                .signWith(getSigningKey(), SignatureAlgorithm.HS256)
                .compact();
    }

    /**
     * Extrait l'identifiant du token.
     * @param token Token JWT
     * @return Identifiant
     */
    public String extractIdentifiant(String token) {
        return extractClaim(token, Claims::getSubject);
    }

    /**
     * Extrait le tenantId du token.
     * @param token Token JWT
     * @return Tenant ID
     */
    public Long extractTenantId(String token) {
        return extractClaim(token, claims -> claims.get("tenantId", Long.class));
    }

    /**
     * Extrait le rôle du token.
     * @param token Token JWT
     * @return Rôle
     */
    public String extractRole(String token) {
        return extractClaim(token, claims -> claims.get("role", String.class));
    }

    /**
     * Vérifie si le token est expiré.
     * @param token Token JWT
     * @return true si expiré
     */
    public boolean isTokenExpired(String token) {
        return extractExpiration(token).before(new Date());
    }

    /**
     * Valide le token.
     * @param token Token JWT
     * @param identifiant Identifiant attendu
     * @return true si valide
     */
    public boolean validateToken(String token, String identifiant) {
        return (identifiant.equals(extractIdentifiant(token)) && !isTokenExpired(token));
    }

    private Date extractExpiration(String token) {
        return extractClaim(token, Claims::getExpiration);
    }

    private <T> T extractClaim(String token, java.util.function.Function<Claims, T> claimsResolver) {
        final Claims claims = extractAllClaims(token);
        return claimsResolver.apply(claims);
    }

    private Claims extractAllClaims(String token) {
        return Jwts.parserBuilder()
                .setSigningKey(getSigningKey())
                .build()
                .parseClaimsJws(token)
                .getBody();
    }
}