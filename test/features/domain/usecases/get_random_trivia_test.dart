import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:reso_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:reso_app/features/number_trivia/domain/repositiores/number_trivia_repository.dart';
import 'package:reso_app/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:reso_app/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

// class MocNumberTriviaRepository extends Mock implements NumberTriviaRepository{}
@GenerateNiceMocks([MockSpec<NumberTriviaRepository>()])
import 'get_concert_number_trivia_test.mocks.dart';
  void main(){
    late MockNumberTriviaRepository mocNumberTriviaRepository;
    late  GetRandomNumbertirivia usecase;
    setUp((){
      mocNumberTriviaRepository = MockNumberTriviaRepository();
      usecase=GetRandomNumbertirivia(  mocNumberTriviaRepository );
    });

    final tNumberTrivia=NumberTrivia(text: "test", number: 1);
    test('should get trivia  from the repository',()async{
      when(mocNumberTriviaRepository.getRandomNumberTrivia()).

      thenAnswer((_) async => Right(tNumberTrivia));
      final result = await usecase.call(NoParams());
      expect(result, Right(tNumberTrivia));
      verify(mocNumberTriviaRepository.getRandomNumberTrivia());
    });
  }
