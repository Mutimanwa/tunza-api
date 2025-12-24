package com.tunza.api.modules.medical.controller;

import com.tunza.api.modules.medical.models.Consultation;
import com.tunza.api.modules.medical.services.ConsultationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Contrôleur REST pour la gestion des consultations médicales dans TUNZA.
 * Gère les CRUD pour les consultations, avec isolation par tenant.
 */
@RestController
@RequestMapping("/api/v1/consultations")
public class ConsultationController {

    @Autowired
    private ConsultationService consultationService;

    /**
     * Récupère toutes les consultations d'un tenant.
     * @param tenantId L'identifiant du tenant
     * @return Liste des consultations
     */
    @GetMapping
    public ResponseEntity<List<Consultation>> getAllConsultations(@RequestAttribute("tenantId") Long tenantId) {
        List<Consultation> consultations = consultationService.getAllConsultationsByTenant(tenantId);
        return ResponseEntity.ok(consultations);
    }

    /**
     * Récupère les consultations d'un patient spécifique dans un tenant.
     * @param patientId L'identifiant du patient
     * @param tenantId L'identifiant du tenant
     * @return Liste des consultations du patient
     */
    @GetMapping("/patient/{patientId}")
    public ResponseEntity<List<Consultation>> getConsultationsByPatient(@PathVariable Long patientId, @RequestAttribute("tenantId") Long tenantId) {
        List<Consultation> consultations = consultationService.getConsultationsByPatientAndTenant(patientId, tenantId);
        return ResponseEntity.ok(consultations);
    }

    /**
     * Récupère une consultation par ID et tenant.
     * @param id L'identifiant de la consultation
     * @param tenantId L'identifiant du tenant
     * @return La consultation ou 404
     */
    @GetMapping("/{id}")
    public ResponseEntity<Consultation> getConsultationById(@PathVariable Long id, @RequestAttribute("tenantId") Long tenantId) {
        return consultationService.getConsultationByIdAndTenant(id, tenantId)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    /**
     * Crée une nouvelle consultation.
     * @param consultation Les données de la consultation
     * @param tenantId L'identifiant du tenant
     * @return La consultation créée
     */
    @PostMapping
    public ResponseEntity<Consultation> createConsultation(@RequestBody Consultation consultation, @RequestAttribute("tenantId") Long tenantId) {
        consultation.setTenantId(tenantId);
        Consultation saved = consultationService.saveConsultation(consultation);
        return ResponseEntity.ok(saved);
    }

    /**
     * Met à jour une consultation existante.
     * @param id L'identifiant de la consultation
     * @param consultation Les nouvelles données
     * @param tenantId L'identifiant du tenant
     * @return La consultation mise à jour ou 404
     */
    @PutMapping("/{id}")
    public ResponseEntity<Consultation> updateConsultation(@PathVariable Long id, @RequestBody Consultation consultation, @RequestAttribute("tenantId") Long tenantId) {
        return consultationService.getConsultationByIdAndTenant(id, tenantId)
                .map(existing -> {
                    consultation.setId(id);
                    consultation.setTenantId(tenantId);
                    return ResponseEntity.ok(consultationService.saveConsultation(consultation));
                })
                .orElse(ResponseEntity.notFound().build());
    }

    /**
     * Supprime une consultation.
     * @param id L'identifiant de la consultation
     * @param tenantId L'identifiant du tenant
     * @return 204 No Content
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteConsultation(@PathVariable Long id, @RequestAttribute("tenantId") Long tenantId) {
        consultationService.deleteConsultation(id, tenantId);
        return ResponseEntity.noContent().build();
    }
}