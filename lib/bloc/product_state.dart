import 'package:clean_arch_ecommerce_app/data/models/product_models.dart';
import 'package:equatable/equatable.dart';

abstract class ProductState extends Equatable {
  @override
  List<Object> get props => [];
}

// Initial State
class InitialState extends ProductState {}

// Loading State
class LoadingState extends ProductState {}

// State when all products are loaded
class LoadedAllProductsState extends ProductState {
  final List<ProductModel> products;

  LoadedAllProductsState(this.products);

  @override
  List<Object> get props => [products];
}

// State when a single product is loaded
class LoadedSingleProductState extends ProductState {
  final ProductModel product;

  LoadedSingleProductState(this.product);

  @override
  List<Object> get props => [product];
}

// Error State
class ErrorState extends ProductState {
  final String message;

  ErrorState(this.message);

  @override
  List<Object> get props => [message];
}
