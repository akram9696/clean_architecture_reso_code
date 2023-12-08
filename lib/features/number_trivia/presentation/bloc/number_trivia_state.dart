import 'package:reso_app/features/number_trivia/domain/entities/number_trivia.dart';

abstract class NumberTriviaStates {}

class Empty extends NumberTriviaStates {}

class Loading extends NumberTriviaStates {}

class Loaded extends NumberTriviaStates {
  final NumberTrivia trivia;

  Loaded({required this.trivia});
}
class Error extends NumberTriviaStates {
  final String messege;

Error({required this.messege});
}