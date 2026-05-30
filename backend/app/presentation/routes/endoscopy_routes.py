"""Endoscopy routes"""
from fastapi import APIRouter, HTTPException
from typing import List
from app.presentation.schemas import EndoscopyCreate, EndoscopyResponse
from app.domain.usecases import CreateEndoscopyUseCase, GetEndoscopyByPatientUseCase, GetEndoscopyUseCase
from app.data.datasources import InMemoryEndoscopyDataSource
from app.data.repositories import EndoscopyRepositoryImpl

# Initialize dependencies
endoscopy_data_source = InMemoryEndoscopyDataSource()
endoscopy_repository = EndoscopyRepositoryImpl(endoscopy_data_source)

router = APIRouter(prefix="/api/v1/endoscopies", tags=["endoscopies"])


@router.post("/", response_model=EndoscopyResponse)
async def create_endoscopy(endoscopy: EndoscopyCreate, patient_id: str):
    """Create a new endoscopy record"""
    try:
        use_case = CreateEndoscopyUseCase(endoscopy_repository)
        result = await use_case.execute(
            patient_id=patient_id,
            findings=endoscopy.findings,
            risk_level=endoscopy.risk_level,
            doctor_notes=endoscopy.doctor_notes,
            image_path=endoscopy.image_path,
        )
        return result
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))


@router.get("/{endoscopy_id}", response_model=EndoscopyResponse)
async def get_endoscopy(endoscopy_id: str):
    """Get endoscopy by ID"""
    try:
        use_case = GetEndoscopyUseCase(endoscopy_repository)
        result = await use_case.execute(endoscopy_id)
        if not result:
            raise HTTPException(status_code=404, detail="Endoscopy not found")
        return result
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))


@router.get("/patient/{patient_id}", response_model=List[EndoscopyResponse])
async def get_patient_endoscopies(patient_id: str, skip: int = 0, limit: int = 10):
    """Get endoscopies for a patient"""
    try:
        use_case = GetEndoscopyByPatientUseCase(endoscopy_repository)
        result = await use_case.execute(patient_id, skip, limit)
        return result
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))
