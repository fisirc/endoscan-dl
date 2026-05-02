/// Modelo de Usuario para la capa de dominio
class User {
  final String id;
  final String email;
  final String name;
  final String? token;
  final DateTime? lastLogin;

  User({
    required this.id,
    required this.email,
    required this.name,
    this.token,
    this.lastLogin,
  });

  /// Copia la instancia con cambios opcionales
  User copyWith({
    String? id,
    String? email,
    String? name,
    String? token,
    DateTime? lastLogin,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      token: token ?? this.token,
      lastLogin: lastLogin ?? this.lastLogin,
    );
  }

  @override
  String toString() => 'User(id: $id, email: $email, name: $name)';
}
