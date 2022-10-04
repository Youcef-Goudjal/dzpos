import 'package:dartz/dartz.dart';

import 'package:dzpos/core/usecases/usecase.dart';
import 'package:dzpos/core/errors/failures.dart';

class UserUseCase implements UseCase<void, UserParams> {
  // TODO: implement the output of your UserUseCase


  @override
  Future<Either<Failure, void>> call(UserParams params) {
    // TODO: implement call
    throw UnimplementedError();
  }
}

class UserParams {
  // TODO: implement your UserParams
  const UserParams();
}
