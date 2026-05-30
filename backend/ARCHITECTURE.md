"""Backend Architecture Documentation"""

# Arquitectura del Backend - EndoScan

## Resumen Ejecutivo

Se ha desarrollado un backend FastAPI siguiendo los principios de **Clean Architecture**, dividiendo la aplicación en capas claramente definidas que permiten:

- ✅ Separación de responsabilidades
- ✅ Facilidad de testing
- ✅ Escalabilidad
- ✅ Mantenibilidad
- ✅ Independencia de frameworks

## Estructura de Capas

### 1. **Core Layer** (Núcleo de la aplicación)
**Ubicación:** `app/core/`

Contiene la lógica compartida y transversal de la aplicación:
- **config/**: Configuración centralizada (settings, variables de entorno)
- **constants/**: Constantes globales de la aplicación
- **exceptions/**: Excepciones personalizadas del negocio
- **security/**: Servicios de seguridad (hashing de contraseñas, JWT)

**Responsabilidad:** Proporcionar utilidades y configuraciones que se usan en toda la aplicación.

### 2. **Domain Layer** (Lógica de Negocio)
**Ubicación:** `app/domain/`

Define la lógica de negocio pura sin dependencias de frameworks:

- **entities/**: Modelos de dominio que representan conceptos del negocio
  - User (Usuario)
  - Patient (Paciente)
  - Endoscopy (Registro de Endoscopia)

- **repositories/**: Interfaces (abstracciones) que define cómo se accede a los datos
  - UserRepository
  - PatientRepository
  - EndoscopyRepository

- **usecases/**: Casos de uso que orquestan la lógica de negocio
  - RegisterUseCase, LoginUseCase, GetCurrentUserUseCase
  - CreatePatientUseCase, GetPatientUseCase
  - CreateEndoscopyUseCase, GetEndoscopyByPatientUseCase

**Responsabilidad:** Encapsular la lógica de negocio. Esta capa NO debe conocer de bases de datos, APIs ni frameworks.

### 3. **Data Layer** (Persistencia y Acceso a Datos)
**Ubicación:** `app/data/`

Implementa cómo se obtienen y almacenan los datos:

- **models/**: Modelos de datos para persistencia
  - UserModel, PatientModel, EndoscopyModel
  - (En el futuro serían modelos SQLAlchemy ORM)

- **datasources/**: Fuentes de datos que hacen el trabajo "sucio"
  - InMemoryUserDataSource (desarrollo)
  - InMemoryPatientDataSource (desarrollo)
  - InMemoryEndoscopyDataSource (desarrollo)
  - (En producción: DatabaseUserDataSource, etc.)

- **repositories/**: Implementaciones concretas de los repositorios abstractos
  - UserRepositoryImpl: Implementa UserRepository usando datasources
  - PatientRepositoryImpl: Implementa PatientRepository
  - EndoscopyRepositoryImpl: Implementa EndoscopyRepository

**Responsabilidad:** Concretar cómo se persisten los datos. Esta es la ÚNICA capa que sabe de bases de datos.

### 4. **Presentation Layer** (API y Comunicación)
**Ubicación:** `app/presentation/`

Define cómo se expone la API y valida entrada:

- **schemas/**: Schemas de Pydantic para validación de requests/responses
  - LoginRequest, RegisterRequest
  - UserResponse, PatientResponse, EndoscopyResponse

- **routes/**: Endpoints de la API FastAPI
  - auth_routes.py: `/auth/register`, `/auth/login`, `/auth/me`
  - patient_routes.py: `/patients/`, `/patients/{id}`, etc.
  - endoscopy_routes.py: `/endoscopies/`, `/endoscopies/{id}`, etc.

**Responsabilidad:** Exponer la API y validar datos de entrada/salida.

## Flujo de una Solicitud (Request)

```
Cliente (Flutter App)
        ↓
[Presentation - Route Handler]
        ↓ (Valida schema Pydantic)
[Use Case - Lógica de Negocio]
        ↓ (Orquesta la lógica)
[Repository - Abstracción]
        ↓ (Define el "qué")
[Repository Impl + DataSource]
        ↓ (Implementa el "cómo")
[En Memoria / Base de Datos]
        ↓
        ↑ (Retorna datos)
[Mapper - Entity]
        ↓ (Convierte a entidad de dominio)
[Use Case Response]
        ↓ (Resultado de negocio)
[Schema Response]
        ↓ (Serializa a JSON)
Cliente (Flutter App)
```

## Ventajas de esta Arquitectura

| Aspecto | Ventaja |
|--------|---------|
| **Testing** | Cada capa se puede testear independientemente |
| **Cambios** | Cambiar DB, API, etc. sin afectar la lógica de negocio |
| **Mantenibilidad** | Código organizado y responsabilidades claras |
| **Escalabilidad** | Fácil agregar nuevas features sin afectar las existentes |
| **Reusabilidad** | La lógica de negocio se puede reutilizar en diferentes contextos |

## Ejemplo: Flujo de Login

1. **Frontend** envía `POST /api/v1/auth/login` con email y password
2. **Route Handler** valida el schema con Pydantic
3. **LoginUseCase** se ejecuta:
   - Busca el usuario (llama al Repository)
   - Verifica la contraseña
   - Genera JWT
4. **UserRepository.get_by_email()** es llamado (abstracción)
5. **UserRepositoryImpl** usa **InMemoryUserDataSource** (en desarrollo)
6. Se retorna el usuario encontrado
7. **LoginUseCase** genera token y retorna `{id, email, full_name, token}`
8. **Route Handler** serializa a JSON y responde al cliente

## Cambios Futuros (Fáciles de hacer)

### Cambiar de En Memoria a Base de Datos
```python
# Hoy:
user_data_source = InMemoryUserDataSource()

# Mañana (muy fácil):
user_data_source = DatabaseUserDataSource(db_session)
# La lógica de negocio NO cambia
```

### Agregar una nueva feature (ej: Análisis de Imágenes)
1. Crear entidad en Domain: `Analysis`
2. Crear repositorio abstracto: `AnalysisRepository`
3. Crear use cases: `CreateAnalysisUseCase`, `GetAnalysisUseCase`
4. Implementar en Data: `AnalysisRepositoryImpl`
5. Crear datasource
6. Crear routes en Presentation
7. ¡Listo! El resto del código sigue funcionando

## Modelos de ML (Futuro)

Se ha diseñado la arquitectura pensando en integrar modelos de ML:
- Los use cases de Endoscopy pueden ser extendidos para llamar a un servicio de análisis
- Se podría crear una capa separada para ML (ej: `app/ml/`) que sea invocada desde los use cases
- Los resultados del ML se almacenarían como parte de la Endoscopy

Ejemplo futuro:
```python
class AnalyzeEndoscopyUseCase:
    async def execute(self, endoscopy_id: str):
        endoscopy = await self.get_endoscopy(endoscopy_id)
        # Llamar al modelo ML
        analysis_result = await self.ml_service.analyze(endoscopy.image_path)
        # Guardar resultado
        return analysis_result
```

## Conclusión

Esta arquitectura proporciona una base sólida y profesional para desarrollar EndoScan, permitiendo:
- Rápido prototipado inicial (con datos en memoria)
- Transición suave a base de datos real
- Integración futura de modelos de ML
- Facilidad de testing y mantenimiento
