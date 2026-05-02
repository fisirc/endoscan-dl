import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_constants.dart';
import '../models/auth_response_model.dart';

/// Data source local para autenticación (Almacenamiento local)
abstract class AuthLocalDataSource {
  /// Guarda el token de autenticación
  Future<void> saveToken(String token);

  /// Obtiene el token guardado
  Future<String?> getToken();

  /// Guarda los datos del usuario
  Future<void> saveUser(AuthResponseModel user);

  /// Obtiene los datos del usuario guardados
  Future<AuthResponseModel?> getUser();

  /// Elimina el token y datos del usuario
  Future<void> clearAuthData();

  /// Verifica si hay un token guardado
  Future<bool> hasToken();
}

/// Implementación de AuthLocalDataSource
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences prefs;

  AuthLocalDataSourceImpl(this.prefs);

  @override
  Future<void> saveToken(String token) async {
    await prefs.setString(AppConstants.authTokenKey, token);
  }

  @override
  Future<String?> getToken() async {
    return prefs.getString(AppConstants.authTokenKey);
  }

  @override
  Future<void> saveUser(AuthResponseModel user) async {
    await prefs.setString(AppConstants.userEmailKey, user.email);
  }

  @override
  Future<AuthResponseModel?> getUser() async {
    final email = prefs.getString(AppConstants.userEmailKey);
    if (email != null) {
      return AuthResponseModel(
        id: '',
        email: email,
        name: '',
        token: '',
      );
    }
    return null;
  }

  @override
  Future<void> clearAuthData() async {
    await prefs.remove(AppConstants.authTokenKey);
    await prefs.remove(AppConstants.userEmailKey);
    await prefs.setBool(AppConstants.isLoggedInKey, false);
  }

  @override
  Future<bool> hasToken() async {
    return prefs.containsKey(AppConstants.authTokenKey);
  }
}
