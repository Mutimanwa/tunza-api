package com.tunza.api.modules.medical.repository;

import com.tunza.api.modules.medical.models.Patient;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PatientRepository extends JpaRepository<Patient, Long> {
    List<Patient> findByTenantId(Long tenantId);
    Patient findByNumeroDossierAndTenantId(String numeroDossier, Long tenantId);
}