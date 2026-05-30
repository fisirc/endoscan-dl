"""Data repositories module"""
from .repository_impl import UserRepositoryImpl, PatientRepositoryImpl, EndoscopyRepositoryImpl

__all__ = ["UserRepositoryImpl", "PatientRepositoryImpl", "EndoscopyRepositoryImpl"]
