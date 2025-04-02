import 'dart:convert';
import 'package:clean_arch_ecommerce_app/data/datasources/product_remote_datasource.dart';
import 'package:clean_arch_ecommerce_app/data/models/product_models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import 'product_remote_datasource_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late ProductRemoteDataSourceImpl dataSource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = ProductRemoteDataSourceImpl(client: mockHttpClient);
  });

  const String baseUrl =
      'https://documenter.getpostman.com/view/24515281/2sA3XPBgv5';

  final testProductModel = ProductModel(
    id: '1',
    name: 'Test Product',
    description: 'Test Description',
    price: 99.99,
    imageUrl: 'https://example.com/test.jpg',
  );

  final testProductJson = jsonEncode(testProductModel.toJson());

  group('ProductRemoteDataSource Tests', () {
    test('should perform a POST request to insert a product', () async {
      when(mockHttpClient.post(
        Uri.parse(baseUrl),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('', 201));

      await dataSource.insertProduct(testProductModel);

      verify(mockHttpClient.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: testProductJson,
      ));
    });

    test('should throw an exception when insert fails', () async {
      when(mockHttpClient.post(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('Error', 400));

      expect(() => dataSource.insertProduct(testProductModel), throwsException);
    });

    test('should perform a PUT request to update a product', () async {
      when(mockHttpClient.put(
        Uri.parse('$baseUrl/1'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('', 200));

      await dataSource.updateProduct(testProductModel);

      verify(mockHttpClient.put(
        Uri.parse('$baseUrl/1'),
        headers: {'Content-Type': 'application/json'},
        body: testProductJson,
      ));
    });

    test('should throw an exception when update fails', () async {
      when(mockHttpClient.put(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('Error', 400));

      expect(() => dataSource.updateProduct(testProductModel), throwsException);
    });

    test('should perform a DELETE request to delete a product', () async {
      when(mockHttpClient.delete(Uri.parse('$baseUrl/1')))
          .thenAnswer((_) async => http.Response('', 200));

      await dataSource.deleteProduct('1');

      verify(mockHttpClient.delete(Uri.parse('$baseUrl/1')));
    });

    test('should throw an exception when delete fails', () async {
      when(mockHttpClient.delete(any))
          .thenAnswer((_) async => http.Response('Error', 400));

      expect(() => dataSource.deleteProduct('1'), throwsException);
    });

    test('should perform a GET request to fetch a product', () async {
      when(mockHttpClient.get(Uri.parse('$baseUrl/1')))
          .thenAnswer((_) async => http.Response(testProductJson, 200));

      final result = await dataSource.getProduct('1');

      expect(result, testProductModel);
      verify(mockHttpClient.get(Uri.parse('$baseUrl/1')));
    });

    test('should throw an exception when getProduct fails', () async {
      when(mockHttpClient.get(any))
          .thenAnswer((_) async => http.Response('Error', 404));

      expect(() => dataSource.getProduct('1'), throwsException);
    });

    test('should perform a GET request to fetch all products', () async {
      final testProductListJson = jsonEncode([testProductModel.toJson()]);

      when(mockHttpClient.get(Uri.parse(baseUrl)))
          .thenAnswer((_) async => http.Response(testProductListJson, 200));

      final result = await dataSource.getAllProducts();

      expect(result, [testProductModel]);
      verify(mockHttpClient.get(Uri.parse(baseUrl)));
    });

    test('should throw an exception when getAllProducts fails', () async {
      when(mockHttpClient.get(any))
          .thenAnswer((_) async => http.Response('Error', 500));

      expect(() => dataSource.getAllProducts(), throwsException);
    });
  });
}
