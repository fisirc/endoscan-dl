"""Backend API Documentation"""

# EndoScan Backend API

Backend FastAPI implementation with Clean Architecture pattern.

## Estructura del Proyecto

```
backend/
├── app/
│   ├── core/              # Lógica compartida (config, excepciones, seguridad)
│   ├── domain/            # Capa de dominio (entidades, repositorios, casos de uso)
│   ├── data/              # Capa de datos (modelos, fuentes de datos, repositorios impl)
│   └── presentation/      # Capa de presentación (rutas, schemas)
├── main.py               # Punto de entrada de la aplicación
└── requirements.txt      # Dependencias del proyecto
```

## Capas de la Arquitectura

### 1. Core Layer
- **config**: Configuración de la aplicación (settings, variables de entorno)
- **exceptions**: Excepciones personalizadas
- **constants**: Constantes globales
- **security**: Servicios de seguridad (hashing, JWT)

### 2. Domain Layer
- **entities**: Modelos de dominio (User, Patient, Endoscopy)
- **repositories**: Interfaces de repositorio
- **usecases**: Casos de uso (lógica de negocio)

### 3. Data Layer
- **models**: Modelos de datos para persistencia
- **datasources**: Fuentes de datos (en memoria, BD, API, etc.)
- **repositories**: Implementaciones de repositorios

### 4. Presentation Layer
- **routes**: Rutas/endpoints de la API
- **schemas**: Schemas de Pydantic para validación

## Endpoints Disponibles

### Autenticación
- `POST /api/v1/auth/register` - Registrar nuevo usuario
- `POST /api/v1/auth/login` - Iniciar sesión
- `GET /api/v1/auth/me` - Obtener usuario actual

### Pacientes
- `POST /api/v1/patients/` - Crear nuevo paciente
- `GET /api/v1/patients/{patient_id}` - Obtener paciente por ID
- `GET /api/v1/patients/user/{user_id}` - Obtener paciente por ID de usuario

### Endoscopias
- `POST /api/v1/endoscopies/` - Crear nuevo registro de endoscopia
- `GET /api/v1/endoscopies/{endoscopy_id}` - Obtener endoscopia por ID
- `GET /api/v1/endoscopies/patient/{patient_id}` - Obtener endoscopias del paciente

## Para ejecutar

```bash
pip install -r requirements.txt
uvicorn main:app --reload
```

La API estará disponible en `http://localhost:8000`
Documentación interactiva en `http://localhost:8000/docs`
