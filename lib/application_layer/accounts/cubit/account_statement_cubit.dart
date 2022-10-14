import 'package:dzpos/core/enums.dart';
import 'package:dzpos/core/services/database.dart';
import 'package:dzpos/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'account_statement_state.dart';

class AccountStatementCubit extends Cubit<AccountStatementState> {
  AccountsRepository accountsRepository;
  AccountStatementCubit(this.accountsRepository, Account account)
      : super(AccountStatementState(account: account));

  void onDateChanged(DateTimeRange? dateRange) async {
    try {
      if (dateRange != null) {
        emit(state.copyWith(status: Status.loading));
        final debts = await accountsRepository.getDebtBetweenDatesOfAccount(
          state.account.id,
          dateRange,
        );
        emit(state.copyWith(
          debts: debts,
          date: dateRange,
          status: Status.success,
        ));
      }
    } on Exception catch (e) {
      emit(state.copyWith(
        status: Status.failure,
        msg: e.toString(),
      ));
    }
  }
}
