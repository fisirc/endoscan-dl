import 'package:flutter/material.dart';

/// Estados posibles para las acciones de autenticación
enum AuthState {
  initial,
  loading,
  success,
  error,
}

/// ViewModel para la pantalla de Login (Patrón MVVM)
class LoginViewModel extends ChangeNotifier {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  AuthState _state = AuthState.initial;
  String _errorMessage = '';
  String _successMessage = '';
  bool _isPasswordVisible = false;

  // Getters
  AuthState get state => _state;
  String get errorMessage => _errorMessage;
  String get successMessage => _successMessage;
  bool get isPasswordVisible => _isPasswordVisible;
  bool get isLoading => _state == AuthState.loading;

  /// Alternar visibilidad de contraseña
  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  /// Simula un login (Aquí irán los use cases)
  Future<void> login() async {
    // Validar campos
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      _setError('Por favor completa todos los campos');
      return;
    }

    _setState(AuthState.loading);

    try {
      // Simulación de delay de API
      await Future.delayed(const Duration(seconds: 2));

      // Aquí iría la lógica de login real usando los use cases
      // await loginUseCase(emailController.text, passwordController.text);

      _setState(AuthState.success);
      _successMessage = 'Bienvenido de vuelta';
      
      // Limpiar contraseña por seguridad
      passwordController.clear();
    } catch (e) {
      _setError('Error al iniciar sesión: ${e.toString()}');
    }
  }

  /// Cambiar estado
  void _setState(AuthState newState) {
    _state = newState;
    notifyListeners();
  }

  /// Establecer error
  void _setError(String message) {
    _errorMessage = message;
    _state = AuthState.error;
    notifyListeners();
  }

  /// Limpiar error
  void clearError() {
    _errorMessage = '';
    _state = AuthState.initial;
    notifyListeners();
  }

  /// Limpiar éxito
  void clearSuccess() {
    _successMessage = '';
    _state = AuthState.initial;
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
