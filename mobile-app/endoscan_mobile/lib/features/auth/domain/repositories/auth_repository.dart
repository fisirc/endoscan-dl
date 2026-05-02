import '../entities/user.dart';

/// Abstracto del repositorio de autenticación
abstract class AuthRepository {
  /// Inicia sesión con email y contraseña
  Future<User> login(String email, String password);

  /// Registra un nuevo usuario
  Future<User> register(String email, String password, String name);

  /// Cierra la sesión
  Future<void> logout();

  /// Obtiene el usuario actual
  Future<User?> getCurrentUser();

  /// Verifica si hay una sesión activa
  Future<bool> isLoggedIn();
}
