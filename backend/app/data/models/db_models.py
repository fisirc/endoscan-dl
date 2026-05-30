"""Data models for database"""
from datetime import datetime
from typing import Optional
import uuid


class UserModel:
    """User database model"""

    def __init__(
        self,
        email: str,
        full_name: str,
        hashed_password: str,
        is_active: bool = True,
        id: Optional[str] = None,
        created_at: Optional[datetime] = None,
        updated_at: Optional[datetime] = None,
    ):
        self.id = id or str(uuid.uuid4())
        self.email = email
        self.full_name = full_name
        self.hashed_password = hashed_password
        self.is_active = is_active
        self.created_at = created_at or datetime.utcnow()
        self.updated_at = updated_at or datetime.utcnow()


class PatientModel:
    """Patient database model"""

    def __init__(
        self,
        user_id: str,
        age: int,
        weight: float,
        height: float,
        medical_history: str = "",
        id: Optional[str] = None,
        created_at: Optional[datetime] = None,
        updated_at: Optional[datetime] = None,
    ):
        self.id = id or str(uuid.uuid4())
        self.user_id = user_id
        self.age = age
        self.weight = weight
        self.height = height
        self.medical_history = medical_history
        self.created_at = created_at or datetime.utcnow()
        self.updated_at = updated_at or datetime.utcnow()


class EndoscopyModel:
    """Endoscopy database model"""

    def __init__(
        self,
        patient_id: str,
        findings: str,
        risk_level: str = "bajo",
        doctor_notes: str = "",
        image_path: Optional[str] = None,
        id: Optional[str] = None,
        date: Optional[datetime] = None,
        created_at: Optional[datetime] = None,
        updated_at: Optional[datetime] = None,
    ):
        self.id = id or str(uuid.uuid4())
        self.patient_id = patient_id
        self.findings = findings
        self.risk_level = risk_level
        self.doctor_notes = doctor_notes
        self.image_path = image_path
        self.date = date or datetime.utcnow()
        self.created_at = created_at or datetime.utcnow()
        self.updated_at = updated_at or datetime.utcnow()
