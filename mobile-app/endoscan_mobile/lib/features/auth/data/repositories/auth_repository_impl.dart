import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';
import '../mappers/auth_mapper.dart';

/// Implementación del repositorio de autenticación
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<User> login(String email, String password) async {
    final response = await remoteDataSource.login(email, password);
    
    // Guarda el token y datos del usuario localmente
    await localDataSource.saveToken(response.token);
    await localDataSource.saveUser(response);
    
    return AuthMapper.toEntity(response);
  }

  @override
  Future<User> register(String email, String password, String name) async {
    final response = await remoteDataSource.register(email, password, name);
    
    // Guarda el token y datos del usuario localmente
    await localDataSource.saveToken(response.token);
    await localDataSource.saveUser(response);
    
    return AuthMapper.toEntity(response);
  }

  @override
  Future<void> logout() async {
    await localDataSource.clearAuthData();
  }

  @override
  Future<User?> getCurrentUser() async {
    final token = await localDataSource.getToken();
    if (token == null) {
      return null;
    }

    try {
      final response = await remoteDataSource.getCurrentUser(token);
      return AuthMapper.toEntity(response);
    } catch (_) {
      // Si falla, retorna null
      return null;
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    return await localDataSource.hasToken();
  }
}
