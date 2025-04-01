import '../../domain/entities/product.dart';

abstract class ProductLocalDataSource {
  Future<void> insertProduct(Product product);
  Future<void> updateProduct(Product product);
  Future<void> deleteProduct(String id);
  Future<Product> getProduct(String id);
  Future<List<Product>> getAllProducts();
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final List<Product> _cachedProducts = [];

  @override
  Future<void> insertProduct(Product product) async {
    _cachedProducts.add(product);
  }

  @override
  Future<void> updateProduct(Product product) async {
    int index = _cachedProducts.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      _cachedProducts[index] = product;
    }
  }

  @override
  Future<void> deleteProduct(String id) async {
    _cachedProducts.removeWhere((p) => p.id == id);
  }

  @override
  Future<Product> getProduct(String id) async {
    return _cachedProducts.firstWhere((p) => p.id == id);
  }

  @override
  Future<List<Product>> getAllProducts() async {
    return _cachedProducts;
  }
}
