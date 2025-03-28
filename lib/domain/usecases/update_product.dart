import 'package:clean_arch_ecommerce_app/domain/entities/product.dart';
import 'package:clean_arch_ecommerce_app/domain/repositories/product_repository.dart';

class UpdateProduct {
  final ProductRepository repository;
  UpdateProduct(this.repository);

  Future<void> call(Product product) {
    return repository.updateProduct(product);
  }
}
