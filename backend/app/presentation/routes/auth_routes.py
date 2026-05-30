"""Authentication routes"""
from fastapi import APIRouter, HTTPException, Depends
from app.presentation.schemas import LoginRequest, RegisterRequest, UserLoginResponse
from app.domain.usecases import RegisterUseCase, LoginUseCase, GetCurrentUserUseCase
from app.data.datasources import InMemoryUserDataSource
from app.data.repositories import UserRepositoryImpl
from app.core.security import SecurityService
from app.core.config import settings

# Initialize dependencies
user_data_source = InMemoryUserDataSource()
user_repository = UserRepositoryImpl(user_data_source)
security_service = SecurityService(settings.secret_key, settings.algorithm)

router = APIRouter(prefix="/api/v1/auth", tags=["auth"])


@router.post("/register", response_model=UserLoginResponse)
async def register(request: RegisterRequest):
    """Register a new user"""
    try:
        use_case = RegisterUseCase(user_repository, security_service)
        result = await use_case.execute(request.email, request.password, request.full_name)
        return UserLoginResponse(**result)
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))


@router.post("/login", response_model=UserLoginResponse)
async def login(request: LoginRequest):
    """Login user"""
    try:
        use_case = LoginUseCase(user_repository, security_service)
        result = await use_case.execute(request.email, request.password)
        return UserLoginResponse(**result)
    except Exception as e:
        raise HTTPException(status_code=401, detail=str(e))


@router.get("/me")
async def get_current_user(token: str):
    """Get current authenticated user"""
    try:
        payload = security_service.decode_token(token)
        if not payload:
            raise HTTPException(status_code=401, detail="Invalid token")
        
        user_email = payload.get("sub")
        use_case = GetCurrentUserUseCase(user_repository)
        result = await use_case.execute(user_email)
        
        if not result:
            raise HTTPException(status_code=404, detail="User not found")
        
        return result
    except Exception as e:
        raise HTTPException(status_code=401, detail=str(e))
