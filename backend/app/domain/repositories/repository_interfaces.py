"""Domain repositories - abstract interfaces"""
from abc import ABC, abstractmethod
from typing import Optional, List
from app.domain.entities import User, Patient, Endoscopy


class UserRepository(ABC):
    """Abstract user repository"""

    @abstractmethod
    async def create(self, user: User) -> User:
        """Create a new user"""
        pass

    @abstractmethod
    async def get_by_id(self, user_id: str) -> Optional[User]:
        """Get user by ID"""
        pass

    @abstractmethod
    async def get_by_email(self, email: str) -> Optional[User]:
        """Get user by email"""
        pass

    @abstractmethod
    async def get_all(self, skip: int = 0, limit: int = 10) -> List[User]:
        """Get all users with pagination"""
        pass

    @abstractmethod
    async def update(self, user_id: str, user: User) -> Optional[User]:
        """Update user"""
        pass

    @abstractmethod
    async def delete(self, user_id: str) -> bool:
        """Delete user"""
        pass


class PatientRepository(ABC):
    """Abstract patient repository"""

    @abstractmethod
    async def create(self, patient: Patient) -> Patient:
        """Create a new patient"""
        pass

    @abstractmethod
    async def get_by_id(self, patient_id: str) -> Optional[Patient]:
        """Get patient by ID"""
        pass

    @abstractmethod
    async def get_by_user_id(self, user_id: str) -> Optional[Patient]:
        """Get patient by user ID"""
        pass

    @abstractmethod
    async def get_all(self, skip: int = 0, limit: int = 10) -> List[Patient]:
        """Get all patients"""
        pass

    @abstractmethod
    async def update(self, patient_id: str, patient: Patient) -> Optional[Patient]:
        """Update patient"""
        pass

    @abstractmethod
    async def delete(self, patient_id: str) -> bool:
        """Delete patient"""
        pass


class EndoscopyRepository(ABC):
    """Abstract endoscopy repository"""

    @abstractmethod
    async def create(self, endoscopy: Endoscopy) -> Endoscopy:
        """Create a new endoscopy record"""
        pass

    @abstractmethod
    async def get_by_id(self, endoscopy_id: str) -> Optional[Endoscopy]:
        """Get endoscopy by ID"""
        pass

    @abstractmethod
    async def get_by_patient_id(self, patient_id: str, skip: int = 0, limit: int = 10) -> List[Endoscopy]:
        """Get endoscopies by patient ID"""
        pass

    @abstractmethod
    async def get_all(self, skip: int = 0, limit: int = 10) -> List[Endoscopy]:
        """Get all endoscopies"""
        pass

    @abstractmethod
    async def update(self, endoscopy_id: str, endoscopy: Endoscopy) -> Optional[Endoscopy]:
        """Update endoscopy"""
        pass

    @abstractmethod
    async def delete(self, endoscopy_id: str) -> bool:
        """Delete endoscopy"""
        pass
