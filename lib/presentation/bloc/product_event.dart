import 'package:clean_arch_ecommerce_app/data/models/product_models.dart';
import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// Event for loading all products
class LoadAllProductsEvent extends ProductEvent {}

// Event for fetching a single product by ID
class GetSingleProductEvent extends ProductEvent {
  final String productId;

  GetSingleProductEvent(this.productId);

  @override
  List<Object> get props => [productId];
}

// Event for creating a new product
class CreateProductEvent extends ProductEvent {
  final ProductModel product;

  CreateProductEvent(this.product);

  @override
  List<Object> get props => [product];
}

// Event for updating a product
class UpdateProductEvent extends ProductEvent {
  final ProductModel product;

  UpdateProductEvent(this.product);

  @override
  List<Object> get props => [product];
}

// Event for deleting a product
class DeleteProductEvent extends ProductEvent {
  final String productId;

  DeleteProductEvent(this.productId);

  @override
  List<Object> get props => [productId];
}
