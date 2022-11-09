import 'dart:async';

import '../../../core/services/database.dart';
import '../../../domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/enums.dart';
import '../../../data/data.dart';

part 'dept_list_state.dart';

class DeptListCubit extends Cubit<DeptListState> {
  AccountsRepository accountsRepository;
  late StreamSubscription? _subscription;
  DeptListCubit(this.accountsRepository) : super(const DeptListState()) {
    emit(state.copyWith(
      status: Status.loading,
    ));
    _subscription = accountsRepository.debts.listen((event) {
      emit(state.copyWith(
        debts: event,
        status: Status.success,
      ));
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
