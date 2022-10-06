import 'package:dartz/dartz.dart';

import 'package:dzpos/core/usecases/usecase.dart';
import 'package:dzpos/core/errors/failures.dart';

class AccountsUseCase implements UseCase<void, AccountsParams> {
  // TODO: implement the output of your AccountsUseCase


  @override
  Future<Either<Failure, void>> call(AccountsParams params) {
    // TODO: implement call
    throw UnimplementedError();
  }
}

class AccountsParams {
  // TODO: implement your AccountsParams
  const AccountsParams();
}
