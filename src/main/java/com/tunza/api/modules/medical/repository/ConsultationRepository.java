package com.tunza.api.modules.medical.repository;

import com.tunza.api.modules.medical.models.Consultation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ConsultationRepository extends JpaRepository<Consultation, Long> {
    List<Consultation> findByTenantId(Long tenantId);
    List<Consultation> findByPatientIdAndTenantId(Long patientId, Long tenantId);
}