import '../../domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required String id,
    required String name,
    required String description,
    required double price,
    required String imageUrl,
  }) : super(
          id: id,
          name: name,
          description: description,
          price: price,
          imageUrl: imageUrl,
        );

  // Factory method to create a ProductModel from a JSON object
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  // Method to convert a ProductModel into a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    };
  }
}
