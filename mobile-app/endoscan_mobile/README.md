# EndoScan Mobile - App Flutter

## Inicio Rápido

### Requisitos
- Flutter 3.11+ ([Descargar](https://flutter.dev/docs/get-started/install))
- Dart 3.11+
- Android SDK / Xcode (para compilar en dispositivos reales)

### Instalación

1. **Navegar al directorio del proyecto**:
   ```bash
   cd mobile-app/endoscan_mobile
   ```

2. **Instalar dependencias**:
   ```bash
   flutter pub get
   ```

3. **Ejecutar la aplicación**:
   ```bash
   flutter run
   ```

### Arquitectura MVVM

Esta aplicación sigue una arquitectura limpia con patrón **MVVM (Model-View-ViewModel)**:

```
Domain Layer       → Lógica de negocio pura (Use Cases, Entities)
   ↓
Data Layer        → Acceso a datos (Repositories, Data Sources)
   ↓
Presentation Layer → UI y ViewModels (MVVM)
```

**Lee** `ARCHITECTURE.md` para más detalles sobre la estructura.

## 📁 Estructura del Proyecto

```
lib/
├── main.dart                    # Punto de entrada
├── app/
│   └── service_locator.dart    # Inyección de dependencias
├── core/
│   ├── constants/              # Constantes globales
│   ├── theme/                  # Tema y estilos
│   └── utils/                  # Validadores, utilidades
└── features/
    └── auth/                   # Feature de autenticación
        ├── data/               # Data sources, models, repositories
        ├── domain/             # Entities, repositories abs, use cases
        └── presentation/       # Pages, ViewModels, Widgets
```

## 🎯 Funcionalidades Actuales

✅ Pantalla de Login
- Validación de campos (email, contraseña)
- Estado de carga
- Manejo de errores y éxito
- Visibilidad de contraseña
- Diseño responsivo inspirado en la UI proporcionada

## 🔧 Desarrollo

### Agregar una nueva Feature

1. **Crear carpetas** en `lib/features/{feature_name}/`
2. **Implementar Domain Layer** (entities, repositories, use cases)
3. **Implementar Data Layer** (models, data sources, repository impl)
4. **Implementar Presentation Layer** (pages, viewmodels, widgets)
5. **Registrar en ServiceLocator** las dependencias

### Comandos Útiles

```bash
# Análisis estático
flutter analyze

# Formatear código
dart format lib/

# Linter personalizado
flutter analyze

# Construcción para producción (Android)
flutter build apk --release

# Construcción para producción (iOS)
flutter build ios --release
```

## 📦 Dependencias Principales

| Paquete | Propósito |
|---------|-----------|
| `provider` | State management (MVVM) |
| `dio` | HTTP client para APIs |
| `shared_preferences` | Almacenamiento local |
| `email_validator` | Validación de emails |
| `google_fonts` | Tipografías personalizadas |

## 🎨 Tema y Estilos

- Tema centralizado en `core/theme/app_theme.dart`
- Colores primarios/secundarios definidos
- Tipografía con Google Fonts (Poppins)
- Material Design 3 compatible

## 🔐 Seguridad

- Tokens guardados de forma segura en SharedPreferences
- Validación de entrada en todos los formularios
- Manejo de errores de red

## 📱 Dimensiones Soportadas

- Mobile (iOS/Android)
- Responsive design

## 🧪 Testing

Tests se agregarán en la carpeta `test/` (próximamente)

```bash
flutter test
```

## 🐛 Debugging

```bash
# Modo debug
flutter run

# Con logs
flutter run -v

# Devtools
flutter pub global activate devtools
devtools
```
