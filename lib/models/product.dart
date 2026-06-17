import 'dart:convert';

class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String image;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      description: json['description'] ?? 'Sem descrição',
      image: json['thumbnail'] ?? '', // Alterado para mapear corretamente o DummyJSON
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'price': price,
    'description': description,
    'thumbnail': image,
  };

  static String encodeList(List<Product> products) => json.encode(
        products.map<Map<String, dynamic>>((p) => p.toJson()).toList(),
      );

  static List<Product> decodeList(String productsStr) =>
      (json.decode(productsStr) as List<dynamic>)
          .map<Product>((item) => Product.fromJson(item))
          .toList();
}