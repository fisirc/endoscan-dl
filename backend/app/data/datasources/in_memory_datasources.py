"""In-memory data sources for development"""
from typing import Optional, List
from app.data.models import UserModel, PatientModel, EndoscopyModel


class InMemoryUserDataSource:
    """In-memory user data source for development"""

    def __init__(self):
        self.users: dict[str, UserModel] = {}

    async def create(self, user: UserModel) -> UserModel:
        self.users[user.id] = user
        return user

    async def get_by_id(self, user_id: str) -> Optional[UserModel]:
        return self.users.get(user_id)

    async def get_by_email(self, email: str) -> Optional[UserModel]:
        for user in self.users.values():
            if user.email == email:
                return user
        return None

    async def get_all(self, skip: int = 0, limit: int = 10) -> List[UserModel]:
        users_list = list(self.users.values())
        return users_list[skip : skip + limit]

    async def update(self, user_id: str, user: UserModel) -> Optional[UserModel]:
        if user_id in self.users:
            self.users[user_id] = user
            return user
        return None

    async def delete(self, user_id: str) -> bool:
        if user_id in self.users:
            del self.users[user_id]
            return True
        return False


class InMemoryPatientDataSource:
    """In-memory patient data source for development"""

    def __init__(self):
        self.patients: dict[str, PatientModel] = {}

    async def create(self, patient: PatientModel) -> PatientModel:
        self.patients[patient.id] = patient
        return patient

    async def get_by_id(self, patient_id: str) -> Optional[PatientModel]:
        return self.patients.get(patient_id)

    async def get_by_user_id(self, user_id: str) -> Optional[PatientModel]:
        for patient in self.patients.values():
            if patient.user_id == user_id:
                return patient
        return None

    async def get_all(self, skip: int = 0, limit: int = 10) -> List[PatientModel]:
        patients_list = list(self.patients.values())
        return patients_list[skip : skip + limit]

    async def update(self, patient_id: str, patient: PatientModel) -> Optional[PatientModel]:
        if patient_id in self.patients:
            self.patients[patient_id] = patient
            return patient
        return None

    async def delete(self, patient_id: str) -> bool:
        if patient_id in self.patients:
            del self.patients[patient_id]
            return True
        return False


class InMemoryEndoscopyDataSource:
    """In-memory endoscopy data source for development"""

    def __init__(self):
        self.endoscopies: dict[str, EndoscopyModel] = {}

    async def create(self, endoscopy: EndoscopyModel) -> EndoscopyModel:
        self.endoscopies[endoscopy.id] = endoscopy
        return endoscopy

    async def get_by_id(self, endoscopy_id: str) -> Optional[EndoscopyModel]:
        return self.endoscopies.get(endoscopy_id)

    async def get_by_patient_id(self, patient_id: str, skip: int = 0, limit: int = 10) -> List[EndoscopyModel]:
        results = [e for e in self.endoscopies.values() if e.patient_id == patient_id]
        return results[skip : skip + limit]

    async def get_all(self, skip: int = 0, limit: int = 10) -> List[EndoscopyModel]:
        endoscopies_list = list(self.endoscopies.values())
        return endoscopies_list[skip : skip + limit]

    async def update(self, endoscopy_id: str, endoscopy: EndoscopyModel) -> Optional[EndoscopyModel]:
        if endoscopy_id in self.endoscopies:
            self.endoscopies[endoscopy_id] = endoscopy
            return endoscopy
        return None

    async def delete(self, endoscopy_id: str) -> bool:
        if endoscopy_id in self.endoscopies:
            del self.endoscopies[endoscopy_id]
            return True
        return False
