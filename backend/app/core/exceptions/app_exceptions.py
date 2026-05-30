"""Application-wide custom exceptions"""


class AppException(Exception):
    """Base exception for the application"""

    def __init__(self, message: str, status_code: int = 400):
        self.message = message
        self.status_code = status_code
        super().__init__(self.message)


class AuthenticationException(AppException):
    """Raised when authentication fails"""

    def __init__(self, message: str = "Credenciales inválidas"):
        super().__init__(message, status_code=401)


class ValidationException(AppException):
    """Raised when validation fails"""

    def __init__(self, message: str = "Error de validación"):
        super().__init__(message, status_code=422)


class NotFoundException(AppException):
    """Raised when a resource is not found"""

    def __init__(self, resource: str = "Recurso"):
        message = f"{resource} no encontrado"
        super().__init__(message, status_code=404)


class ConflictException(AppException):
    """Raised when there is a conflict (e.g., duplicate email)"""

    def __init__(self, message: str = "Conflicto en los datos"):
        super().__init__(message, status_code=409)
