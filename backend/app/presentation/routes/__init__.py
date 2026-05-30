"""Routes module"""
from .auth_routes import router as auth_router
from .patient_routes import router as patient_router
from .endoscopy_routes import router as endoscopy_router

__all__ = ["auth_router", "patient_router", "endoscopy_router"]
