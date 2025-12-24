-- Migration V1: Create MVP Schema for TUNZA Hospital Platform
-- Based on todo.md requirements: Multi-tenant MVP with Tenant, User, Role, Patient, Consultation

-- Enable foreign key checks
SET FOREIGN_KEY_CHECKS = 1;

-- Table: tenants (Etablissements)
CREATE TABLE tenants (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    nom VARCHAR(255) NOT NULL,
    adresse TEXT,
    telephone VARCHAR(20),
    email VARCHAR(255),
    admin_user_id BIGINT UNSIGNED, -- Reference to users table, set after creation
    statut ENUM('ACTIF', 'INACTIF') DEFAULT 'ACTIF',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uk_tenant_nom (nom),
    UNIQUE KEY uk_tenant_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: roles
CREATE TABLE roles (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL, -- e.g., ADMIN, MEDECIN, INFIRMIER, RECEPTION
    description TEXT,
    permissions JSON, -- Store permissions as JSON array
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uk_role_nom (nom)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: users (Utilisateurs système)
CREATE TABLE users (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    tenant_id BIGINT UNSIGNED NOT NULL,
    identifiant VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL,
    mot_de_passe_hash VARCHAR(255) NOT NULL,
    role_id BIGINT UNSIGNED NOT NULL,
    statut ENUM('ACTIF', 'INACTIF', 'SUSPENDU') DEFAULT 'ACTIF',
    date_derniere_connexion DATETIME,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uk_user_identifiant (identifiant),
    UNIQUE KEY uk_user_email (email),
    FOREIGN KEY (tenant_id) REFERENCES tenants(id) ON DELETE CASCADE,
    FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Update tenants to reference admin_user_id
ALTER TABLE tenants ADD CONSTRAINT fk_tenant_admin_user FOREIGN KEY (admin_user_id) REFERENCES users(id) ON DELETE SET NULL;

-- Table: patients
CREATE TABLE patients (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    tenant_id BIGINT UNSIGNED NOT NULL,
    numero_dossier VARCHAR(20) NOT NULL,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    sexe ENUM('M', 'F') NOT NULL,
    date_naissance DATE NOT NULL,
    contact VARCHAR(20), -- Telephone
    adresse TEXT,
    statut ENUM('ACTIF', 'INACTIF', 'DECEDE') DEFAULT 'ACTIF',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uk_patient_dossier_tenant (numero_dossier, tenant_id),
    FOREIGN KEY (tenant_id) REFERENCES tenants(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: consultations
CREATE TABLE consultations (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    tenant_id BIGINT UNSIGNED NOT NULL,
    patient_id BIGINT UNSIGNED NOT NULL,
    user_id BIGINT UNSIGNED NOT NULL, -- Medecin/soignant
    date_consultation DATETIME NOT NULL,
    diagnostic TEXT,
    actes_medicaux TEXT, -- JSON or text for acts
    observation_medicale TEXT,
    statut ENUM('PROGRAMMEE', 'EN_COURS', 'TERMINEE', 'ANNULEE') DEFAULT 'PROGRAMMEE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    FOREIGN KEY (tenant_id) REFERENCES tenants(id) ON DELETE CASCADE,
    FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insert default roles
INSERT INTO roles (nom, description, permissions) VALUES
('ADMIN', 'Administrateur établissement', '["ALL"]'),
('MEDECIN', 'Médecin', '["READ_PATIENT", "WRITE_PATIENT", "READ_CONSULTATION", "WRITE_CONSULTATION"]'),
('INFIRMIER', 'Infirmier', '["READ_PATIENT", "READ_CONSULTATION"]'),
('RECEPTION', 'Réceptionniste', '["READ_PATIENT", "WRITE_PATIENT"]');

-- Note: Tenants and users will be inserted via application or separate migration</content>
-- <parameter name="filePath">/opt/lampp/htdocs/tunza-platform/tunza-api/src/main/resources/db/migration/V1__Create_MVP_Schema.sql