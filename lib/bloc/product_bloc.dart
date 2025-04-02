import 'package:clean_arch_ecommerce_app/bloc/product_event.dart';
import 'package:clean_arch_ecommerce_app/bloc/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_arch_ecommerce_app/domain/repositories/product_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  ProductBloc(this.productRepository) : super(InitialState()) {
    on<LoadAllProductsEvent>(_onLoadAllProducts);
    on<GetSingleProductEvent>(_onGetSingleProduct);
    on<CreateProductEvent>(_onCreateProduct);
    on<UpdateProductEvent>(_onUpdateProduct);
    on<DeleteProductEvent>(_onDeleteProduct);
  }

  // Fetch all products
  void _onLoadAllProducts(
      LoadAllProductsEvent event, Emitter<ProductState> emit) async {
    emit(LoadingState());
    try {
      final products = await productRepository.getAllProducts();
      emit(LoadedAllProductsState(products));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }

  // Fetch a single product by ID
  void _onGetSingleProduct(
      GetSingleProductEvent event, Emitter<ProductState> emit) async {
    emit(LoadingState());
    try {
      final product = await productRepository.getProduct(event.productId);
      emit(LoadedSingleProductState(product));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }

  // Create a product
  void _onCreateProduct(
      CreateProductEvent event, Emitter<ProductState> emit) async {
    emit(LoadingState());
    try {
      await productRepository.insertProduct(event.product);
      emit(InitialState());
      add(LoadAllProductsEvent()); // Refresh the product list
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }

  // Update a product
  void _onUpdateProduct(
      UpdateProductEvent event, Emitter<ProductState> emit) async {
    emit(LoadingState());
    try {
      await productRepository.updateProduct(event.product);
      emit(InitialState());
      add(LoadAllProductsEvent()); // Refresh the product list
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }

  // Delete a product
  void _onDeleteProduct(
      DeleteProductEvent event, Emitter<ProductState> emit) async {
    emit(LoadingState());
    try {
      await productRepository.deleteProduct(event.productId);
      emit(InitialState());
      add(LoadAllProductsEvent()); // Refresh the product list
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}
