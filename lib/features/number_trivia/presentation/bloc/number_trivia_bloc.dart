import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reso_app/core/utils/input_converter.dart';
import 'package:reso_app/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:reso_app/features/number_trivia/presentation/bloc/bloc.dart';

import '../../domain/usecases/get_concrete_number_trivia.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaStates> {
  final GetConcerteNumbertirivia getConcerteNumbertirivia;
  final GetRandomNumbertirivia getRandomNumbertirivia;
  final InputConverter inputConverter;
  NumberTriviaBloc({required this.getConcerteNumbertirivia, required this.getRandomNumbertirivia,
     required this.inputConverter})
      : super(Empty()){

    on<GetConcertTrivaEvent>((event, emit) async {
      emit(Loading());
      final response= await getConcerteNumbertirivia(Params(number: event.number as int));
      response.fold((l) => emit(Error(messege: "bad connection")), (r) => emit(Loaded(trivia: r)));
    },);
}


}
