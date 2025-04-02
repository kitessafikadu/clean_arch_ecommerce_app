import 'package:clean_arch_ecommerce_app/presentation/bloc/product_bloc.dart';
import 'package:clean_arch_ecommerce_app/presentation/bloc/product_state.dart';
import 'package:clean_arch_ecommerce_app/presentation/bloc/product_event.dart';
import 'package:clean_arch_ecommerce_app/data/models/product_models.dart';
import 'package:clean_arch_ecommerce_app/domain/repositories/product_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';

import 'product_bloc_test.mocks.dart';

@GenerateMocks([ProductRepository])
void main() {
  late ProductBloc productBloc;
  late MockProductRepository mockRepository;

  setUp(() {
    mockRepository = MockProductRepository();
    productBloc = ProductBloc(mockRepository);
  });

  final testProduct = ProductModel(
    id: '1',
    name: 'Test Product',
    description: 'Test Description',
    price: 99.99,
    imageUrl: 'https://example.com/test.jpg',
  );

  group('ProductBloc Tests', () {
    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, LoadedAllProductsState] when LoadAllProductsEvent is added',
      build: () {
        when(mockRepository.getAllProducts())
            .thenAnswer((_) async => [testProduct]);
        return productBloc;
      },
      act: (bloc) => bloc.add(LoadAllProductsEvent()),
      expect: () => [
        LoadingState(),
        LoadedAllProductsState([testProduct])
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, ErrorState] when LoadAllProductsEvent fails',
      build: () {
        when(mockRepository.getAllProducts())
            .thenThrow(Exception('Failed to fetch products'));
        return productBloc;
      },
      act: (bloc) => bloc.add(LoadAllProductsEvent()),
      expect: () =>
          [LoadingState(), ErrorState('Exception: Failed to fetch products')],
    );
  });
}
