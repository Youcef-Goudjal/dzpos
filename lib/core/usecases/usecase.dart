import 'package:dartz/dartz.dart';
import 'package:dzpos/core/errors/failures.dart';

abstract class UseCase<Output, Input> {
  Future<Either<Failure, Output>> call(Input params);
}
