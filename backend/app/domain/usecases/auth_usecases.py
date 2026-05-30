"""Authentication use cases"""
from typing import Optional
from app.domain.entities import User
from app.domain.repositories import UserRepository
from app.core.exceptions import AuthenticationException, ConflictException, ValidationException
from app.core.security import SecurityService


class RegisterUseCase:
    """Use case for user registration"""

    def __init__(self, user_repository: UserRepository, security_service: SecurityService):
        self.user_repository = user_repository
        self.security_service = security_service

    async def execute(self, email: str, password: str, full_name: str) -> dict:
        """
        Register a new user
        
        Args:
            email: User email
            password: User password
            full_name: User full name
            
        Returns:
            Dictionary with user info and access token
        """
        # Validate email format
        if not email or "@" not in email:
            raise ValidationException("Email inválido")

        # Validate password strength
        if len(password) < 6:
            raise ValidationException("La contraseña debe tener al menos 6 caracteres")

        # Check if email already exists
        existing_user = await self.user_repository.get_by_email(email)
        if existing_user:
            raise ConflictException("El email ya está registrado")

        # Create new user
        hashed_password = self.security_service.hash_password(password)
        user = User(
            email=email,
            full_name=full_name,
            hashed_password=hashed_password,
            is_active=True,
        )

        created_user = await self.user_repository.create(user)

        # Generate token
        access_token = self.security_service.create_access_token({"sub": created_user.email})

        return {
            "id": created_user.id,
            "email": created_user.email,
            "full_name": created_user.full_name,
            "token": access_token,
        }


class LoginUseCase:
    """Use case for user login"""

    def __init__(self, user_repository: UserRepository, security_service: SecurityService):
        self.user_repository = user_repository
        self.security_service = security_service

    async def execute(self, email: str, password: str) -> dict:
        """
        Login user
        
        Args:
            email: User email
            password: User password
            
        Returns:
            Dictionary with user info and access token
        """
        # Find user by email
        user = await self.user_repository.get_by_email(email)
        if not user:
            raise AuthenticationException("Credenciales inválidas")

        # Verify password
        if not self.security_service.verify_password(password, user.hashed_password):
            raise AuthenticationException("Credenciales inválidas")

        # Check if user is active
        if not user.is_active:
            raise AuthenticationException("Usuario inactivo")

        # Generate token
        access_token = self.security_service.create_access_token({"sub": user.email})

        return {
            "id": user.id,
            "email": user.email,
            "full_name": user.full_name,
            "token": access_token,
        }


class GetCurrentUserUseCase:
    """Use case to get current authenticated user"""

    def __init__(self, user_repository: UserRepository):
        self.user_repository = user_repository

    async def execute(self, user_email: str) -> Optional[dict]:
        """
        Get current user
        
        Args:
            user_email: User email from token
            
        Returns:
            User info or None
        """
        user = await self.user_repository.get_by_email(user_email)
        if not user:
            return None

        return {
            "id": user.id,
            "email": user.email,
            "full_name": user.full_name,
        }
