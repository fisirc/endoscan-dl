"""Patient routes"""
from fastapi import APIRouter, HTTPException
from typing import List
from app.presentation.schemas import PatientCreate, PatientResponse
from app.domain.usecases import CreatePatientUseCase, GetPatientUseCase, GetPatientByUserUseCase
from app.data.datasources import InMemoryPatientDataSource
from app.data.repositories import PatientRepositoryImpl

# Initialize dependencies
patient_data_source = InMemoryPatientDataSource()
patient_repository = PatientRepositoryImpl(patient_data_source)

router = APIRouter(prefix="/api/v1/patients", tags=["patients"])


@router.post("/", response_model=PatientResponse)
async def create_patient(user_id: str, patient: PatientCreate):
    """Create a new patient"""
    try:
        use_case = CreatePatientUseCase(patient_repository)
        result = await use_case.execute(
            user_id=user_id,
            age=patient.age,
            weight=patient.weight,
            height=patient.height,
            medical_history=patient.medical_history,
        )
        return result
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))


@router.get("/{patient_id}", response_model=PatientResponse)
async def get_patient(patient_id: str):
    """Get patient by ID"""
    try:
        use_case = GetPatientUseCase(patient_repository)
        result = await use_case.execute(patient_id)
        if not result:
            raise HTTPException(status_code=404, detail="Patient not found")
        return result
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))


@router.get("/user/{user_id}", response_model=PatientResponse)
async def get_patient_by_user(user_id: str):
    """Get patient by user ID"""
    try:
        use_case = GetPatientByUserUseCase(patient_repository)
        result = await use_case.execute(user_id)
        if not result:
            raise HTTPException(status_code=404, detail="Patient not found for this user")
        return result
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))
