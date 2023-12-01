import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:reso_app/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:reso_app/features/number_trivia/domain/entities/number_trivia.dart';

import '../../../fixtures/fixture.reader.dart';

void main(){
  final tNumberTriviaModel = NumberTriviaModel(number:1,text:"Test Text");
  test("should be a subclass of NumberTriviaEntity", ()async{
    expect(tNumberTriviaModel, isA<NumberTrivia>());
  });
  group('fromJson',(){
  test('should return a valid model when a json number is integer', (){
    final Map<String,dynamic> jsonMap= jsonDecode(fixture('trivia.json'));
    final result = NumberTriviaModel.fromJson(jsonMap);
    expect(result, tNumberTriviaModel);
  });
  test('should return a valid model when a json number is regarder as a double', (){
    final Map<String,dynamic> jsonMap= jsonDecode(fixture('trivia_double.json'));
    final result = NumberTriviaModel.fromJson(jsonMap);
    expect(result, tNumberTriviaModel);
  });
  });
  group('toJson',(){
    test('should return a json map containing the proper data',() async{
      final result= tNumberTriviaModel.toJson();
      final expectedMap= {
        "text": "Test Text",
        "number": 1,};
      expect(result, expectedMap);
    });
  });
}