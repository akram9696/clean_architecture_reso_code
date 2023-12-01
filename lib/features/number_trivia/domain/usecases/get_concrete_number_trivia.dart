import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:reso_app/core/error/failures.dart';
import 'package:reso_app/core/usecases/usecase.dart';
import 'package:reso_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:reso_app/features/number_trivia/domain/repositiores/number_trivia_repository.dart';


class GetConcerteNumbertirivia implements UseCase<NumberTrivia,Params>{
  final NumberTriviaRepository repository;
  GetConcerteNumbertirivia({required this.repository});

  @override
  Future<Either<Failure, NumberTrivia>> call(Params params) async{
    return await repository.getconcretNumberTrivia(number:params.number );
  }

}
class Params extends Equatable{
  final int number;

  Params({required this.number});

  @override
  // TODO: implement props
  List<Object?> get props =>[number];


}