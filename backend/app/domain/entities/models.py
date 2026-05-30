"""Domain entities"""
from dataclasses import dataclass
from datetime import datetime
from typing import Optional


@dataclass
class User:
    """User entity"""

    id: Optional[str] = None
    email: str = ""
    full_name: str = ""
    hashed_password: str = ""
    is_active: bool = True
    created_at: Optional[datetime] = None
    updated_at: Optional[datetime] = None

    def __post_init__(self):
        if self.created_at is None:
            self.created_at = datetime.utcnow()
        if self.updated_at is None:
            self.updated_at = datetime.utcnow()


@dataclass
class Patient:
    """Patient entity"""

    id: Optional[str] = None
    user_id: str = ""
    age: int = 0
    weight: float = 0.0
    height: float = 0.0
    medical_history: str = ""
    created_at: Optional[datetime] = None
    updated_at: Optional[datetime] = None


@dataclass
class Endoscopy:
    """Endoscopy record entity"""

    id: Optional[str] = None
    patient_id: str = ""
    date: datetime = None
    findings: str = ""
    risk_level: str = "bajo"  # bajo, medio, alto
    doctor_notes: str = ""
    image_path: Optional[str] = None
    created_at: Optional[datetime] = None
    updated_at: Optional[datetime] = None
