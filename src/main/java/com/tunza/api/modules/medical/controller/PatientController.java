package com.tunza.api.modules.medical.controller;

import com.tunza.api.modules.medical.models.Patient;
import com.tunza.api.modules.medical.services.PatientService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Contrôleur REST pour la gestion des patients dans le système TUNZA.
 * Fournit des endpoints CRUD pour les patients, avec isolation par tenant.
 */
@RestController
@RequestMapping("/api/v1/patients")
public class PatientController {

    @Autowired
    private PatientService patientService;

    // TODO: Extraire tenantId du JWT ou du contexte de sécurité en production
    // Pour le MVP, tenantId est passé en paramètre de requête

    /**
     * Récupère tous les patients d'un tenant spécifique.
     * @param tenantId L'identifiant du tenant (établissement)
     * @return Liste des patients
     */
    @GetMapping
    public ResponseEntity<List<Patient>> getAllPatients(@RequestAttribute("tenantId") Long tenantId) {
        List<Patient> patients = patientService.getAllPatientsByTenant(tenantId);
        return ResponseEntity.ok(patients);
    }

    /**
     * Récupère un patient par son ID et tenant.
     * @param id L'identifiant du patient
     * @param tenantId L'identifiant du tenant
     * @return Le patient ou 404 si non trouvé
     */
    @GetMapping("/{id}")
    public ResponseEntity<Patient> getPatientById(@PathVariable Long id, @RequestAttribute("tenantId") Long tenantId) {
        return patientService.getPatientByIdAndTenant(id, tenantId)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    /**
     * Crée un nouveau patient pour un tenant.
     * @param patient Les données du patient
     * @param tenantId L'identifiant du tenant
     * @return Le patient créé
     */
    @PostMapping
    public ResponseEntity<Patient> createPatient(@RequestBody Patient patient, @RequestAttribute("tenantId") Long tenantId) {
        patient.setTenantId(tenantId);
        Patient saved = patientService.savePatient(patient);
        return ResponseEntity.ok(saved);
    }

    /**
     * Met à jour un patient existant.
     * @param id L'identifiant du patient
     * @param patient Les nouvelles données
     * @param tenantId L'identifiant du tenant
     * @return Le patient mis à jour ou 404 si non trouvé
     */
    @PutMapping("/{id}")
    public ResponseEntity<Patient> updatePatient(@PathVariable Long id, @RequestBody Patient patient, @RequestAttribute("tenantId") Long tenantId) {
        return patientService.getPatientByIdAndTenant(id, tenantId)
                .map(existing -> {
                    patient.setId(id);
                    patient.setTenantId(tenantId);
                    return ResponseEntity.ok(patientService.savePatient(patient));
                })
                .orElse(ResponseEntity.notFound().build());
    }

    /**
     * Supprime un patient.
     * @param id L'identifiant du patient
     * @param tenantId L'identifiant du tenant
     * @return 204 No Content
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deletePatient(@PathVariable Long id, @RequestAttribute("tenantId") Long tenantId) {
        patientService.deletePatient(id, tenantId);
        return ResponseEntity.noContent().build();
    }
}