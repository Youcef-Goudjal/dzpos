import 'package:dartz/dartz.dart';

import 'package:dzpos/core/usecases/usecase.dart';
import 'package:dzpos/core/errors/failures.dart';

class ReportsUseCase implements UseCase<void, ReportsParams> {
  // TODO: implement the output of your ReportsUseCase


  @override
  Future<Either<Failure, void>> call(ReportsParams params) {
    // TODO: implement call
    throw UnimplementedError();
  }
}

class ReportsParams {
  // TODO: implement your ReportsParams
  const ReportsParams();
}
