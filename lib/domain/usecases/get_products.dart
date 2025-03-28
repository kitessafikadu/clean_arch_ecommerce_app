import 'package:clean_arch_ecommerce_app/domain/entities/product.dart';
import 'package:clean_arch_ecommerce_app/domain/repositories/product_repository.dart';

class GetProduct {
  final ProductRepository repository;
  GetProduct(this.repository);

  Future<Product> call(String id) {
    return repository.getProduct(id);
  }
}
