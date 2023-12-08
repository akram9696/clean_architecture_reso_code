import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:reso_app/core/platform/network_info.dart';

// class MockInternetConnectionChecker extends Mock
//     implements InternetConnectionChecker {}
@GenerateNiceMocks([MockSpec<InternetConnectionChecker>()])
import 'network_info_test.mocks.dart';

void main() {
  late MockInternetConnectionChecker mockInternetConnectionChecker;
  late NetworkInfoImpl networkInfoImpl;
  setUp(() {
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    networkInfoImpl = NetworkInfoImpl(mockInternetConnectionChecker);
  });

  test('should forword call to internet connection checker', () async {
    final tHasConnectionFuture = Future.value(true);
    when(mockInternetConnectionChecker.hasConnection)
        .thenAnswer((_) async => Future.value(true));
    final result = await networkInfoImpl.isConnected;
    verify(mockInternetConnectionChecker.hasConnection);
    expect(result, true);
  });
}
