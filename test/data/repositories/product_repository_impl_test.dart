import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import '../../../lib/domain/entities/product.dart';
import '../../../lib/data/repositories/product_repository_impl.dart';
import '../../../lib/data/datasources/product_remote_datasource.dart';
import '../../../lib/data/datasources/product_local_datasource.dart';
import '../../../lib/core/network_info.dart';

@GenerateMocks([ProductRemoteDataSource, ProductLocalDataSource, NetworkInfo])
import 'product_repository_impl_test.mocks.dart';

void main() {
  late ProductRepositoryImpl repository;
  late MockProductRemoteDataSource mockRemoteDataSource;
  late MockProductLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockProductRemoteDataSource();
    mockLocalDataSource = MockProductLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = ProductRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  final product = Product(
    id: '1',
    name: 'Test Product',
    description: 'This is a test',
    price: 10.0,
    imageUrl: 'test.png',
  );

  group('insertProduct', () {
    test('Should insert into remote when network is available', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.insertProduct(product))
          .thenAnswer((_) async {});

      await repository.insertProduct(product);

      verify(mockRemoteDataSource.insertProduct(product)).called(1);
      verifyNever(mockLocalDataSource.insertProduct(any));
    });

    test('Should insert into local when network is unavailable', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(mockLocalDataSource.insertProduct(product)).thenAnswer((_) async {});

      await repository.insertProduct(product);

      verify(mockLocalDataSource.insertProduct(product)).called(1);
      verifyNever(mockRemoteDataSource.insertProduct(any));
    });
  });

  group('getProduct', () {
    test('Should get product from remote when network is available', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getProduct('1'))
          .thenAnswer((_) async => product);

      final result = await repository.getProduct('1');

      expect(result, product);
      verify(mockRemoteDataSource.getProduct('1')).called(1);
      verifyNever(mockLocalDataSource.getProduct(any));
    });

    test('Should get product from local when network is unavailable', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(mockLocalDataSource.getProduct('1'))
          .thenAnswer((_) async => product);

      final result = await repository.getProduct('1');

      expect(result, product);
      verify(mockLocalDataSource.getProduct('1')).called(1);
      verifyNever(mockRemoteDataSource.getProduct(any));
    });
  });
}
