import '../../domain/entities/user.dart';
import '../models/auth_response_model.dart';

/// Mapper para convertir entre modelos de datos y entidades de dominio
class AuthMapper {
  /// Convierte AuthResponseModel a User
  static User toEntity(AuthResponseModel model) {
    return User(
      id: model.id,
      email: model.email,
      name: model.name,
      token: model.token,
      lastLogin: model.lastLogin,
    );
  }

  /// Convierte User a AuthResponseModel
  static AuthResponseModel toModel(User entity) {
    return AuthResponseModel(
      id: entity.id,
      email: entity.email,
      name: entity.name,
      token: entity.token ?? '',
      lastLogin: entity.lastLogin,
    );
  }
}
