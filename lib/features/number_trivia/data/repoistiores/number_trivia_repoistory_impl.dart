import 'package:dartz/dartz.dart';
import 'package:reso_app/core/error/exceptions.dart';
import 'package:reso_app/core/error/failures.dart';
import 'package:reso_app/core/platform/network_info.dart';
import 'package:reso_app/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:reso_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:reso_app/features/number_trivia/domain/repositiores/number_trivia_repository.dart';

import '../datasources/number_trivia_local_data_source.dart';
typedef Future<NumberTrivia> _ConcerteOrRandomChooser();
class NumberTriviaRepoistoryImpl implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource numberTriviaRemoteDataSource;
  final NumbeTriviaLocalDataSource numbeTriviaLocalDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepoistoryImpl({required this.numberTriviaRemoteDataSource,
    required this.numbeTriviaLocalDataSource,
    required this.networkInfo});

  // @override
  // Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
  //   // networkInfo.isConnected;
  //   return (Right(await numberTriviaRemoteDataSource.getRandomNumberTrivia()));
  // }

  @override
  Future<Either<Failure, NumberTrivia>> getconcretNumberTrivia(
      {required int number}) async {
    return await _getTrivia(() {
      return numberTriviaRemoteDataSource.getconcretNumberTrivia(number: number);
    });
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return await _getTrivia(() {
      return numberTriviaRemoteDataSource.getRandomNumberTrivia();
    });
  }
  Future<Either<Failure, NumberTrivia>> _getTrivia(
   _ConcerteOrRandomChooser getConcreteOrRandom
      ) async{

    if (await networkInfo.isConnected) {
      try {
        final remotetrivia = await getConcreteOrRandom();
        numbeTriviaLocalDataSource.cacheNumberTrivia(remotetrivia);
        return (Right(remotetrivia));
      } on ServerException {
        return (Left(ServerFailure()));
      }
    } else {
      try {
        final localTrivia = await numbeTriviaLocalDataSource
            .getLastNumberTrivia();
        return Right(localTrivia);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}