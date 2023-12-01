import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:reso_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:reso_app/features/number_trivia/domain/repositiores/number_trivia_repository.dart';
import 'package:reso_app/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';

class MocNumberTriviaRepository extends Mock implements NumberTriviaRepository{}
   void main(){
     late MocNumberTriviaRepository mocNumberTriviaRepository;
    late  GetConcerteNumbertirivia usecase;
     setUp((){
        mocNumberTriviaRepository = MocNumberTriviaRepository();
       usecase=GetConcerteNumbertirivia(repository: mocNumberTriviaRepository,  );
     });
     final tNumber=1;
     final tNumberTrivia=NumberTrivia(text: "test", number: 1);
     test('should get trivia for the number from the repository',()async{
      when(mocNumberTriviaRepository.getconcretNumberTrivia(number: 1)).
           
       thenAnswer((_) async => Right(tNumberTrivia));
       final result = await usecase.call(Params(number: tNumber));
       expect(result, Right(tNumberTrivia));
       verify(mocNumberTriviaRepository.getconcretNumberTrivia(number: tNumber));
     });
   }
