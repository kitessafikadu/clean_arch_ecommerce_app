import 'package:flutter_test/flutter_test.dart';
import 'package:ecommerce_app/features/product/data/models/product_model.dart';

void main() {
  group('ProductModel', () {
    test('should convert from JSON to ProductModel', () {
      final json = {
        'id': '1',
        'name': 'Product 1',
        'description': 'This is a product',
        'price': 20.0,
        'imageUrl': 'https://example.com/product1.jpg',
      };

      final productModel = ProductModel.fromJson(json);

      expect(productModel.id, '1');
      expect(productModel.name, 'Product 1');
      expect(productModel.description, 'This is a product');
      expect(productModel.price, 20.0);
      expect(productModel.imageUrl, 'https://example.com/product1.jpg');
    });

    test('should convert ProductModel to JSON', () {
      final productModel = ProductModel(
        id: '1',
        name: 'Product 1',
        description: 'This is a product',
        price: 20.0,
        imageUrl: 'https://example.com/product1.jpg',
      );

      final json = productModel.toJson();

      expect(json['id'], '1');
      expect(json['name'], 'Product 1');
      expect(json['description'], 'This is a product');
      expect(json['price'], 20.0);
      expect(json['imageUrl'], 'https://example.com/product1.jpg');
    });
  });
}
