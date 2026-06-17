import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/product.dart';
import '../../models/user.dart';

class RemoteDataSource {
  final String apiUrl = 'https://dummyjson.com';

  Future<User> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$apiUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'username': username, 'password': password, 'expiresInMins': 30}),
    );

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Credenciais inválidas ou erro no servidor.');
    }
  }

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('$apiUrl/products'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final List<dynamic> jsonList = jsonResponse['products'];
      return jsonList.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao buscar produtos da API');
    }
  }
}