import 'package:email_validator/email_validator.dart';

/// Utilidades para validación de datos
class AppValidators {
  /// Valida un email
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'El email es requerido';
    }
    if (!EmailValidator.validate(value)) {
      return 'Por favor ingresa un email válido';
    }
    return null;
  }

  /// Valida una contraseña
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'La contraseña es requerida';
    }
    if (value.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres';
    }
    return null;
  }

  /// Valida que las contraseñas coincidan
  static String? validatePasswordMatch(
    String? password,
    String? confirmPassword,
  ) {
    if (password != confirmPassword) {
      return 'Las contraseñas no coinciden';
    }
    return null;
  }

  /// Valida un campo no vacío
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName es requerido';
    }
    return null;
  }

  /// Valida un teléfono
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'El teléfono es requerido';
    }
    if (!RegExp(
      r'^[0-9]{7,15}$',
    ).hasMatch(value.replaceAll(RegExp(r'[^0-9]'), ''))) {
      return 'Por favor ingresa un teléfono válido';
    }
    return null;
  }

  /// Valida un DNI/Cédula
  static String? validateDNI(String? value) {
    if (value == null || value.isEmpty) {
      return 'El DNI es requerido';
    }
    if (!RegExp(
      r'^[0-9]{6,10}$',
    ).hasMatch(value.replaceAll(RegExp(r'[^0-9]'), ''))) {
      return 'Por favor ingresa un DNI válido';
    }
    return null;
  }
}
