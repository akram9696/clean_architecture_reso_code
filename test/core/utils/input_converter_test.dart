import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:reso_app/core/utils/input_converter.dart';
import 'package:reso_app/features/number_trivia/data/models/number_trivia_model.dart';

void main() {
  late InputConverter inputConverter;
  setUp(() {
    inputConverter = InputConverter();
  });
  group('stringToUnsigned', () {
    test('should return unsigned number', () {
      final str = '123';
      final result = inputConverter.stringToUnsignedInt(str);
      expect(result, Right(123));
    });
    test('should return failure number when string input not int', () {
      final str = 'abc';
      final result = inputConverter.stringToUnsignedInt(str);
      expect(result, Left(InvalidInputFailure()));
    });
  });

}
