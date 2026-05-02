/// Modelo de respuesta de autenticación desde la API
class AuthResponseModel {
  final String id;
  final String email;
  final String name;
  final String token;
  final DateTime? lastLogin;

  AuthResponseModel({
    required this.id,
    required this.email,
    required this.name,
    required this.token,
    this.lastLogin,
  });

  /// Crea una instancia desde JSON
  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      token: json['token'] as String,
      lastLogin: json['lastLogin'] != null
          ? DateTime.parse(json['lastLogin'] as String)
          : null,
    );
  }

  /// Convierte a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'token': token,
      'lastLogin': lastLogin?.toIso8601String(),
    };
  }
}
