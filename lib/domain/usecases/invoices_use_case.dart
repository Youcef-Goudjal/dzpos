import 'package:dartz/dartz.dart';

import 'package:dzpos/core/usecases/usecase.dart';
import 'package:dzpos/core/errors/failures.dart';

class InvoicesUseCase implements UseCase<void, InvoicesParams> {
  // TODO: implement the output of your InvoicesUseCase


  @override
  Future<Either<Failure, void>> call(InvoicesParams params) {
    // TODO: implement call
    throw UnimplementedError();
  }
}

class InvoicesParams {
  // TODO: implement your InvoicesParams
  const InvoicesParams();
}
