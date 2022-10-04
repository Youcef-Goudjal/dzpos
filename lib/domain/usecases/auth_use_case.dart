import 'package:dartz/dartz.dart';

import 'package:dzpos/core/usecases/usecase.dart';
import 'package:dzpos/core/errors/failures.dart';

class AuthUseCase implements UseCase<void, AuthParams> {
  // TODO: implement the output of your AuthUseCase


  @override
  Future<Either<Failure, void>> call(AuthParams params) {
    // TODO: implement call
    throw UnimplementedError();
  }
}

class AuthParams {
  // TODO: implement your AuthParams
  const AuthParams();
}
