import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:reso_app/core/error/failures.dart';
import 'package:reso_app/core/usecases/usecase.dart';
import 'package:reso_app/features/number_trivia/domain/entities/number_trivia.dart';

import '../repositiores/number_trivia_repository.dart';

class GetRandomNumbertirivia implements UseCase<NumberTrivia, NoParams> {
  final NumberTriviaRepository repository;
  GetRandomNumbertirivia( this.repository);
  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) async {
    return await repository.getRandomNumberTrivia();
  }
}

class NoParams extends Equatable {
  @override

  List<Object?> get props => [];
}
