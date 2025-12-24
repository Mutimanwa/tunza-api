-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 23, 2025 at 12:30 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hospital_complete_system`
--

-- --------------------------------------------------------

--
-- Table structure for table `accouchements`
--

CREATE TABLE `accouchements` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `grossesse_id` bigint(20) UNSIGNED NOT NULL,
  `date_debut_travail` datetime DEFAULT NULL,
  `date_accouchement` datetime NOT NULL,
  `duree_travail_heures` decimal(4,1) DEFAULT NULL,
  `salle_accouchement` varchar(50) DEFAULT NULL,
  `sage_femme_id` bigint(20) UNSIGNED NOT NULL,
  `obstetricien_id` bigint(20) UNSIGNED DEFAULT NULL,
  `anesthesiste_id` bigint(20) UNSIGNED DEFAULT NULL,
  `pediatre_id` bigint(20) UNSIGNED DEFAULT NULL,
  `declenchement` tinyint(1) DEFAULT 0,
  `motif_declenchement` text DEFAULT NULL,
  `rupture_membranes` enum('SPONTANEE','ARTIFICIELLE','PREMATUREE') DEFAULT NULL,
  `heure_rupture_membranes` time DEFAULT NULL,
  `aspect_liquide_amniotique` enum('CLAIR','TEINTE','MECONIAL') DEFAULT NULL,
  `anesthesie` enum('AUCUNE','PERIDURALE','RACHIANESTHESIE','GENERALE') DEFAULT NULL,
  `heure_pose_peridurale` time DEFAULT NULL,
  `efficacite_anesthesie` enum('EFFICACE','PARTIELLE','INEFFICACE') DEFAULT NULL,
  `voie_accouchement` enum('BASSE_SPONTANEE','BASSE_INSTRUMENTALE','CESARIENNE') DEFAULT NULL,
  `presentation` enum('CEPHALIQUE','SIEGE','TRANSVERSE') DEFAULT 'CEPHALIQUE',
  `instrument_utilise` enum('AUCUN','FORCEPS','VENTOUSE','SPATULES') DEFAULT NULL,
  `episiotomie` tinyint(1) DEFAULT 0,
  `dechirures` enum('AUCUNE','GRADE_1','GRADE_2','GRADE_3','GRADE_4') DEFAULT NULL,
  `indication_cesarienne` text DEFAULT NULL,
  `cesarienne_programmee` tinyint(1) DEFAULT 0,
  `type_incision` enum('PFANNENSTIEL','MEDIANE') DEFAULT 'PFANNENSTIEL',
  `delivrance` enum('SPONTANEE','ARTIFICIELLE','DIRIGEE') DEFAULT 'DIRIGEE',
  `placenta_complet` tinyint(1) DEFAULT 1,
  `hemorragie_delivrance` tinyint(1) DEFAULT 0,
  `quantite_saignement_ml` smallint(5) UNSIGNED DEFAULT NULL,
  `sexe_enfant` enum('M','F') DEFAULT NULL,
  `poids_naissance` smallint(5) UNSIGNED DEFAULT NULL COMMENT 'en grammes',
  `taille_naissance` tinyint(3) UNSIGNED DEFAULT NULL COMMENT 'en cm',
  `pc_naissance` decimal(4,1) DEFAULT NULL COMMENT 'Périmètre crânien en cm',
  `apgar_1min` tinyint(3) UNSIGNED DEFAULT NULL,
  `apgar_5min` tinyint(3) UNSIGNED DEFAULT NULL,
  `apgar_10min` tinyint(3) UNSIGNED DEFAULT NULL,
  `complications_maternelles` text DEFAULT NULL,
  `complications_foetales` text DEFAULT NULL,
  `allaitement_souhaite` tinyint(1) DEFAULT 1,
  `montee_lait` tinyint(1) DEFAULT 1,
  `duree_sejour_jours` tinyint(3) UNSIGNED DEFAULT NULL,
  `sortie_domicile` tinyint(1) DEFAULT 1,
  `visite_sage_femme_prevue` tinyint(1) DEFAULT 1,
  `compte_rendu` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `chambres`
--

CREATE TABLE `chambres` (
  `id` mediumint(8) UNSIGNED NOT NULL,
  `unite_id` smallint(5) UNSIGNED NOT NULL,
  `numero` varchar(20) NOT NULL,
  `type_chambre` enum('INDIVIDUELLE','DOUBLE','TRIPLE','QUADRUPLE','ISOLEMENT','ISOLEMENT_PROTECTEUR','ISOLEMENT_SEPTIQUE','SOINS_INTENSIFS','SURVEILLANCE_CONTINUE','MATERNITE','PEDIATRIE','CHAMBRE_MERE_ENFANT') NOT NULL,
  `superficie` decimal(5,2) DEFAULT NULL COMMENT 'en m²',
  `vue_exterieure` tinyint(1) DEFAULT 0,
  `climatisation` tinyint(1) DEFAULT 0,
  `television` tinyint(1) DEFAULT 0,
  `refrigerateur` tinyint(1) DEFAULT 0,
  `coffre_fort` tinyint(1) DEFAULT 0,
  `acces_handicap` tinyint(1) DEFAULT 0,
  `salle_bain_adaptee` tinyint(1) DEFAULT 0,
  `prises_oxygene` tinyint(3) UNSIGNED DEFAULT 0,
  `prises_vide` tinyint(3) UNSIGNED DEFAULT 0,
  `prises_air_comprime` tinyint(3) UNSIGNED DEFAULT 0,
  `prises_electriques_medical` tinyint(3) UNSIGNED DEFAULT 0,
  `telephone` varchar(20) DEFAULT NULL,
  `poste_infirmier` varchar(10) DEFAULT NULL,
  `supplement_chambre_individuelle` decimal(8,2) DEFAULT 0.00,
  `categorie_confort` enum('STANDARD','CONFORT','LUXE') DEFAULT 'STANDARD',
  `statut` enum('DISPONIBLE','OCCUPEE','NETTOYAGE','DESINFECTION','MAINTENANCE','HORS_SERVICE') DEFAULT 'DISPONIBLE',
  `date_derniere_desinfection` datetime DEFAULT NULL,
  `date_derniere_maintenance` date DEFAULT NULL,
  `particularites` text DEFAULT NULL,
  `restrictions_usage` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `competences_personnel`
--

CREATE TABLE `competences_personnel` (
  `id` int(10) UNSIGNED NOT NULL,
  `personnel_id` bigint(20) UNSIGNED NOT NULL,
  `specialite_id` smallint(5) UNSIGNED NOT NULL,
  `niveau` enum('DEBUTANT','JUNIOR','CONFIRME','SENIOR','EXPERT','REFERENT') NOT NULL,
  `diplome_obtenu` varchar(200) DEFAULT NULL,
  `organisme_formation` varchar(200) DEFAULT NULL,
  `date_obtention` date DEFAULT NULL,
  `date_expiration` date DEFAULT NULL,
  `numero_certification` varchar(100) DEFAULT NULL,
  `valide_par_id` bigint(20) UNSIGNED DEFAULT NULL,
  `date_validation` date DEFAULT NULL,
  `date_debut_pratique` date DEFAULT NULL,
  `nombre_actes_realises` int(11) DEFAULT 0,
  `derniere_formation` date DEFAULT NULL,
  `statut` enum('ACTIVE','SUSPENDUE','EXPIREE','RETIREE') DEFAULT 'ACTIVE',
  `note_evaluation` decimal(3,1) DEFAULT NULL COMMENT 'Sur 10',
  `date_derniere_evaluation` date DEFAULT NULL,
  `evaluateur_id` bigint(20) UNSIGNED DEFAULT NULL,
  `observations` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `consultations`
--

CREATE TABLE `consultations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `numero_consultation` varchar(20) NOT NULL,
  `patient_id` bigint(20) UNSIGNED NOT NULL,
  `medecin_id` bigint(20) UNSIGNED NOT NULL,
  `service_id` smallint(5) UNSIGNED NOT NULL,
  `type_consultation_id` smallint(5) UNSIGNED NOT NULL,
  `date_consultation` datetime NOT NULL,
  `duree_prevue` smallint(5) UNSIGNED NOT NULL COMMENT 'en minutes',
  `duree_reelle` smallint(5) UNSIGNED DEFAULT NULL COMMENT 'en minutes',
  `mode_consultation` enum('PRESENTIEL','TELECONSULTATION','TELEPHONIQUE') DEFAULT 'PRESENTIEL',
  `urgence` enum('PROGRAMMEE','SEMI_URGENTE','URGENTE') DEFAULT 'PROGRAMMEE',
  `origine` enum('PREMIERE_CONSULTATION','SUIVI','CONTROLE','URGENCE','TRANSFERT') NOT NULL,
  `motif_consultation` text NOT NULL,
  `histoire_maladie` text DEFAULT NULL,
  `antecedents_personnels` text DEFAULT NULL,
  `antecedents_familiaux` text DEFAULT NULL,
  `traitements_en_cours` text DEFAULT NULL,
  `constantes_vitales` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'TA, pouls, température, poids, taille, etc.' CHECK (json_valid(`constantes_vitales`)),
  `examen_general` text DEFAULT NULL,
  `examen_specialise` text DEFAULT NULL,
  `examens_demandes` text DEFAULT NULL,
  `resultats_examens` text DEFAULT NULL,
  `diagnostic_principal` varchar(300) DEFAULT NULL,
  `diagnostics_associes` text DEFAULT NULL,
  `codes_cim10` varchar(200) DEFAULT NULL COMMENT 'Codes CIM-10 séparés par virgules',
  `prescription_medicamenteuse` text DEFAULT NULL,
  `prescription_non_medicamenteuse` text DEFAULT NULL,
  `arret_travail_jours` smallint(5) UNSIGNED DEFAULT NULL,
  `certificat_medical` text DEFAULT NULL,
  `suivi_necessaire` tinyint(1) DEFAULT 0,
  `date_prochain_rdv` date DEFAULT NULL,
  `orientation` varchar(200) DEFAULT NULL,
  `hospitalisation_necessaire` tinyint(1) DEFAULT 0,
  `tarif_applique` decimal(8,2) DEFAULT NULL,
  `taux_remboursement` decimal(5,2) DEFAULT NULL,
  `depassement_honoraires` decimal(8,2) DEFAULT 0.00,
  `duree_attente` smallint(5) UNSIGNED DEFAULT NULL COMMENT 'en minutes',
  `satisfaction_patient` enum('TRES_INSATISFAIT','INSATISFAIT','NEUTRE','SATISFAIT','TRES_SATISFAIT') DEFAULT NULL,
  `statut` enum('PROGRAMMEE','EN_COURS','TERMINEE','ANNULEE','REPORTEE') DEFAULT 'PROGRAMMEE',
  `motif_annulation` text DEFAULT NULL,
  `salle_consultation` varchar(50) DEFAULT NULL,
  `temperature_corporelle` decimal(3,1) DEFAULT NULL,
  `poids_kg` decimal(5,2) DEFAULT NULL,
  `taille_cm` smallint(5) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_by` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `contrats_travail`
--

CREATE TABLE `contrats_travail` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `personnel_id` bigint(20) UNSIGNED NOT NULL,
  `numero_contrat` varchar(20) NOT NULL,
  `type_contrat` enum('CDI','CDD','INTERIM','STAGIAIRE','LIBERAL','PRATICIEN_HOSPITALIER','CONSULTANT') NOT NULL,
  `statut_contrat` enum('EN_COURS','SUSPENDU','ROMPU','TERMINE','RENOUVELE') DEFAULT 'EN_COURS',
  `date_debut` date NOT NULL,
  `date_fin` date DEFAULT NULL,
  `date_signature` date DEFAULT NULL,
  `date_embauche_effective` date DEFAULT NULL,
  `periode_essai_jours` smallint(5) UNSIGNED DEFAULT NULL,
  `salaire_base` decimal(10,2) NOT NULL,
  `coefficient` smallint(5) UNSIGNED DEFAULT NULL,
  `echelon` tinyint(3) UNSIGNED DEFAULT NULL,
  `grille_salaire` varchar(50) DEFAULT NULL,
  `prime_fonction` decimal(8,2) DEFAULT 0.00,
  `prime_risque` decimal(8,2) DEFAULT 0.00,
  `quotite_travail` decimal(5,2) DEFAULT 100.00 COMMENT 'Pourcentage temps plein',
  `heures_hebdomadaires` decimal(4,1) DEFAULT 35.0,
  `amplitude_horaire` varchar(100) DEFAULT NULL,
  `travail_nuit` tinyint(1) DEFAULT 0,
  `travail_weekend` tinyint(1) DEFAULT 0,
  `poste_occupe` varchar(100) NOT NULL,
  `service_affectation` smallint(5) UNSIGNED DEFAULT NULL,
  `lieu_travail_principal` varchar(100) DEFAULT NULL,
  `convention_collective` varchar(100) DEFAULT NULL,
  `classification` varchar(50) DEFAULT NULL,
  `diplome_requis` varchar(200) DEFAULT NULL,
  `contrat_pdf` varchar(255) DEFAULT NULL,
  `annexes` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`annexes`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_by` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `courbes_croissance`
--

CREATE TABLE `courbes_croissance` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `patient_id` bigint(20) UNSIGNED NOT NULL,
  `date_mesure` date NOT NULL,
  `age_mois` smallint(5) UNSIGNED NOT NULL,
  `age_corrige_mois` smallint(5) UNSIGNED DEFAULT NULL COMMENT 'Pour prématurés',
  `poids_kg` decimal(5,2) DEFAULT NULL,
  `taille_cm` decimal(5,1) DEFAULT NULL,
  `pc_cm` decimal(4,1) DEFAULT NULL COMMENT 'Périmètre crânien',
  `imc` decimal(4,1) DEFAULT NULL,
  `percentile_poids` tinyint(3) UNSIGNED DEFAULT NULL,
  `percentile_taille` tinyint(3) UNSIGNED DEFAULT NULL,
  `percentile_pc` tinyint(3) UNSIGNED DEFAULT NULL,
  `percentile_imc` tinyint(3) UNSIGNED DEFAULT NULL,
  `consultation_id` bigint(20) UNSIGNED DEFAULT NULL,
  `personnel_mesure_id` bigint(20) UNSIGNED DEFAULT NULL,
  `observations` text DEFAULT NULL,
  `courbe_normale` tinyint(1) DEFAULT 1,
  `alerte_cassure` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `developpement_psychomoteur`
--

CREATE TABLE `developpement_psychomoteur` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `patient_id` bigint(20) UNSIGNED NOT NULL,
  `date_evaluation` date NOT NULL,
  `age_mois` smallint(5) UNSIGNED NOT NULL,
  `tient_tete` tinyint(1) DEFAULT NULL,
  `se_retourne` tinyint(1) DEFAULT NULL,
  `tient_assis` tinyint(1) DEFAULT NULL,
  `marche_quatre_pattes` tinyint(1) DEFAULT NULL,
  `marche_seul` tinyint(1) DEFAULT NULL,
  `court` tinyint(1) DEFAULT NULL,
  `monte_escaliers` tinyint(1) DEFAULT NULL,
  `saisie_objet` tinyint(1) DEFAULT NULL,
  `tenue_crayon` tinyint(1) DEFAULT NULL,
  `construction_tour` tinyint(1) DEFAULT NULL,
  `dessin_formes` tinyint(1) DEFAULT NULL,
  `babillage` tinyint(1) DEFAULT NULL,
  `premiers_mots` tinyint(1) DEFAULT NULL,
  `phrases_deux_mots` tinyint(1) DEFAULT NULL,
  `langage_complexe` tinyint(1) DEFAULT NULL,
  `sourire_reponse` tinyint(1) DEFAULT NULL,
  `jeu_coucou` tinyint(1) DEFAULT NULL,
  `interaction_autres_enfants` tinyint(1) DEFAULT NULL,
  `autonomie_habillage` tinyint(1) DEFAULT NULL,
  `age_developpement_equivalent_mois` smallint(5) UNSIGNED DEFAULT NULL,
  `retard_global` tinyint(1) DEFAULT 0,
  `domaines_retard` text DEFAULT NULL,
  `besoins_reeducation` text DEFAULT NULL,
  `orientation_specialiste` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `equipements_medicaux`
--

CREATE TABLE `equipements_medicaux` (
  `id` mediumint(8) UNSIGNED NOT NULL,
  `numero_parc` varchar(50) NOT NULL,
  `type_equipement` enum('DIAGNOSTIC','THERAPEUTIQUE','MONITORING','MOBILIER','INFORMATIQUE','AUTRE') NOT NULL,
  `categorie_equipement` varchar(100) DEFAULT NULL,
  `modele` varchar(100) NOT NULL,
  `marque` varchar(100) NOT NULL,
  `numero_serie` varchar(100) DEFAULT NULL,
  `caracteristiques_techniques` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`caracteristiques_techniques`)),
  `classe_risque` enum('I','IIa','IIb','III') DEFAULT 'I',
  `normes_conformite` text DEFAULT NULL,
  `service_affectation` smallint(5) UNSIGNED DEFAULT NULL,
  `localisation_precise` varchar(100) DEFAULT NULL,
  `responsable_maintenance_id` bigint(20) UNSIGNED DEFAULT NULL,
  `date_acquisition` date DEFAULT NULL,
  `date_mise_en_service` date DEFAULT NULL,
  `cout_acquisition` decimal(12,2) DEFAULT NULL,
  `fournisseur` varchar(100) DEFAULT NULL,
  `garantie_jours` smallint(5) UNSIGNED DEFAULT NULL,
  `frequence_maintenance_mois` tinyint(3) UNSIGNED DEFAULT NULL,
  `dernier_controle` date DEFAULT NULL,
  `prochain_controle` date DEFAULT NULL,
  `contrat_maintenance` tinyint(1) DEFAULT 0,
  `societe_maintenance` varchar(100) DEFAULT NULL,
  `statut` enum('OPERATIONNEL','EN_MAINTENANCE','HORS_SERVICE','EN_TEST','RETIRE') DEFAULT 'OPERATIONNEL',
  `notice_utilisation` varchar(255) DEFAULT NULL,
  `certificats` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`certificats`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_by` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `etablissements`
--

CREATE TABLE `etablissements` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `code_finess` varchar(9) NOT NULL,
  `nom` varchar(200) NOT NULL,
  `raison_sociale` varchar(250) DEFAULT NULL,
  `siret` varchar(14) DEFAULT NULL,
  `type_etablissement` enum('CHU','CHR','CH','CLINIQUE_PRIVEE','HOPITAL_PRIVE','ESPIC') NOT NULL,
  `statut_juridique` enum('PUBLIC','PRIVE_LUCRATIF','PRIVE_NON_LUCRATIF') NOT NULL,
  `adresse` text NOT NULL,
  `code_postal` varchar(10) NOT NULL,
  `ville` varchar(100) NOT NULL,
  `region` varchar(100) NOT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `fax` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `site_web` varchar(255) DEFAULT NULL,
  `directeur_id` bigint(20) UNSIGNED DEFAULT NULL,
  `directeur_medical_id` bigint(20) UNSIGNED DEFAULT NULL,
  `nombre_lits_total` smallint(5) UNSIGNED DEFAULT 0,
  `nombre_places_hospit` smallint(5) UNSIGNED DEFAULT 0,
  `nombre_places_ambulatoire` smallint(5) UNSIGNED DEFAULT 0,
  `autorisations` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'Liste des autorisations d''activité' CHECK (json_valid(`autorisations`)),
  `certifications` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'HAS, ISO, etc.' CHECK (json_valid(`certifications`)),
  `date_derniere_certification` date DEFAULT NULL,
  `statut` enum('ACTIF','FERME_TEMPORAIRE','FERME_DEFINITIF') DEFAULT 'ACTIF',
  `date_ouverture` date DEFAULT NULL,
  `date_fermeture` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `factures_lignes`
--

CREATE TABLE `factures_lignes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `facture_id` bigint(20) UNSIGNED NOT NULL,
  `numero_ligne` smallint(5) UNSIGNED NOT NULL,
  `tarif_reference_id` int(10) UNSIGNED DEFAULT NULL,
  `code_prestation` varchar(20) DEFAULT NULL,
  `libelle_prestation` varchar(200) NOT NULL,
  `quantite` decimal(10,3) DEFAULT 1.000,
  `prix_unitaire_ht` decimal(10,2) NOT NULL,
  `taux_tva` decimal(5,2) DEFAULT 20.00,
  `montant_ht` decimal(12,2) GENERATED ALWAYS AS (`quantite` * `prix_unitaire_ht`) STORED,
  `montant_tva` decimal(12,2) GENERATED ALWAYS AS (`montant_ht` * `taux_tva` / 100) STORED,
  `montant_ttc` decimal(12,2) GENERATED ALWAYS AS (`montant_ht` + `montant_tva`) STORED,
  `remboursement_secu` tinyint(1) DEFAULT 1,
  `taux_remboursement_secu` decimal(5,2) DEFAULT NULL,
  `base_remboursement_secu` decimal(10,2) DEFAULT NULL,
  `date_prestation` date NOT NULL,
  `date_comptabilisation` date DEFAULT NULL,
  `type_activite` enum('CONSULTATION','HOSPITALISATION','EXAMEN','PHARMACIE','MATERIEL','FRAIS_DIVERS') NOT NULL,
  `activite_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'ID selon type_activite'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `factures_patients`
--

CREATE TABLE `factures_patients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `numero_facture` varchar(20) NOT NULL,
  `patient_id` bigint(20) UNSIGNED NOT NULL,
  `sejour_id` bigint(20) UNSIGNED DEFAULT NULL,
  `consultation_id` bigint(20) UNSIGNED DEFAULT NULL,
  `intervention_id` bigint(20) UNSIGNED DEFAULT NULL,
  `date_emission` date NOT NULL,
  `date_echeance` date NOT NULL,
  `date_reglement` date DEFAULT NULL,
  `montant_total_ht` decimal(12,2) NOT NULL,
  `montant_tva` decimal(12,2) NOT NULL,
  `montant_ttc` decimal(12,2) GENERATED ALWAYS AS (`montant_total_ht` + `montant_tva`) STORED,
  `montant_remise` decimal(10,2) DEFAULT 0.00,
  `montant_net_a_payer` decimal(12,2) GENERATED ALWAYS AS (`montant_ttc` - `montant_remise`) STORED,
  `montant_paye` decimal(12,2) DEFAULT 0.00,
  `solde_restant` decimal(12,2) GENERATED ALWAYS AS (`montant_net_a_payer` - `montant_paye`) STORED,
  `prise_en_charge_secu` decimal(12,2) DEFAULT 0.00,
  `prise_en_charge_mutuelle` decimal(12,2) DEFAULT 0.00,
  `reste_a_charge_patient` decimal(12,2) GENERATED ALWAYS AS (`montant_net_a_payer` - `prise_en_charge_secu` - `prise_en_charge_mutuelle`) STORED,
  `mode_reglement` enum('ESPECES','CARTE_BANCAIRE','CHEQUE','VIREMENT','TIPI','PRISE_EN_CHARGE','GRATUITE') DEFAULT NULL,
  `reference_reglement` varchar(100) DEFAULT NULL,
  `statut` enum('BROUILLON','VALIDEE','ENVOYEE','PARTIELLEMENT_PAYEE','PAYEE','ANNULEE') DEFAULT 'BROUILLON',
  `pdf_genere` tinyint(1) DEFAULT 0,
  `chemin_pdf` varchar(255) DEFAULT NULL,
  `envoyee_par_courrier` tinyint(1) DEFAULT 0,
  `date_envoi_courrier` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_by` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `grossesses`
--

CREATE TABLE `grossesses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `patiente_id` bigint(20) UNSIGNED NOT NULL,
  `date_dernieres_regles` date DEFAULT NULL,
  `date_debut_grossesse` date DEFAULT NULL,
  `date_prevue_accouchement` date DEFAULT NULL,
  `terme_theorique_sa` tinyint(3) UNSIGNED DEFAULT NULL COMMENT 'Semaines d''aménorrhée',
  `gyneco_obstetricien_id` bigint(20) UNSIGNED DEFAULT NULL,
  `sage_femme_referente_id` bigint(20) UNSIGNED DEFAULT NULL,
  `nombre_foetus` tinyint(3) UNSIGNED DEFAULT 1,
  `type_grossesse` enum('UNIQUE','GEMELLAIRE','MULTIPLE') DEFAULT 'UNIQUE',
  `geste` tinyint(3) UNSIGNED DEFAULT 1 COMMENT 'Nombre de grossesses',
  `parite` tinyint(3) UNSIGNED DEFAULT 0 COMMENT 'Nombre d''accouchements',
  `avortements` tinyint(3) UNSIGNED DEFAULT 0,
  `enfants_vivants` tinyint(3) UNSIGNED DEFAULT 0,
  `age_maternel` tinyint(3) UNSIGNED DEFAULT NULL,
  `facteurs_risque` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`facteurs_risque`)),
  `pathologies_associees` text DEFAULT NULL,
  `groupe_sanguin_verifie` tinyint(1) DEFAULT 0,
  `rai_negatif` tinyint(1) DEFAULT 1 COMMENT 'Recherche d''agglutinines irrégulières',
  `serologies_infectieuses` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`serologies_infectieuses`)),
  `echo_t1_date` date DEFAULT NULL,
  `echo_t1_normale` tinyint(1) DEFAULT NULL,
  `echo_t2_date` date DEFAULT NULL,
  `echo_t2_normale` tinyint(1) DEFAULT NULL,
  `echo_t3_date` date DEFAULT NULL,
  `echo_t3_normale` tinyint(1) DEFAULT NULL,
  `depistage_t21` enum('REFUSE','RISQUE_FAIBLE','RISQUE_ELEVE','AMNIOCENTESE_NORMALE','TRISOMIE_CONFIRMEE') DEFAULT NULL,
  `preparation_accouchement` tinyint(1) DEFAULT 0,
  `projet_naissance` text DEFAULT NULL,
  `souhait_anesthesie` enum('SANS_PERIDURALE','AVEC_PERIDURALE','INDIFFERENT') DEFAULT 'INDIFFERENT',
  `statut` enum('EN_COURS','ACCOUCHEE','INTERRUPTION','FAUSSE_COUCHE') DEFAULT 'EN_COURS',
  `date_fin_grossesse` date DEFAULT NULL,
  `terme_accouchement_sa` tinyint(3) UNSIGNED DEFAULT NULL,
  `lieu_accouchement` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `interventions_maintenance`
--

CREATE TABLE `interventions_maintenance` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `equipement_id` mediumint(8) UNSIGNED NOT NULL,
  `type_intervention` enum('PREVENTIVE','CORRECTIVE','CONTROLE','MISE_EN_SERVICE','RECEPTION') NOT NULL,
  `nature_probleme` text DEFAULT NULL,
  `date_intervention` date NOT NULL,
  `heure_debut` time DEFAULT NULL,
  `heure_fin` time DEFAULT NULL,
  `duree_minutes` smallint(5) UNSIGNED DEFAULT NULL,
  `intervenant_id` bigint(20) UNSIGNED DEFAULT NULL,
  `societe_intervenante` varchar(100) DEFAULT NULL,
  `personnel_demandeur_id` bigint(20) UNSIGNED DEFAULT NULL,
  `actions_realisees` text DEFAULT NULL,
  `pieces_remplacees` text DEFAULT NULL,
  `observations` text DEFAULT NULL,
  `cout_intervention` decimal(10,2) DEFAULT NULL,
  `cout_pieces` decimal(10,2) DEFAULT NULL,
  `cout_total` decimal(10,2) GENERATED ALWAYS AS (`cout_intervention` + `cout_pieces`) STORED,
  `resultat` enum('REPAREE','REMPLACEE','A_REPARER','IRREPARABLE','CONTROLE_OK') NOT NULL,
  `garantie_applicable` tinyint(1) DEFAULT 0,
  `rapport_intervention` varchar(255) DEFAULT NULL,
  `facture_fournisseur` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `journaux_activites`
--

CREATE TABLE `journaux_activites` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `utilisateur_id` bigint(20) UNSIGNED DEFAULT NULL,
  `adresse_ip` varchar(45) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `date_heure` datetime NOT NULL,
  `type_action` enum('CONNEXION','DECONNEXION','CREATION','MODIFICATION','SUPPRESSION','CONSULTATION','TELECHARGEMENT','AUTRE') NOT NULL,
  `entite_affectee` varchar(50) DEFAULT NULL,
  `id_entite` bigint(20) UNSIGNED DEFAULT NULL,
  `description` text DEFAULT NULL,
  `ancienne_valeur` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`ancienne_valeur`)),
  `nouvelle_valeur` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`nouvelle_valeur`)),
  `localisation_approximative` varchar(100) DEFAULT NULL,
  `coordonnees_gps` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lits`
--

CREATE TABLE `lits` (
  `id` mediumint(8) UNSIGNED NOT NULL,
  `chambre_id` mediumint(8) UNSIGNED NOT NULL,
  `code_lit` varchar(10) NOT NULL,
  `type_lit` enum('STANDARD','ELECTRIQUE','REANIMATION','SOINS_INTENSIFS','MATERNITE','PEDIATRIQUE','NEONATOLOGIE','BARIATRIQUE','ORTHOPEDIQUE','PSYCHIATRIE') NOT NULL DEFAULT 'STANDARD',
  `poids_max_patient` smallint(5) UNSIGNED DEFAULT 150 COMMENT 'en kg',
  `hauteur_variable` tinyint(1) DEFAULT 0,
  `inclinaison_variable` tinyint(1) DEFAULT 0,
  `barrières` tinyint(1) DEFAULT 1,
  `potence` tinyint(1) DEFAULT 0,
  `table_de_lit` tinyint(1) DEFAULT 0,
  `éclairage_integre` tinyint(1) DEFAULT 0,
  `moniteur_multiparametrique` tinyint(1) DEFAULT 0,
  `pousse_seringue_electrique` tinyint(1) DEFAULT 0,
  `respirateur` tinyint(1) DEFAULT 0,
  `scope_cardiaque` tinyint(1) DEFAULT 0,
  `type_matelas` enum('STANDARD','ANTI_ESCARRE','ALTERNATING','AIR_FLUIDISE') DEFAULT 'STANDARD',
  `date_changement_matelas` date DEFAULT NULL,
  `statut` enum('LIBRE','OCCUPE','RESERVE','NETTOYAGE','MAINTENANCE','HORS_SERVICE') DEFAULT 'LIBRE',
  `date_derniere_desinfection` datetime DEFAULT NULL,
  `prochaine_maintenance` date DEFAULT NULL,
  `reserve_pour_patient_id` bigint(20) UNSIGNED DEFAULT NULL,
  `date_reservation` datetime DEFAULT NULL,
  `duree_reservation_heures` tinyint(3) UNSIGNED DEFAULT NULL,
  `equipements_specifiques` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`equipements_specifiques`)),
  `restrictions_usage` text DEFAULT NULL,
  `observations` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `medicaments`
--

CREATE TABLE `medicaments` (
  `id` mediumint(8) UNSIGNED NOT NULL,
  `code_cip` varchar(20) NOT NULL,
  `nom_commercial` varchar(100) NOT NULL,
  `dci` varchar(200) NOT NULL COMMENT 'Dénomination Commune Internationale',
  `classe_therapeutique` varchar(100) DEFAULT NULL,
  `categorie_legale` enum('LISTE_I','LISTE_II','STUPEFIANT','AUTRE') NOT NULL,
  `forme_galenique` varchar(50) NOT NULL,
  `dosage` varchar(100) NOT NULL,
  `unite_dosage` varchar(20) NOT NULL,
  `stock_alerte` smallint(5) UNSIGNED DEFAULT 10,
  `stock_optimal` smallint(5) UNSIGNED DEFAULT 50,
  `prix_achat` decimal(8,2) NOT NULL,
  `prix_vente` decimal(8,2) NOT NULL,
  `taux_remboursement` decimal(5,2) DEFAULT NULL,
  `code_nomenclature` varchar(20) DEFAULT NULL,
  `duree_conservation_mois` smallint(5) UNSIGNED DEFAULT NULL,
  `conditions_conservation` varchar(100) DEFAULT NULL,
  `thermosensible` tinyint(1) DEFAULT 0,
  `prescription_obligatoire` tinyint(1) DEFAULT 1,
  `renouvellement_autorise` tinyint(3) UNSIGNED DEFAULT 0,
  `statut` enum('DISPONIBLE','RUPTURE','COMMANDE','OBSOLETE') DEFAULT 'DISPONIBLE',
  `notice_url` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mouvements_lits`
--

CREATE TABLE `mouvements_lits` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `sejour_id` bigint(20) UNSIGNED NOT NULL,
  `lit_origine_id` mediumint(8) UNSIGNED DEFAULT NULL,
  `lit_destination_id` mediumint(8) UNSIGNED NOT NULL,
  `date_mouvement` datetime NOT NULL,
  `heure_liberation` time DEFAULT NULL,
  `heure_occupation` time DEFAULT NULL,
  `motif` enum('ADMISSION','CHANGEMENT_SERVICE','CHANGEMENT_CHAMBRE','ISOLEMENT','SURVEILLANCE_RENFORCEE','DEMANDE_PATIENT','OPTIMISATION','MAINTENANCE','SORTIE') NOT NULL,
  `details_motif` text DEFAULT NULL,
  `demandeur_id` bigint(20) UNSIGNED NOT NULL,
  `valideur_id` bigint(20) UNSIGNED DEFAULT NULL,
  `statut` enum('DEMANDE','VALIDE','REALISE','ANNULE') DEFAULT 'DEMANDE'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nouveaux_nes`
--

CREATE TABLE `nouveaux_nes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `accouchement_id` bigint(20) UNSIGNED NOT NULL,
  `numero_enfant` tinyint(3) UNSIGNED DEFAULT 1 COMMENT 'Pour grossesses multiples',
  `sexe` enum('M','F') NOT NULL,
  `nom_provisoire` varchar(100) DEFAULT NULL,
  `poids_naissance` smallint(5) UNSIGNED NOT NULL COMMENT 'en grammes',
  `taille_naissance` tinyint(3) UNSIGNED NOT NULL COMMENT 'en cm',
  `pc_naissance` decimal(4,1) NOT NULL COMMENT 'Périmètre crânien',
  `apgar_1min` tinyint(3) UNSIGNED NOT NULL,
  `apgar_5min` tinyint(3) UNSIGNED NOT NULL,
  `apgar_10min` tinyint(3) UNSIGNED DEFAULT NULL,
  `reanimation_necessaire` tinyint(1) DEFAULT 0,
  `gestes_reanimation` text DEFAULT NULL,
  `intubation` tinyint(1) DEFAULT 0,
  `test_guthrie_fait` tinyint(1) DEFAULT 0,
  `date_test_guthrie` date DEFAULT NULL,
  `examen_ophtalmologique` tinyint(1) DEFAULT 0,
  `examen_hanches` tinyint(1) DEFAULT 0,
  `pathologies` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`pathologies`)),
  `malformations` text DEFAULT NULL,
  `type_alimentation` enum('ALLAITEMENT_MATERNEL','ALLAITEMENT_MIXTE','LAIT_ARTIFICIEL') DEFAULT 'ALLAITEMENT_MATERNEL',
  `premiere_tetee` datetime DEFAULT NULL,
  `perte_poids_physiologique` tinyint(1) DEFAULT 1,
  `ictere_neonatal` tinyint(1) DEFAULT 0,
  `niveau_bilirubine` decimal(4,1) DEFAULT NULL,
  `age_sortie_heures` smallint(5) UNSIGNED DEFAULT NULL,
  `poids_sortie` smallint(5) UNSIGNED DEFAULT NULL,
  `statut` enum('VIVANT','DECEDE','TRANSFERE') DEFAULT 'VIVANT',
  `date_deces` datetime DEFAULT NULL,
  `service_transfert` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `paiements_personnel`
--

CREATE TABLE `paiements_personnel` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `personnel_id` bigint(20) UNSIGNED NOT NULL,
  `contrat_id` bigint(20) UNSIGNED NOT NULL,
  `mois` tinyint(3) UNSIGNED NOT NULL,
  `annee` smallint(5) UNSIGNED NOT NULL,
  `date_paiement` date NOT NULL,
  `salaire_base` decimal(10,2) NOT NULL,
  `heures_supplementaires` decimal(8,2) DEFAULT 0.00,
  `primes_diverses` decimal(8,2) DEFAULT 0.00,
  `indemnites_transport` decimal(6,2) DEFAULT 0.00,
  `indemnites_repas` decimal(6,2) DEFAULT 0.00,
  `total_brut` decimal(10,2) GENERATED ALWAYS AS (`salaire_base` + `heures_supplementaires` + `primes_diverses` + `indemnites_transport` + `indemnites_repas`) STORED,
  `cotisations_sociales` decimal(8,2) DEFAULT 0.00,
  `impot_revenu` decimal(8,2) DEFAULT 0.00,
  `autres_retenues` decimal(8,2) DEFAULT 0.00,
  `total_retenues` decimal(8,2) GENERATED ALWAYS AS (`cotisations_sociales` + `impot_revenu` + `autres_retenues`) STORED,
  `net_a_payer` decimal(10,2) GENERATED ALWAYS AS (`total_brut` - `total_retenues`) STORED,
  `mode_paiement` enum('VIREMENT','CHEQUE','ESPECES','MOYEN_ELECTRONIQUE') DEFAULT 'VIREMENT',
  `reference_paiement` varchar(100) DEFAULT NULL,
  `statut` enum('CALCULE','VALIDEE','PAYE','ANNULE','ERREUR') DEFAULT 'CALCULE',
  `bulletin_genere` tinyint(1) DEFAULT 0,
  `chemin_bulletin` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_by` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `patients`
--

CREATE TABLE `patients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `numero_dossier` varchar(20) NOT NULL,
  `numero_secu` varchar(15) DEFAULT NULL,
  `nir_certifie` tinyint(1) DEFAULT 0,
  `groupe_sanguin` enum('A+','A-','B+','B-','AB+','AB-','O+','O-') DEFAULT NULL,
  `rhesus` enum('+','-') DEFAULT NULL,
  `groupe_sanguin_verifie` tinyint(1) DEFAULT 0,
  `date_verification_gs` date DEFAULT NULL,
  `regime_assurance` varchar(100) DEFAULT NULL,
  `numero_assure` varchar(50) DEFAULT NULL,
  `organisme_complementaire` varchar(100) DEFAULT NULL,
  `numero_complementaire` varchar(50) DEFAULT NULL,
  `ald` tinyint(1) DEFAULT 0 COMMENT 'Affection Longue Durée',
  `numero_ald` varchar(20) DEFAULT NULL,
  `situation_familiale` enum('CELIBATAIRE','MARIE','PACSE','CONCUBINAGE','VEUF','DIVORCE') DEFAULT NULL,
  `profession` varchar(150) DEFAULT NULL,
  `employeur` varchar(200) DEFAULT NULL,
  `contact_urgence_1_nom` varchar(200) DEFAULT NULL,
  `contact_urgence_1_tel` varchar(20) DEFAULT NULL,
  `contact_urgence_1_lien` varchar(50) DEFAULT NULL,
  `contact_urgence_2_nom` varchar(200) DEFAULT NULL,
  `contact_urgence_2_tel` varchar(20) DEFAULT NULL,
  `contact_urgence_2_lien` varchar(50) DEFAULT NULL,
  `directives_anticipees` text DEFAULT NULL,
  `personne_confiance_designee` varchar(200) DEFAULT NULL,
  `religion` varchar(100) DEFAULT NULL,
  `regime_alimentaire` varchar(200) DEFAULT NULL,
  `allergies_alimentaires` text DEFAULT NULL,
  `statut` enum('ACTIF','INACTIF','DECEDE','TRANSFERE') DEFAULT 'ACTIF',
  `date_deces` date DEFAULT NULL,
  `lieu_deces` varchar(200) DEFAULT NULL,
  `medecin_traitant_externe` varchar(200) DEFAULT NULL,
  `date_derniere_visite` date DEFAULT NULL,
  `nombre_hospitalisations` int(11) DEFAULT 0,
  `risque_nosocomial` enum('FAIBLE','MOYEN','ELEVE') DEFAULT 'FAIBLE'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personnel`
--

CREATE TABLE `personnel` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `matricule` varchar(20) NOT NULL,
  `fonction` varchar(100) NOT NULL,
  `grade` varchar(50) DEFAULT NULL,
  `categorie` enum('MEDICAL','PARAMEDICAL','ADMINISTRATIF','TECHNIQUE','DIRECTION') NOT NULL,
  `specialite_principale` varchar(100) DEFAULT NULL,
  `type_contrat` enum('CDI','CDD','INTERIM','STAGIAIRE','LIBERAL','PRATICIEN_HOSPITALIER') NOT NULL,
  `date_embauche` date NOT NULL,
  `date_fin_contrat` date DEFAULT NULL,
  `date_titularisation` date DEFAULT NULL,
  `numero_rpps` varchar(11) DEFAULT NULL COMMENT 'Répertoire Partagé des Professionnels de Santé',
  `numero_adeli` varchar(9) DEFAULT NULL COMMENT 'Automatisation des Listes',
  `numero_ordre` varchar(20) DEFAULT NULL,
  `numero_agrement` varchar(50) DEFAULT NULL,
  `diplome_principal` varchar(200) DEFAULT NULL,
  `universite_diplome` varchar(200) DEFAULT NULL,
  `annee_diplome` year(4) DEFAULT NULL,
  `formations_complementaires` text DEFAULT NULL,
  `quotite_travail` decimal(5,2) DEFAULT 100.00 COMMENT 'Pourcentage temps plein',
  `temps_travail_hebdo` decimal(4,1) DEFAULT 35.0,
  `service_affectation_principal` smallint(5) UNSIGNED DEFAULT NULL,
  `droit_prescription` tinyint(1) DEFAULT 0,
  `droit_signature_electronique` tinyint(1) DEFAULT 0,
  `niveau_habilitation` enum('BASIQUE','INTERMEDIAIRE','AVANCE','ADMINISTRATEUR') DEFAULT 'BASIQUE',
  `statut` enum('ACTIF','CONGE','MALADIE','FORMATION','DISPONIBILITE','RETRAITE','DEMISSION') DEFAULT 'ACTIF',
  `disponible_garde` tinyint(1) DEFAULT 1,
  `disponible_astreinte` tinyint(1) DEFAULT 1,
  `bureau` varchar(50) DEFAULT NULL,
  `poste_interne` varchar(10) DEFAULT NULL,
  `bip` varchar(20) DEFAULT NULL,
  `salaire_base` decimal(10,2) DEFAULT NULL,
  `coefficient` int(11) DEFAULT NULL,
  `echelon` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `poles`
--

CREATE TABLE `poles` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `etablissement_id` smallint(5) UNSIGNED NOT NULL,
  `code` varchar(10) NOT NULL,
  `nom` varchar(150) NOT NULL,
  `description` text DEFAULT NULL,
  `chef_pole_id` bigint(20) UNSIGNED DEFAULT NULL,
  `chef_pole_adjoint_id` bigint(20) UNSIGNED DEFAULT NULL,
  `date_creation` date NOT NULL,
  `date_fin` date DEFAULT NULL,
  `budget_annuel` decimal(15,2) DEFAULT NULL,
  `code_analytique` varchar(20) DEFAULT NULL,
  `statut` enum('ACTIF','INACTIF','REORGANISATION') DEFAULT 'ACTIF'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `prescriptions_lignes`
--

CREATE TABLE `prescriptions_lignes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `prescription_id` bigint(20) UNSIGNED NOT NULL,
  `medicament_id` mediumint(8) UNSIGNED NOT NULL,
  `numero_ligne` tinyint(3) UNSIGNED NOT NULL,
  `posologie` text NOT NULL,
  `voie_administration` enum('ORALE','IV','IM','SC','INHALEE','TOPICALE','RECTALE','OCULAIRE','AURICULAIRE') NOT NULL,
  `duree_jours` smallint(5) UNSIGNED DEFAULT NULL,
  `frequence_prise` varchar(100) DEFAULT NULL COMMENT 'Ex: 3 fois par jour',
  `heure_prise_specifique` time DEFAULT NULL,
  `quantite_unite` smallint(5) UNSIGNED DEFAULT NULL,
  `unite_posologie` varchar(20) DEFAULT NULL,
  `quantite_totale` decimal(10,3) DEFAULT NULL,
  `conditionnement_dispense` varchar(100) DEFAULT NULL,
  `quantite_dispensee` decimal(10,3) DEFAULT NULL,
  `lot_dispense` varchar(50) DEFAULT NULL,
  `statut` enum('A_DISPENSER','DISPENSE','ADMINISTRE','ANNULE','REMPLACE') DEFAULT 'A_DISPENSER',
  `substitution_autorisee` tinyint(1) DEFAULT 1,
  `medicament_substitue_id` mediumint(8) UNSIGNED DEFAULT NULL,
  `motif_substitution` text DEFAULT NULL,
  `precautions_particulieres` text DEFAULT NULL,
  `effets_indesirables` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `prescriptions_medicamenteuses`
--

CREATE TABLE `prescriptions_medicamenteuses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `numero_prescription` varchar(20) NOT NULL,
  `patient_id` bigint(20) UNSIGNED NOT NULL,
  `prescripteur_id` bigint(20) UNSIGNED NOT NULL,
  `service_prescripteur_id` smallint(5) UNSIGNED DEFAULT NULL,
  `consultation_id` bigint(20) UNSIGNED DEFAULT NULL,
  `hospitalisation_id` bigint(20) UNSIGNED DEFAULT NULL,
  `date_prescription` datetime NOT NULL,
  `date_debut_traitement` date DEFAULT NULL,
  `date_fin_traitement` date DEFAULT NULL,
  `type_prescription` enum('HOSPITALIERE','AMBULATOIRE','URGENCE','CHRONIQUE','ATU','RECONSTITUTION') NOT NULL,
  `statut` enum('ACTIVE','SUSPENDUE','TERMINEE','ANNULEE','EN_ATTENTE_VALIDATION') DEFAULT 'ACTIVE',
  `validateur_pharmacien_id` bigint(20) UNSIGNED DEFAULT NULL,
  `date_validation` datetime DEFAULT NULL,
  `remarques_pharmacien` text DEFAULT NULL,
  `dispense` tinyint(1) DEFAULT 0,
  `date_dispensation` datetime DEFAULT NULL,
  `dispensateur_id` bigint(20) UNSIGNED DEFAULT NULL,
  `mode_administration` enum('A_DOMICILE','INFIRMERIE','HOSPITALIER','AUTONOMIE','AIDE_FAMILIALE') DEFAULT 'HOSPITALIER',
  `instructions_patient` text DEFAULT NULL,
  `document_impression` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `programmations_operatoires`
--

CREATE TABLE `programmations_operatoires` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `numero_programme` varchar(20) NOT NULL,
  `patient_id` bigint(20) UNSIGNED NOT NULL,
  `sejour_id` bigint(20) UNSIGNED DEFAULT NULL,
  `type_intervention_id` smallint(5) UNSIGNED NOT NULL,
  `libelle_intervention` text DEFAULT NULL,
  `date_intervention` date NOT NULL,
  `heure_debut` time NOT NULL,
  `duree_prevue` smallint(5) UNSIGNED NOT NULL COMMENT 'en minutes',
  `salle_operation_id` smallint(5) UNSIGNED NOT NULL,
  `chirurgien_principal_id` bigint(20) UNSIGNED NOT NULL,
  `chirurgien_assistant_id` bigint(20) UNSIGNED DEFAULT NULL,
  `anesthesiste_id` bigint(20) UNSIGNED NOT NULL,
  `ibode_id` bigint(20) UNSIGNED DEFAULT NULL,
  `iade_id` bigint(20) UNSIGNED DEFAULT NULL,
  `type_anesthesie_prevue` enum('LOCALE','LOCO_REGIONALE','GENERALE','RACHIANESTHESIE','PERIDURALE') DEFAULT NULL,
  `consultation_anesthesie_faite` tinyint(1) DEFAULT 0,
  `date_consultation_anesthesie` date DEFAULT NULL,
  `cote_intervention` enum('DROITE','GAUCHE','BILATERALE','NON_APPLICABLE') DEFAULT 'NON_APPLICABLE',
  `position_operatoire` varchar(100) DEFAULT NULL,
  `materiel_specifique_requis` text DEFAULT NULL,
  `urgence` enum('PROGRAMMEE','URGENCE_RELATIVE','URGENCE_ABSOLUE') DEFAULT 'PROGRAMMEE',
  `priorite` tinyint(3) UNSIGNED DEFAULT 3 COMMENT '1=très haute, 5=basse',
  `preparation_necessaire` text DEFAULT NULL,
  `jeun_depuis` datetime DEFAULT NULL,
  `premedicaion` text DEFAULT NULL,
  `statut` enum('PROGRAMMEE','CONFIRMEE','EN_COURS','TERMINEE','ANNULEE','REPORTEE') DEFAULT 'PROGRAMMEE',
  `motif_annulation` text DEFAULT NULL,
  `nouvelle_date_si_reporte` date DEFAULT NULL,
  `heure_debut_reelle` time DEFAULT NULL,
  `heure_fin_reelle` time DEFAULT NULL,
  `duree_reelle` smallint(5) UNSIGNED DEFAULT NULL,
  `compte_rendu_operatoire` text DEFAULT NULL,
  `complications` text DEFAULT NULL,
  `surveillance_post_op` enum('STANDARD','RAPPROCHEE','SOINS_INTENSIFS','REANIMATION') DEFAULT 'STANDARD',
  `duree_surveillance_heures` tinyint(3) UNSIGNED DEFAULT 2,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_by` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `salles_operation`
--

CREATE TABLE `salles_operation` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `service_id` smallint(5) UNSIGNED NOT NULL,
  `numero_salle` varchar(20) NOT NULL,
  `nom` varchar(100) DEFAULT NULL,
  `classe_salle` enum('A','B','C','D') NOT NULL COMMENT 'Classification selon normes',
  `specialites_autorisees` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`specialites_autorisees`)),
  `superficie` decimal(6,2) DEFAULT NULL COMMENT 'en m²',
  `hauteur_sous_plafond` decimal(4,2) DEFAULT NULL,
  `surpression_pa` smallint(5) UNSIGNED DEFAULT NULL COMMENT 'en Pascals',
  `scialytique` tinyint(1) DEFAULT 1,
  `table_operation_type` varchar(100) DEFAULT NULL,
  `monitoring_integre` tinyint(1) DEFAULT 0,
  `video_projection` tinyint(1) DEFAULT 0,
  `robot_chirurgical` tinyint(1) DEFAULT 0,
  `arrivees_oxygene` tinyint(3) UNSIGNED DEFAULT 0,
  `arrivees_vide` tinyint(3) UNSIGNED DEFAULT 0,
  `arrivees_air_comprime` tinyint(3) UNSIGNED DEFAULT 0,
  `arrivees_co2` tinyint(3) UNSIGNED DEFAULT 0,
  `systeme_ventilation` varchar(100) DEFAULT NULL,
  `filtration_hepa` tinyint(1) DEFAULT 1,
  `derniere_qualification` date DEFAULT NULL,
  `prochaine_qualification` date DEFAULT NULL,
  `capacite_personnel` tinyint(3) UNSIGNED DEFAULT 8,
  `acces_urgence` tinyint(1) DEFAULT 1,
  `programmable` tinyint(1) DEFAULT 1,
  `statut` enum('DISPONIBLE','OCCUPEE','NETTOYAGE','MAINTENANCE','QUALIFICATION','HORS_SERVICE') DEFAULT 'DISPONIBLE'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sejours`
--

CREATE TABLE `sejours` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `numero_sejour` varchar(20) NOT NULL,
  `patient_id` bigint(20) UNSIGNED NOT NULL,
  `service_admission_id` smallint(5) UNSIGNED NOT NULL,
  `service_sortie_id` smallint(5) UNSIGNED DEFAULT NULL,
  `date_admission` datetime NOT NULL,
  `date_sortie_prevue` datetime DEFAULT NULL,
  `date_sortie_reelle` datetime DEFAULT NULL,
  `duree_prevue_jours` smallint(5) UNSIGNED DEFAULT NULL,
  `duree_reelle_jours` smallint(5) UNSIGNED DEFAULT NULL,
  `type_sejour` enum('HOSPITALISATION_COMPLETE','HOSPITALISATION_JOUR','HOSPITALISATION_SEMAINE','AMBULATOIRE','URGENCE','TRANSFERT','READMISSION') NOT NULL,
  `mode_entree` enum('DOMICILE','URGENCES','TRANSFERT_INTERNE','TRANSFERT_EXTERNE','NAISSANCE') NOT NULL,
  `mode_sortie` enum('DOMICILE','TRANSFERT_INTERNE','TRANSFERT_EXTERNE','DECES','FUGUE','CONTRE_AVIS_MEDICAL') DEFAULT NULL,
  `motif_hospitalisation` text NOT NULL,
  `diagnostic_entree` varchar(300) DEFAULT NULL,
  `diagnostic_principal_sortie` varchar(300) DEFAULT NULL,
  `diagnostics_associes_sortie` text DEFAULT NULL,
  `medecin_referent_id` bigint(20) UNSIGNED NOT NULL,
  `medecin_sortie_id` bigint(20) UNSIGNED DEFAULT NULL,
  `chambre_id` mediumint(8) UNSIGNED DEFAULT NULL,
  `lit_id` mediumint(8) UNSIGNED DEFAULT NULL,
  `isolement` enum('AUCUN','PROTECTEUR','SEPTIQUE','PSYCHIATRIQUE') DEFAULT 'AUCUN',
  `surveillance` enum('STANDARD','RAPPROCHEE','CONTINUE','INTENSIVE') DEFAULT 'STANDARD',
  `regime_alimentaire` text DEFAULT NULL,
  `allergies_signalees` text DEFAULT NULL,
  `accompagnant_autorise` tinyint(1) DEFAULT 0,
  `nom_accompagnant` varchar(200) DEFAULT NULL,
  `lien_accompagnant` varchar(100) DEFAULT NULL,
  `type_prise_charge` enum('SECURITE_SOCIALE','MUTUELLE','PRIVE','AME','SOINS_URGENTS') DEFAULT 'SECURITE_SOCIALE',
  `ticket_moderateur` decimal(8,2) DEFAULT 0.00,
  `forfait_journalier` decimal(6,2) DEFAULT 0.00,
  `depassements` decimal(8,2) DEFAULT 0.00,
  `enquete_satisfaction` tinyint(1) DEFAULT 0,
  `note_satisfaction` tinyint(3) UNSIGNED DEFAULT NULL,
  `commentaires_satisfaction` text DEFAULT NULL,
  `destination_sortie` varchar(200) DEFAULT NULL,
  `prescription_sortie` text DEFAULT NULL,
  `rendez_vous_programmés` text DEFAULT NULL,
  `lettre_sortie_generee` tinyint(1) DEFAULT 0,
  `compte_rendu_hospitalisation` text DEFAULT NULL,
  `statut` enum('EN_COURS','TERMINE','TRANSFERE','ANNULE') DEFAULT 'EN_COURS',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Triggers `sejours`
--
DELIMITER $$
CREATE TRIGGER `after_sejour_insert` AFTER INSERT ON `sejours` FOR EACH ROW BEGIN
    IF NEW.lit_id IS NOT NULL THEN
        UPDATE lits 
        SET statut = 'OCCUPE',
            reserve_pour_patient_id = NULL,
            date_reservation = NULL
        WHERE id = NEW.lit_id;
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_sejour_update` AFTER UPDATE ON `sejours` FOR EACH ROW BEGIN
    IF NEW.statut = 'TERMINE' AND OLD.statut != 'TERMINE' AND NEW.lit_id IS NOT NULL THEN
        UPDATE lits 
        SET statut = 'LIBRE',
            date_derniere_desinfection = CURRENT_TIMESTAMP
        WHERE id = NEW.lit_id;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `pole_id` smallint(5) UNSIGNED NOT NULL,
  `code` varchar(10) NOT NULL,
  `nom` varchar(150) NOT NULL,
  `nom_court` varchar(50) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `type_service` enum('MEDECINE','CHIRURGIE','OBSTETRIQUE','PEDIATRIE','PSYCHIATRIE','URGENCES','REANIMATION','SOINS_INTENSIFS','SOINS_CONTINUS','RADIOLOGIE','LABORATOIRE','PHARMACIE','BLOC_OPERATOIRE','CONSULTATIONS_EXTERNES','HOSPITALISATION_JOUR','HAD','ADMINISTRATIF','TECHNIQUE','LOGISTIQUE','DIRECTION') NOT NULL,
  `discipline_medicale` varchar(100) DEFAULT NULL,
  `age_min` tinyint(3) UNSIGNED DEFAULT NULL COMMENT 'Âge minimum des patients',
  `age_max` tinyint(3) UNSIGNED DEFAULT NULL COMMENT 'Âge maximum des patients',
  `sexe_specifique` enum('M','F','MIXTE') DEFAULT 'MIXTE',
  `batiment` varchar(50) DEFAULT NULL,
  `etage` tinyint(4) DEFAULT NULL,
  `aile` varchar(50) DEFAULT NULL,
  `chef_service_id` bigint(20) UNSIGNED DEFAULT NULL,
  `chef_service_adjoint_id` bigint(20) UNSIGNED DEFAULT NULL,
  `cadre_sante_id` bigint(20) UNSIGNED DEFAULT NULL,
  `secretaire_medicale_id` bigint(20) UNSIGNED DEFAULT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `fax` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `nombre_lits_autorises` tinyint(3) UNSIGNED DEFAULT 0,
  `nombre_lits_installes` tinyint(3) UNSIGNED DEFAULT 0,
  `nombre_places_hospit_jour` tinyint(3) UNSIGNED DEFAULT 0,
  `nombre_consultations_par_jour` tinyint(3) UNSIGNED DEFAULT 0,
  `horaires_ouverture` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'Horaires par jour de la semaine' CHECK (json_valid(`horaires_ouverture`)),
  `garde_assure` tinyint(1) DEFAULT 0,
  `astreinte_assure` tinyint(1) DEFAULT 0,
  `acces_urgence` tinyint(1) DEFAULT 0,
  `acces_handicap` tinyint(1) DEFAULT 0,
  `isolement_possible` tinyint(1) DEFAULT 0,
  `surveillance_continue` tinyint(1) DEFAULT 0,
  `budget_annuel` decimal(12,2) DEFAULT NULL,
  `code_analytique` varchar(20) DEFAULT NULL,
  `centre_cout` varchar(20) DEFAULT NULL,
  `derniere_inspection` date DEFAULT NULL,
  `certifie_has` tinyint(1) DEFAULT 0,
  `date_certification_has` date DEFAULT NULL,
  `statut` enum('ACTIF','FERME_TEMPORAIRE','FERME_DEFINITIF','REORGANISATION') DEFAULT 'ACTIF',
  `date_ouverture` date DEFAULT NULL,
  `date_fermeture` date DEFAULT NULL,
  `motif_fermeture` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `specialites`
--

CREATE TABLE `specialites` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `code` varchar(10) NOT NULL,
  `nom` varchar(150) NOT NULL,
  `nom_court` varchar(50) DEFAULT NULL,
  `type_specialite` enum('MEDICALE','CHIRURGICALE','BIOLOGIQUE','IMAGERIE','PARAMEDICALE','PHARMACEUTIQUE','TECHNIQUE','ADMINISTRATIVE') NOT NULL,
  `specialite_parent_id` smallint(5) UNSIGNED DEFAULT NULL,
  `niveau_hierarchique` tinyint(4) DEFAULT 1,
  `diplome_requis` varchar(200) DEFAULT NULL,
  `duree_formation_annees` tinyint(4) DEFAULT NULL,
  `organismes_certificateurs` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `competences_cles` text DEFAULT NULL,
  `actes_autorises` text DEFAULT NULL,
  `reconnue_officiellement` tinyint(1) DEFAULT 1,
  `date_reconnaissance` date DEFAULT NULL,
  `statut` enum('ACTIVE','OBSOLETE','EN_EVOLUTION') DEFAULT 'ACTIVE'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `stocks_pharmaceutiques`
--

CREATE TABLE `stocks_pharmaceutiques` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `medicament_id` mediumint(8) UNSIGNED NOT NULL,
  `service_id` smallint(5) UNSIGNED DEFAULT NULL COMMENT 'Si stock déporté',
  `numero_lot` varchar(50) NOT NULL,
  `date_peremption` date NOT NULL,
  `date_fabrication` date DEFAULT NULL,
  `fournisseur` varchar(100) DEFAULT NULL,
  `quantite_initiale` int(11) NOT NULL,
  `quantite_actuelle` int(11) NOT NULL,
  `seuil_alerte` int(11) DEFAULT 10,
  `emplacement` varchar(100) DEFAULT NULL,
  `zone_stockage` enum('AMBU','HOSPIT','URGENCES','BLOC','PHARMACIE') NOT NULL,
  `temperature_stockage` enum('AMBIANTE','REFRIGERE','CONGELATION') DEFAULT 'AMBIANTE',
  `date_reception` date NOT NULL,
  `receptionnaire_id` bigint(20) UNSIGNED DEFAULT NULL,
  `dernier_inventaire` date DEFAULT NULL,
  `statut` enum('DISPONIBLE','RESERVE','QUARANTAINE','DETRUIT') DEFAULT 'DISPONIBLE',
  `motif_quarantaine` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tarifs_hospitaliers`
--

CREATE TABLE `tarifs_hospitaliers` (
  `id` int(10) UNSIGNED NOT NULL,
  `code_tarif` varchar(20) NOT NULL,
  `libelle` varchar(200) NOT NULL,
  `type_tarif` enum('CONSULTATION','HOSPITALISATION','ACTE','EXAMEN','PHARMACIE','FORFAIT','SUPPLEMENT') NOT NULL,
  `code_ghm` varchar(10) DEFAULT NULL COMMENT 'Groupe Homogène de Malades',
  `code_ccam` varchar(20) DEFAULT NULL COMMENT 'Classification Commune des Actes Médicaux',
  `tarif_base` decimal(10,2) NOT NULL,
  `majoration_nuit` decimal(10,2) DEFAULT 0.00,
  `majoration_weekend` decimal(10,2) DEFAULT 0.00,
  `majoration_urgence` decimal(10,2) DEFAULT 0.00,
  `prise_en_charge_secu` tinyint(1) DEFAULT 1,
  `taux_remboursement` decimal(5,2) DEFAULT 100.00,
  `forfait_patient` decimal(8,2) DEFAULT 0.00,
  `date_debut` date NOT NULL,
  `date_fin` date DEFAULT NULL,
  `actif` tinyint(1) DEFAULT 1,
  `description` text DEFAULT NULL,
  `conditions_application` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `types_consultations`
--

CREATE TABLE `types_consultations` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `code` varchar(20) NOT NULL,
  `libelle` varchar(200) NOT NULL,
  `specialite_id` smallint(5) UNSIGNED DEFAULT NULL,
  `duree_standard` smallint(5) UNSIGNED NOT NULL COMMENT 'en minutes',
  `duree_min` smallint(5) UNSIGNED DEFAULT NULL COMMENT 'Durée minimale',
  `duree_max` smallint(5) UNSIGNED DEFAULT NULL COMMENT 'Durée maximale',
  `tarif_secteur1` decimal(8,2) DEFAULT NULL,
  `tarif_secteur2` decimal(8,2) DEFAULT NULL,
  `code_ccam` varchar(20) DEFAULT NULL,
  `necessite_jeun` tinyint(1) DEFAULT 0,
  `necessite_accompagnant` tinyint(1) DEFAULT 0,
  `age_min` tinyint(3) UNSIGNED DEFAULT NULL,
  `age_max` tinyint(3) UNSIGNED DEFAULT NULL,
  `instructions_preparation` text DEFAULT NULL,
  `documents_necessaires` text DEFAULT NULL,
  `contre_indications` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `statut` enum('ACTIF','INACTIF') DEFAULT 'ACTIF'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `types_interventions`
--

CREATE TABLE `types_interventions` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `code_ccam` varchar(20) NOT NULL,
  `libelle` varchar(300) NOT NULL,
  `libelle_court` varchar(150) DEFAULT NULL,
  `specialite_id` smallint(5) UNSIGNED NOT NULL,
  `classe_intervention` enum('1','2','3','4') NOT NULL COMMENT 'Classe de complexité',
  `duree_moyenne` smallint(5) UNSIGNED NOT NULL COMMENT 'en minutes',
  `duree_min` smallint(5) UNSIGNED DEFAULT NULL,
  `duree_max` smallint(5) UNSIGNED DEFAULT NULL,
  `duree_installation` smallint(5) UNSIGNED DEFAULT 30,
  `duree_reveil` smallint(5) UNSIGNED DEFAULT 60,
  `type_anesthesie` enum('LOCALE','LOCO_REGIONALE','GENERALE','RACHIANESTHESIE','PERIDURALE') NOT NULL,
  `anesthesie_obligatoire` tinyint(1) DEFAULT 1,
  `nb_chirurgiens` tinyint(3) UNSIGNED DEFAULT 1,
  `nb_anesthesistes` tinyint(3) UNSIGNED DEFAULT 1,
  `nb_ibode` tinyint(3) UNSIGNED DEFAULT 1 COMMENT 'Infirmier Bloc Opératoire',
  `nb_iade` tinyint(3) UNSIGNED DEFAULT 1 COMMENT 'Infirmier Anesthésiste',
  `materiel_specifique` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`materiel_specifique`)),
  `implants_necessaires` tinyint(1) DEFAULT 0,
  `hospitalisation_requise` tinyint(1) DEFAULT 1,
  `duree_hospitalisation_jours` tinyint(3) UNSIGNED DEFAULT NULL,
  `age_min` tinyint(3) UNSIGNED DEFAULT NULL,
  `age_max` tinyint(3) UNSIGNED DEFAULT NULL,
  `niveau_risque` enum('FAIBLE','MOYEN','ELEVE','TRES_ELEVE') DEFAULT 'MOYEN',
  `contre_indications` text DEFAULT NULL,
  `precautions_particulieres` text DEFAULT NULL,
  `tarif_secteur1` decimal(10,2) DEFAULT NULL,
  `tarif_secteur2` decimal(10,2) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `statut` enum('ACTIF','OBSOLETE') DEFAULT 'ACTIF'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `unites_fonctionnelles`
--

CREATE TABLE `unites_fonctionnelles` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `service_id` smallint(5) UNSIGNED NOT NULL,
  `code` varchar(10) NOT NULL,
  `nom` varchar(150) NOT NULL,
  `type_unite` enum('HOSPITALISATION_COMPLETE','HOSPITALISATION_JOUR','AMBULATOIRE','CONSULTATIONS','URGENCES','BLOC_OPERATOIRE','RADIOLOGIE','LABORATOIRE','PHARMACIE','REANIMATION','SOINS_INTENSIFS','MATERNITE','NEONATOLOGIE','DIALYSE','CHIMIOTHERAPIE') NOT NULL,
  `batiment` varchar(50) DEFAULT NULL,
  `etage` tinyint(4) DEFAULT NULL,
  `secteur` varchar(50) DEFAULT NULL,
  `responsable_id` bigint(20) UNSIGNED DEFAULT NULL,
  `responsable_adjoint_id` bigint(20) UNSIGNED DEFAULT NULL,
  `capacite_lits` tinyint(3) UNSIGNED DEFAULT 0,
  `capacite_fauteuils` tinyint(3) UNSIGNED DEFAULT 0,
  `capacite_consultations` tinyint(3) UNSIGNED DEFAULT 0,
  `equipements_specifiques` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`equipements_specifiques`)),
  `niveau_surveillance` enum('STANDARD','INTERMEDIAIRE','INTENSIF') DEFAULT 'STANDARD',
  `fonctionne_24h` tinyint(1) DEFAULT 0,
  `fonctionne_weekend` tinyint(1) DEFAULT 0,
  `statut` enum('ACTIF','INACTIF','MAINTENANCE','REORGANISATION') DEFAULT 'ACTIF'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `utilisateurs_systeme`
--

CREATE TABLE `utilisateurs_systeme` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `personnel_id` bigint(20) UNSIGNED DEFAULT NULL,
  `identifiant` varchar(50) NOT NULL,
  `email` varchar(255) NOT NULL,
  `mot_de_passe_hash` varchar(255) NOT NULL,
  `sel_password` varchar(100) NOT NULL,
  `role_principal` varchar(50) NOT NULL,
  `roles_secondaires` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`roles_secondaires`)),
  `permissions_specifiques` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`permissions_specifiques`)),
  `date_derniere_connexion` datetime DEFAULT NULL,
  `date_expiration_mdp` date DEFAULT NULL,
  `doit_changer_mdp` tinyint(1) DEFAULT 1,
  `compte_verrouille` tinyint(1) DEFAULT 0,
  `nombre_tentatives_echec` tinyint(3) UNSIGNED DEFAULT 0,
  `auth_2fa_activee` tinyint(1) DEFAULT 0,
  `methode_2fa` enum('SMS','EMAIL','APPLI','JETON') DEFAULT 'APPLI',
  `telephone_2fa` varchar(20) DEFAULT NULL,
  `statut` enum('ACTIF','INACTIF','SUSPENDU') DEFAULT 'ACTIF',
  `date_activation` date DEFAULT NULL,
  `date_desactivation` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_by` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vaccinations_pediatriques`
--

CREATE TABLE `vaccinations_pediatriques` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `patient_id` bigint(20) UNSIGNED NOT NULL,
  `vaccin` varchar(100) NOT NULL,
  `code_vaccin` varchar(20) DEFAULT NULL COMMENT 'Code CIP ou autre référence',
  `lot_vaccin` varchar(50) DEFAULT NULL,
  `date_vaccination` date NOT NULL,
  `date_rappel_prevue` date DEFAULT NULL,
  `date_rappel_effectif` date DEFAULT NULL,
  `voie_administration` enum('IM','SC','ORALE','INTRADERMIQUE') NOT NULL,
  `site_injection` enum('DELTOIDE','CUISSE','FESSE') DEFAULT 'DELTOIDE',
  `personnel_vaccinateur_id` bigint(20) UNSIGNED DEFAULT NULL,
  `reaction_locale` tinyint(1) DEFAULT 0,
  `reaction_generale` tinyint(1) DEFAULT 0,
  `description_reaction` text DEFAULT NULL,
  `statut` enum('FAIT','A_FAIRE','REPORTE','CONTRE_INDICATION') DEFAULT 'FAIT',
  `motif_report` text DEFAULT NULL,
  `certificat_vaccinal_genere` tinyint(1) DEFAULT 0,
  `document_preuve` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accouchements`
--
ALTER TABLE `accouchements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `obstetricien_id` (`obstetricien_id`),
  ADD KEY `idx_grossesse` (`grossesse_id`),
  ADD KEY `idx_date` (`date_accouchement`),
  ADD KEY `idx_sage_femme` (`sage_femme_id`);

--
-- Indexes for table `chambres`
--
ALTER TABLE `chambres`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_unite_numero` (`unite_id`,`numero`),
  ADD KEY `idx_statut` (`statut`),
  ADD KEY `idx_type` (`type_chambre`);

--
-- Indexes for table `competences_personnel`
--
ALTER TABLE `competences_personnel`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_personnel_specialite` (`personnel_id`,`specialite_id`),
  ADD KEY `specialite_id` (`specialite_id`),
  ADD KEY `valide_par_id` (`valide_par_id`),
  ADD KEY `idx_niveau` (`niveau`),
  ADD KEY `idx_statut` (`statut`),
  ADD KEY `idx_expiration` (`date_expiration`);

--
-- Indexes for table `consultations`
--
ALTER TABLE `consultations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `numero_consultation` (`numero_consultation`),
  ADD KEY `type_consultation_id` (`type_consultation_id`),
  ADD KEY `idx_patient` (`patient_id`),
  ADD KEY `idx_medecin` (`medecin_id`),
  ADD KEY `idx_date` (`date_consultation`),
  ADD KEY `idx_statut` (`statut`),
  ADD KEY `idx_service` (`service_id`),
  ADD KEY `idx_numero` (`numero_consultation`);

--
-- Indexes for table `contrats_travail`
--
ALTER TABLE `contrats_travail`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `numero_contrat` (`numero_contrat`),
  ADD KEY `service_affectation` (`service_affectation`),
  ADD KEY `idx_personnel` (`personnel_id`),
  ADD KEY `idx_numero` (`numero_contrat`),
  ADD KEY `idx_statut` (`statut_contrat`);

--
-- Indexes for table `courbes_croissance`
--
ALTER TABLE `courbes_croissance`
  ADD PRIMARY KEY (`id`),
  ADD KEY `consultation_id` (`consultation_id`),
  ADD KEY `personnel_mesure_id` (`personnel_mesure_id`),
  ADD KEY `idx_patient_date` (`patient_id`,`date_mesure`),
  ADD KEY `idx_age` (`age_mois`);

--
-- Indexes for table `developpement_psychomoteur`
--
ALTER TABLE `developpement_psychomoteur`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_patient_age` (`patient_id`,`age_mois`);

--
-- Indexes for table `equipements_medicaux`
--
ALTER TABLE `equipements_medicaux`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `numero_parc` (`numero_parc`),
  ADD KEY `service_affectation` (`service_affectation`),
  ADD KEY `responsable_maintenance_id` (`responsable_maintenance_id`),
  ADD KEY `idx_numero_parc` (`numero_parc`),
  ADD KEY `idx_type` (`type_equipement`),
  ADD KEY `idx_statut` (`statut`);

--
-- Indexes for table `etablissements`
--
ALTER TABLE `etablissements`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code_finess` (`code_finess`),
  ADD KEY `idx_finess` (`code_finess`),
  ADD KEY `idx_type` (`type_etablissement`),
  ADD KEY `idx_statut` (`statut`);

--
-- Indexes for table `factures_lignes`
--
ALTER TABLE `factures_lignes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tarif_reference_id` (`tarif_reference_id`),
  ADD KEY `idx_facture` (`facture_id`),
  ADD KEY `idx_activite` (`type_activite`,`activite_id`);

--
-- Indexes for table `factures_patients`
--
ALTER TABLE `factures_patients`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `numero_facture` (`numero_facture`),
  ADD KEY `sejour_id` (`sejour_id`),
  ADD KEY `consultation_id` (`consultation_id`),
  ADD KEY `idx_patient` (`patient_id`),
  ADD KEY `idx_numero` (`numero_facture`),
  ADD KEY `idx_date_emission` (`date_emission`),
  ADD KEY `idx_statut` (`statut`);

--
-- Indexes for table `grossesses`
--
ALTER TABLE `grossesses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `gyneco_obstetricien_id` (`gyneco_obstetricien_id`),
  ADD KEY `sage_femme_referente_id` (`sage_femme_referente_id`),
  ADD KEY `idx_patiente` (`patiente_id`),
  ADD KEY `idx_date_prevue` (`date_prevue_accouchement`),
  ADD KEY `idx_statut` (`statut`);

--
-- Indexes for table `interventions_maintenance`
--
ALTER TABLE `interventions_maintenance`
  ADD PRIMARY KEY (`id`),
  ADD KEY `intervenant_id` (`intervenant_id`),
  ADD KEY `idx_equipement` (`equipement_id`),
  ADD KEY `idx_date` (`date_intervention`),
  ADD KEY `idx_type` (`type_intervention`);

--
-- Indexes for table `journaux_activites`
--
ALTER TABLE `journaux_activites`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_date` (`date_heure`),
  ADD KEY `idx_utilisateur` (`utilisateur_id`),
  ADD KEY `idx_action` (`type_action`);

--
-- Indexes for table `lits`
--
ALTER TABLE `lits`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_chambre_lit` (`chambre_id`,`code_lit`),
  ADD KEY `idx_statut` (`statut`),
  ADD KEY `idx_type` (`type_lit`),
  ADD KEY `idx_reservation` (`reserve_pour_patient_id`,`date_reservation`);

--
-- Indexes for table `medicaments`
--
ALTER TABLE `medicaments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code_cip` (`code_cip`);

--
-- Indexes for table `mouvements_lits`
--
ALTER TABLE `mouvements_lits`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lit_origine_id` (`lit_origine_id`),
  ADD KEY `demandeur_id` (`demandeur_id`),
  ADD KEY `idx_sejour` (`sejour_id`),
  ADD KEY `idx_date` (`date_mouvement`),
  ADD KEY `idx_lit_destination` (`lit_destination_id`);

--
-- Indexes for table `nouveaux_nes`
--
ALTER TABLE `nouveaux_nes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_accouchement` (`accouchement_id`),
  ADD KEY `idx_statut` (`statut`);

--
-- Indexes for table `paiements_personnel`
--
ALTER TABLE `paiements_personnel`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_personnel_mois_annee` (`personnel_id`,`mois`,`annee`),
  ADD KEY `contrat_id` (`contrat_id`),
  ADD KEY `idx_date_paiement` (`date_paiement`),
  ADD KEY `idx_statut` (`statut`);

--
-- Indexes for table `patients`
--
ALTER TABLE `patients`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `numero_dossier` (`numero_dossier`),
  ADD UNIQUE KEY `numero_secu` (`numero_secu`),
  ADD KEY `idx_numero_dossier` (`numero_dossier`),
  ADD KEY `idx_numero_secu` (`numero_secu`),
  ADD KEY `idx_statut` (`statut`),
  ADD KEY `idx_groupe_sanguin` (`groupe_sanguin`),
  ADD KEY `idx_derniere_visite` (`date_derniere_visite`);

--
-- Indexes for table `personnel`
--
ALTER TABLE `personnel`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `matricule` (`matricule`),
  ADD KEY `idx_matricule` (`matricule`),
  ADD KEY `idx_fonction` (`fonction`),
  ADD KEY `idx_categorie` (`categorie`),
  ADD KEY `idx_statut` (`statut`),
  ADD KEY `idx_rpps` (`numero_rpps`),
  ADD KEY `idx_service_principal` (`service_affectation_principal`);

--
-- Indexes for table `poles`
--
ALTER TABLE `poles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`),
  ADD KEY `chef_pole_id` (`chef_pole_id`),
  ADD KEY `idx_code` (`code`),
  ADD KEY `idx_etablissement` (`etablissement_id`);

--
-- Indexes for table `prescriptions_lignes`
--
ALTER TABLE `prescriptions_lignes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `medicament_substitue_id` (`medicament_substitue_id`),
  ADD KEY `idx_prescription` (`prescription_id`),
  ADD KEY `idx_medicament` (`medicament_id`);

--
-- Indexes for table `prescriptions_medicamenteuses`
--
ALTER TABLE `prescriptions_medicamenteuses`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `numero_prescription` (`numero_prescription`),
  ADD KEY `validateur_pharmacien_id` (`validateur_pharmacien_id`),
  ADD KEY `consultation_id` (`consultation_id`),
  ADD KEY `idx_patient` (`patient_id`),
  ADD KEY `idx_prescripteur` (`prescripteur_id`),
  ADD KEY `idx_date_prescription` (`date_prescription`),
  ADD KEY `idx_statut` (`statut`);

--
-- Indexes for table `programmations_operatoires`
--
ALTER TABLE `programmations_operatoires`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `numero_programme` (`numero_programme`),
  ADD KEY `sejour_id` (`sejour_id`),
  ADD KEY `type_intervention_id` (`type_intervention_id`),
  ADD KEY `anesthesiste_id` (`anesthesiste_id`),
  ADD KEY `idx_patient` (`patient_id`),
  ADD KEY `idx_date_intervention` (`date_intervention`,`heure_debut`),
  ADD KEY `idx_salle` (`salle_operation_id`),
  ADD KEY `idx_chirurgien` (`chirurgien_principal_id`),
  ADD KEY `idx_statut` (`statut`);

--
-- Indexes for table `salles_operation`
--
ALTER TABLE `salles_operation`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `numero_salle` (`numero_salle`),
  ADD KEY `idx_numero` (`numero_salle`),
  ADD KEY `idx_statut` (`statut`),
  ADD KEY `idx_service` (`service_id`);

--
-- Indexes for table `sejours`
--
ALTER TABLE `sejours`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `numero_sejour` (`numero_sejour`),
  ADD KEY `service_sortie_id` (`service_sortie_id`),
  ADD KEY `chambre_id` (`chambre_id`),
  ADD KEY `lit_id` (`lit_id`),
  ADD KEY `idx_patient` (`patient_id`),
  ADD KEY `idx_numero` (`numero_sejour`),
  ADD KEY `idx_dates` (`date_admission`,`date_sortie_reelle`),
  ADD KEY `idx_service_admission` (`service_admission_id`),
  ADD KEY `idx_medecin_referent` (`medecin_referent_id`),
  ADD KEY `idx_statut` (`statut`);

--
-- Indexes for table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`),
  ADD KEY `chef_service_id` (`chef_service_id`),
  ADD KEY `cadre_sante_id` (`cadre_sante_id`),
  ADD KEY `idx_code` (`code`),
  ADD KEY `idx_type` (`type_service`),
  ADD KEY `idx_statut` (`statut`),
  ADD KEY `idx_pole` (`pole_id`);

--
-- Indexes for table `specialites`
--
ALTER TABLE `specialites`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`),
  ADD KEY `idx_code` (`code`),
  ADD KEY `idx_type` (`type_specialite`),
  ADD KEY `idx_parent` (`specialite_parent_id`);

--
-- Indexes for table `stocks_pharmaceutiques`
--
ALTER TABLE `stocks_pharmaceutiques`
  ADD PRIMARY KEY (`id`),
  ADD KEY `service_id` (`service_id`),
  ADD KEY `receptionnaire_id` (`receptionnaire_id`),
  ADD KEY `idx_medicament` (`medicament_id`),
  ADD KEY `idx_peremption` (`date_peremption`),
  ADD KEY `idx_lot` (`numero_lot`);

--
-- Indexes for table `tarifs_hospitaliers`
--
ALTER TABLE `tarifs_hospitaliers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code_tarif` (`code_tarif`),
  ADD KEY `idx_code` (`code_tarif`),
  ADD KEY `idx_type` (`type_tarif`),
  ADD KEY `idx_ghm` (`code_ghm`),
  ADD KEY `idx_ccam` (`code_ccam`);

--
-- Indexes for table `types_consultations`
--
ALTER TABLE `types_consultations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`),
  ADD KEY `idx_code` (`code`),
  ADD KEY `idx_specialite` (`specialite_id`);

--
-- Indexes for table `types_interventions`
--
ALTER TABLE `types_interventions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code_ccam` (`code_ccam`),
  ADD KEY `idx_code_ccam` (`code_ccam`),
  ADD KEY `idx_specialite` (`specialite_id`),
  ADD KEY `idx_classe` (`classe_intervention`);

--
-- Indexes for table `unites_fonctionnelles`
--
ALTER TABLE `unites_fonctionnelles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`),
  ADD KEY `responsable_id` (`responsable_id`),
  ADD KEY `idx_code` (`code`),
  ADD KEY `idx_service` (`service_id`),
  ADD KEY `idx_type` (`type_unite`);

--
-- Indexes for table `utilisateurs_systeme`
--
ALTER TABLE `utilisateurs_systeme`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `identifiant` (`identifiant`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `personnel_id` (`personnel_id`),
  ADD KEY `idx_identifiant` (`identifiant`),
  ADD KEY `idx_email` (`email`),
  ADD KEY `idx_statut` (`statut`);

--
-- Indexes for table `vaccinations_pediatriques`
--
ALTER TABLE `vaccinations_pediatriques`
  ADD PRIMARY KEY (`id`),
  ADD KEY `personnel_vaccinateur_id` (`personnel_vaccinateur_id`),
  ADD KEY `idx_patient_vaccin` (`patient_id`,`vaccin`),
  ADD KEY `idx_date_vaccination` (`date_vaccination`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accouchements`
--
ALTER TABLE `accouchements`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `chambres`
--
ALTER TABLE `chambres`
  MODIFY `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `competences_personnel`
--
ALTER TABLE `competences_personnel`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `consultations`
--
ALTER TABLE `consultations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contrats_travail`
--
ALTER TABLE `contrats_travail`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `courbes_croissance`
--
ALTER TABLE `courbes_croissance`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `developpement_psychomoteur`
--
ALTER TABLE `developpement_psychomoteur`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `equipements_medicaux`
--
ALTER TABLE `equipements_medicaux`
  MODIFY `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `etablissements`
--
ALTER TABLE `etablissements`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `factures_lignes`
--
ALTER TABLE `factures_lignes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `factures_patients`
--
ALTER TABLE `factures_patients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `grossesses`
--
ALTER TABLE `grossesses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `interventions_maintenance`
--
ALTER TABLE `interventions_maintenance`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `journaux_activites`
--
ALTER TABLE `journaux_activites`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lits`
--
ALTER TABLE `lits`
  MODIFY `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `medicaments`
--
ALTER TABLE `medicaments`
  MODIFY `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mouvements_lits`
--
ALTER TABLE `mouvements_lits`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `nouveaux_nes`
--
ALTER TABLE `nouveaux_nes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `paiements_personnel`
--
ALTER TABLE `paiements_personnel`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `poles`
--
ALTER TABLE `poles`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `prescriptions_lignes`
--
ALTER TABLE `prescriptions_lignes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `prescriptions_medicamenteuses`
--
ALTER TABLE `prescriptions_medicamenteuses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `programmations_operatoires`
--
ALTER TABLE `programmations_operatoires`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `salles_operation`
--
ALTER TABLE `salles_operation`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sejours`
--
ALTER TABLE `sejours`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `specialites`
--
ALTER TABLE `specialites`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `stocks_pharmaceutiques`
--
ALTER TABLE `stocks_pharmaceutiques`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tarifs_hospitaliers`
--
ALTER TABLE `tarifs_hospitaliers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `types_consultations`
--
ALTER TABLE `types_consultations`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `types_interventions`
--
ALTER TABLE `types_interventions`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `unites_fonctionnelles`
--
ALTER TABLE `unites_fonctionnelles`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `utilisateurs_systeme`
--
ALTER TABLE `utilisateurs_systeme`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `vaccinations_pediatriques`
--
ALTER TABLE `vaccinations_pediatriques`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `accouchements`
--
ALTER TABLE `accouchements`
  ADD CONSTRAINT `accouchements_ibfk_1` FOREIGN KEY (`grossesse_id`) REFERENCES `grossesses` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `accouchements_ibfk_2` FOREIGN KEY (`sage_femme_id`) REFERENCES `personnel` (`id`),
  ADD CONSTRAINT `accouchements_ibfk_3` FOREIGN KEY (`obstetricien_id`) REFERENCES `personnel` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `chambres`
--
ALTER TABLE `chambres`
  ADD CONSTRAINT `chambres_ibfk_1` FOREIGN KEY (`unite_id`) REFERENCES `unites_fonctionnelles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `competences_personnel`
--
ALTER TABLE `competences_personnel`
  ADD CONSTRAINT `competences_personnel_ibfk_1` FOREIGN KEY (`personnel_id`) REFERENCES `personnel` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `competences_personnel_ibfk_2` FOREIGN KEY (`specialite_id`) REFERENCES `specialites` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `competences_personnel_ibfk_3` FOREIGN KEY (`valide_par_id`) REFERENCES `personnel` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `consultations`
--
ALTER TABLE `consultations`
  ADD CONSTRAINT `consultations_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `consultations_ibfk_2` FOREIGN KEY (`medecin_id`) REFERENCES `personnel` (`id`),
  ADD CONSTRAINT `consultations_ibfk_3` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`),
  ADD CONSTRAINT `consultations_ibfk_4` FOREIGN KEY (`type_consultation_id`) REFERENCES `types_consultations` (`id`);

--
-- Constraints for table `contrats_travail`
--
ALTER TABLE `contrats_travail`
  ADD CONSTRAINT `contrats_travail_ibfk_1` FOREIGN KEY (`personnel_id`) REFERENCES `personnel` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `contrats_travail_ibfk_2` FOREIGN KEY (`service_affectation`) REFERENCES `services` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `courbes_croissance`
--
ALTER TABLE `courbes_croissance`
  ADD CONSTRAINT `courbes_croissance_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `courbes_croissance_ibfk_2` FOREIGN KEY (`consultation_id`) REFERENCES `consultations` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `courbes_croissance_ibfk_3` FOREIGN KEY (`personnel_mesure_id`) REFERENCES `personnel` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `developpement_psychomoteur`
--
ALTER TABLE `developpement_psychomoteur`
  ADD CONSTRAINT `developpement_psychomoteur_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `equipements_medicaux`
--
ALTER TABLE `equipements_medicaux`
  ADD CONSTRAINT `equipements_medicaux_ibfk_1` FOREIGN KEY (`service_affectation`) REFERENCES `services` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `equipements_medicaux_ibfk_2` FOREIGN KEY (`responsable_maintenance_id`) REFERENCES `personnel` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `factures_lignes`
--
ALTER TABLE `factures_lignes`
  ADD CONSTRAINT `factures_lignes_ibfk_1` FOREIGN KEY (`facture_id`) REFERENCES `factures_patients` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `factures_lignes_ibfk_2` FOREIGN KEY (`tarif_reference_id`) REFERENCES `tarifs_hospitaliers` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `factures_patients`
--
ALTER TABLE `factures_patients`
  ADD CONSTRAINT `factures_patients_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `factures_patients_ibfk_2` FOREIGN KEY (`sejour_id`) REFERENCES `sejours` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `factures_patients_ibfk_3` FOREIGN KEY (`consultation_id`) REFERENCES `consultations` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `grossesses`
--
ALTER TABLE `grossesses`
  ADD CONSTRAINT `grossesses_ibfk_1` FOREIGN KEY (`patiente_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `grossesses_ibfk_2` FOREIGN KEY (`gyneco_obstetricien_id`) REFERENCES `personnel` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `grossesses_ibfk_3` FOREIGN KEY (`sage_femme_referente_id`) REFERENCES `personnel` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `interventions_maintenance`
--
ALTER TABLE `interventions_maintenance`
  ADD CONSTRAINT `interventions_maintenance_ibfk_1` FOREIGN KEY (`equipement_id`) REFERENCES `equipements_medicaux` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `interventions_maintenance_ibfk_2` FOREIGN KEY (`intervenant_id`) REFERENCES `personnel` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `journaux_activites`
--
ALTER TABLE `journaux_activites`
  ADD CONSTRAINT `journaux_activites_ibfk_1` FOREIGN KEY (`utilisateur_id`) REFERENCES `utilisateurs_systeme` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `lits`
--
ALTER TABLE `lits`
  ADD CONSTRAINT `lits_ibfk_1` FOREIGN KEY (`chambre_id`) REFERENCES `chambres` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `lits_ibfk_2` FOREIGN KEY (`reserve_pour_patient_id`) REFERENCES `patients` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `mouvements_lits`
--
ALTER TABLE `mouvements_lits`
  ADD CONSTRAINT `mouvements_lits_ibfk_1` FOREIGN KEY (`sejour_id`) REFERENCES `sejours` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `mouvements_lits_ibfk_2` FOREIGN KEY (`lit_origine_id`) REFERENCES `lits` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `mouvements_lits_ibfk_3` FOREIGN KEY (`lit_destination_id`) REFERENCES `lits` (`id`),
  ADD CONSTRAINT `mouvements_lits_ibfk_4` FOREIGN KEY (`demandeur_id`) REFERENCES `personnel` (`id`);

--
-- Constraints for table `nouveaux_nes`
--
ALTER TABLE `nouveaux_nes`
  ADD CONSTRAINT `nouveaux_nes_ibfk_1` FOREIGN KEY (`accouchement_id`) REFERENCES `accouchements` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `paiements_personnel`
--
ALTER TABLE `paiements_personnel`
  ADD CONSTRAINT `paiements_personnel_ibfk_1` FOREIGN KEY (`personnel_id`) REFERENCES `personnel` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `paiements_personnel_ibfk_2` FOREIGN KEY (`contrat_id`) REFERENCES `contrats_travail` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `patients`
--
ALTER TABLE `patients`
  ADD CONSTRAINT `patients_ibfk_1` FOREIGN KEY (`id`) REFERENCES `personnes` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `personnel`
--
ALTER TABLE `personnel`
  ADD CONSTRAINT `personnel_ibfk_1` FOREIGN KEY (`id`) REFERENCES `personnes` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `poles`
--
ALTER TABLE `poles`
  ADD CONSTRAINT `poles_ibfk_1` FOREIGN KEY (`etablissement_id`) REFERENCES `etablissements` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `poles_ibfk_2` FOREIGN KEY (`chef_pole_id`) REFERENCES `personnel` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `prescriptions_lignes`
--
ALTER TABLE `prescriptions_lignes`
  ADD CONSTRAINT `prescriptions_lignes_ibfk_1` FOREIGN KEY (`prescription_id`) REFERENCES `prescriptions_medicamenteuses` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `prescriptions_lignes_ibfk_2` FOREIGN KEY (`medicament_id`) REFERENCES `medicaments` (`id`),
  ADD CONSTRAINT `prescriptions_lignes_ibfk_3` FOREIGN KEY (`medicament_substitue_id`) REFERENCES `medicaments` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `prescriptions_medicamenteuses`
--
ALTER TABLE `prescriptions_medicamenteuses`
  ADD CONSTRAINT `prescriptions_medicamenteuses_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `prescriptions_medicamenteuses_ibfk_2` FOREIGN KEY (`prescripteur_id`) REFERENCES `personnel` (`id`),
  ADD CONSTRAINT `prescriptions_medicamenteuses_ibfk_3` FOREIGN KEY (`validateur_pharmacien_id`) REFERENCES `personnel` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `prescriptions_medicamenteuses_ibfk_4` FOREIGN KEY (`consultation_id`) REFERENCES `consultations` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `programmations_operatoires`
--
ALTER TABLE `programmations_operatoires`
  ADD CONSTRAINT `programmations_operatoires_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `programmations_operatoires_ibfk_2` FOREIGN KEY (`sejour_id`) REFERENCES `sejours` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `programmations_operatoires_ibfk_3` FOREIGN KEY (`type_intervention_id`) REFERENCES `types_interventions` (`id`),
  ADD CONSTRAINT `programmations_operatoires_ibfk_4` FOREIGN KEY (`salle_operation_id`) REFERENCES `salles_operation` (`id`),
  ADD CONSTRAINT `programmations_operatoires_ibfk_5` FOREIGN KEY (`chirurgien_principal_id`) REFERENCES `personnel` (`id`),
  ADD CONSTRAINT `programmations_operatoires_ibfk_6` FOREIGN KEY (`anesthesiste_id`) REFERENCES `personnel` (`id`);

--
-- Constraints for table `salles_operation`
--
ALTER TABLE `salles_operation`
  ADD CONSTRAINT `salles_operation_ibfk_1` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `sejours`
--
ALTER TABLE `sejours`
  ADD CONSTRAINT `sejours_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `sejours_ibfk_2` FOREIGN KEY (`service_admission_id`) REFERENCES `services` (`id`),
  ADD CONSTRAINT `sejours_ibfk_3` FOREIGN KEY (`service_sortie_id`) REFERENCES `services` (`id`),
  ADD CONSTRAINT `sejours_ibfk_4` FOREIGN KEY (`medecin_referent_id`) REFERENCES `personnel` (`id`),
  ADD CONSTRAINT `sejours_ibfk_5` FOREIGN KEY (`chambre_id`) REFERENCES `chambres` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `sejours_ibfk_6` FOREIGN KEY (`lit_id`) REFERENCES `lits` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `services`
--
ALTER TABLE `services`
  ADD CONSTRAINT `services_ibfk_1` FOREIGN KEY (`pole_id`) REFERENCES `poles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `services_ibfk_2` FOREIGN KEY (`chef_service_id`) REFERENCES `personnel` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `services_ibfk_3` FOREIGN KEY (`cadre_sante_id`) REFERENCES `personnel` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `specialites`
--
ALTER TABLE `specialites`
  ADD CONSTRAINT `specialites_ibfk_1` FOREIGN KEY (`specialite_parent_id`) REFERENCES `specialites` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `stocks_pharmaceutiques`
--
ALTER TABLE `stocks_pharmaceutiques`
  ADD CONSTRAINT `stocks_pharmaceutiques_ibfk_1` FOREIGN KEY (`medicament_id`) REFERENCES `medicaments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `stocks_pharmaceutiques_ibfk_2` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `stocks_pharmaceutiques_ibfk_3` FOREIGN KEY (`receptionnaire_id`) REFERENCES `personnel` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `types_consultations`
--
ALTER TABLE `types_consultations`
  ADD CONSTRAINT `types_consultations_ibfk_1` FOREIGN KEY (`specialite_id`) REFERENCES `specialites` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `types_interventions`
--
ALTER TABLE `types_interventions`
  ADD CONSTRAINT `types_interventions_ibfk_1` FOREIGN KEY (`specialite_id`) REFERENCES `specialites` (`id`);

--
-- Constraints for table `unites_fonctionnelles`
--
ALTER TABLE `unites_fonctionnelles`
  ADD CONSTRAINT `unites_fonctionnelles_ibfk_1` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `unites_fonctionnelles_ibfk_2` FOREIGN KEY (`responsable_id`) REFERENCES `personnel` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `utilisateurs_systeme`
--
ALTER TABLE `utilisateurs_systeme`
  ADD CONSTRAINT `utilisateurs_systeme_ibfk_1` FOREIGN KEY (`personnel_id`) REFERENCES `personnel` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `vaccinations_pediatriques`
--
ALTER TABLE `vaccinations_pediatriques`
  ADD CONSTRAINT `vaccinations_pediatriques_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `vaccinations_pediatriques_ibfk_2` FOREIGN KEY (`personnel_vaccinateur_id`) REFERENCES `personnel` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
