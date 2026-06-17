class User {
  final int id;
  final String username;
  final String firstName;
  final String token;

  User({
    required this.id,
    required this.username,
    required this.firstName,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      // CORREÇÃO: Prevenção contra campos nulos vindos da API
      id: json['id'] ?? 0,
      username: json['username'] ?? 'usuario_desconhecido',
      firstName: json['firstName'] ?? 'Visitante',
      token: json['token'] ?? '',
    );
  }
}