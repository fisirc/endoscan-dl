import 'package:flutter/material.dart';

/// Estados posibles para las acciones de autenticación
enum AuthState { initial, loading, success, error }

/// ViewModel para la pantalla de Registro (Patrón MVVM)
class RegisterViewModel extends ChangeNotifier {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final dniController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  AuthState _state = AuthState.initial;
  String _errorMessage = '';
  String _successMessage = '';
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  // Getters
  AuthState get state => _state;
  String get errorMessage => _errorMessage;
  String get successMessage => _successMessage;
  bool get isPasswordVisible => _isPasswordVisible;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;
  bool get isLoading => _state == AuthState.loading;

  /// Alternar visibilidad de contraseña
  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  /// Alternar visibilidad de confirmación de contraseña
  void toggleConfirmPasswordVisibility() {
    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    notifyListeners();
  }

  /// Registrar un nuevo usuario
  Future<void> register() async {
    // Validar campos
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneController.text.isEmpty ||
        dniController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      _setError('Por favor completa todos los campos');
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      _setError('Las contraseñas no coinciden');
      return;
    }

    if (passwordController.text.length < 6) {
      _setError('La contraseña debe tener al menos 6 caracteres');
      return;
    }

    _setState(AuthState.loading);

    try {
      // Simulación de delay de API
      await Future.delayed(const Duration(seconds: 2));

      // Aquí iría la lógica de registro real usando los use cases
      // await registerUseCase(nameController.text, emailController.text, passwordController.text);

      _setState(AuthState.success);
      _successMessage = '¡Cuenta creada exitosamente!';

      // Limpiar campos por seguridad
      nameController.clear();
      emailController.clear();
      phoneController.clear();
      dniController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
    } catch (e) {
      _setError('Error al registrarse: ${e.toString()}');
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
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    dniController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
