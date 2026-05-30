"""Main FastAPI application"""
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.core.config import settings
from app.presentation.routes import auth_router, patient_router, endoscopy_router

# Create FastAPI app
app = FastAPI(
    title=settings.project_name,
    version=settings.project_version,
    debug=settings.debug,
)

# Add CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.backend_cors_origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Include routers
app.include_router(auth_router)
app.include_router(patient_router)
app.include_router(endoscopy_router)


@app.get("/")
async def root():
    """Root endpoint"""
    return {
        "message": "Welcome to EndoScan API",
        "version": settings.project_version,
        "docs": "/docs",
    }


@app.get("/health")
async def health_check():
    """Health check endpoint"""
    return {"status": "healthy"}
