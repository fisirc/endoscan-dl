"""Endoscopy use cases"""
from typing import Optional, List
from app.domain.entities import Endoscopy
from app.domain.repositories import EndoscopyRepository


class CreateEndoscopyUseCase:
    """Use case to create a new endoscopy record"""

    def __init__(self, endoscopy_repository: EndoscopyRepository):
        self.endoscopy_repository = endoscopy_repository

    async def execute(
        self,
        patient_id: str,
        findings: str,
        risk_level: str = "bajo",
        doctor_notes: str = "",
        image_path: Optional[str] = None,
    ) -> dict:
        """Create a new endoscopy record"""
        endoscopy = Endoscopy(
            patient_id=patient_id,
            findings=findings,
            risk_level=risk_level,
            doctor_notes=doctor_notes,
            image_path=image_path,
        )
        created = await self.endoscopy_repository.create(endoscopy)
        return {
            "id": created.id,
            "patient_id": created.patient_id,
            "findings": created.findings,
            "risk_level": created.risk_level,
            "doctor_notes": created.doctor_notes,
            "image_path": created.image_path,
            "date": created.date,
            "created_at": created.created_at,
        }


class GetEndoscopyByPatientUseCase:
    """Use case to get endoscopies by patient"""

    def __init__(self, endoscopy_repository: EndoscopyRepository):
        self.endoscopy_repository = endoscopy_repository

    async def execute(self, patient_id: str, skip: int = 0, limit: int = 10) -> List[dict]:
        """Get endoscopies for a patient"""
        endoscopies = await self.endoscopy_repository.get_by_patient_id(patient_id, skip, limit)
        return [
            {
                "id": e.id,
                "patient_id": e.patient_id,
                "findings": e.findings,
                "risk_level": e.risk_level,
                "doctor_notes": e.doctor_notes,
                "image_path": e.image_path,
                "date": e.date,
                "created_at": e.created_at,
            }
            for e in endoscopies
        ]


class GetEndoscopyUseCase:
    """Use case to get a single endoscopy record"""

    def __init__(self, endoscopy_repository: EndoscopyRepository):
        self.endoscopy_repository = endoscopy_repository

    async def execute(self, endoscopy_id: str) -> Optional[dict]:
        """Get endoscopy by ID"""
        endoscopy = await self.endoscopy_repository.get_by_id(endoscopy_id)
        if not endoscopy:
            return None

        return {
            "id": endoscopy.id,
            "patient_id": endoscopy.patient_id,
            "findings": endoscopy.findings,
            "risk_level": endoscopy.risk_level,
            "doctor_notes": endoscopy.doctor_notes,
            "image_path": endoscopy.image_path,
            "date": endoscopy.date,
            "created_at": endoscopy.created_at,
            "updated_at": endoscopy.updated_at,
        }
