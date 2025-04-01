import '../../core/network_info.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/entities/product.dart';
import '../datasources/product_remote_datasource.dart';
import '../datasources/product_local_datasource.dart';
import '../../core/failure.dart';

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
    if (await networkInfo.isConnected) {
      await remoteDataSource.insertProduct(product);
    } else {
      await localDataSource.insertProduct(product);
    }
  }

  @override
  Future<void> updateProduct(Product product) async {
    if (await networkInfo.isConnected) {
      await remoteDataSource.updateProduct(product);
    } else {
      await localDataSource.updateProduct(product);
    }
  }

  @override
  Future<void> deleteProduct(String id) async {
    if (await networkInfo.isConnected) {
      await remoteDataSource.deleteProduct(id);
    } else {
      await localDataSource.deleteProduct(id);
    }
  }

  @override
  Future<Product> getProduct(String id) async {
    if (await networkInfo.isConnected) {
      return remoteDataSource.getProduct(id);
    } else {
      return localDataSource.getProduct(id);
    }
  }

  @override
  Future<List<Product>> getAllProducts() async {
    if (await networkInfo.isConnected) {
      return remoteDataSource.getAllProducts();
    } else {
      return localDataSource.getAllProducts();
    }
  }
}
