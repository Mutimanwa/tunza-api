package com.tunza.api.modules.medical.services;

import com.tunza.api.modules.medical.models.Patient;
import com.tunza.api.modules.medical.repository.PatientRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

/**
 * Service métier pour la gestion des patients.
 * Gère la logique CRUD avec isolation par tenant.
 */
@Service
public class PatientService {

    @Autowired
    private PatientRepository patientRepository;

    /**
     * Récupère tous les patients d'un tenant.
     * @param tenantId L'identifiant du tenant
     * @return Liste des patients
     */
    public List<Patient> getAllPatientsByTenant(Long tenantId) {
        return patientRepository.findByTenantId(tenantId);
    }

    /**
     * Récupère un patient par ID et tenant.
     * @param id L'identifiant du patient
     * @param tenantId L'identifiant du tenant
     * @return Optional du patient
     */
    public Optional<Patient> getPatientByIdAndTenant(Long id, Long tenantId) {
        return patientRepository.findById(id).filter(p -> p.getTenantId().equals(tenantId));
    }

    /**
     * Sauvegarde un patient (création ou mise à jour).
     * @param patient Le patient à sauvegarder
     * @return Le patient sauvegardé
     */
    public Patient savePatient(Patient patient) {
        return patientRepository.save(patient);
    }

    /**
     * Supprime un patient si il appartient au tenant.
     * @param id L'identifiant du patient
     * @param tenantId L'identifiant du tenant
     */
    public void deletePatient(Long id, Long tenantId) {
        patientRepository.findById(id).ifPresent(p -> {
            if (p.getTenantId().equals(tenantId)) {
                patientRepository.delete(p);
            }
        });
    }
}