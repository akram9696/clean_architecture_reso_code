import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NumberTriviaEvent {}

class GetConcertTrivaEvent extends NumberTriviaEvent {
  String number;
  GetConcertTrivaEvent({required this.number});
}

class GetRandomTriviaEvent extends NumberTriviaEvent {}
