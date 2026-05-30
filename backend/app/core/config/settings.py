"""Application configuration"""
from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    """Application settings"""

    # Project
    project_name: str = "EndoScan API"
    project_version: str = "1.0.0"
    debug: bool = False

    # API
    api_v1_str: str = "/api/v1"
    backend_cors_origins: list = ["http://localhost", "http://localhost:3000", "http://localhost:8080"]

    # Security
    secret_key: str = "endoscan-secret-key-change-in-production"
    algorithm: str = "HS256"
    access_token_expire_minutes: int = 60 * 24  # 24 hours

    # Database
    database_url: str = "sqlite:///./test.db"

    class Config:
        env_file = ".env"
        case_sensitive = True


settings = Settings()
