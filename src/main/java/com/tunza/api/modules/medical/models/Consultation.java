package com.tunza.api.modules.medical.models;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "consultations")
public class Consultation {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "tenant_id", nullable = false)
    private Long tenantId;

    @Column(name = "patient_id", nullable = false)
    private Long patientId;

    @Column(name = "user_id", nullable = false)
    private Long userId;

    @Column(name = "date_consultation", nullable = false)
    private LocalDateTime dateConsultation;

    @Column(columnDefinition = "TEXT")
    private String diagnostic;

    @Column(name = "actes_medicaux", columnDefinition = "TEXT")
    private String actesMedicaux;

    @Column(name = "observation_medicale", columnDefinition = "TEXT")
    private String observationMedicale;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private StatutConsultation statut = StatutConsultation.PROGRAMMEE;

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Long getTenantId() { return tenantId; }
    public void setTenantId(Long tenantId) { this.tenantId = tenantId; }

    public Long getPatientId() { return patientId; }
    public void setPatientId(Long patientId) { this.patientId = patientId; }

    public Long getUserId() { return userId; }
    public void setUserId(Long userId) { this.userId = userId; }

    public LocalDateTime getDateConsultation() { return dateConsultation; }
    public void setDateConsultation(LocalDateTime dateConsultation) { this.dateConsultation = dateConsultation; }

    public String getDiagnostic() { return diagnostic; }
    public void setDiagnostic(String diagnostic) { this.diagnostic = diagnostic; }

    public String getActesMedicaux() { return actesMedicaux; }
    public void setActesMedicaux(String actesMedicaux) { this.actesMedicaux = actesMedicaux; }

    public String getObservationMedicale() { return observationMedicale; }
    public void setObservationMedicale(String observationMedicale) { this.observationMedicale = observationMedicale; }

    public StatutConsultation getStatut() { return statut; }
    public void setStatut(StatutConsultation statut) { this.statut = statut; }

    public enum StatutConsultation {
        PROGRAMMEE, EN_COURS, TERMINEE, ANNULEE
    }
}