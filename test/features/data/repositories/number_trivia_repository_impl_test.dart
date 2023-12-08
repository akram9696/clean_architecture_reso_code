import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:reso_app/core/error/exceptions.dart';
import 'package:reso_app/core/error/failures.dart';
import 'package:reso_app/core/platform/network_info.dart';
import 'package:reso_app/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:reso_app/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:reso_app/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:reso_app/features/number_trivia/data/repoistiores/number_trivia_repoistory_impl.dart';
import 'package:reso_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:reso_app/features/number_trivia/domain/repositiores/number_trivia_repository.dart';
//
// class MockRemoteDataSource extends Mock
//     implements NumberTriviaRemoteDataSource {}
//
// class MocklocalDataSource extends Mock implements NumbeTriviaLocalDataSource {}
//
// class MockNetworkInfo extends Mock implements NetworkInfo {}
@GenerateNiceMocks([MockSpec<NumberTriviaRemoteDataSource>()])
@GenerateNiceMocks([MockSpec<NumbeTriviaLocalDataSource>()])
@GenerateNiceMocks([MockSpec<NetworkInfo>()])
import 'number_trivia_repository_impl_test.mocks.dart';

void main() {
  late NumberTriviaRepoistoryImpl numberTriviaRepoistoryImpl;
  late MockNumberTriviaRemoteDataSource mockRemoteDataSource;
  late NumbeTriviaLocalDataSource mocklocalDataSource;
  late MockNetworkInfo mockNetworkInfo;
  setUp(() {
    mockRemoteDataSource = MockNumberTriviaRemoteDataSource();
    mocklocalDataSource = MockNumbeTriviaLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    numberTriviaRepoistoryImpl = NumberTriviaRepoistoryImpl(
        numberTriviaRemoteDataSource: mockRemoteDataSource,
        numbeTriviaLocalDataSource: mocklocalDataSource,
        networkInfo: mockNetworkInfo);
  });
  runTestsOnline(Function body) {
    group("the device is online", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  runTestsOffline(Function body) {
    group("the device is offline", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  group("getConcereteNumberTrivia", () {
    final tNumber = 1;

    final tNumberTriviaModel =
        NumberTriviaModel(text: "test trivia", number: tNumber);
    final NumberTrivia tNumberTrivia = tNumberTriviaModel;
    test("should check if the device is online", () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      numberTriviaRepoistoryImpl.getconcretNumberTrivia(number: tNumber);
      verify(mockNetworkInfo.isConnected);
    });
    runTestsOnline(() {
      test(
          "should return remote data when the call to remote data source is successful",
          () async {
        when(mockRemoteDataSource.getconcretNumberTrivia(number: 1))
            .thenAnswer((_) async => tNumberTriviaModel);
        final result = await numberTriviaRepoistoryImpl.getconcretNumberTrivia(
            number: tNumber);
        verify(mockRemoteDataSource.getconcretNumberTrivia(number: tNumber));
        expect(result, Right(tNumberTrivia));
      });
      test(
          "should return cach data locally when the call to remote data source is successful",
          () async {
        when(mockRemoteDataSource.getconcretNumberTrivia(number: 1))
            .thenAnswer((_) async => tNumberTriviaModel);
        final result = await numberTriviaRepoistoryImpl.getconcretNumberTrivia(
            number: tNumber);
        verify(mockRemoteDataSource.getconcretNumberTrivia(number: tNumber));
        verify(mocklocalDataSource.cacheNumberTrivia(tNumberTriviaModel));
      });
      test(
          "should return server failure data when the call to remote data source is unsuccessful",
          () async {
        when(mockRemoteDataSource.getconcretNumberTrivia(number: 1))
            .thenThrow(ServerException());
        final result = await numberTriviaRepoistoryImpl.getconcretNumberTrivia(
            number: tNumber);
        verify(mockRemoteDataSource.getconcretNumberTrivia(number: tNumber));
        verifyZeroInteractions(mocklocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });
    runTestsOffline(() {
      test("should return last locally cached data when data is present",
          () async {
        when(mocklocalDataSource.getLastNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);
        final result = await numberTriviaRepoistoryImpl.getconcretNumberTrivia(
            number: tNumber);
        verifyZeroInteractions(mocklocalDataSource);
        verify(mocklocalDataSource.getLastNumberTrivia());
        expect(result, equals(Right(tNumberTrivia)));
      });
      test("should return cachedFailure data when no data is present",
          () async {
        when(mocklocalDataSource.getLastNumberTrivia())
            .thenThrow(CacheException());
        final result = await numberTriviaRepoistoryImpl.getconcretNumberTrivia(
            number: tNumber);
        verifyZeroInteractions(mocklocalDataSource);
        verify(mocklocalDataSource.getLastNumberTrivia());
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });
  group("getRandomNumberTrivia", () {
    // final tNumber = 1;

    final tNumberTriviaModel =
    NumberTriviaModel(text: "test trivia", number: 123);
    final NumberTrivia tNumberTrivia = tNumberTriviaModel;
    test("should check if the device is online", () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      numberTriviaRepoistoryImpl.getRandomNumberTrivia();
      verify(mockNetworkInfo.isConnected);
    });
    runTestsOnline(() {
      test(
          "should return remote data when the call to remote data source is successful",
              () async {
            when(mockRemoteDataSource.getconcretNumberTrivia(number: 1))
                .thenAnswer((_) async => tNumberTriviaModel);
            final result = await numberTriviaRepoistoryImpl.getRandomNumberTrivia();
            verify(mockRemoteDataSource.getRandomNumberTrivia());
            expect(result, Right(tNumberTrivia));
          });
      test(
          "should return cach data locally when the call to remote data source is successful",
              () async {
            when(mockRemoteDataSource.getRandomNumberTrivia())
                .thenAnswer((_) async => tNumberTriviaModel);
            final result = await numberTriviaRepoistoryImpl.getRandomNumberTrivia();
            verify(mockRemoteDataSource.getRandomNumberTrivia());
            verify(mocklocalDataSource.cacheNumberTrivia(tNumberTriviaModel));
          });
      test(
          "should return server failure data when the call to remote data source is unsuccessful",
              () async {
            when(mockRemoteDataSource.getRandomNumberTrivia())
                .thenThrow(ServerException());
            final result = await numberTriviaRepoistoryImpl.getRandomNumberTrivia();
            verify(mockRemoteDataSource.getRandomNumberTrivia());
            verifyZeroInteractions(mocklocalDataSource);
            expect(result, equals(Left(ServerFailure())));
          });
    });
    runTestsOffline(() {
      test("should return last locally cached data when data is present",
              () async {
            when(mocklocalDataSource.getLastNumberTrivia())
                .thenAnswer((_) async => tNumberTriviaModel);
            final result = await numberTriviaRepoistoryImpl.getRandomNumberTrivia();
            verifyZeroInteractions(mocklocalDataSource);
            verify(mocklocalDataSource.getLastNumberTrivia());
            expect(result, equals(Right(tNumberTrivia)));
          });
      test("should return cachedFailure data when no data is present",
              () async {
            when(mocklocalDataSource.getLastNumberTrivia())
                .thenThrow(CacheException());
            final result = await numberTriviaRepoistoryImpl.getRandomNumberTrivia();
            verifyZeroInteractions(mocklocalDataSource);
            verify(mocklocalDataSource.getLastNumberTrivia());
            expect(result, equals(Left(CacheFailure())));
          });
    });
  });

}
