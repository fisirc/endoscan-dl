"""Repository implementations"""
from typing import Optional, List
from app.domain.entities import User, Patient, Endoscopy
from app.domain.repositories import UserRepository, PatientRepository, EndoscopyRepository
from app.data.models import UserModel, PatientModel, EndoscopyModel
from app.data.datasources import InMemoryUserDataSource, InMemoryPatientDataSource, InMemoryEndoscopyDataSource


class UserRepositoryImpl(UserRepository):
    """User repository implementation"""

    def __init__(self, data_source: InMemoryUserDataSource):
        self.data_source = data_source

    async def create(self, user: User) -> User:
        model = UserModel(
            email=user.email,
            full_name=user.full_name,
            hashed_password=user.hashed_password,
            is_active=user.is_active,
        )
        created = await self.data_source.create(model)
        return User(
            id=created.id,
            email=created.email,
            full_name=created.full_name,
            hashed_password=created.hashed_password,
            is_active=created.is_active,
            created_at=created.created_at,
            updated_at=created.updated_at,
        )

    async def get_by_id(self, user_id: str) -> Optional[User]:
        model = await self.data_source.get_by_id(user_id)
        if not model:
            return None
        return User(
            id=model.id,
            email=model.email,
            full_name=model.full_name,
            hashed_password=model.hashed_password,
            is_active=model.is_active,
            created_at=model.created_at,
            updated_at=model.updated_at,
        )

    async def get_by_email(self, email: str) -> Optional[User]:
        model = await self.data_source.get_by_email(email)
        if not model:
            return None
        return User(
            id=model.id,
            email=model.email,
            full_name=model.full_name,
            hashed_password=model.hashed_password,
            is_active=model.is_active,
            created_at=model.created_at,
            updated_at=model.updated_at,
        )

    async def get_all(self, skip: int = 0, limit: int = 10) -> List[User]:
        models = await self.data_source.get_all(skip, limit)
        return [
            User(
                id=m.id,
                email=m.email,
                full_name=m.full_name,
                hashed_password=m.hashed_password,
                is_active=m.is_active,
                created_at=m.created_at,
                updated_at=m.updated_at,
            )
            for m in models
        ]

    async def update(self, user_id: str, user: User) -> Optional[User]:
        model = UserModel(
            id=user_id,
            email=user.email,
            full_name=user.full_name,
            hashed_password=user.hashed_password,
            is_active=user.is_active,
            created_at=user.created_at,
            updated_at=user.updated_at,
        )
        updated = await self.data_source.update(user_id, model)
        if not updated:
            return None
        return User(
            id=updated.id,
            email=updated.email,
            full_name=updated.full_name,
            hashed_password=updated.hashed_password,
            is_active=updated.is_active,
            created_at=updated.created_at,
            updated_at=updated.updated_at,
        )

    async def delete(self, user_id: str) -> bool:
        return await self.data_source.delete(user_id)


class PatientRepositoryImpl(PatientRepository):
    """Patient repository implementation"""

    def __init__(self, data_source: InMemoryPatientDataSource):
        self.data_source = data_source

    async def create(self, patient: Patient) -> Patient:
        model = PatientModel(
            user_id=patient.user_id,
            age=patient.age,
            weight=patient.weight,
            height=patient.height,
            medical_history=patient.medical_history,
        )
        created = await self.data_source.create(model)
        return Patient(
            id=created.id,
            user_id=created.user_id,
            age=created.age,
            weight=created.weight,
            height=created.height,
            medical_history=created.medical_history,
            created_at=created.created_at,
            updated_at=created.updated_at,
        )

    async def get_by_id(self, patient_id: str) -> Optional[Patient]:
        model = await self.data_source.get_by_id(patient_id)
        if not model:
            return None
        return Patient(
            id=model.id,
            user_id=model.user_id,
            age=model.age,
            weight=model.weight,
            height=model.height,
            medical_history=model.medical_history,
            created_at=model.created_at,
            updated_at=model.updated_at,
        )

    async def get_by_user_id(self, user_id: str) -> Optional[Patient]:
        model = await self.data_source.get_by_user_id(user_id)
        if not model:
            return None
        return Patient(
            id=model.id,
            user_id=model.user_id,
            age=model.age,
            weight=model.weight,
            height=model.height,
            medical_history=model.medical_history,
            created_at=model.created_at,
            updated_at=model.updated_at,
        )

    async def get_all(self, skip: int = 0, limit: int = 10) -> List[Patient]:
        models = await self.data_source.get_all(skip, limit)
        return [
            Patient(
                id=m.id,
                user_id=m.user_id,
                age=m.age,
                weight=m.weight,
                height=m.height,
                medical_history=m.medical_history,
                created_at=m.created_at,
                updated_at=m.updated_at,
            )
            for m in models
        ]

    async def update(self, patient_id: str, patient: Patient) -> Optional[Patient]:
        model = PatientModel(
            id=patient_id,
            user_id=patient.user_id,
            age=patient.age,
            weight=patient.weight,
            height=patient.height,
            medical_history=patient.medical_history,
            created_at=patient.created_at,
            updated_at=patient.updated_at,
        )
        updated = await self.data_source.update(patient_id, model)
        if not updated:
            return None
        return Patient(
            id=updated.id,
            user_id=updated.user_id,
            age=updated.age,
            weight=updated.weight,
            height=updated.height,
            medical_history=updated.medical_history,
            created_at=updated.created_at,
            updated_at=updated.updated_at,
        )

    async def delete(self, patient_id: str) -> bool:
        return await self.data_source.delete(patient_id)


class EndoscopyRepositoryImpl(EndoscopyRepository):
    """Endoscopy repository implementation"""

    def __init__(self, data_source: InMemoryEndoscopyDataSource):
        self.data_source = data_source

    async def create(self, endoscopy: Endoscopy) -> Endoscopy:
        model = EndoscopyModel(
            patient_id=endoscopy.patient_id,
            findings=endoscopy.findings,
            risk_level=endoscopy.risk_level,
            doctor_notes=endoscopy.doctor_notes,
            image_path=endoscopy.image_path,
        )
        created = await self.data_source.create(model)
        return Endoscopy(
            id=created.id,
            patient_id=created.patient_id,
            findings=created.findings,
            risk_level=created.risk_level,
            doctor_notes=created.doctor_notes,
            image_path=created.image_path,
            date=created.date,
            created_at=created.created_at,
            updated_at=created.updated_at,
        )

    async def get_by_id(self, endoscopy_id: str) -> Optional[Endoscopy]:
        model = await self.data_source.get_by_id(endoscopy_id)
        if not model:
            return None
        return Endoscopy(
            id=model.id,
            patient_id=model.patient_id,
            findings=model.findings,
            risk_level=model.risk_level,
            doctor_notes=model.doctor_notes,
            image_path=model.image_path,
            date=model.date,
            created_at=model.created_at,
            updated_at=model.updated_at,
        )

    async def get_by_patient_id(self, patient_id: str, skip: int = 0, limit: int = 10) -> List[Endoscopy]:
        models = await self.data_source.get_by_patient_id(patient_id, skip, limit)
        return [
            Endoscopy(
                id=m.id,
                patient_id=m.patient_id,
                findings=m.findings,
                risk_level=m.risk_level,
                doctor_notes=m.doctor_notes,
                image_path=m.image_path,
                date=m.date,
                created_at=m.created_at,
                updated_at=m.updated_at,
            )
            for m in models
        ]

    async def get_all(self, skip: int = 0, limit: int = 10) -> List[Endoscopy]:
        models = await self.data_source.get_all(skip, limit)
        return [
            Endoscopy(
                id=m.id,
                patient_id=m.patient_id,
                findings=m.findings,
                risk_level=m.risk_level,
                doctor_notes=m.doctor_notes,
                image_path=m.image_path,
                date=m.date,
                created_at=m.created_at,
                updated_at=m.updated_at,
            )
            for m in models
        ]

    async def update(self, endoscopy_id: str, endoscopy: Endoscopy) -> Optional[Endoscopy]:
        model = EndoscopyModel(
            id=endoscopy_id,
            patient_id=endoscopy.patient_id,
            findings=endoscopy.findings,
            risk_level=endoscopy.risk_level,
            doctor_notes=endoscopy.doctor_notes,
            image_path=endoscopy.image_path,
            date=endoscopy.date,
            created_at=endoscopy.created_at,
            updated_at=endoscopy.updated_at,
        )
        updated = await self.data_source.update(endoscopy_id, model)
        if not updated:
            return None
        return Endoscopy(
            id=updated.id,
            patient_id=updated.patient_id,
            findings=updated.findings,
            risk_level=updated.risk_level,
            doctor_notes=updated.doctor_notes,
            image_path=updated.image_path,
            date=updated.date,
            created_at=updated.created_at,
            updated_at=updated.updated_at,
        )

    async def delete(self, endoscopy_id: str) -> bool:
        return await self.data_source.delete(endoscopy_id)
