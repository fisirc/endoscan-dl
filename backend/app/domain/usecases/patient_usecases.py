"""Patient use cases"""
from typing import Optional, List
from app.domain.entities import Patient
from app.domain.repositories import PatientRepository


class CreatePatientUseCase:
    """Use case to create a new patient"""

    def __init__(self, patient_repository: PatientRepository):
        self.patient_repository = patient_repository

    async def execute(self, user_id: str, age: int, weight: float, height: float, medical_history: str = "") -> dict:
        """Create a new patient record"""
        patient = Patient(
            user_id=user_id,
            age=age,
            weight=weight,
            height=height,
            medical_history=medical_history,
        )
        created_patient = await self.patient_repository.create(patient)
        return {
            "id": created_patient.id,
            "user_id": created_patient.user_id,
            "age": created_patient.age,
            "weight": created_patient.weight,
            "height": created_patient.height,
            "medical_history": created_patient.medical_history,
        }


class GetPatientUseCase:
    """Use case to get patient details"""

    def __init__(self, patient_repository: PatientRepository):
        self.patient_repository = patient_repository

    async def execute(self, patient_id: str) -> Optional[dict]:
        """Get patient by ID"""
        patient = await self.patient_repository.get_by_id(patient_id)
        if not patient:
            return None

        return {
            "id": patient.id,
            "user_id": patient.user_id,
            "age": patient.age,
            "weight": patient.weight,
            "height": patient.height,
            "medical_history": patient.medical_history,
            "created_at": patient.created_at,
            "updated_at": patient.updated_at,
        }


class GetPatientByUserUseCase:
    """Use case to get patient by user ID"""

    def __init__(self, patient_repository: PatientRepository):
        self.patient_repository = patient_repository

    async def execute(self, user_id: str) -> Optional[dict]:
        """Get patient by user ID"""
        patient = await self.patient_repository.get_by_user_id(user_id)
        if not patient:
            return None

        return {
            "id": patient.id,
            "user_id": patient.user_id,
            "age": patient.age,
            "weight": patient.weight,
            "height": patient.height,
            "medical_history": patient.medical_history,
            "created_at": patient.created_at,
            "updated_at": patient.updated_at,
        }
