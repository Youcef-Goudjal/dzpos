import 'package:dartz/dartz.dart';

import 'package:dzpos/core/usecases/usecase.dart';
import 'package:dzpos/core/errors/failures.dart';

class SettingsUseCase implements UseCase<void, SettingsParams> {
  // TODO: implement the output of your SettingsUseCase


  @override
  Future<Either<Failure, void>> call(SettingsParams params) {
    // TODO: implement call
    throw UnimplementedError();
  }
}

class SettingsParams {
  // TODO: implement your SettingsParams
  const SettingsParams();
}
