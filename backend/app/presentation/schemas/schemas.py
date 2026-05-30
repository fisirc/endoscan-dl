"""Pydantic schemas for API requests and responses"""
from pydantic import BaseModel, EmailStr
from typing import Optional
from datetime import datetime


class UserBase(BaseModel):
    """Base user schema"""

    email: EmailStr
    full_name: str


class UserCreate(UserBase):
    """User creation schema"""

    password: str


class UserResponse(UserBase):
    """User response schema"""

    id: str
    is_active: bool
    created_at: datetime
    updated_at: datetime

    class Config:
        from_attributes = True


class UserLoginResponse(BaseModel):
    """User login response schema"""

    id: str
    email: str
    full_name: str
    token: str


class PatientBase(BaseModel):
    """Base patient schema"""

    age: int
    weight: float
    height: float
    medical_history: str = ""


class PatientCreate(PatientBase):
    """Patient creation schema"""

    pass


class PatientResponse(PatientBase):
    """Patient response schema"""

    id: str
    user_id: str
    created_at: datetime
    updated_at: datetime

    class Config:
        from_attributes = True


class EndoscopyBase(BaseModel):
    """Base endoscopy schema"""

    findings: str
    risk_level: str = "bajo"
    doctor_notes: str = ""
    image_path: Optional[str] = None


class EndoscopyCreate(EndoscopyBase):
    """Endoscopy creation schema"""

    pass


class EndoscopyResponse(EndoscopyBase):
    """Endoscopy response schema"""

    id: str
    patient_id: str
    date: datetime
    created_at: datetime
    updated_at: datetime

    class Config:
        from_attributes = True


class LoginRequest(BaseModel):
    """Login request schema"""

    email: str
    password: str


class RegisterRequest(BaseModel):
    """Register request schema"""

    email: str
    password: str
    full_name: str
