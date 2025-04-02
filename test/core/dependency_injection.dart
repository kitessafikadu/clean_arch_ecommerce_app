import 'package:clean_arch_ecommerce_app/bloc/product_bloc.dart';
import 'package:clean_arch_ecommerce_app/core/network_info.dart';
import 'package:clean_arch_ecommerce_app/data/datasources/product_local_datasource.dart';
import 'package:clean_arch_ecommerce_app/data/datasources/product_remote_datasource.dart';
import 'package:clean_arch_ecommerce_app/data/repositories/product_repository_impl.dart';
import 'package:clean_arch_ecommerce_app/domain/repositories/product_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance; // Service Locator

Future<void> init() async {
  // **Bloc**
  sl.registerFactory(() => ProductBloc(sl()));

  // **Repository**
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
        remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()),
  );

  // **Data Sources**
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<ProductLocalDataSource>(
    () => ProductLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // **Core**
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl()),
  );

  // **External Dependencies**
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
