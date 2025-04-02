import 'package:clean_arch_ecommerce_app/data/datasources/product_local_datasource.dart';
import 'package:clean_arch_ecommerce_app/data/models/product_models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

// Mock SharedPreferences
class MockSharedPreferences extends Mock implements SharedPreferences {}

const String CACHED_PRODUCTS = 'CACHED_PRODUCTS';

void main() {
  late ProductLocalDataSourceImpl localDataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    localDataSource =
        ProductLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  final testProduct = ProductModel(
    id: "1",
    name: "Test Product",
    description: "Test Description",
    price: 10.0,
    imageUrl: "test.png",
  );

  final testProductList = [testProduct];
  final jsonString =
      jsonEncode(testProductList.map((p) => p.toJson()).toList());

  test('should cache product list', () async {
    when(mockSharedPreferences.setString(any as String, any as String))
        .thenAnswer((_) async => true);

    await localDataSource.cacheProducts(testProductList);

    verify(mockSharedPreferences.setString(CACHED_PRODUCTS, jsonString))
        .called(1);
  });

  test('should return cached product list when available', () async {
    when(mockSharedPreferences.getString(CACHED_PRODUCTS))
        .thenReturn(jsonString);

    final result = await localDataSource.getCachedProducts();

    expect(result, equals(testProductList));
  });

  test('should throw an exception when no cached data exists', () async {
    when(mockSharedPreferences.getString(CACHED_PRODUCTS)).thenReturn(null);

    expect(() => localDataSource.getCachedProducts(), throwsException);
  });
}
