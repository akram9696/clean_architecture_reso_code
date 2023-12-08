import 'package:get_it/get_it.dart';
import 'package:reso_app/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:reso_app/features/number_trivia/presentation/bloc/bloc.dart';
final sl= GetIt.instance;
void init(){
sl.registerFactory(() => NumberTriviaBloc(getConcerteNumbertirivia: sl(), getRandomNumbertirivia: sl(), inputConverter: sl()));
sl.registerLazySingleton(() => GetConcerteNumbertirivia(repository: sl()));
}