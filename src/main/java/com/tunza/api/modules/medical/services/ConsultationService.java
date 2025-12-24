package com.tunza.api.modules.medical.services;

import com.tunza.api.modules.medical.models.Consultation;
import com.tunza.api.modules.medical.repository.ConsultationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ConsultationService {

    @Autowired
    private ConsultationRepository consultationRepository;

    public List<Consultation> getAllConsultationsByTenant(Long tenantId) {
        return consultationRepository.findByTenantId(tenantId);
    }

    public List<Consultation> getConsultationsByPatientAndTenant(Long patientId, Long tenantId) {
        return consultationRepository.findByPatientIdAndTenantId(patientId, tenantId);
    }

    public Optional<Consultation> getConsultationByIdAndTenant(Long id, Long tenantId) {
        return consultationRepository.findById(id).filter(c -> c.getTenantId().equals(tenantId));
    }

    public Consultation saveConsultation(Consultation consultation) {
        return consultationRepository.save(consultation);
    }

    public void deleteConsultation(Long id, Long tenantId) {
        consultationRepository.findById(id).ifPresent(c -> {
            if (c.getTenantId().equals(tenantId)) {
                consultationRepository.delete(c);
            }
        });
    }
}