import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dzpos/core/services/database.dart';
import 'package:dzpos/domain/domain.dart';
import 'package:equatable/equatable.dart';

import '../../../core/enums.dart';

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
