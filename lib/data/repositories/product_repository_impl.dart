import 'package:clean_arch_ecommerce_app/data/datasources/product_local_datasource.dart';
import 'package:clean_arch_ecommerce_app/data/datasources/product_remote_datasource.dart';
import 'package:clean_arch_ecommerce_app/data/models/product_models.dart';

import '../../domain/repositories/product_repository.dart';
import '../../domain/entities/product.dart';
import '../../core/network_info.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<void> insertProduct(Product product) async {
    await remoteDataSource.insertProduct(product);
  }

  @override
  Future<void> updateProduct(Product product) async {
    await remoteDataSource.updateProduct(product);
  }

  @override
  Future<void> deleteProduct(String id) async {
    await remoteDataSource.deleteProduct(id);
  }

  @override
  Future<Product> getProduct(String id) async {
    if (await networkInfo.isConnected) {
      return await remoteDataSource.getProduct(id);
    } else {
      final cachedProducts = await localDataSource.getCachedProducts();
      return cachedProducts.firstWhere((p) => p.id == id);
    }
  }

  @override
  Future<List<Product>> getAllProducts() async {
    if (await networkInfo.isConnected) {
      final products = await remoteDataSource.getAllProducts();
      await localDataSource.cacheProducts(products as List<ProductModel>);
      return products;
    } else {
      return await localDataSource.getCachedProducts();
    }
  }
}
