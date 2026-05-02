# EndoScan Mobile - Arquitectura Flutter

## 📱 Visión General

Esta es la aplicación móvil para EndoScan, desarrollada con **Flutter** utilizando la arquitectura **MVVM (Model-View-ViewModel)** desde el inicio.

## 🏗️ Estructura de Carpetas

```
lib/
├── main.dart                 # Punto de entrada de la app
├── app/
│   └── service_locator.dart # Inyección de dependencias (DI)
├── core/
│   ├── constants/
│   │   └── app_constants.dart    # Constantes globales
│   ├── theme/
│   │   └── app_theme.dart        # Tema y estilos globales
│   └── utils/
│       └── validators.dart       # Utilidades de validación
└── features/
    └── auth/
        ├── data/
        │   ├── datasources/
        │   │   ├── auth_remote_datasource.dart    # API calls
        │   │   └── auth_local_datasource.dart     # Local storage
        │   ├── mappers/
        │   │   └── auth_mapper.dart               # Data → Domain conversion
        │   ├── models/
        │   │   └── auth_response_model.dart       # Data models
        │   └── repositories/
        │       └── auth_repository_impl.dart      # Repository implementation
        ├── domain/
        │   ├── entities/
        │   │   └── user.dart                      # Domain entities
        │   ├── repositories/
        │   │   └── auth_repository.dart           # Repository abstract
        │   └── usecases/
        │       └── auth_usecases.dart             # Business logic
        └── presentation/
            ├── pages/
            │   └── login_page.dart                # UI Pages
            ├── viewmodels/
            │   └── login_viewmodel.dart           # MVVM ViewModels
            └── widgets/
                ├── app_buttons.dart               # Custom widgets
                └── app_text_field.dart            # Custom widgets
```

## 🎯 Arquitectura MVVM (Model-View-ViewModel)

La arquitectura está dividida en **tres capas** siguiendo Clean Architecture:

### 1️⃣ **Data Layer** (`features/auth/data/`)
Responsable de la comunicación externa y almacenamiento local.

- **DataSources**: 
  - `AuthRemoteDataSource`: Llamadas a API (Dio)
  - `AuthLocalDataSource`: Almacenamiento local (SharedPreferences)

- **Models**: Representan la estructura de datos de la API
- **Repositories**: Implementan la lógica de obtención de datos
- **Mappers**: Convierten entre Models y Entities

### 2️⃣ **Domain Layer** (`features/auth/domain/`)
Contiene la lógica de negocio pura (sin dependencias de Flutter).

- **Entities**: Modelos de dominio (User, etc.)
- **Repositories** (Abstract): Contratos que la capa de datos debe implementar
- **UseCases**: Encapsulan la lógica de negocio (LoginUseCase, RegisterUseCase, etc.)

### 3️⃣ **Presentation Layer** (`features/auth/presentation/`)
Responsable de la UI y la interacción del usuario.

- **Pages**: Pantallas principales
- **ViewModels** (MVVM): Contienen el estado y lógica de presentación
  - Extienden `ChangeNotifier` para reactividad con Provider
  - Usan los UseCases de Domain
  - Exponen estado (`AuthState`) y métodos para la UI

- **Widgets**: Componentes reutilizables de UI

## 🔄 Flujo de Datos

```
UI (LoginPage)
    ↓
ViewModel (LoginViewModel)
    ↓
UseCases (LoginUseCase)
    ↓
Domain Repository (abstract)
    ↓
Data Repository (implementation)
    ↓
DataSources (Remote + Local)
    ↓
API / Local Storage
```

## 📦 Dependencias Principales

- **provider**: State management con MVVM
- **dio**: HTTP client para APIs
- **shared_preferences**: Almacenamiento local
- **email_validator**: Validación de emails
- **google_fonts**: Tipografías personalizadas

## 🚀 Cómo Ejecutar

1. **Instalar dependencias**:
   ```bash
   flutter pub get
   ```

2. **Ejecutar la app**:
   ```bash
   flutter run
   ```

3. **Generar APK/IPA**:
   ```bash
   flutter build apk        # Android
   flutter build ios        # iOS
   ```

## 📝 Convenciones de Código

- **Nombres de archivos**: `snake_case`
- **Nombres de clases**: `PascalCase`
- **Nombres de métodos/variables**: `camelCase`
- **Constantes**: `UPPER_CASE` o como variables estáticas
- **Imports**: Ordenados alfabéticamente, primero `dart:`, luego `package:`, luego relativos

## 🔐 Manejo de Autenticación

El flujo de autenticación implementa:
- ✅ Validación de campos (email, contraseña)
- ✅ Llamadas a API
- ✅ Almacenamiento seguro de tokens
- ✅ Manejo de errores
- ✅ Estados de carga

## 🎨 Tema y Estilos

El tema está centralizado en `core/theme/app_theme.dart`:
- Colores primarios y secundarios
- Tipografía con Google Fonts
- TextTheme personalizado
- Input decorations

## 🔗 Cómo Agregar Nuevas Funcionalidades

1. **Crear nueva feature** en `lib/features/`
2. **Crear carpetas**: `data/`, `domain/`, `presentation/`
3. **Implementar en orden**:
   - Domain Entities
   - Domain Repositories (abstract)
   - Domain UseCases
   - Data Models y DataSources
   - Data Repository (implementation)
   - Presentation ViewModel
   - Presentation Page

4. **Registrar en ServiceLocator** las dependencias necesarias

