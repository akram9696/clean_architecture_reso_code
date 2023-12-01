import 'dart:convert';

import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:reso_app/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:reso_app/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:reso_app/features/number_trivia/data/repoistiores/number_trivia_repoistory_impl.dart';

import '../../../fixtures/fixture.reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late MockHttpClient mockHttpClient;
  late NumberTriviaRemoteDataSourceImpL dataSource;
  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = NumberTriviaRemoteDataSourceImpL(client: mockHttpClient);
  });
  group('get concerte number trivia from get method', () {
    final tNumber = 2;
    final tNumberTriviaModel=NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));
    test('should perform get request method with endpoint', () async {
      when(mockHttpClient.get(Uri.parse('http://numbersapi.com/$tNumber') ,
              headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
      dataSource.getconcretNumberTrivia(number: tNumber);
      verify(
        mockHttpClient.get(Uri.parse('http://numbersapi.com/$tNumber') ,
            headers: {'Content-Type': 'Application/json'}),
      );
    });
    test('should return number trivia model when response is success',()async{
      when(mockHttpClient.get(Uri.parse('http://numbersapi.com/$tNumber') ,
          headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
      final result= await dataSource.getconcretNumberTrivia(number: tNumber);
      expect(result, equals(tNumberTriviaModel));
    });
  });
  group('get random number trivia from get method', () {

    final tNumberTriviaModel=NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));
    test('should perform get request method without endpoint', () async {
      when(mockHttpClient.get(Uri.parse('http://numbersapi.com/random') ,
          headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
      dataSource.getRandomNumberTrivia();
      verify(
        mockHttpClient.get(Uri.parse('http://numbersapi.com/random') ,
            headers: {'Content-Type': 'Application/json'}),
      );
    });
    test('should return random trivia model when response is success',()async{
      when(mockHttpClient.get(Uri.parse('http://numbersapi.com/random') ,
          headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
      final result= await dataSource.getRandomNumberTrivia();
      expect(result, equals(tNumberTriviaModel));
    });
  });
}
