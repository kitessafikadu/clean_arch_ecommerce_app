import 'package:clean_arch_ecommerce_app/core/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

@GenerateMocks([InternetConnectionChecker])
import 'network_info_test.mocks.dart';

void main() {
  late NetworkInfoImpl networkInfo;
  late MockInternetConnectionChecker mockConnectionChecker;

  setUp(() {
    mockConnectionChecker = MockInternetConnectionChecker();
    networkInfo = NetworkInfoImpl(mockConnectionChecker);
  });

  test('Should return true when there is internet connection', () async {
    when(mockConnectionChecker.hasConnection).thenAnswer((_) async => true);

    final result = await networkInfo.isConnected;

    expect(result, true);
    verify(mockConnectionChecker.hasConnection).called(1);
  });

  test('Should return false when there is no internet connection', () async {
    when(mockConnectionChecker.hasConnection).thenAnswer((_) async => false);

    final result = await networkInfo.isConnected;

    expect(result, false);
    verify(mockConnectionChecker.hasConnection).called(1);
  });
}
