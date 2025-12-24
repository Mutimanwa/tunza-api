-- Script de données de test pour MVP TUNZA
-- À exécuter après la migration V1

-- Insérer un tenant de test
INSERT INTO tenants (nom, email, statut) VALUES ('Hôpital Test', 'test@hopital.com', 'ACTIF');

-- Insérer des rôles
INSERT INTO roles (nom, description) VALUES
('ADMIN', 'Administrateur'),
('MEDECIN', 'Médecin'),
('INFIRMIER', 'Infirmier'),
('RECEPTION', 'Réceptionniste');

-- Insérer un utilisateur de test (mot de passe: 'password' hashé avec BCrypt)
-- Le hash BCrypt pour 'password' est: $2a$10$example.hash.here (remplacer par réel)
INSERT INTO users (tenant_id, identifiant, email, mot_de_passe_hash, role_id, statut) VALUES
(1, 'admin', 'admin@test.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 1, 'ACTIF');

-- Insérer des patients de test
INSERT INTO patients (tenant_id, numero_dossier, nom, prenom, sexe, date_naissance, contact) VALUES
(1, 'PAT001', 'Dupont', 'Jean', 'M', '1980-01-15', '0123456789'),
(1, 'PAT002', 'Martin', 'Marie', 'F', '1990-05-20', '0987654321');

-- Insérer des consultations de test
INSERT INTO consultations (tenant_id, patient_id, user_id, date_consultation, diagnostic) VALUES
(1, 1, 1, '2025-12-24 10:00:00', 'Contrôle annuel'),
(1, 2, 1, '2025-12-24 11:00:00', 'Consultation générale');