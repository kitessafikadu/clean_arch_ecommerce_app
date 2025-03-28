import 'package:clean_arch_ecommerce_app/domain/entities/product.dart';
import 'package:clean_arch_ecommerce_app/domain/repositories/product_repository.dart';

class GetAllProducts {
  final ProductRepository repository;
  GetAllProducts(this.repository);

  Future<List<Product>> call() {
    return repository.getAllProducts();
  }
}
