import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:reso_app/core/error/exceptions.dart';
import 'package:reso_app/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:reso_app/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../fixtures/fixture.reader.dart';

class MockSharedPrefrence extends Mock implements SharedPreferences {}

void main() {
  late NumberTriviaLocalDataSourceImpl dataSource;
  late MockSharedPrefrence mockSharedPrefrence;
  setUp(() {
    mockSharedPrefrence = MockSharedPrefrence();
    dataSource =
        NumberTriviaLocalDataSourceImpl(sharedPreferences: mockSharedPrefrence);
  });
  group('getLastNumberTrivia', () {
    test(
        'should return number trvia from sharedPrefrence when there is on in cach',
        () async {
      final tNumberTriviaModel =
          NumberTriviaModel.fromJson(jsonDecode(fixture('trivia_cached.json')));
      when(mockSharedPrefrence.getString('CACHED_NUMBER_TRIVIA'))
          .thenReturn(fixture('trivia_cached.json'));
      final result = await dataSource.getLastNumberTrivia();
      verify(mockSharedPrefrence.getString('CACHED_NUMBER_TRIVIA'));
      expect(result, equals(tNumberTriviaModel));
    });
    test(
        'should throw cachEexpection when  there is no value in cach',
            () async {

          when(mockSharedPrefrence.getString('CACHED_NUMBER_TRIVIA'))
              .thenReturn(null);
          final call = dataSource.getLastNumberTrivia;
          expect(() =>call(), throwsA(isA<CacheException>()));
        });
  });
  group('cachedNumberTrivia', (){
    final tNumberTriviaModel=NumberTriviaModel(text: 'test trivia', number: 1);

    test('should call sharedPrefrence to cache data',() async{
      dataSource.cacheNumberTrivia(tNumberTriviaModel);
      final jsonToMap=json.encode(tNumberTriviaModel.toJson());
      verify(mockSharedPrefrence.setString('CACHED_NUMBER_TRIVIA', jsonToMap));
   });
  });
}
