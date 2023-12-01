import 'package:dartz/dartz.dart';
import 'package:reso_app/core/error/failures.dart';
import 'package:reso_app/features/number_trivia/domain/entities/number_trivia.dart';

abstract class NumberTriviaRepository{
Future<Either<Failure,NumberTrivia>> getconcretNumberTrivia( {required int number});
  Future<Either<Failure,NumberTrivia>> getRandomNumberTrivia();
}
